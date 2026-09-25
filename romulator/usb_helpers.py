#!/usr/bin/env python3
"""Portable ROMulator reset, storage, and prebuilt-firmware helpers."""

import argparse
import glob
import hashlib
import json
import os
from pathlib import Path
import platform
import shutil
import subprocess
import sys
import time

ROOT = Path(__file__).resolve().parent.parent


def serial_device(explicit=None):
    if explicit:
        return explicit
    if platform.system() == "Darwin":
        candidates = glob.glob("/dev/cu.usbmodemEPROM5*")
    elif platform.system() == "Linux":
        candidates = glob.glob("/dev/serial/by-id/*EPROM*if00*")
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
    parser.add_argument("action", choices=("reset", "mount", "eject", "reload", "reload-aperture", "info"))
    parser.add_argument("uf2", nargs="?", type=Path, help="prebuilt firmware (reload actions only)")
    parser.add_argument("--device", help="explicit CDC serial device")
    parser.add_argument("--timeout", type=float, default=15, help="volume discovery timeout")
    args = parser.parse_args()
    if args.uf2 and not args.action.startswith("reload"):
        parser.error("UF2 path is only valid for reload actions")
    device = serial_device(args.device)
    if args.action == "info":
        print(f"serial: {device}")
        for label in ("EPROMEMU", "RPI-RP2"):
            print(f"{label}: {volume(label) or 'not mounted'}")
    elif args.action == "eject":
        unmount_storage()
        send(device, "eject")
    elif args.action == "mount":
        send(device, "mount")
        print(f"ROM storage: {wait_volume('EPROMEMU', args.timeout)}")
    elif args.action == "reset":
        send(device, "reset")
    else:
        build = "build-aperture" if args.action == "reload-aperture" else "build"
        source = args.uf2 or ROOT / "romulator" / build / "pico_eprom_emulator.uf2"
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
        if args.action == "reload-aperture":
            print("This firmware exposes CDC only; no EPROMEMU disk should mount.")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (OSError, RuntimeError, subprocess.CalledProcessError) as error:
        print(f"FAIL: {error}", file=sys.stderr)
        raise SystemExit(1)
