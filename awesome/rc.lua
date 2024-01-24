-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
CONFIG_DIR = awful.util.get_configuration_dir()
HOME_DIR = CONFIG_DIR .. "../../"
SCRIPTS_DIR = HOME_DIR .. "dotfiles/scripts/"
HOME_BIN = HOME_DIR .. "bin/"
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

require("modules/smart_reload")
require("modules/laptop_detector")

modkey = "Mod4" -- super
require("modules/navigation_keys")
require("modules/special_keys")

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error",
		function(err)
			-- avoid endless error loop
			if in_error then return end
			in_error = true
			naughty.notify({
				preset = naughty.config.presets.critical,
				title = "Error loading config!",
				text = tostring(err)
			})
			in_error = false
		end
	)
end


-- Theme
local theme_path = CONFIG_DIR .. "/themes/default/"
beautiful.init(theme_path .. "theme.lua")
-- naughty.notify({ title = "Theme loaded", text = tostring(theme_path), icon = theme_path .. "icon.png", screen = 1 })
-- naughty.notify({ title = "Screen count", text = tostring(screen:count()), icon = theme_path .. "icon.png", screen = 1 })
require("modules/brightness")
require("modules/battery")

-- default apps
terminal = "kitty"
file_manager = "pcmanfm"


awful.menu.menu_keys = {
	up = { "Up", "k", "q", "w" },
	down = { "Down", "j", "Tab", "s" },
	back = { "Left", "h", "a" },
	exec = { "Return", "Space" },
	enter = { "Right", "l", "d" },
	close = { "Escape" },
}

-- Menu
-- Create a launcher widget and a main menu
local system_menu = {
	{ "keyboard layout", {
		{ "SE", function() awful.spawn("setxkbmap -layout se") end },
		{ "US", function() awful.spawn("setxkbmap -layout us") end },
	} },
	{ "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
	{ "reload",  smart_reload },
	{ "log out", function() awesome.quit() end },
	{ "shut down", {
		{ "now",    function() awful.spawn("shutdown now") end },
		{ "in 60s", function() awful.spawn("shutdown") end }
	} },
}

local main_menu = awful.menu({
	items = {
		{ "system",       system_menu,                                                                       beautiful.awesome_icon },
		{ "terminal",     terminal },
		{ "file manager", file_manager },
		{ "OVR Utils",    function() awful.spawn("./proj/godot/ovr-utils/builds/linux/ovr-utils.x86_64") end },
		{ "sinpin-vr",    function() awful.spawn(terminal .. " -e fish -C ~/bin/sinpin-vr/sinpin_vr") end },
		{ "close menu", function()
		end }
	}
})


local launcher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = main_menu })
local blahaj = awful.widget.button({
	image = beautiful.blahaj,
	menu = function()
		awful.spawn(
			"xdg-open https://www.ikea.com/se/sv/p/blahaj-mjukleksak-haj-30373588/")
	end
})

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
menubar.show_categories = false
menubar.menu_gen.all_menu_dirs = {
	"/usr/share/applications/",
	HOME_DIR .. ".local/share/applications/",
	--"/var/lib/flatpak/exports/share/applications",
}

local juneday = awful.widget.watch(HOME_BIN .. "june", 600, function(widget, stdout)
	for line in stdout:gmatch("[^\r\n]+") do
		widget.text = " [ " .. line .. " ] "
		break
	end
end)

local kb_battery = awful.widget.watch(SCRIPTS_DIR .. "kb_battery.py", 60, function(widget, stdout)
	for line in stdout:gmatch("[^\r\n]+") do
		widget.text = " [ " .. line .. " ] "
		break
	end
end)

local birthday = awful.widget.watch(SCRIPTS_DIR .. "bdays.sh", 600, function(widget, stdout)
	widget.text = ""
	for line in stdout:gmatch("[^\r\n]+") do
		widget.text = widget.text .. line .. " "
	end
	if widget.text ~= "" then
		widget.text = "[ Birthday: " .. widget.text .. "]"
	end
end)

local steamvr_status = awful.widget.watch("cat /tmp/steamvr_battery_status", 1, function(widget, stdout)
	widget.text = ""
	for line in stdout:gmatch("[^\r\n]+") do
		widget.text = " [ " .. line .. "] "
		break
	end
end)

-- Create a textclock widget
local textclock = awful.widget.textclock()

-- Create a wibox for each screen and add it
-- buttons for each tag widget
local taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t) t:view_only() end),
	awful.button({ modkey }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),
	awful.button({}, 5, function(t)
		awful.tag.viewnext()
	end),
	awful.button({}, 4, function(t)
		awful.tag.viewprev()
	end)
)

-- main section of top bar
local tasklist_buttons = gears.table.join(
	awful.button({}, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			c:emit_signal(
				"request::activate",
				"tasklist",
				{ raise = true }
			)
		end
	end),
	awful.button({}, 3, function()
		awful.menu.client_list({ theme = { width = 250 } })
	end)
)

local function set_wallpaper(s)
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper
		-- If wallpaper is a function, call it with the screen
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end
		gears.wallpaper.centered(wallpaper, s)
	end
end

awful.screen.connect_for_each_screen(function(s)
	set_wallpaper(s)

	-- Each screen has its own tag table.
	awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.suit.corner.nw)

	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist {
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = taglist_buttons
	}

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist {
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons
	}

	-- Create the wibox
	s.mywibox = awful.wibar({ position = "top", screen = s })

	-- Add widgets to the wibox
	s.mywibox:setup {
		layout = wibox.layout.align.horizontal,
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			launcher,
			s.mytaglist,
			blahaj,
		},
		s.mytasklist, -- Middle widget
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			brightness.piechart,
			battery_widget,
			-- wibox.widget.systray(),
			steamvr_status,
			birthday,
			kb_battery,
			juneday,
			textclock,
			--s.mylayoutbox,
		},
	}
end)

-- Mouse bindings for background
root.buttons(gears.table.join(
	awful.button({}, 3, function() main_menu:toggle() end)
))

-- global key bindings
local globalkeys = gears.table.join(
	awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
	awful.key({ modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
	awful.key({ modkey, "Control" }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
	awful.key({ modkey }, "a", awful.tag.viewprev, { description = "view previous", group = "tag" }),
	awful.key({ modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
	awful.key({ modkey, "Control" }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
	awful.key({ modkey }, "d", awful.tag.viewnext, { description = "view next", group = "tag" }),
	awful.key({ modkey }, "j",
		function()
			awful.client.focus.byidx(1)
		end,
		{ description = "focus next by index", group = "client" }
	),
	awful.key({ modkey }, "k",
		function()
			awful.client.focus.byidx(-1)
		end,
		{ description = "focus previous by index", group = "client" }
	),
	awful.key({ modkey }, "Return", function() awful.spawn(terminal) end,
		{ description = "open terminal", group = "launcher" }),
	awful.key({ modkey, "Control" }, "r", smart_reload,
		{ description = "reload awesome", group = "awesome" }),
	awful.key({ modkey }, "l", function() awful.tag.incmwfact(0.05) end,
		{ description = "increase master width factor", group = "layout" }),
	awful.key({ modkey }, "h", function() awful.tag.incmwfact(-0.05) end,
		{ description = "decrease master width factor", group = "layout" }),
	awful.key({ modkey, "Shift" }, "h", function() awful.tag.incnmaster(1, nil, true) end,
		{ description = "increase the number of master clients", group = "layout" }),
	awful.key({ modkey, "Shift" }, "l", function() awful.tag.incnmaster(-1, nil, true) end,
		{ description = "decrease the number of master clients", group = "layout" }),
	awful.key({ modkey, "Control" }, "h", function() awful.tag.incncol(1, nil, true) end,
		{ description = "increase the number of columns", group = "layout" }),
	awful.key({ modkey, "Control" }, "l", function() awful.tag.incncol(-1, nil, true) end,
		{ description = "decrease the number of columns", group = "layout" }),
	awful.key({ modkey }, "space", function() awful.layout.inc(1) end,
		{ description = "select next", group = "layout" }),
	awful.key({ modkey, "Shift" }, "space", function() awful.layout.inc(-1) end,
		{ description = "select previous", group = "layout" }),

	awful.key({ modkey, "Control" }, "n",
		function()
			local c = awful.client.restore()
			-- Focus restored client
			if c then
				c:emit_signal("request::activate", "key.unminimize", { raise = true })
			end
		end,
		{ description = "restore minimized", group = "client" }),

	-- Menubar
	awful.key({ modkey }, "Escape", function() menubar.show() end,
		{ description = "show the menubar", group = "launcher" }),
	awful.key({ modkey }, "e", function() menubar.show() end,
		{ description = "show the menubar", group = "launcher" }),
	awful.key({ modkey }, "f", function() awful.spawn(file_manager) end,
		{ description = "open files", group = "launcher" }),
	awful.key({ modkey }, "t", function() awful.spawn(terminal) end,
		{ description = "open terminal", group = "launcher" }),
	-- alt-tab menu
	awful.key({ "Mod1" }, "Tab", function()
			awful.spawn("rofi -show")
		end,
		{ description = "rofi", group = "launcher" })

)
globalkeys = gears.table.join(globalkeys, special_keys, navigation_keys)

local clientkeys = gears.table.join(
	awful.key({ modkey, "Shift" }, "f",
		function(c)
			c.fullscreen = not c.fullscreen
			c:raise()
		end,
		{ description = "toggle fullscreen", group = "client" }),
	awful.key({ modkey }, "q",
		function(c) c:kill() end,
		{ description = "close", group = "client" }),
	awful.key({ modkey, "Control" }, "space",
		awful.client.floating.toggle,
		{ description = "toggle floating", group = "client" }),
	awful.key({ modkey, "Shift" }, "t",
		function(c) c.ontop = not c.ontop end,
		{ description = "toggle keep on top", group = "client" }),
	awful.key({ modkey }, "n",
		function(c) c.minimized = true end,
		{ description = "minimize", group = "client" }),

	awful.key({ modkey }, "m",
		function(c)
			c.maximized = not c.maximized
			c:raise()
		end,
		{ description = "(un)maximize", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	globalkeys = gears.table.join(globalkeys,
		-- View tag only.
		awful.key({ modkey }, "#" .. i + 9,
			function()
				local screen = awful.screen.focused()
				local tag = screen.tags[i]
				if tag then
					tag:view_only()
				end
			end,
			{ description = "view tag #" .. i, group = "tag" }),
		-- Toggle tag display.
		awful.key({ modkey, "Control" }, "#" .. i + 9,
			function()
				local screen = awful.screen.focused()
				local tag = screen.tags[i]
				if tag then
					awful.tag.viewtoggle(tag)
				end
			end,
			{ description = "toggle tag #" .. i, group = "tag" }),
		-- Move client to tag.
		awful.key({ modkey, "Shift" }, "#" .. i + 9,
			function()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then
						client.focus:move_to_tag(tag)
					end
				end
			end,
			{ description = "move focused client to tag #" .. i, group = "tag" })
	)
end

-- client mouse input
local clientbuttons = gears.table.join(
	awful.button({}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),
	awful.button({ modkey }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),
	awful.button({ modkey }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)

-- Set keys
root.keys(globalkeys)

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
	-- All clients will match this rule.
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen
		}
	},

	-- Floating clients.
	{
		rule_any = {
			instance = {
				"pavucontrol",
			},
			class = {
				"Arandr",
				--"Godot_Engine",
			},
			-- Note that the name property shown in xprop might be set slightly after creation of the client
			-- and the name shown there might not match defined rules here.
			name = {
				"Event Tester", -- xev
				"Steam",
				"Friends List",
				"Beataroni",
				"ovr-utils",
				"Godot",
			},
		},
		properties = { floating = true, placement = awful.placement.no_offscreen }
	},

	-- Add titlebars to normal clients and dialogs
	{
		rule_any = { type = { "normal", "dialog" }
		},
		properties = { titlebars_enabled = true }
	},
	{
		rule_any = { name = { "Launching steam" }
		},
		properties = { focus = false, raise = false }
	},
	{
		rule = {
			class = "/home/crispypin/bin/ovr-utils/ovr-utils.x86_64",
		},
		properties = { floating = true, width = 16, height = 16, tag = "9" }
	},
}

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(client)
	if awesome.startup
		and not client.size_hints.user_position
		and not client.size_hints.program_position then
		awful.placement.no_offscreen(client)
	end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(client)
	if client.focus ~= nil then
		local focus_class = client.focus.class
		-- naughty.notify({title = focus_class}) -- DEBUG
		if focus_class == "steam_app_361420" or -- astroneer
			focus_class == "minecraft" then
			return
		end
	end
	client:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)


require("modules/autostart")


-- Run garbage collector regularly to prevent memory leaks
-- gears.timer {
-- 	timeout = 60,
-- 	autostart = true,
-- 	callback = function() collectgarbage() end
--}
