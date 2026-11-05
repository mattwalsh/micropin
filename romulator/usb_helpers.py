#!/usr/bin/env python3
"""Portable ROMulator reset, storage, and prebuilt-firmware helpers."""

import argparse
import glob
import hashlib
import json
import os
from pathlib import Path
import platform
import select
import shutil
import subprocess
import sys
import termios
import time
import tty

ROOT = Path(__file__).resolve().parent.parent


def linux_tty_interface(device):
    """Return a Linux tty's USB interface string, when sysfs provides it."""
    interface = Path("/sys/class/tty") / Path(device).name / "device" / "interface"
    try:
        return interface.read_text().strip()
    except (OSError, UnicodeError):
        return None


def serial_device(explicit=None):
    if explicit:
        return explicit
    if platform.system() == "Darwin":
        candidates = glob.glob("/dev/cu.usbmodemEPROM5*")
        # The composite firmware exposes CDC interface 0 (Romulator Control)
        # and interface 1 (raw LED frames). macOS names their callout devices
        # with trailing 1 and 3 respectively, e.g. _00011 and _00013.
        control_candidates = [path for path in candidates if path.endswith("1")]
        if control_candidates:
            candidates = control_candidates
    elif platform.system() == "Linux":
        candidates = glob.glob("/dev/serial/by-id/*EPROM*if00*")
        if not candidates:
            candidates = [
                path for path in glob.glob("/dev/ttyACM*")
                if linux_tty_interface(path) == "Romulator Control"
            ]
    else:
        raise RuntimeError("supported systems are macOS and Linux")
    candidates = sorted(set(os.path.realpath(p) for p in candidates))
    if not candidates:
        raise RuntimeError(
            "no connected ROMulator CDC device; refusing to guess from generic "
            "USB modem/ttyACM devices (connect the ROMulator or pass --device explicitly)"
        )
    if len(candidates) != 1:
        raise RuntimeError("multiple serial devices; use --device: " + ", ".join(candidates))
    return candidates[0]


def send(device, command):
    # Match the original helpers: these commands can disconnect USB before
    # their reply is read. Do not compete with an active game for CDC replies.
    fd = os.open(device, os.O_WRONLY | os.O_NOCTTY)
    try:
        data = (command + "\n").encode("ascii")
        while data:
            data = data[os.write(fd, data):]
    finally:
        os.close(fd)
    print(f"{command} sent to {device}")


def query(device, command, timeout=2.0):
    """Send one CDC line command and return its one-line reply."""
    fd = os.open(device, os.O_RDWR | os.O_NOCTTY | os.O_NONBLOCK)
    try:
        tty.setraw(fd, termios.TCSANOW)
        attributes = termios.tcgetattr(fd)
        attributes[4] = termios.B115200
        attributes[5] = termios.B115200
        termios.tcsetattr(fd, termios.TCSANOW, attributes)
        termios.tcflush(fd, termios.TCIOFLUSH)
        pending = (command + "\n").encode("ascii")
        deadline = time.monotonic() + timeout
        while pending:
            remaining = deadline - time.monotonic()
            if remaining <= 0:
                raise RuntimeError(f"timed out writing {command!r}")
            _, writable, _ = select.select([], [fd], [], remaining)
            if writable:
                pending = pending[os.write(fd, pending):]
        received = bytearray()
        while b"\n" not in received:
            remaining = deadline - time.monotonic()
            if remaining <= 0:
                raise RuntimeError(f"no reply to {command!r}")
            readable, _, _ = select.select([fd], [], [], remaining)
            if readable:
                received.extend(os.read(fd, 256))
        line, _, _ = received.partition(b"\n")
        return line.rstrip(b"\r").decode("ascii")
    finally:
        os.close(fd)


def linux_volumes():
    result = subprocess.run(
        ["lsblk", "--json", "--paths", "--output", "NAME,LABEL,MOUNTPOINTS"],
        check=True, capture_output=True, text=True,
    )

    def flatten(items):
        for item in items:
            yield item
            yield from flatten(item.get("children", []))

    return list(flatten(json.loads(result.stdout)["blockdevices"]))


def volume(label, mount=False):
    if platform.system() == "Darwin":
        path = Path("/Volumes") / label
        return path if os.path.ismount(path) else None
    matches = [v for v in linux_volumes() if v.get("label") == label]
    if len(matches) > 1:
        raise RuntimeError(f"multiple volumes labeled {label}; refusing to choose")
    if not matches:
        return None
    item = matches[0]
    paths = [p for p in item.get("mountpoints", []) if p]
    if paths:
        return Path(paths[0])
    if mount:
        if not shutil.which("udisksctl"):
            raise RuntimeError(f"{label} is present but unmounted; mount {item['name']} or install udisks2")
        subprocess.run(["udisksctl", "mount", "--block-device", item["name"]], check=True)
        return volume(label)
    return None


def wait_volume(label, timeout):
    deadline = time.monotonic() + timeout
    while time.monotonic() < deadline:
        path = volume(label, mount=True)
        if path:
            return path
        time.sleep(0.25)
    raise RuntimeError(f"{label} volume did not appear within {timeout:g} seconds")


def unmount_storage():
    path = volume("EPROMEMU")
    if not path:
        return
    # Flush/unmount before firmware disconnects the storage interface.
    if platform.system() == "Darwin":
        subprocess.run(["diskutil", "unmount", str(path)], check=True)
    else:
        items = [v for v in linux_volumes() if v.get("label") == "EPROMEMU"]
        subprocess.run(["udisksctl", "unmount", "--block-device", items[0]["name"]], check=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "action",
        choices=("reset", "mount", "eject", "reload", "mode", "info", "status"),
    )
    parser.add_argument("value", nargs="?", help="firmware path (reload) or rom/aperture (mode)")
    parser.add_argument("--device", help="explicit CDC serial device")
    parser.add_argument("--timeout", type=float, default=15, help="volume discovery timeout")
    args = parser.parse_args()
    if args.value and not (args.action.startswith("reload") or args.action == "mode"):
        parser.error("an argument is only valid for reload or mode actions")
    if args.action == "mode" and args.value not in {"rom", "aperture"}:
        parser.error("mode requires either 'rom' or 'aperture'")
    device = serial_device(args.device)
    if args.action == "info":
        print(f"serial: {device}")
        for label in ("EPROMEMU", "RPI-RP2"):
            print(f"{label}: {volume(label) or 'not mounted'}")
    elif args.action == "status":
        print(f"serial: {device}")
        for command in ("status", "state", "stats", "diag", "bootcount"):
            print(query(device, command))
    elif args.action == "eject":
        unmount_storage()
        send(device, "eject")
    elif args.action == "mount":
        send(device, "mount")
        print(f"ROM storage: {wait_volume('EPROMEMU', args.timeout)}")
    elif args.action == "reset":
        send(device, "reset")
    elif args.action == "mode":
        send(device, f"setmode {args.value}")
    else:
        build = "build"
        source = Path(args.value) if args.value else ROOT / "romulator" / build / "pico_eprom_emulator.uf2"
        # Validate before sending BOOTSEL so a missing file leaves hardware alone.
        with source.open("rb") as file:
            digest = hashlib.md5(file.read()).hexdigest()
        unmount_storage()
        send(device, "bootsel")
        time.sleep(3)  # Preserve the Mac helper's proven enumeration delay.
        target = wait_volume("RPI-RP2", args.timeout) / source.name
        if platform.system() == "Darwin":
            subprocess.run(["cp", "-X", str(source), str(target)], check=True)
        else:
            # No extended attributes or macOS resource forks copied.
            shutil.copyfile(source, target)
            os.sync()
        print(f"deployed {source} (MD5 {digest})")
        print("This firmware uses CE2/$1000 for the aperture and GP26 for WS2812 LEDs.")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (OSError, RuntimeError, subprocess.CalledProcessError) as error:
        print(f"FAIL: {error}", file=sys.stderr)
        raise SystemExit(1)
