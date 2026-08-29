local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local VirtualUser = game:GetService("VirtualUser")

if not RunService:IsClient() then return end

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

player.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)

local gui = Instance.new("ScreenGui")
gui.Name = "AFK_GUI"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local fullHeight = 110
local minimizedHeight = 25

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 240, 0, fullHeight)
frame.Position = UDim2.new(0.5, -120, 0.1, 0)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 0, 20)
title.Position = UDim2.new(0, 5, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Anti AFK by Ztx Team"
title.Font = Enum.Font.SourceSansBold
title.TextSize = 16
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame

local minimize = Instance.new("TextButton")
minimize.Size = UDim2.new(0, 20, 0, 20)
minimize.Position = UDim2.new(1, -25, 0, 0)
minimize.Text = "-"
minimize.Font = Enum.Font.SourceSansBold
minimize.TextSize = 18
minimize.TextColor3 = Color3.fromRGB(255, 255, 255)
minimize.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
minimize.Parent = frame

local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 20, 0, 20)
close.Position = UDim2.new(1, -45, 0, 0)
close.Text = "X"
close.Font = Enum.Font.SourceSansBold
close.TextSize = 16
close.TextColor3 = Color3.fromRGB(255, 255, 255)
close.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
close.Parent = frame

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, -10, 1, -30)
label.Position = UDim2.new(0, 5, 0, 25)
label.BackgroundTransparency = 1
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.Font = Enum.Font.SourceSans
label.TextSize = 14
label.TextXAlignment = Enum.TextXAlignment.Left
label.TextYAlignment = Enum.TextYAlignment.Top
label.Text = "Cargando..."
label.Parent = frame

local minimized = false
minimize.MouseButton1Click:Connect(function()
    minimized = not minimized
    label.Visible = not minimized
    frame.Size = UDim2.new(0, 240, 0, minimized and minimizedHeight or fullHeight)
    minimize.Text = minimized and "+" or "-"
end)

local startTime = tick()
local frames = 0
local fps = 0

RunService.Heartbeat:Connect(function()
    frames += 1
end)

task.spawn(function()
    while gui.Parent do
        local now = tick()
        local elapsed = now - startTime
        local hours = math.floor(elapsed / 3600)
        local minutes = math.floor((elapsed % 3600) / 60)
        local seconds = math.floor(elapsed % 60)

        fps = frames
        frames = 0

        local ping = "N/A"
        local network = Stats:FindFirstChild("Network")
        if network and network:FindFirstChild("ServerStatsItem") and network.ServerStatsItem:FindFirstChild("Data Ping") then
            ping = math.floor(network.ServerStatsItem["Data Ping"]:GetValue())
        end

        label.Text = string.format(
            "Tiempo activo: %02dh %02dm %02ds\nFPS: %d\nPing: %s ms",
            hours, minutes, seconds, fps, tostring(ping)
        )

        task.wait(1)
    end
end)
