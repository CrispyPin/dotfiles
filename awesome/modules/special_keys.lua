local awful = require("awful")
local gears = require("gears")

require("modules/laptop_detector")

special_keys = gears.table.join(
	awful.key({ "Ctrl" }, "Print", function()
		awful.util.spawn(SCRIPTS_DIR .. "screenshot_selection.sh")
	end,
		{ description = "screenshot selection", group = "screenshot" }),

	awful.key({ modkey, "Shift" }, "s", function()
		awful.util.spawn(SCRIPTS_DIR .. "screenshot_selection.sh")
	end,
		{ description = "screenshot selection", group = "screenshot" }),

	awful.key({}, "Print", function()
		awful.util.spawn(SCRIPTS_DIR .. "screenshot_full.sh")
	end,
		{ description = "full screenshot", group = "screenshot" }),

	awful.key({ "Shift" }, "Print", function()
		awful.util.spawn(SCRIPTS_DIR .. "record_mp4.sh")
	end,
		{ description = "record selection", group = "screenshot" }),

	awful.key({ modkey }, "Print", function()
		awful.util.spawn(SCRIPTS_DIR .. "screenshot_active.sh")
	end,
		{ description = "screenshot active window", group = "screenshot" }),


	awful.key({ modkey }, "r", function()
		awful.util.spawn("rofi -show")
	end,
		{ description = "Rofi", group = "launcher" }),

	-- awful.key({ "Ctrl", "Shift" }, "E", function()
	awful.key({ modkey }, "u", function()
		awful.util.spawn(SCRIPTS_DIR .. "emoji_picker.sh")
	end,
		{ description = "Emoji picker", group = "launcher" }),


	-- Media Keys
	awful.key({}, "XF86AudioPlay", function()
		awful.util.spawn("playerctl play-pause", false)
	end),
	awful.key({}, "XF86AudioNext", function()
		awful.util.spawn("playerctl next", false)
	end),
	awful.key({}, "XF86AudioPrev", function()
		awful.util.spawn("playerctl previous", false)
	end)
)

if is_laptop then
	special_keys = gears.table.join(
		special_keys,
		awful.key({}, "XF86MonBrightnessUp", function()
			awful.spawn("/usr/bin/simple-brightness -inc 32")
		end,
			{ description = "Increase brightness", group = "laptop" }),

		awful.key({}, "XF86MonBrightnessDown", function()
			awful.spawn("/usr/bin/simple-brightness -dec 32")
		end,
			{ description = "Lower brightness", group = "laptop" })
	)
end
