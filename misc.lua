--	misc.lua	by YuLun
--	Jan 06 2023

function math.clamp(lower, value, upper)
	if lower > upper then lower, upper = upper, lower end
	return math.max(lower, math.min(upper, value))
end

function math.cycle(value, max, opt_decrease)
	if opt_decrease then
		local offset = max > 2 and (value+max-3)%max+1 or value
		return offset%max+1
	end
	return cycle%max + 1
end

function BinToDec(binNum)
	return tonumber(binNum, 2)
end

function DecToBin(decNum)
	return string.reverse(table.concat(NumToBin(decNum, 2)))
end

function HexToDec(hexNum)
	return tonumber(hexNum, 16)
end

function DecToHex(decNum)
	return string.format("%x", decNum)
end

function NumToBin(numStr, base)
	local digitTable = {}
	local value = tonumber(numStr, base) or 0
	local _, digits = math.frexp(value)
	for i=digits, 1, -1 do
		digitTable[i] = math.floor(value/(2^(i-1)))
		value = value%(2^(i-1))
	end
	return digitTable
end

function NumToDec(numStr, base)
	return tonumber(numStr, base)
end

function NumToHex(numStr, base)
	local digitTable = {}
	local value = tonumber(numStr, base) or 0
	local _, digits = math.frexp(value)
	digits = math.ceil(digits/4)
	for i=digits, 1, -1 do
		digitTable[i] = math.floor(value/(16^(i-1)))
		value = value%(16^(i-1))
	end
	return digitTable
end

function HexToRGB(hexColor, opt_in255)
	local r = HexToDec(string.sub(hexColor, 1, 2))
	local g = HexToDec(string.sub(hexColor, 3, 4))
	local b = HexToDec(string.sub(hexColor, 5, 6))
	if opt_in255 == false then
		r = r/255
		g = g/255
		b = b/255
		return r, g, b
	end
	return r, g, b
end

function RGBToHex(RGBcolor, opt_in255)
	local r, g, b = RGBcolor[1], RGBcolor[2], RGBcolor[3]
	if opt_in255 == false then
		return string.format("%02x%02x%02x", math.floor(math.min(r*255+0.5, 255)), math.floor(math.min(g*255+0.5, 255)), math.floor(math.min(b*255+0.5, 255)))
	end
	return string.format("%02x%02x%02x", r, g, b)
end
