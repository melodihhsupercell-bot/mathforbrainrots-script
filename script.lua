local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TeleportButtons"
screenGui.Parent = player:WaitForChild("PlayerGui")

local container = Instance.new("Frame")
container.Size = UDim2.new(0, 260, 0, 100)
container.Position = UDim2.new(0.5, -130, 0.8, 0)
container.BackgroundTransparency = 1
container.Parent = screenGui

local dragBar = Instance.new("TextButton")
dragBar.Size = UDim2.new(1, 0, 0, 25)
dragBar.Position = UDim2.new(0, 0, 0, -25)
dragBar.Text = "Drag Here"
dragBar.TextSize = 12
dragBar.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
dragBar.BorderSizePixel = 0
dragBar.AutoButtonColor = false
dragBar.Parent = container

local secretBtn = Instance.new("TextButton")
secretBtn.Size = UDim2.new(0, 120, 0, 40)
secretBtn.Position = UDim2.new(0, 0, 0, 0)
secretBtn.Text = "Secret"
secretBtn.Parent = container

secretBtn.MouseButton1Click:Connect(function()
	local character = player.Character
	if character and character:FindFirstChild("Humanoid") then
		character:MoveTo(Vector3.new(-6469, 20, -21))
	end
end)

local backBtn = Instance.new("TextButton")
backBtn.Size = UDim2.new(0, 120, 0, 40)
backBtn.Position = UDim2.new(0, 140, 0, 0)
backBtn.Text = "Back"
backBtn.Parent = container

backBtn.MouseButton1Click:Connect(function()
	local character = player.Character
	if character and character:FindFirstChild("Humanoid") then
		character:MoveTo(Vector3.new(24, 20, 11))
	end
end)

local deleteBtn = Instance.new("TextButton")
deleteBtn.Size = UDim2.new(0, 120, 0, 40)
deleteBtn.Position = UDim2.new(0, 70, 0, 50)
deleteBtn.Text = "Delete Buttons"
deleteBtn.BackgroundColor3 = Color3.fromRGB(180, 60, 60)
deleteBtn.Parent = container

deleteBtn.MouseButton1Click:Connect(function()
	screenGui:Destroy()
end)

local dragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil

local function update(input)
	local delta = input.Position - dragStart
	container.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

dragBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = container.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

dragBar.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		container.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)
