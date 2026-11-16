-- Regression test for the source-relocatable playfield PCHL table.
-- Rollover 1's handler is deliberately moved from $145f to ROM 5 at $2ff9;
-- this input only works if the table contains the newly assembled label value.
local frame = 0
local controls = manager.machine.ioport.ports[":X4"]
local playfield = manager.machine.ioport.ports[":PF"]
local rollovers = manager.machine.ioport.ports[":ROLLOVER"]
local coin = controls:field(0x10)
local start = controls:field(0x80)
local launch = playfield:field(0x04)
local rollover_1 = rollovers:field(0x01)
local program = manager.machine.devices[":v2cpu"].spaces["program"]
local before_score = 0
local before_rollovers = 0

emu.register_frame_done(function()
	frame = frame + 1
	if frame == 180 then coin:set_value(1)
	elseif frame == 185 then coin:clear_value()
	elseif frame == 300 then start:set_value(1)
	elseif frame == 305 then start:clear_value()
	elseif frame == 720 then launch:set_value(1)
	elseif frame == 725 then launch:clear_value()
	elseif frame == 950 then
		before_score = program:read_u8(0x2363)
		before_rollovers = program:read_u8(0x21c6)
	elseif frame == 1000 then rollover_1:set_value(1)
	elseif frame == 1005 then rollover_1:clear_value()
	elseif frame == 1150 then
		local after_score = program:read_u8(0x2363)
		local after_rollovers = program:read_u8(0x21c6)
		-- This handler owns rollover bit zero.  Score/display bookkeeping is
		-- deferred elsewhere, so the bit transition is the direct dispatch proof.
		local passed = after_rollovers == (before_rollovers & 0xfe)
		emu.print_error(string.format(
			"relocated rollover: %s score=%02x>%02x rollovers=%02x>%02x",
			passed and "PASS" or "FAIL", before_score, after_score,
			before_rollovers, after_rollovers))
	end
end, "micropin_relocated_rollover")
