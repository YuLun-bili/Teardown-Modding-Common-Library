--	vehicle.lua	by YuLun
--	Feb 02 2023

function GetVehicleWheelBodies(vehicle)
	local list = {}
	for i, body in ipairs(FindBodies(nil, true)) do
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

function GetVehicleBodies(vehicle)
	local list = {}
	for i, body in ipairs(FindBodies(nil, true)) do
		if body > vehicle and GetBodyVehicle(body) == vehicle then table.insert(list, body) end
	end
	return list
end
