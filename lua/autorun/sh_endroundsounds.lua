WST = {}
local math = math
function math.Clamp01(val)
	return math.Clamp(val, 0, 1)
end