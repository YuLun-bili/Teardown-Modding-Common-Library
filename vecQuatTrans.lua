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

function FormatAabb(min, max)
	local checkList = {min, max}
	for l=1, 2 do
		if type(checkList[l]) ~= "table" then
			error([[unexpected variable type for argument #]]..l..[[ (table [Teardown vector] expected)]], 2)
			return
		end
		local checkPoint = true
		local point = checkList[l]
		for i=1, 3 do
			checkPoint = type(point[i]) == "number" and checkPoint
			if not checkPoint then break end
		end
		if not checkPoint then
			error([[unexpected variable type for argument #]]..l..[[ (table [Teardown vector] expected)]], 2)
			return
		end
	end
	local newMin, newMax = {}, {}
	for i=1, 3 do
		newMin[i] = min[i] < max[i] and min[i] or max[i]
		newMax[i] = max[i] > min[i] and max[i] or min[i]
	end
	return newMin, newMax
end

function IsPointInAabb(point, min, max)
	local checkList = {point, min, max}
	for l=1, 3 do
		if type(checkList[l]) ~= "table" then
			error([[unexpected variable type for argument #]]..l..[[ (table [Teardown vector] expected)]], 2)
			return
		end
		local checkPoint = true
		local Cpoint = checkList[l]
		for i=1, 3 do
			checkPoint = type(Cpoint[i]) == "number" and checkPoint
			if not checkPoint then break end
		end
		if not checkPoint then
			error([[unexpected variable type for argument #]]..l..[[ (table [Teardown vector] expected)]], 2)
			return
		end
	end
	local Lmin, Lmax = FormatAabb(min, max)
	local inCheck = true
	for i=1, 3 do
		inCheck = point[i] > Lmin[i] and point[i] < Lmax[i] and inCheck
		if not inCheck then break end
	end
	return inCheck
end

function IsAabbOverlapping(min0, max0, min1, max1)
	local checkList = {min0, max0, min1, max1}
	for l=1, 4 do
		if type(checkList[l]) ~= "table" then
			error([[unexpected variable type for argument #]]..l..[[ (table [Teardown vector] expected)]], 2)
			return
		end
		local checkPoint = true
		local point = checkList[l]
		for i=1, 3 do
			checkPoint = type(point[i]) == "number" and checkPoint
			if not checkPoint then break end
		end
		if not checkPoint then
			error([[unexpected variable type for argument #]]..l..[[ (table [Teardown vector] expected)]], 2)
			return
		end
	end
	local Lmin0, Lmax0 = FormatAabb(min0, max0)
	local Lmin1, Lmax1 = FormatAabb(min1, max1)
	if (IsPointInAabb(Lmin0, Lmin1, Lmax1) and IsPointInAabb(Lmax0, Lmin1, Lmax1)) or (IsPointInAabb(Lmin1, Lmin0, Lmax0) and IsPointInAabb(Lmax1, Lmin0, Lmax0)) then
		return true
	end
	local overCheck = true
	for i=1, 3 do
		local totalLen = Lmax0[i]-Lmin0[i]+Lmax1[i]-Lmin1[i]
		local diffLen0, diffLen1 = Lmax0[i]-Lmin1[i], Lmax1[i]-Lmin0[i]
		local diffLen = diffLen0 > diffLen1 and diffLen0 or diffLen1
		overCheck = diffLen > totalLen and overCheck
		if not overCheck then break end
	end
	return overCheck
end