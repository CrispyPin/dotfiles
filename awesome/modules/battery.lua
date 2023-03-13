local awful = require("awful")
local wibox = require("wibox")
--local beautiful = require("beautiful")
local gears = require("gears")

require("modules/laptop_detector")

if not is_laptop then
	battery_widget = wibox.widget.textbox()
	return
end


local tohex = function(value)
	local h = string.format("%x", value)
	if h:len() == 1 then
		h = "0" .. h
	end
	return h
end

-- battery percentage
local battery_text = awful.widget.watch("cat /sys/class/power_supply/BAT0/capacity", 30, function(widget, stdout)
	for line in stdout:gmatch("[^\r\n]+") do
		widget.text = line .. "%"
		break
	end

	widget.align = "center"
end)

local battery_charging = awful.widget.watch("cat /sys/class/power_supply/AC/online", 5, function(widget, stdout)
	for line in stdout:gmatch("[^\r\n]+") do
		if line == "1" then
			widget.text = " +"
		else
			widget.text = " -"
		end
		break
	end
end)

local battery_bar = awful.widget.watch("cat /sys/class/power_supply/BAT0/capacity", 30, function(widget, stdout)
	local charge = 0
	for line in stdout:gmatch("[^\r\n]+") do
		charge = tonumber(line)
		break
	end
	widget.value = charge
	local red = 0
	local green = 102
	if charge <= 50 then
		red = (50 - charge) * 5
		green = charge * 2
	end
	local color             = "#" .. tohex(red) .. tohex(green) .. "00"
	widget.color            = color
	widget.max_value        = 100
	widget.forced_width     = 64
	widget.border_color     = color --"#008866"
	widget.background_color = "#000000"
	widget.border_width     = 1
	widget.shape            = function(cr, width, height) gears.shape.octogon(cr, width, height, 2) end
	widget.margins          = { top = 1, bottom = 1, left = 5, right = 5 }
end,
	wibox.widget.progressbar())


battery_widget = {
	battery_bar,
	battery_text,
	battery_charging,
	layout = wibox.layout.stack
}
