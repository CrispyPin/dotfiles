local awful = require("awful")
require("modules/smart_reload")
require("modules/laptop_detector")

if is_reloading() then
	finish_reload()
	return
end

awful.spawn("picom -b")
awful.spawn("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1") -- authentication popup for obs virtual camera etc
awful.spawn("redshift")
awful.spawn("sxhkd")

if not is_laptop then
	awful.spawn("vesktop")
	awful.spawn("vscodium")
	awful.spawn("spotify")
	awful.spawn("firefox")
	awful.spawn("cinny")

	local side_monitor = screen:count()
	awful.spawn(terminal .. " -e fish -C \"sleep 5 && ncpamixer\"",
		{ tag = "3", screen = side_monitor, urgent = false, focus = false })
	awful.spawn(terminal .. " -e fish -C btop", { tag = "4", screen = side_monitor, urgent = false, focus = false })
	awful.spawn(terminal .. " -e fish -C \"sleep 5 && snoud\"",
		{ tag = "5", screen = side_monitor, urgent = false, focus = false })
end
