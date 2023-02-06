--	fire.lua	by YuLun
--	Jan 28 2023

function LocateFire(center, radius_pow, accuracy_pow)
	if GetFireCount() == 0 then return {} end
	local rPow = math.floor(tonumber(radius_pow) or 0)
	local aPow = math.floor(tonumber(accuracy_pow) or 0)
	local radius = 2^rPow
	local accuracy = 2^aPow
	local minPos = VecAdd(center, Vec(-radius, -radius, -radius))
	local maxPos = VecAdd(center, Vec( radius,  radius,  radius))
	local fireCount = QueryAabbFireCount(minPos, maxPos)
	if fireCount == 0 then return {} end
	if radius <= (accuracy/2) then
		return {pos = center, count = fireCount}
	end
	local fireTable = {}
	local newR = radius/2
	local newC = {
		VecAdd(center, Vec( newR,  newR,  newR)),
		VecAdd(center, Vec( newR,  newR, -newR)),
		VecAdd(center, Vec( newR, -newR,  newR)),
		VecAdd(center, Vec( newR, -newR, -newR)),
		VecAdd(center, Vec(-newR,  newR,  newR)),
		VecAdd(center, Vec(-newR,  newR, -newR)),
		VecAdd(center, Vec(-newR, -newR,  newR)),
		VecAdd(center, Vec(-newR, -newR, -newR)),
	}
	for i=1, 8 do
		local returnTable = LocateFire(newC[i], rPow-1, aPow)
		if not returnTable then break end
		if returnTable.pos then table.insert(fireTable, returnTable) break end
		for t, fire in ipairs(returnTable) do
			table.insert(fireTable, fire)
		end
	end
	return fireTable
end