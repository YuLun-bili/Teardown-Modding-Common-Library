--	vehicle.lua	by YuLun
--	Mar 15 2023

function GetVehicleWheelBodies(vehicle)
	local list = {}
	local allBodies = FindBodies(nil, true)
	for i=1, #allBodies do
		local body = allBodies[i]
		if body > vehicle and not IsBodyDynamic(body) and GetBodyVehicle(body) == vehicle then
			local allLess = true
			for k, shape in ipairs(GetBodyShapes(body)) do
				if shape > body then allLess = false break end
			end
			if allLess then table.insert(list, body) end
		end
	end
	return list
end

function GetVehicleWheelShapes(vehicle)
	local list = {}
	local allBodies = FindBodies(nil, true)
	for i=1, #allBodies do
		local body = allBodies[i]
		if body > vehicle and GetBodyVehicle(body) == vehicle and not IsBodyDynamic(body) then
			local allLess = true
			local bodyShapes = GetBodyShapes(body)
			for k, shape in ipairs(bodyShapes) do
				if shape > body then allLess = false break end
			end
			if allLess then
				for k, shape in ipairs(bodyShapes) do table.insert(list, shape) end
			end
		end
	end
	return list
end

function GetVehicleBodies(vehicle)
	local list = {}
	local allBodies = FindBodies(nil, true)
	for i=1, #allBodies do
		local body = allBodies[i]
		if body > vehicle and GetBodyVehicle(body) == vehicle then table.insert(list, body) end
	end
	return list
end
