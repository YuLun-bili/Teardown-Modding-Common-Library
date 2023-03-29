--	shape.lua	by YuLun
--	Mar 15 2023

function GetShapeCentre(shape)
	local min, max = GetShapeBounds(shape)
	return VecLerp(min, max, 0.5)
end