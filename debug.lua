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
	if type(RGBcolor) ~= "table" then
		error([[bad argument #3 to 'DebugRGBLine' (table [RGB] expected, got ]]..type(RGBcolor)..[[)]], 2)
	end
	DebugLine(pos0, pos1, RGBcolor[1], RGBcolor[2], RGBcolor[3], opt_alpha or 1)
end

function DebugHexCross(pos0, hexColor, opt_alpha)
	local r, g, b = HexToRGB(hexColor, false)
	DebugCross(pos0, r, g, b, opt_alpha or 1)
end

function DebugRGBCross(pos0, RGBcolor, opt_alpha)
	if type(RGBcolor) ~= "table" then
		error([[bad argument #2 to 'DebugRGBCross' (table [RGB] expected, got ]]..type(RGBcolor)..[[)]], 2)
	end
	DebugCross(pos0, RGBcolor[1], RGBcolor[2], RGBcolor[3], opt_alpha or 1)
end

function DebugAabb(min, max, opt_r, opt_g, opt_b, opt_alpha)
	local checkList = {min, max}
	local name = "DebugAabb"
	for l=1, 2 do
		if type(checkList[l]) ~= "table" then
			error([[bad argument #]]..l..[[ to ']]..name..[[' (table [vector] expected, got ]]..type(checkList[l])..[[)]], 2)
		end
		local checkPoint = true
		local point = checkList[l]
		for i=1, 3 do
			checkPoint = type(point[i]) == "number" and checkPoint
			if not checkPoint then break end
		end
		if not checkPoint then
			error([[bad argument #]]..l..[[ to ']]..name..[[' (table [vector] expected, got table)]], 2)
		end
	end

	local ooo, xyz = {}, {}
	for i=1, 3 do
		ooo[i] = min[i] < max[i] and min[i] or max[i]
		xyz[i] = max[i] > min[i] and max[i] or min[i]
	end
	local xoo = {xyz[1], ooo[2], ooo[3]}
	local oyo = {ooo[1], xyz[2], ooo[3]}
	local ooz = {ooo[1], ooo[2], xyz[3]}
	local xyo = {xyz[1], xyz[2], ooo[3]}
	local xoz = {xyz[1], ooo[2], xyz[3]}
	local oyz = {ooo[1], xyz[2], xyz[3]}

	local pData = {}
	for i=1, 3 do
		pData[i] = {}
		pData[i][1] = min[i] < max[i] and min[i] or max[i]
		pData[i][2] = max[i] > min[i] and max[i] or min[i]
	end
	for i=1, 4 do
		DebugLine(
			{pData[1][i%2+1], pData[2][i>2 and 1 or 2], pData[3][1]},
			{pData[1][i%2+1], pData[2][i>2 and 1 or 2], pData[3][2]},
			opt_r or 1, opt_g or 1, opt_b or 1, opt_alpha or 1
		)
		DebugLine(
			{pData[1][1], pData[2][i%2+1], pData[3][i>2 and 1 or 2]},
			{pData[1][2], pData[2][i%2+1], pData[3][i>2 and 1 or 2]},
			opt_r or 1, opt_g or 1, opt_b or 1, opt_alpha or 1
		)
		DebugLine(
			{pData[1][i>2 and 1 or 2], pData[2][1], pData[3][i%2+1]},
			{pData[1][i>2 and 1 or 2], pData[2][2], pData[3][i%2+1]},
			opt_r or 1, opt_g or 1, opt_b or 1, opt_alpha or 1
		)
	end
end

function DebugHEXAabb(min, max, hexColor, opt_alpha)
	local checkList = {min, max}
	local name = "DebugAabb"
	for l=1, 2 do
		if type(checkList[l]) ~= "table" then
			error([[bad argument #]]..l..[[ to ']]..name..[[' (table [vector] expected, got ]]..type(checkList[l])..[[)]], 2)
		end
		local checkPoint = true
		local point = checkList[l]
		for i=1, 3 do
			checkPoint = type(point[i]) == "number" and checkPoint
			if not checkPoint then break end
		end
		if not checkPoint then
			error([[bad argument #]]..l..[[ to ']]..name..[[' (table [vector] expected, got table)]], 2)
		end
	end

	local r, g, b = HexToRGB(hexColor, false)
	local ooo, xyz = {}, {}
	for i=1, 3 do
		ooo[i] = min[i] < max[i] and min[i] or max[i]
		xyz[i] = max[i] > min[i] and max[i] or min[i]
	end
	local xoo = {xyz[1], ooo[2], ooo[3]}
	local oyo = {ooo[1], xyz[2], ooo[3]}
	local ooz = {ooo[1], ooo[2], xyz[3]}
	local xyo = {xyz[1], xyz[2], ooo[3]}
	local xoz = {xyz[1], ooo[2], xyz[3]}
	local oyz = {ooo[1], xyz[2], xyz[3]}

	local pData = {}
	for i=1, 3 do
		pData[i] = {}
		pData[i][1] = min[i] < max[i] and min[i] or max[i]
		pData[i][2] = max[i] > min[i] and max[i] or min[i]
	end
	for i=1, 4 do
		DebugLine(
			{pData[1][i%2+1], pData[2][i>2 and 1 or 2], pData[3][1]},
			{pData[1][i%2+1], pData[2][i>2 and 1 or 2], pData[3][2]},
			r, g, b, opt_alpha or 1
		)
		DebugLine(
			{pData[1][1], pData[2][i%2+1], pData[3][i>2 and 1 or 2]},
			{pData[1][2], pData[2][i%2+1], pData[3][i>2 and 1 or 2]},
			r, g, b, opt_alpha or 1
		)
		DebugLine(
			{pData[1][i>2 and 1 or 2], pData[2][1], pData[3][i%2+1]},
			{pData[1][i>2 and 1 or 2], pData[2][2], pData[3][i%2+1]},
			r, g, b, opt_alpha or 1
		)
	end
end

function DebugHEXAabb(min, max, RGBcolor, opt_alpha)
	local checkList = {min, max}
	local name = "DebugAabb"
	for l=1, 2 do
		if type(checkList[l]) ~= "table" then
			error([[bad argument #]]..l..[[ to ']]..name..[[' (table [vector] expected, got ]]..type(checkList[l])..[[)]], 2)
		end
		local checkPoint = true
		local point = checkList[l]
		for i=1, 3 do
			checkPoint = type(point[i]) == "number" and checkPoint
			if not checkPoint then break end
		end
		if not checkPoint then
			error([[bad argument #]]..l..[[ to ']]..name..[[' (table [vector] expected, got table)]], 2)
		end
	end
	if type(RGBcolor) ~= "table" then
		error([[bad argument #3 to ']]..name..[[' (table [RGB] expected, got ]]..type(RGBcolor)..[[)]], 2)
	end

	local ooo, xyz = {}, {}
	for i=1, 3 do
		ooo[i] = min[i] < max[i] and min[i] or max[i]
		xyz[i] = max[i] > min[i] and max[i] or min[i]
	end
	local xoo = {xyz[1], ooo[2], ooo[3]}
	local oyo = {ooo[1], xyz[2], ooo[3]}
	local ooz = {ooo[1], ooo[2], xyz[3]}
	local xyo = {xyz[1], xyz[2], ooo[3]}
	local xoz = {xyz[1], ooo[2], xyz[3]}
	local oyz = {ooo[1], xyz[2], xyz[3]}

	local pData = {}
	for i=1, 3 do
		pData[i] = {}
		pData[i][1] = min[i] < max[i] and min[i] or max[i]
		pData[i][2] = max[i] > min[i] and max[i] or min[i]
	end
	for i=1, 4 do
		DebugLine(
			{pData[1][i%2+1], pData[2][i>2 and 1 or 2], pData[3][1]},
			{pData[1][i%2+1], pData[2][i>2 and 1 or 2], pData[3][2]},
			RGBcolor[1], RGBcolor[2], RGBcolor[3], opt_alpha or 1
		)
		DebugLine(
			{pData[1][1], pData[2][i%2+1], pData[3][i>2 and 1 or 2]},
			{pData[1][2], pData[2][i%2+1], pData[3][i>2 and 1 or 2]},
			RGBcolor[1], RGBcolor[2], RGBcolor[3], opt_alpha or 1
		)
		DebugLine(
			{pData[1][i>2 and 1 or 2], pData[2][1], pData[3][i%2+1]},
			{pData[1][i>2 and 1 or 2], pData[2][2], pData[3][i%2+1]},
			RGBcolor[1], RGBcolor[2], RGBcolor[3], opt_alpha or 1
		)
	end
end