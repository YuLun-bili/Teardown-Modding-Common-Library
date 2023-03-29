--	draw.lua	by YuLun
--	Mar 29 2023

function DrawAxis(trans, opt_size)
	local size = math.abs(opt_size or 1)
	local tPos = trans.pos
	local Xvec = Vec(size, 0, 0)
	local Yvec = Vec(0, size, 0)
	local Zvec = Vec(0, 0, size)

	local worldX = TransformToParentVec(trans, Xvec)
	local worldY = TransformToParentVec(trans, Yvec)
	local worldZ = TransformToParentVec(trans, Zvec)

	DrawLine(tPos, VecAdd(tPos, worldX), 1, 0, 0)
	DrawLine(tPos, VecAdd(tPos, worldY), 0, 1, 0)
	DrawLine(tPos, VecAdd(tPos, worldZ), 0, 0, 1)
end

function DrawHexLine(pos0, pos1, hexColor, opt_alpha)
	local r, g, b = HexToRGB(hexColor, false)
	DrawLine(pos0, pos1, r, g, b, opt_alpha or 1)
end

function DrawRGBLine(pos0, pos1, RGBcolor, opt_alpha)
	if type(RGBcolor) ~= "table" then
		error([[bad argument #3 to 'DrawRGBLine' (table [RGB] expected, got ]]..type(RGBcolor)..[[)]], 2)
	end
	DrawLine(pos0, pos1, RGBcolor[1], RGBcolor[2], RGBcolor[3], opt_alpha or 1)
end

function DrawShapeHexOutline(handle, hexColor, opt_alpha)
	local r, g, b = HexToRGB(hexColor, false)
	DrawShapeOutline(handle, r, g, b, opt_alpha or 1)
end

function DrawShapeRGBOutline(handle, RGBcolor, opt_alpha)
	if type(RGBcolor) ~= "table" then
		error([[bad argument #2 to 'DrawShapeRGBOutline' (table [RGB] expected, got ]]..type(RGBcolor)..[[)]], 2)
	end
	DrawShapeOutline(handle, RGBcolor[1], RGBcolor[2], RGBcolor[3], opt_alpha or 1)
end

function DrawBodyHexOutline(handle, hexColor, opt_alpha)
	local r, g, b = HexToRGB(hexColor, false)
	DrawBodyOutline(handle, r, g, b, opt_alpha or 1)
end

function DrawBodyRGBOutline(handle, RGBcolor, opt_alpha)
	if type(RGBcolor) ~= "table" then
		error([[bad argument #2 to 'DrawBodyRGBOutline' (table [RGB] expected, got ]]..type(RGBcolor)..[[)]], 2)
	end
	DrawBodyOutline(handle, RGBcolor[1], RGBcolor[2], RGBcolor[3], opt_alpha or 1)
end

function DrawHexSprite(handle, trans, width, height, hexColor, opt_alpha, opt_depthTest, opt_additive)
	local r, g, b = HexToRGB(hexColor, false)
	DrawSprite(handle, trans, width, height, r, g, b, opt_alpha or 1, opt_depthTest, opt_additive)
end

function DrawRGBSprite(handle, trans, width, height, RGBcolor, opt_alpha, opt_depthTest, opt_additive)
	if type(RGBcolor) ~= "table" then
		error([[bad argument #5 to 'DrawRGBSprite' (table [RGB] expected, got ]]..type(RGBcolor)..[[)]], 2)
	end
	DrawSprite(handle, trans, width, height, RGBcolor[1], RGBcolor[2], RGBcolor[3], opt_alpha or 1, opt_depthTest, opt_additive)
end
