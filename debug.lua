--  debug.lua by YuLun
--  Jan 06 2023

function DebugAxis(trans, opt_size)
	local size = math.abs(opt_size or 1)
	local tPos = trans.pos
	local Xvec = Vec(size, 0, 0)
	local Yvec = Vec(0, size, 0)
	local Zvec = Vec(0, 0, size)

	local worldX = TransformToParentVec(trans, Xvec)
	local worldY = TransformToParentVec(trans, Yvec)
	local worldZ = TransformToParentVec(trans, Zvec)

	DebugLine(tPos, VecAdd(tPos, worldX), 1, 0, 0)
	DebugLine(tPos, VecAdd(tPos, worldY), 0, 1, 0)
	DebugLine(tPos, VecAdd(tPos, worldZ), 0, 0, 1)
end

function DebugHexLine(pos0, pos1, hexColor, opt_alpha)
	local r, g, b = HexToRGB(hexColor, false)
	DebugLine(pos0, pos1, r, g, b, opt_alpha or 1)
end

function DebugRGBLine(pos0, pos1, RGBcolor, opt_alpha)
	DebugLine(pos0, pos1, RGBcolor[1], RGBcolor[2], RGBcolor[3], opt_alpha or 1)
end

function DebugHexCross(pos0, hexColor, opt_alpha)
	local r, g, b = HexToRGB(hexColor, false)
	DebugCross(pos0, r, g, b, opt_alpha or 1)
end

function DebugRGBCross(pos0, RGBcolor, opt_alpha)
	DebugCross(pos0, RGBcolor[1], RGBcolor[2], RGBcolor[3], opt_alpha or 1)
end
