local awful = require("awful")

CONFIG_DIR = awful.util.get_configuration_dir()
HOME_DIR = CONFIG_DIR .. "../../"

local function file_exists(name)
	local f = io.open(name, "r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

local INDICATOR_FILE = "/tmp/awesome_is_restarting"

function test()
	local focused_client = awful.client.focus.history.get()
	focused_client:raise()
end

function smart_reload()
	awful.spawn("touch " .. INDICATOR_FILE)
	awesome.restart()
end

function is_reloading()
	return file_exists(INDICATOR_FILE)
end

function finish_reload()
	awful.spawn("rm " .. INDICATOR_FILE)
end
