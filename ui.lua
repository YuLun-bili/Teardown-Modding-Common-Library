--	ui.lua	bu YuLun
--	Mar 29 2023

function UiHexColor(hexColor, opt_alpha)
	local r, g, b = HexToRGB(hexColor, false)
	UiColor(r, g, b, opt_alpha or 1)
end

function UiRGBColor(RGBcolor, opt_alpha)
	if type(RGBcolor) ~= "table" then
		error([[bad argument #2 to 'UiRGBColor' (table [RGB] expected, got ]]..type(RGBcolor)..[[)]], 2)
	end
	UiColor(RGBcolor[1] or 1, RGBcolor[2] or 1, RGBcolor[3] or 1, opt_alpha or 1)
end

function UiAlphaFilter(alpha)
	UiColorFilter(1, 1, 1, alpha)
end

function UiHexColorFilter(hexColor, opt_alpha)
	local r, g, b = HexToRGB(hexColor, false)
	UiColorFilter(r, g, b, opt_alpha or 1)
end

function UiRGBColorFilter(RGBcolor, opt_alpha)
	if type(RGBcolor) ~= "table" then
		error([[bad argument #1 to 'UiRGBColorFilter' (table [RGB] expected, got ]]..type(RGBcolor)..[[)]], 2)
	end
	UiColorFilter(RGBcolor[1] or 1, RGBcolor[2] or 1, RGBcolor[3] or 1, opt_alpha or 1)
end

function UiHexTextOutline(hexColor, opt_alpha, opt_thickness)
	local r, g, b = HexToRGB(hexColor, false)
	UiTextOutline(r, g, b, opt_alpha or 1, opt_thickness or 0.1)
end

function UiRGBTextOutline(RGBcolor, opt_alpha, opt_thickness)
	if type(RGBcolor) ~= "table" then
		error([[bad argument #1 to 'UiRGBTextOutline' (table [RGB] expected, got ]]..type(RGBcolor)..[[)]], 2)
	end
	UiTextOutline(RGBcolor[1], RGBcolor[2], RGBcolor[3], opt_alpha or 1, opt_thickness or 0.1)
end

function UiHexTextShadow(hexColor, opt_alpha, opt_distance, opt_blur)
	local r, g, b = HexToRGB(hexColor, false)
	UiTextShadow(r, g, b, opt_alpha or 1, opt_distance or 1.0, opt_blur or 0.5)
end

function UiRGBTextShadow(RGBcolor, opt_alpha, opt_distance, opt_blur)
	if type(RGBcolor) ~= "table" then
		error([[bad argument #1 to 'UiRGBTextShadow' (table [RGB] expected, got ]]..type(RGBcolor)..[[)]], 2)
	end
	UiTextShadow(RGBcolor[1], RGBcolor[2], RGBcolor[3], opt_alpha or 1, opt_distance or 1.0, opt_blur or 0.5)
end

function UiHexButtonImageBox(path, borderWidth, borderHeight, hexColor, opt_alpha)
	local r, g, b = HexToRGB(hexColor, false)
	UiButtonImageBox(path, borderWidth, borderHeight, r, g, b, opt_alpha or 1)
end

function UiRGBButtonImageBox(path, borderWidth, borderHeight, RGBcolor, opt_alpha)
	if type(RGBcolor) ~= "table" then
		error([[bad argument #4 to 'UiRGBButtonImageBox' (table [RGB] expected, got ]]..type(RGBcolor)..[[)]], 2)
	end
	UiButtonImageBox(path, borderWidth, borderHeight, RGBcolor[1], RGBcolor[2], RGBcolor[3], opt_alpha or 1)
end

function UiHexButtonHoverColor(hexColor, opt_alpha)
	local r, g, b = HexToRGB(hexColor, false)
	UiButtonHoverColor(r, g, b, opt_alpha or 1)
end

function UiRGBButtonHoverColor(RGBcolor, opt_alpha)
	if type(RGBcolor) ~= "table" then
		error([[bad argument #1 to 'UiRGBButtonHoverColor' (table [RGB] expected, got ]]..type(RGBcolor)..[[)]], 2)
	end
	UiButtonHoverColor(RGBcolor[1], RGBcolor[2], RGBcolor[3], opt_alpha or 1)
end

function UiHexButtonPressColor(hexColor, opt_alpha)
	local r, g, b = HexToRGB(hexColor, false)
	UiButtonPressColor(r, g, b, opt_alpha or 1)
end

function UiRGBButtonPressColor(RGBcolor, opt_alpha)
	if type(RGBcolor) ~= "table" then
		error([[bad argument #1 to 'UiRGBButtonPressColor' (table [RGB] expected, got ]]..type(RGBcolor)..[[)]], 2)
	end
	UiButtonPressColor(RGBcolor[1], RGBcolor[2], RGBcolor[3], opt_alpha or 1)
end

function UiScaleShear(direction, scale)
	local direction = direction:lower()
	if direction ~= "x" and direction ~= "y" then
		return
	end
	local scale = (tonumber(scale) or 0)*0.735
	local scaleSign = scale/math.abs(scale)
	local scaleVal = math.abs(scale or 0)+1
	local const = -2/(scaleVal+1)+2
	local rotAng = math.atan(1/scaleVal)
	local rotAngDeg = math.deg(rotAng)
	local scaleAngDeg = 45-rotAngDeg

	local xScale = math.sqrt(2/(1+scaleVal^2))
	local yScale = 1/(const*math.cos(math.rad(scaleAngDeg)))
	if direction == "y" then
		xScale, yScale = yScale, xScale
	end

	for i=1, 2 do
		-- no idea why twice but it works
		UiScale(xScale, yScale)
		UiRotate(-rotAngDeg*scaleSign)
		if direction == "y" then
			UiScale(1, scaleVal)
		else
			UiScale(scaleVal, 1)
		end
		UiRotate(45*scaleSign)
	end
end

function UiToggleTextButton(condition, textList, width, height)
	local press = false
	if UiTextButton(condition and textList[1] or textList[2], width, height) then
		condition = not condition
		press = true
	end
	return press, condition
end
	
function UiCycleTextButton(cycle, textList, width, height, opt_decrease)
	local press = false
	if UiTextButton(textList[cycle], width, height) then
		cycle = math.cycle(cycle, #textList, opt_decrease or false)
		press = true
	end
	return press, cycle
end

function UiDrawSelectTab(list, selectVal, width, height, font, size, Hex0, Hex1, Hex2, Hex3)	--	optional: font ~ Hex3
	font = font or "bold.ttf"
	size = size or height*0.75
	Hex0, Hex1, Hex2, Hex3 = Hex0 or "ffffff", Hex1 or "bbffbb", Hex2 or "909090", Hex3 or "85ff85"
	local tabNum = #list
	local tabWidth = width/tabNum
	UiPush()
		UiAlign("top left")
		for i=1, tabNum do
			UiPush()
				UiHexColor(Hex0)
				if selectVal == i then UiHexColor(Hex3) end
				UiHexButtonImageBox("ui/common/box-outline-4.png", 8, 8, Hex0)
				UiHexButtonHoverColor(Hex1)
				UiHexButtonPressColor(Hex2)
				UiButtonPressDist(0.5)
				UiFont(font, size)
				if UiTextButton(list[i], tabWidth, height) then selectVal = i end
				if selectVal == i then
					UiPush()
						UiTranslate(0, height-5)
						UiHexColor("000000")
						UiRect(tabWidth, 5)
					UiPop()
				end
			UiPop()
			UiTranslate(tabWidth, 0)
		end
	UiPop()
	return selectVal
end

function UiDrawVertialSelectTab(list, selectVal, width, height, font, size, Hex0, Hex1, Hex2, Hex3)	--	optional: font ~ Hex3
	font = font or "bold.ttf"
	Hex0, Hex1, Hex2, Hex3 = Hex0 or "ffffff", Hex1 or "bbffbb", Hex2 or "909090", Hex3 or "85ff85"
	local tabNum = #list
	local tabHeight = height/tabNum
	size = size or tabHeight*0.15
	UiPush()
		UiAlign("top left")
		for i=1, tabNum do
			UiPush()
				UiHexColor(Hex0)
				if selectVal == i then UiHexColor(Hex3) end
				UiHexButtonImageBox("ui/common/box-outline-4.png", 8, 8, Hex0)
				UiHexButtonHoverColor(Hex1)
				UiHexButtonPressColor(Hex2)
				UiButtonPressDist(0.5)
				UiFont(font, size)
				if UiTextButton(list[i], width, tabHeight) then selectVal = i end
				if selectVal == i then
					UiPush()
						UiTranslate(width-5)
						UiHexColor("000000")
						UiRect(5, tabHeight)
					UiPop()
				end
			UiPop()
			UiTranslate(0, tabHeight)
		end
	UiPop()
	return selectVal
end

function UiHexDrawSlider(picPath0, picPath1, value, min, max, opt_gap, opt_direction, Hex0, Hex1)	--	optional: Hex0, Hex1
	opt_gap = opt_gap or 0
	opt_direction = opt_direction or "x"
	Hex0, Hex1 = Hex0 or "404040", Hex1 or "ffffff"
	UiPush()
		if opt_direction == "x" then
			UiAlign("left middle")
			UiHexColor(Hex0)
			UiImageBox(picPath1, max-min+20+opt_gap*2, 20+opt_gap*2, 8, 8)
			UiTranslate(opt_gap-min, 0)
			UiHexColor(Hex1)
			value, done = UiSlider(picPath0, "x", value, min, max)
		else
			UiAlign("center top")
			UiHexColor(Hex0)
			UiImageBox(picPath1, 20+opt_gap*2, max-min+20+opt_gap*2, 8, 8)
			UiTranslate(0, opt_gap-min)
			UiHexColor(Hex1)
			value, done = UiSlider(picPath0, "x", value, min, max)
		end
	UiPop()
	return value, done
end

function UiFormatValueUnit(value, unit, opt_fontValue, opt_fontUnit, opt_sizeValue, opt_sizeUnit, opt_format)
	local value = tonumber(value) or 0
	local format = opt_format or "%d"
	local success, errData = pcall(string.format, format, value)
	if not success then error(errData:gsub("'format'", "argument #7 in 'UiFormatValueUnit'", 1), 2) end
	local unit = tostring(unit or "")
	local fontValue = opt_fontValue or "regular.ttf"
	local fontUnit = opt_fontUnit or "regular.ttf"
	local sizeValue = tonumber(opt_sizeValue) or 30
	local sizeUnit = tonumber(opt_sizeUnit) or 18
	local unitW = 2
	UiPush()
		UiHexColor("ffffff")
		UiFont(fontValue, sizeValue)
		local valLen, valH = UiGetTextSize(errData)
		UiTranslate(valLen, 0)
		UiPush()
			UiAlign("right middle")
			UiText(errData)
		UiPop()
		UiTranslate(2, 0)
		if unit ~= "" then
			UiFont(fontUnit, sizeUnit)
			unitW = UiGetTextSize(unit)
			UiPush()
				UiTranslate(0, valH/2)
				UiAlign("left bottom")
				UiText(unit)
			UiPop()
		end
	UiPop()
	UiTranslate(valLen+unitW, 0)
end