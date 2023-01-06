--	trigger.lua	by YuLun
--	Jan 06 2023

function GetTriggerRadius(handle)
	local vec0, vec1 = GetTriggerBounds(handle)
	return math.abs(vec1[1]-vec0[1])/2
end
