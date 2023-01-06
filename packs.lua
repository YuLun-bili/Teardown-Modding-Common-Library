--	packs.lua	by YuLun
--	Jan 06 2023

function ImportPacks(registry, fileName, category)
	local packNum = 0
	for i, pack in ipairs(ListKeys("spawn")) do
		if GetString("spawn."..pack..".1") == (category.."/DUMMY") then
			Spawn(pack..":"..fileName, Transform())
			packNum = packNum + 1
		end
	end
	SetInt(registry..".pack.totalnum", packNum)
	SetBool(registry..".pack.menu", false)
	return packNum
end

function InitPackRegistry(registry, useDesc)
	local keys = ListKeys(registry..".packs")
	local index = 0
	if #keys < GetInt(registry..".pack.totalnum") then
		index = #keys+1
		SetString(registry..".packs."..index..".name", PACKNAME)
		if useDesc then
			SetString(registry..".packs."..index..".desc", PACKDESC)
		end
		SetBool(registry..".packs."..index..".active", false)
		return true, true, index
	end
end

function GetMasterStatus(registry)
	return GetBool(registry..".pack.menu")
end

function GetPackStatus(registry, index)
	return GetBool(registry..".packs."..index..".active")
end

function GetPackName(registry, index)
	return GetString(registry..".packs."..index..".name", "Unnamed Pack")
end

function GetPackDescription(registry, index)
	return GetString(registry..".packs."..index..".desc")
end

function ActivateMaster(registry)
	SetBool(registry..".pack.menu", true)
	for i, pack in ipairs(ListKeys(registry..".packs")) do
		SetBool(registry..".packs."..pack..".active", false)
	end
end

function ActivatePack(registry, index)
	SetBool(registry..".packs."..index..".active", true)
	SetBool(registry..".pack.menu", false)
end

function PackQuitAll(registry)
	SetBool(registry..".pack.menu", false)
	for i, pack in ipairs(ListKeys(registry..".packs")) do
		SetBool(registry..".packs."..pack..".active", false)
	end
end
