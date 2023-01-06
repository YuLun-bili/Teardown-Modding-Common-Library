--	body.lua	by YuLun
--	Jan 06 2023

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

function GetBodyHeading(handle, opt_vec)
	local trans = GetBodyTransform(handle)
	local heading = TransformToParentVec(trans, opt_vec or Vec(0, 0, -1))
	return heading
end
