local player = game:GetService("Players").LocalPlayer

-- Ruta nueva donde están los botones
local scrollingFrame = player:WaitForChild("PlayerGui")
	:WaitForChild("ResponsiveGUI")
	:WaitForChild("Root")
	:WaitForChild("BoostMenu")
	:WaitForChild("Booster")
	:WaitForChild("ScrollingFrame")

local boostFolder = player:WaitForChild("Boost")

local ATTRIBUTE_NAME = "CreatedByScript"

-- Borrar cualquier BoolValue que ya exista
for _, v in ipairs(boostFolder:GetChildren()) do
	if v:IsA("BoolValue") then
		v:Destroy()
	end
end

-- Obtener todos los ImageButton y usar su nombre
local function getBoostNames()
	local names = {}

	for _, obj in ipairs(scrollingFrame:GetDescendants()) do
		if obj:IsA("ImageButton") then
			names[obj.Name] = true
		end
	end

	return names
end

local boostNames = getBoostNames()

-- Crear BoolValues según nombres del UI
local function createBoosts(name, amount)
	for i = 1, amount do
		local v = Instance.new("BoolValue")
		v.Name = name
		v.Value = true
		v.Archivable = true
		v:SetAttribute(ATTRIBUTE_NAME, true)
		v.Parent = boostFolder
	end
end

-- Crear todos los boosts desde los botones
for name in pairs(boostNames) do
	createBoosts(name, 99)
end

print("✅ Boosts creados")
