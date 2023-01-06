--	vec.lua	by YuLun
--	Jan 06 2023

function VecAlignXZ(vec0, vec1)
	return VecNormalize(VecCross(vec0, vec1))
end

function TransformToLocalQuat(trans, quat)
	local trans1 = Transform(Vec(), quat)
	local trans1Loc = TransformToLocalTransform(trans, trans1)
	return trans1Loc.rot
end

function TransformToParentQuat(trans, quat)
	local trans1 = Transform(Vec(), quat)
	local trans1Loc = TransformToParentTransform(trans, trans1)
	return trans1Loc.rot
end
