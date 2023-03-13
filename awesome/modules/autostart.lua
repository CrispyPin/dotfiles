local awful = require("awful")
require("modules/smart_reload")
require("modules/laptop_detector")

if is_reloading() then
	finish_reload()
	return
end

awful.spawn(CONFIG_DIR .. "utils/xcape_conf.sh") -- xcape config
awful.spawn("picom -b") -- compositor
awful.spawn("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1") -- authentication popup for obs virtual camera etc
awful.spawn("redshift")
awful.spawn("sxhkd")

if not is_laptop then
	awful.spawn("numlockx on") -- numlock
	awful.spawn(CONFIG_DIR .. "utils/xrandr_conf.sh") -- xrandr config

	awful.spawn("discord", { screen = 3 })
	awful.spawn("vscodium")
	awful.spawn("spotify", { tag = "2", screen = 3, urgent = false })
	awful.spawn("firefox")

	awful.spawn(terminal .. " -e fish -c \"sleep 2 && gomuks\"", { tag = "3", screen = 3, urgent = false, focus = false })
	awful.spawn(terminal .. " -e fish -c \"sleep 5 && ncpamixer\"",
		{ tag = "4", screen = 3, urgent = false, focus = false })
	awful.spawn(terminal .. " -e btop", { tag = "5", screen = 3, urgent = false, focus = false })
	awful.spawn(terminal .. " -e fish -c \"sleep 5 && snoud\"", { tag = "6", screen = 3, urgent = false, focus = false })
end
