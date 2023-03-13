local function file_exists(name)
	local f = io.open(name, "r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

is_laptop = file_exists("/sys/class/power_supply/BAT0/capacity")
--is_laptop = true
