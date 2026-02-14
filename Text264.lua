-- ======================  
-- OLDMNA MAN1 ESP (TOGGLE)  
-- ======================  

if _G.OLDMNA_ESP then  
	_G.OLDMNA_ESP = false  
	print("OLDMNA ESP: OFF")  

	if _G.OLDMNA_ESP_DATA then  
		for model, highlight in pairs(_G.OLDMNA_ESP_DATA) do  
			if highlight then  
				pcall(function()  
					highlight:Destroy()  
				end)  
			end  
		end  
	end  

	return  
end  

_G.OLDMNA_ESP = true  
_G.OLDMNA_ESP_DATA = {}  
print("OLDMNA ESP: ON")  

-- ======================  
-- SERVICIOS  
-- ======================  
local humFolder = workspace:WaitForChild("Hum")  
local ESPs = _G.OLDMNA_ESP_DATA  

-- ======================  
-- FUNCIONES  
-- ======================  

local function getMainPart(model)  
	return model:FindFirstChild("HumanoidRootPart")  
		or model:FindFirstChildWhichIsA("BasePart")  
end  

local function createESP(manModel)  
	if not _G.OLDMNA_ESP then return end  

	local parentModel = manModel.Parent  
	if not parentModel then return end  
	if ESPs[parentModel] then return end  

	local mainPart = getMainPart(manModel)  
	if not mainPart then return end  

	local highlight = Instance.new("Highlight")  
	highlight.Adornee = manModel  
	highlight.FillColor = Color3.fromRGB(200, 200, 200)  
	highlight.OutlineColor = Color3.fromRGB(200, 200, 200)  
	highlight.FillTransparency = 0.4  
	highlight.OutlineTransparency = 0  
	highlight.Parent = workspace  

	local size = manModel:GetExtentsSize()  
	local offsetY = size.Y/2 + 1.5  

	local billboard = Instance.new("BillboardGui")  
	billboard.Adornee = mainPart  
	billboard.Size = UDim2.new(0,120,0,30)  
	billboard.StudsOffset = Vector3.new(0, offsetY, 0)  
	billboard.AlwaysOnTop = true  
	billboard.Parent = highlight  

	local text = Instance.new("TextLabel")  
	text.Size = UDim2.new(1,0,1,0)  
	text.BackgroundTransparency = 1  
	text.Text = parentModel.Name  
	text.TextColor3 = Color3.fromRGB(200, 200, 200)  
	text.TextStrokeTransparency = 0  
	text.TextStrokeColor3 = Color3.new(0,0,0)  
	text.TextSize = 30  
	text.Font = Enum.Font.GothamBold  
	text.Parent = billboard  

	ESPs[parentModel] = highlight  
end  

local function removeESP(parentModel)  
	if ESPs[parentModel] then  
		pcall(function()  
			ESPs[parentModel]:Destroy()  
		end)  
		ESPs[parentModel] = nil  
	end  
end  

-- ======================  
-- LOOP (1 SEGUNDO)
-- ======================  

task.spawn(function()
	while _G.OLDMNA_ESP do
		local activeModels = {}

		for _, obj in pairs(humFolder:GetDescendants()) do  
			if obj:IsA("Model") and obj.Name == "Man1" then  
				if obj.Parent and obj.Parent.Name:match("OldMna") then  
					activeModels[obj.Parent] = obj  
					createESP(obj)  
				end  
			end  
		end  

		for model,_ in pairs(ESPs) do  
			if not activeModels[model] then  
				removeESP(model)  
			end  
		end  

		task.wait(1) -- 🔥 ACTUALIZA CADA 1 SEGUNDO
	end
end)
