
-- Setup
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "EndlessLoadingScreen"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

-- Background
local bg = Instance.new("Frame")
bg.Size = UDim2.new(1, 0, 1, 0)
bg.Position = UDim2.new(0, 0, 0, 0)
bg.BackgroundColor3 = Color3.new(0, 0, 0)
bg.Parent = screenGui

-- Progress Bar Container
local barContainer = Instance.new("Frame")
barContainer.Size = UDim2.new(0.6, 0, 0.06, 0)
barContainer.Position = UDim2.new(0.5, 0, 0.9, 0)
barContainer.AnchorPoint = Vector2.new(0.5, 0.5)
barContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
barContainer.BorderSizePixel = 0
barContainer.ClipsDescendants = true
barContainer.BackgroundTransparency = 0.2
barContainer.Parent = bg

-- Progress Bar Fill
local progressBar = Instance.new("Frame")
progressBar.Size = UDim2.new(0, 0, 1, 0)
progressBar.BackgroundColor3 = Color3.fromRGB(255, 200, 50)
progressBar.BorderSizePixel = 0
progressBar.Parent = barContainer

-- Percentage Label
local percentLabel = Instance.new("TextLabel")
percentLabel.Size = UDim2.new(0, 100, 0, 40)
percentLabel.Position = UDim2.new(0.5, -50, 0.75, -20)
percentLabel.BackgroundTransparency = 1
percentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
percentLabel.Font = Enum.Font.GothamBold
percentLabel.TextSize = 28
percentLabel.Text = "Loading... 0%"
percentLabel.Parent = bg

-- Fruit Emojis Animation
local fruits = {"🍎", "🍌", "🍇", "🍍", "🥭", "🍓"}
for _, emoji in pairs(fruits) do
	local fruit = Instance.new("TextLabel")
	fruit.Text = emoji
	fruit.TextSize = 40
	fruit.Font = Enum.Font.SourceSansBold
	fruit.TextColor3 = Color3.fromRGB(255, 255, 255)
	fruit.BackgroundTransparency = 1
	fruit.Size = UDim2.new(0, 50, 0, 50)
	fruit.Position = UDim2.new(math.random(), 0, math.random(), 0)
	fruit.Parent = bg

	local function animate()
		fruit.Position = UDim2.new(-0.1, 0, math.random(), 0)
		local target = UDim2.new(1.1, 0, fruit.Position.Y.Scale, 0)
		local tween = TweenService:Create(fruit, TweenInfo.new(10 + math.random() * 3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {
			Position = target
		})
		tween:Play()
	end

	animate()
end

-- Progress Logic (10 minutes)
local duration = 600
local currentTime = 0
local step = 1

spawn(function()
	while currentTime <= duration do
		local percent = currentTime / duration
		progressBar:TweenSize(UDim2.new(percent, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.5, true)
		percentLabel.Text = string.format("Loading... %d%%", math.floor(percent * 100))
		currentTime += step
		wait(step)
	end

	-- Stay stuck at 100%
	progressBar.Size = UDim2.new(1, 0, 1, 0)
	percentLabel.Text = "Loading... 100%"
end)
