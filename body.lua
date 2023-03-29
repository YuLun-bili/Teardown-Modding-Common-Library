--	body.lua	by YuLun
--	Jan 16 2023

function GetBodyJoints(handle)
	local shapes = GetBodyShapes(handle)
	local joints = {}
	for i, shape in ipairs(shapes) do
		local tempJoints = GetShapeJoints(shape)
		for j, joint in ipairs(tempJoints) do
			table.insert(joints, joint)
		end
	end
	return joints
end

function GetBodyLights(handle)
	local shapes = GetBodyShapes(handle)
	local lights = {}
	for i, shape in ipairs(shapes) do
		local tempLights = GetShapeLights(shape)
		for j, light in ipairs(tempLights) do
			table.insert(lights, light)
		end
	end
	return lights
end

function GetBodyVoxelCount(handle)
	local shapes = GetBodyShapes(handle)
	local count = 0
	for i, shape in ipairs(shapes) do
		count = count+(GetShapeVoxelCount(shape) or 0)
	end
	return count
end

function SetBodyCollisionFilter(handle, layer, mask)
	local shapes = GetBodyShapes(handle)
	for i, shape in ipairs(shapes) do
		SetShapeCollisionFilter(shape, layer, mask)
	end
end

function GetBodyHeading(handle, opt_vec)
	local trans = GetBodyTransform(handle)
	local heading = TransformToParentVec(trans, opt_vec or Vec(0, 0, -1))
	return heading
end

function GetBodyCentre(handle)
	local min, max = GetBodyBounds(handle)
	return VecLerp(min, max, 0.5)
end

function IsBodyTouching(body0, body1)
	local min0, max0 = GetBodyBounds(body0)
	local min1, max1 = GetBodyBounds(body1)
	if not IsAabbOverlapping(min0, max0, min1, max1) then return false end
	local bodyCentre0 = VecLerp(min0, max0, 0.5)
	local bodyCentre1 = VecLerp(min1, max1, 0.5)
	local hit0, point0, _, shape0 = GetBodyClosestPoint(body0, bodyCentre1)
	local hit1, point1, _, shape1 = GetBodyClosestPoint(body1, bodyCentre0)
	if hit0 and hit1 and IsShapeTouching(shape0, shape1) then return true end
	local hit0, point0, _, shape0 = GetBodyClosestPoint(body0, point1)
	local hit1, point1, _, shape1 = GetBodyClosestPoint(body1, point0)
	if hit0 and hit1 and IsShapeTouching(shape0, shape1) then return true end
	local shapes0 = GetBodyShapes(body0)
	local shapes1 = GetBodyShapes(body1)
	for i=1, #shapes0 do
		for j=1, #shapes1 do
			if IsShapeTouching(shapes0[i], shapes1[j]) then return true end
		end
	end
	return false
end
