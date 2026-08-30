local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/memejames/elerium-v2-ui-library//main/Library", true))()
local Window = Library:AddWindow("Canes Priv Script�� Cracked BY ZTX", {
    main_color = Color3.fromRGB(27, 2, 252),
    min_size = Vector2.new(600, 600),
    can_resize = false,
})

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

local statFrames = {"strengthFrame", "durabilityFrame", "agilityFrame"}

for _, frameName in ipairs(statFrames) do
    local frame = ReplicatedStorage:FindFirstChild(frameName)
    if frame and frame:IsA("GuiObject") then
        frame.Visible = false
    end
end

ReplicatedStorage.ChildAdded:Connect(function(child)
    if table.find(statFrames, child.Name) and child:IsA("GuiObject") then
        child.Visible = false
    end
end)

local MainTab = Window:AddTab("Main")
MainTab:AddLabel("Settings").TextSize = 20

local changeSpeedSizeRemote = ReplicatedStorage.rEvents.changeSpeedSizeRemote
local targetSize = 2
local sizeEnabled = false

MainTab:AddTextBox("Size", function(input)
    local size = tonumber(input:match("%d+"))
    if size then
        targetSize = size
    end
end)

MainTab:AddSwitch("Set Size", function(value)
    sizeEnabled = value
end):Set(false)

task.spawn(function()
    while true do
        if sizeEnabled then
            local character = LocalPlayer.Character
            if character and character:FindFirstChildOfClass("Humanoid") then
                changeSpeedSizeRemote:InvokeServer("changeSize", targetSize)
            end
        end
        task.wait(0.5)
    end
end)

local targetSpeed = 120
local speedEnabled = false

MainTab:AddTextBox("Speed", function(input)
    local speed = tonumber(input:match("%d+"))
    if speed then
        targetSpeed = speed
    end
end)

MainTab:AddSwitch("Set Speed", function(value)
    speedEnabled = value
end):Set(false)

task.spawn(function()
    while true do
        if speedEnabled then
            local character = LocalPlayer.Character
            if character and character:FindFirstChildOfClass("Humanoid") then
                changeSpeedSizeRemote:InvokeServer("changeSpeed", targetSpeed)
            end
        end
        task.wait(0.5)
    end
end)

MainTab:AddLabel("Misc").TextSize = 20

MainTab:AddSwitch("Show Pets", function(value)
    local hidePets = LocalPlayer:FindFirstChild("hidePets")
    if hidePets then
        hidePets.Value = value
    end
end):Set(false)

local antiAFKConnection = nil

local function enableAntiAFK()
    if not antiAFKConnection then
        antiAFKConnection = LocalPlayer.Idled:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end
end

local function disableAntiAFK()
    if antiAFKConnection then
        antiAFKConnection:Disconnect()
        antiAFKConnection = nil
    end
end

MainTab:AddSwitch("Anti AFK", function(value)
    if value then
        enableAntiAFK()
    else
        disableAntiAFK()
    end
end):Set(true)

MainTab:AddSwitch("Anti Fling", function(value)
    local character = workspace:FindFirstChild(LocalPlayer.Name)
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    
    if rootPart then
        if value then
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 0, 100000)
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyVelocity.P = 1250
            bodyVelocity.Name = "AntiFling"
            bodyVelocity.Parent = rootPart
        else
            local antiFling = rootPart:FindFirstChild("AntiFling")
            if antiFling then
                antiFling:Destroy()
            end
        end
    end
end)

local SpecsTab = Window:AddTab("Specs")
SpecsTab:AddLabel("Player:").TextSize = 20

local function formatNumber(num)
    local suffixes = {"K", "M", "B", "T", "Qa"}
    
    for i = #suffixes, 1, -1 do
        local value = 10 ^ (i * 3)
        if value <= num then
            return string.format("%.2f%s", num / value, suffixes[i])
        end
    end
    
    return string.format("%.2f", num)
end

local statLabels = {}
local selectedPlayer = nil

local function updatePlayerStats(player)
    for _, label in pairs(statLabels) do
        label:Remove()
    end
    
    statLabels = {}
    selectedPlayer = player
    
    if player then
        local leaderstats = player:WaitForChild("leaderstats")
        local strength = leaderstats:WaitForChild("Strength")
        local rebirths = leaderstats:WaitForChild("Rebirths")
        local durability = player:WaitForChild("Durability")
        local kills = leaderstats:WaitForChild("Kills")
        local agility = player:WaitForChild("Agility")
        local evilKarma = player:WaitForChild("evilKarma")
        local goodKarma = player:WaitForChild("goodKarma")
        local brawls = leaderstats:WaitForChild("Brawls")
        
        statLabels.strengthLabel = MainTab:AddLabel("💪 Strength: " .. formatNumber(strength.Value))
        statLabels.rebirthsLabel = MainTab:AddLabel("🔄 Rebirths: " .. formatNumber(rebirths.Value))
        statLabels.durabilityLabel = MainTab:AddLabel("🛡️ Durability: " .. formatNumber(durability.Value))
        statLabels.killsLabel = MainTab:AddLabel("⚔️ Kills: " .. formatNumber(kills.Value))
        statLabels.agilityLabel = MainTab:AddLabel("🏃 Agility: " .. formatNumber(agility.Value))
        statLabels.evilKarmaLabel = MainTab:AddLabel("😈 Evil Karma: " .. formatNumber(evilKarma.Value))
        statLabels.goodKarmaLabel = MainTab:AddLabel("😇 Good Karma: " .. formatNumber(goodKarma.Value))
        statLabels.brawlsLabel = MainTab:AddLabel("👊 Brawls: " .. formatNumber(brawls.Value))
        
        task.spawn(function()
            while player and player.Parent do
                task.wait(1)
                statLabels.strengthLabel:SetText("💪 Strength: " .. formatNumber(strength.Value))
                statLabels.rebirthsLabel:SetText("🔄 Rebirths: " .. formatNumber(rebirths.Value))
                statLabels.durabilityLabel:SetText("🛡️ Durability: " .. formatNumber(durability.Value))
                statLabels.killsLabel:SetText("⚔️ Kills: " .. formatNumber(kills.Value))
                statLabels.agilityLabel:SetText("🏃 Agility: " .. formatNumber(agility.Value))
                statLabels.evilKarmaLabel:SetText("😈 Evil Karma: " .. formatNumber(evilKarma.Value))
                statLabels.goodKarmaLabel:SetText("😇 Good Karma: " .. formatNumber(goodKarma.Value))
                statLabels.brawlsLabel:SetText("👊 Brawls: " .. formatNumber(brawls.Value))
            end
        end)
    end
end

local playerDropdown = MainTab:AddDropdown("Choose Player", function(selected)
    for _, player in ipairs(Players:GetPlayers()) do
        if selected == player.DisplayName .. " | " .. player.Name then
            updatePlayerStats(player)
            break
        end
    end
end)

for _, player in ipairs(Players:GetPlayers()) do
    playerDropdown:Add(player.DisplayName .. " | " .. player.Name)
end

Players.PlayerAdded:Connect(function(player)
    playerDropdown:Add(player.DisplayName .. " | " .. player.Name)
end)

Players.PlayerRemoving:Connect(function(player)
    playerDropdown:Remove(player.DisplayName .. " | " .. player.Name)
end)

SpecsTab:AddSwitch("Spectate Player", function() end):Set(false)
SpecsTab:AddLabel("")
SpecsTab:AddLabel("Player Stats:").TextSize = 20

local KillerTab = Window:AddTab("Killer")

local function getCharacter()
    if not LocalPlayer.Character then
        repeat
            task.wait()
        until LocalPlayer.Character
    end
    return LocalPlayer.Character
end

local function punch()
    for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
        if tool.Name == "Punch" and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid:EquipTool(tool)
        end
    end
    
    LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
    LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
end

local function isPlayerAlive(player)
    return player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0
end

local function killPlayer(target)
    if isPlayerAlive(target) then
        local character = getCharacter()
        if character and character:FindFirstChild("LeftHand") then
            pcall(function()
                firetouchinterest(target.Character.HumanoidRootPart, character.LeftHand, 0)
                firetouchinterest(target.Character.HumanoidRootPart, character.LeftHand, 1)
                punch()
            end)
        end
    end
end

KillerTab:AddLabel("Misc").TextSize = 20

local SelectPet = KillerTab:AddDropdown("Select Pet", function(petName)
    for _, folder in pairs(LocalPlayer.petsFolder:GetChildren()) do
        if folder:IsA("Folder") then
            for _, pet in pairs(folder:GetChildren()) do
                ReplicatedStorage.rEvents.equipPetEvent:FireServer("unequipPet", pet)
            end
        end
    end
    
    task.wait(0.2)
    
    local matchingPets = {}
    for _, pet in pairs(LocalPlayer.petsFolder.Unique:GetChildren()) do
        if pet.Name == petName then
            table.insert(matchingPets, pet)
        end
    end
    
    for i = 1, math.min(8, #matchingPets) do
        ReplicatedStorage.rEvents.equipPetEvent:FireServer("equipPet", matchingPets[i])
        task.wait(0.1)
    end
end)

SelectPet:Add("Wild Wizard")
SelectPet:Add("Mighty Monster")

KillerTab:AddButton("Remove Attack Animations", function()
    local blockedAnimations = {
        ["rbxassetid://3638729053"] = true,
        ["rbxassetid://3638767427"] = true,
    }
    
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("Humanoid") then
        local humanoid = character:FindFirstChild("Humanoid")
        
        for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
            if track.Animation then
                local animationId = track.Animation.AnimationId
                local trackName = track.Name:lower()
                
                if blockedAnimations[animationId] or trackName:match("punch") or trackName:match("attack") or trackName:match("right") then
                    track:Stop()
                end
            end
        end
        
        if not _G.AnimBlockConnection then
            _G.AnimBlockConnection = humanoid.AnimationPlayed:Connect(function(track)
                if track.Animation then
                    local animationId = track.Animation.AnimationId
                    local trackName = track.Name:lower()
                    
                    if blockedAnimations[animationId] or trackName:match("punch") or trackName:match("attack") or trackName:match("right") then
                        track:Stop()
                    end
                end
            end)
        end
    end
end)

KillerTab:AddLabel("")
KillerTab:AddLabel("Auto Kill").TextSize = 20

_G.whitelistedPlayers = _G.whitelistedPlayers or {}
_G.blacklistedPlayers = _G.blacklistedPlayers or {}

local function isWhitelisted(player)
    for _, name in ipairs(_G.whitelistedPlayers) do
        if name:lower() == player.Name:lower() then
            return true
        end
    end
    return false
end

local Whitelist = KillerTab:AddDropdown("Whitelist", function(selected)
    local playerName = selected:match("| (.+)$")
    if playerName then
        playerName = playerName:gsub("^%s*(.-)%s*$", "%1")
        
        for _, name in ipairs(_G.whitelistedPlayers) do
            if name:lower() == playerName:lower() then
                return
            end
        end
        
        table.insert(_G.whitelistedPlayers, playerName)
    end
end)

KillerTab:AddSwitch("Kill Everyone", function(value)
    _G.killAll = value
    
    if value then
        if not _G.killAllConnection then
            _G.killAllConnection = game:GetService("RunService").Heartbeat:Connect(function()
                if _G.killAll then
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and not isWhitelisted(player) then
                            killPlayer(player)
                        end
                    end
                end
            end)
        end
    elseif _G.killAllConnection then
        _G.killAllConnection:Disconnect()
        _G.killAllConnection = nil
    end
end):Set(false)

KillerTab:AddSwitch("Whitelist Friends", function(value)
    _G.whitelistFriends = value
    
    if value then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player:IsFriendsWith(LocalPlayer.UserId) then
                local alreadyWhitelisted = false
                for _, name in ipairs(_G.whitelistedPlayers) do
                    if name:lower() == player.Name:lower() then
                        alreadyWhitelisted = true
                        break
                    end
                end
                
                if not alreadyWhitelisted then
                    table.insert(_G.whitelistedPlayers, player.Name)
                end
            end
        end
    end
end):Set(false)

KillerTab:AddLabel("")
KillerTab:AddLabel("Kill Targets").TextSize = 20

local Blacklist = KillerTab:AddDropdown("Blacklist", function(selected)
    local playerName = selected:match("| (.+)$")
    if playerName then
        playerName = playerName:gsub("^%s*(.-)%s*$", "%1")
        
        for _, name in ipairs(_G.blacklistedPlayers) do
            if name:lower() == playerName:lower() then
                return
            end
        end
        
        table.insert(_G.blacklistedPlayers, playerName)
    end
end)

local function isBlacklisted(player)
    for _, name in ipairs(_G.blacklistedPlayers) do
        if name:lower() == player.Name:lower() then
            return true
        end
    end
    return false
end

for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        local displayName = player.DisplayName .. " | " .. player.Name
        Whitelist:Add(displayName)
        Blacklist:Add(displayName)
    end
end

Players.PlayerAdded:Connect(function(player)
    if player ~= LocalPlayer then
        local displayName = player.DisplayName .. " | " .. player.Name
        Whitelist:Add(displayName)
        Blacklist:Add(displayName)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    local displayName = player.DisplayName .. " | " .. player.Name
    
    for _, item in pairs(Whitelist:GetItems()) do
        if item.Text == displayName then
            Whitelist:Remove(item.Text)
            break
        end
    end
    
    for _, item in pairs(Blacklist:GetItems()) do
        if item.Text == displayName then
            Blacklist:Remove(item.Text)
            break
        end
    end
end)

KillerTab:AddSwitch("Kill Blacklist", function(value)
    _G.killBlacklistedOnly = value
    
    if value then
        if not _G.blacklistKillConnection then
            _G.blacklistKillConnection = game:GetService("RunService").Heartbeat:Connect(function()
                if _G.killBlacklistedOnly then
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and isBlacklisted(player) then
                            killPlayer(player)
                        end
                    end
                end
            end)
        end
    elseif _G.blacklistKillConnection then
        _G.blacklistKillConnection:Disconnect()
        _G.blacklistKillConnection = nil
    end
end)

KillerTab:AddLabel("")
KillerTab:AddLabel("Kill Aura").TextSize = 20

KillerTab:AddTextBox("Range (1-140)", function(input)
    local range = tonumber(input)
    if range then
        _G.deathRingRange = math.clamp(range, 1, 140)
    end
end)

KillerTab:AddSwitch("Death Ring", function(value)
    _G.deathRingEnabled = value
    
    if value then
        if not _G.deathRingConnection then
            _G.deathRingConnection = game:GetService("RunService").Heartbeat:Connect(function()
                local character = getCharacter()
                local rootPart = character and character:FindFirstChild("HumanoidRootPart")
                local position = rootPart and rootPart.Position
                
                if position then
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and not isWhitelisted(player) and isPlayerAlive(player) then
                            if (position - player.Character.HumanoidRootPart.Position).Magnitude <= (_G.deathRingRange or 20) then
                                killPlayer(player)
                            end
                        end
                    end
                end
            end)
        end
    elseif _G.deathRingConnection then
        _G.deathRingConnection:Disconnect()
        _G.deathRingConnection = nil
    end
end):Set(false)

KillerTab:AddLabel("")

local WhitelistLabel = KillerTab:AddLabel("Whitelist: None")
WhitelistLabel.TextColor3 = Color3.fromRGB(26, 212, 51)
WhitelistLabel.TextSize = 17

KillerTab:AddButton("Clear Whitelist", function()
    _G.whitelistedPlayers = {}
end)

local BlacklistLabel = KillerTab:AddLabel("Blacklist: None")
BlacklistLabel.TextColor3 = Color3.fromRGB(191, 25, 25)
BlacklistLabel.TextSize = 17

KillerTab:AddButton("Clear Blacklist", function()
    _G.blacklistedPlayers = {}
end)

local function updateWhitelistLabel()
    if #_G.whitelistedPlayers ~= 0 then
        WhitelistLabel.Text = "Whitelist: " .. table.concat(_G.whitelistedPlayers, ", ")
    else
        WhitelistLabel.Text = "Whitelist: None"
    end
end

local function updateBlacklistLabel()
    if #_G.blacklistedPlayers ~= 0 then
        BlacklistLabel.Text = "Blacklist: " .. table.concat(_G.blacklistedPlayers, ", ")
    else
        BlacklistLabel.Text = "Blacklist: None"
    end
end

task.spawn(function()
    while true do
        updateWhitelistLabel()
        updateBlacklistLabel()
        task.wait(0.2)
    end
end)

local FarmingTab = Window:AddTab("Farming")

FarmingTab:AddLabel("Misc").TextSize = 20

FarmingTab:AddSwitch("Auto Lift (Gamepass)", function(value)
    if value then
        local gamepassIds = ReplicatedStorage.gamepassIds
        
        for _, gamepass in pairs(gamepassIds:GetChildren()) do
            local intValue = Instance.new("IntValue")
            intValue.Name = gamepass.Name
            intValue.Value = gamepass.Value
            intValue.Parent = LocalPlayer.ownedGamepasses
        end
    else
        if LocalPlayer and LocalPlayer.ownedGamepasses then
            local gamepassIds = ReplicatedStorage.gamepassIds
            
            for _, gamepass in pairs(gamepassIds:GetChildren()) do
                local ownedGamepass = LocalPlayer.ownedGamepasses:FindFirstChild(gamepass.Name)
                if ownedGamepass and ownedGamepass.Value == gamepass.Value then
                    ownedGamepass:Destroy()
                end
            end
        end
    end
end)

local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local backpack = LocalPlayer:WaitForChild("Backpack")
local autoPunchEnabled = false

FarmingTab:AddSwitch("Auto Punch (without animation)", function(value)
    autoPunchEnabled = value
    
    if autoPunchEnabled then
        task.spawn(function()
            local punchTool = backpack:FindFirstChild("Punch") or character:FindFirstChild("Punch")
            
            if not punchTool then
                repeat
                    punchTool = backpack:FindFirstChild("Punch") or character:FindFirstChild("Punch")
                    task.wait(0.1)
                until punchTool
            end
            
            local hand = "leftHand"
            
            if punchTool.Parent ~= backpack then
                hand = "leftHand"
            else
                punchTool.Parent = character
                hand = "leftHand"
            end
            
            while autoPunchEnabled do
                if LocalPlayer:FindFirstChild("muscleEvent") then
                    LocalPlayer.muscleEvent:FireServer("punch", hand)
                    hand = hand == "leftHand" and "rightHand" or "leftHand"
                end
                
                task.wait(0.2)
            end
        end)
    else
        local punchTool = character:FindFirstChild("Punch")
        if punchTool then
            punchTool.Parent = backpack
        end
    end
end):Set(false)

local RebirthsLabel = FarmingTab:AddLabel("🔄 Rebirths:")
RebirthsLabel.TextSize = 20

local function formatWithCommas(num)
    local str = tostring(num)
    local result = ""
    local count = 0
    
    for i = #str, 1, -1 do
        count = count + 1
        result = str:sub(i, i) .. result
        
        if count % 3 == 0 and i > 1 then
            result = "," .. result
        end
    end
    
    return result
end

task.spawn(function()
    local rebirths = LocalPlayer.leaderstats:WaitForChild("Rebirths")
    
    while true do
        RebirthsLabel.Text = "Rebirths: " .. formatWithCommas(rebirths.Value)
        task.wait(0.2)
    end
end)

FarmingTab:AddSwitch("Auto Rebirth", function(value)
    if value then
        while true do
            ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
            task.wait(0.05)
        end
    end
end):Set(false)

FarmingTab:AddSwitch("Auto Size 1", function(value)
    sizeEnabled = value
end):Set(false)

task.spawn(function()
    while true do
        if sizeEnabled then
            local character = LocalPlayer.Character
            if character and character:FindFirstChildOfClass("Humanoid") then
                changeSpeedSizeRemote:InvokeServer("changeSize", 1)
            end
        end
        task.wait(0.05)
    end
end)

local kingPosition = CFrame.new(-8665.4, 17.21, -5792.9)
local autoKingEnabled = false

FarmingTab:AddSwitch("Auto King", function(value)
    autoKingEnabled = value
end):Set(false)

task.spawn(function()
    local rootPart = (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart")
    
    while true do
        if autoKingEnabled and (rootPart.Position - kingPosition.Position).magnitude > 5 then
            rootPart.CFrame = kingPosition
        end
        
        task.wait(0.05)
    end
end)

FarmingTab:AddLabel("Tools").TextSize = 20

local selectedTool = nil
local toolEnabled = false

local SelectTool = FarmingTab:AddDropdown("Select Tool", function(tool)
    selectedTool = tool
end)

SelectTool:Add("Weight")
SelectTool:Add("Pushups")
SelectTool:Add("Situps")
SelectTool:Add("Handstands")
SelectTool:Add("Fast Punch")
SelectTool:Add("Stomp")
SelectTool:Add("Ground Slam")

FarmingTab:AddSwitch("Start", function(value)
    toolEnabled = value
    
    if value then
        task.spawn(function()
            while toolEnabled do
                if selectedTool == "Weight" then
                    local tool = LocalPlayer.Backpack:FindFirstChild("Weight")
                    if tool and not LocalPlayer.Character:FindFirstChild("Weight") then
                        LocalPlayer.Character.Humanoid:EquipTool(tool)
                    end
                    LocalPlayer.muscleEvent:FireServer("rep")
                elseif selectedTool == "Pushups" then
                    local tool = LocalPlayer.Backpack:FindFirstChild("Pushups")
                    if tool and not LocalPlayer.Character:FindFirstChild("Pushups") then
                        LocalPlayer.Character.Humanoid:EquipTool(tool)
                    end
                    LocalPlayer.muscleEvent:FireServer("rep")
                elseif selectedTool == "Situps" then
                    local tool = LocalPlayer.Backpack:FindFirstChild("Situps")
                    if tool and not LocalPlayer.Character:FindFirstChild("Situps") then
                        LocalPlayer.Character.Humanoid:EquipTool(tool)
                    end
                    LocalPlayer.muscleEvent:FireServer("rep")
                elseif selectedTool == "Handstands" then
                    local tool = LocalPlayer.Backpack:FindFirstChild("Handstands")
                    if tool and not LocalPlayer.Character:FindFirstChild("Handstands") then
                        LocalPlayer.Character.Humanoid:EquipTool(tool)
                    end
                    LocalPlayer.muscleEvent:FireServer("rep")
                elseif selectedTool == "Fast Punch" then
                    local tool = LocalPlayer.Backpack:FindFirstChild("Punch")
                    if tool then
                        tool.Parent = LocalPlayer.Character
                        if tool:FindFirstChild("attackTime") then
                            tool.attackTime.Value = 0
                        end
                    end
                    LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
                    LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
                    if LocalPlayer.Character:FindFirstChild("Punch") then
                        LocalPlayer.Character.Punch:Activate()
                    end
                elseif selectedTool == "Stomp" then
                    local tool = LocalPlayer.Backpack:FindFirstChild("Stomp")
                    if tool then
                        tool.Parent = LocalPlayer.Character
                        if tool:FindFirstChild("attackTime") then
                            tool.attackTime.Value = 0
                        end
                    end
                    LocalPlayer.muscleEvent:FireServer("stomp")
                    if LocalPlayer.Character:FindFirstChild("Stomp") then
                        LocalPlayer.Character.Stomp:Activate()
                    end
                    if tick() % 6 < 0.1 then
                        VirtualUser:CaptureController()
                        VirtualUser:ClickButton1(Vector2.new(500, 500))
                    end
                elseif selectedTool == "Ground Slam" then
                    local tool = LocalPlayer.Backpack:FindFirstChild("Ground Slam")
                    if tool then
                        tool.Parent = LocalPlayer.Character
                        if tool:FindFirstChild("attackTime") then
                            tool.attackTime.Value = 0
                        end
                    end
                    LocalPlayer.muscleEvent:FireServer("slam")
                    if LocalPlayer.Character:FindFirstChild("Ground Slam") then
                        LocalPlayer.Character["Ground Slam"]:Activate()
                    end
                    if tick() % 6 < 0.1 then
                        VirtualUser:CaptureController()
                        VirtualUser:ClickButton1(Vector2.new(500, 500))
                    end
                end
                
                task.wait()
            end
        end)
    else
        if selectedTool and LocalPlayer.Character:FindFirstChild(selectedTool) then
            LocalPlayer.Character:FindFirstChild(selectedTool).Parent = LocalPlayer.Backpack
        end
    end
end)

FarmingTab:AddLabel("Rocks").TextSize = 20

local rockRequirements = {
    ["Tiny Rock"] = 0,
    ["Starter Island"] = 100,
    ["Punching Rock"] = 1000,
    ["Golden Rock"] = 5000,
    ["Frost Rock"] = 150000,
    ["Mythical Rock"] = 400000,
    ["Eternal Rock"] = 750000,
    ["Legend Rock"] = 1000000,
    ["Muscle King Rock"] = 5000000,
    ["Jungle Rock"] = 10000000,
}

local selectedRock = nil
local SelectRock = FarmingTab:AddDropdown("Select Rock", function(rock)
    selectedRock = rock
end)

for rockName, _ in pairs(rockRequirements) do
    SelectRock:Add(rockName)
end

FarmingTab:AddSwitch("Fast Glitch", function(value)
    getgenv().RockFarmRunning = value
    
    if value and selectedRock then
        task.spawn(function()
            local requiredDurability = rockRequirements[selectedRock]
            
            while getgenv().RockFarmRunning do
                task.wait()
                
                if requiredDurability <= LocalPlayer.Durability.Value then
                    for _, descendant in pairs(workspace.machinesFolder:GetDescendants()) do
                        if descendant.Name == "neededDurability" and descendant.Value == requiredDurability and LocalPlayer.Character:FindFirstChild("LeftHand") and LocalPlayer.Character:FindFirstChild("RightHand") then
                            local rock = descendant.Parent:FindFirstChild("Rock")
                            
                            if rock then
                                firetouchinterest(rock, LocalPlayer.Character.RightHand, 0)
                                firetouchinterest(rock, LocalPlayer.Character.RightHand, 1)
                                firetouchinterest(rock, LocalPlayer.Character.LeftHand, 0)
                                firetouchinterest(rock, LocalPlayer.Character.LeftHand, 1)
                                punch()
                            end
                        end
                    end
                end
            end
        end)
    end
end)

FarmingTab:AddLabel("Machines").TextSize = 20

local selectedGym = nil
local selectedMachine = nil
local machineEnabled = false
local machineDropdown = nil
local machineTask = nil

local function pressE()
    local vim = game:GetService("VirtualInputManager")
    vim:SendKeyEvent(true, "E", false, game)
    task.wait(0.1)
    vim:SendKeyEvent(false, "E", false, game)
end

local function machineLoop()
    while machineEnabled and task.wait() do
        LocalPlayer.muscleEvent:FireServer("rep")
    end
end

local function stopMachine()
    if machineTask then
        machineTask:Cancel()
        machineTask = nil
    end
end

local function teleportToMachine(machine, position)
    local character = LocalPlayer.Character
    
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = position
        task.wait(0.5)
        pressE()
        
        if machineEnabled then
            machineTask = task.spawn(machineLoop)
        end
    end
end

local machinePositions = {
    ["Bench Press"] = {
        ["Jungle Gym"] = CFrame.new(-8173, 64, 1898),
        ["Muscle King Gym"] = CFrame.new(-8590.06152, 46.0167427, -6043.34717),
        ["Legend Gym"] = CFrame.new(4111.91748, 1020.46674, -3799.97217),
    },
    ["Squat"] = {
        ["Jungle Gym"] = CFrame.new(-8352, 34, 2878),
        ["Muscle King Gym"] = CFrame.new(-8940.12402, 13.1642084, -5699.13477),
        ["Legend Gym"] = CFrame.new(4304.99023, 987.829956, -4124.2334),
    },
    ["Pull Up"] = {
        ["Jungle Gym"] = CFrame.new(-8666, 34, 2070),
        ["Muscle King Gym"] = CFrame.new(-8940.12402, 13.1642084, -5699.13477),
        ["Legend Gym"] = CFrame.new(4304.99023, 987.829956, -4124.2334),
    },
    ["Boulder"] = {
        ["Jungle Gym"] = CFrame.new(-8621, 34, 2684),
        ["Muscle King Gym"] = CFrame.new(-8940.12402, 13.1642084, -5699.13477),
        ["Legend Gym"] = CFrame.new(4304.99023, 987.829956, -4124.2334),
    },
}

FarmingTab:AddSwitch("Start", function(value)
    machineEnabled = value
    
    if value then
        if selectedGym and selectedMachine and machinePositions[selectedMachine][selectedGym] then
            teleportToMachine(selectedMachine, machinePositions[selectedMachine][selectedGym])
        end
    else
        stopMachine()
    end
end)

local Gym = FarmingTab:AddDropdown("Gym", function(gym)
    selectedGym = gym
    
    if machineDropdown then
        machineDropdown:Clear()
    end
    
    machineDropdown = FarmingTab:AddDropdown("Machine", function(machine)
        selectedMachine = machine
    end)
    
    machineDropdown:Add("Bench Press")
    machineDropdown:Add("Squat")
    machineDropdown:Add("Pull Up")
    machineDropdown:Add("Boulder")
end)

Gym:Add("Jungle Gym")
Gym:Add("Muscle King Gym")
Gym:Add("Legend Gym")

local RebirthingTab = Window:AddTab("Rebirthing")

RebirthingTab:AddLabel("Farming").TextSize = 20

local RebirthsLabel2 = RebirthingTab:AddLabel("Rebirths:")
RebirthsLabel2.TextSize = 17

local function formatWithCommas2(num)
    local str = tostring(num)
    local result = ""
    local count = 0
    
    for i = #str, 1, -1 do
        count = count + 1
        result = str:sub(i, i) .. result
        
        if count % 3 == 0 and i > 1 then
            result = "," .. result
        end
    end
    
    return result
end

task.spawn(function()
    local rebirths = LocalPlayer.leaderstats:WaitForChild("Rebirths")
    
    while true do
        RebirthsLabel2.Text = "Rebirths: " .. formatWithCommas2(rebirths.Value)
        task.wait(0.2)
    end
end)

local muscleEvent = LocalPlayer:WaitForChild("muscleEvent")

local function unequipAllPets()
    for _, folder in pairs(LocalPlayer.petsFolder:GetChildren()) do
        if folder:IsA("Folder") then
            for _, pet in pairs(folder:GetChildren()) do
                ReplicatedStorage.rEvents.equipPetEvent:FireServer("unequipPet", pet)
            end
        end
    end
    
    task.wait(0.1)
end

local function equipPet(petName)
    unequipAllPets()
    task.wait(0.01)
    
    for _, pet in pairs(LocalPlayer.petsFolder.Unique:GetChildren()) do
        if pet.Name == petName then
            ReplicatedStorage.rEvents.equipPetEvent:FireServer("equipPet", pet)
        end
    end
end

local fastRebirthEnabled = false

local function fastRebirth()
    while fastRebirthEnabled do
        equipPet("Swift Samurai")
        task.wait(0.4)
        
        local targetStrength = 5000 + LocalPlayer.leaderstats.Rebirths.Value * 2550
        
        while fastRebirthEnabled and LocalPlayer.leaderstats.Strength.Value < targetStrength do
            for _ = 1, LocalPlayer.MembershipType == Enum.MembershipType.Premium and 8 or 14 do
                muscleEvent:FireServer("rep")
            end
            
            task.wait(0.02)
        end
        
        if targetStrength <= LocalPlayer.leaderstats.Strength.Value then
            equipPet("Tribal Overlord")
            task.wait(0.25)
            
            local currentRebirths = LocalPlayer.leaderstats.Rebirths.Value
            
            repeat
                ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
                task.wait(0.05)
            until currentRebirths < LocalPlayer.leaderstats.Rebirths.Value
            
            task.wait(0.5)
        end
    end
end

RebirthingTab:AddSwitch("Fast Rebirth", function(value)
    if value then
        fastRebirthEnabled = true
        fastRebirth()
    else
        fastRebirthEnabled = false
    end
end)

local lockPositionEnabled = false
local lockPositionCoroutine = nil

RebirthingTab:AddSwitch("Lock Position", function(value)
    lockPositionEnabled = value
    
    if lockPositionEnabled then
        local rootPart = (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart")
        local position = rootPart.Position
        
        lockPositionCoroutine = coroutine.create(function()
            while lockPositionEnabled do
                rootPart.Velocity = Vector3.new(0, 0, 0)
                rootPart.RotVelocity = Vector3.new(0, 0, 0)
                rootPart.CFrame = CFrame.new(position)
                
                task.wait(0.05)
            end
        end)
        
        coroutine.resume(lockPositionCoroutine)
    end
end):Set(false)

RebirthingTab:AddLabel("Pets").TextSize = 20

RebirthingTab:AddButton("Equip Swift Samurai", function()
    unequipAllPets()
    equipPet("Swift Samurai")
end)

RebirthingTab:AddButton("Equip Tribal Overlord", function()
    unequipAllPets()
    equipPet("Tribal Overlord")
end)

local SpeedFarmingTab = Window:AddTab("Speed Farming")

SpeedFarmingTab:AddLabel("Farming").TextSize = 20

local muscleEvent2 = LocalPlayer:WaitForChild("muscleEvent")
local fastRepEnabled = false
local baseSpeed = 500
local safetyMode = true
local dataPing = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]

local function getPing()
    return dataPing:GetValue()
end

local function getSafeSpeed(ping)
    return ping < 80 and 500 or (ping < 150 and 300 or (ping < 250 and 100 or 50))
end

SpeedFarmingTab:AddTextBox("Base Speed", function(input)
    local speed = tonumber(input)
    if speed then
        baseSpeed = math.clamp(math.floor(speed), 1, 1000)
    end
end, {
    placeholder = "500",
})

SpeedFarmingTab:AddSwitch("Safety Mode", function(value)
    safetyMode = value
end):Set(true)

local function fastRepLoop()
    local fireServer = muscleEvent2.FireServer
    local lastUpdate = time()
    local currentPing = getPing()
    
    while fastRepEnabled do
        if time() - lastUpdate > 0.5 then
            currentPing = getPing()
            lastUpdate = time()
        end
        
        local speed = safetyMode and getSafeSpeed(currentPing) or baseSpeed
        local delay = math.clamp(currentPing / 2500, 0.001, 0.1)
        
        for i = 1, math.min(speed, baseSpeed) do
            fireServer(muscleEvent2, "rep")
            
            if i % 50 == 0 then
                task.wait(0)
            end
        end
        
        task.wait(delay)
    end
end

SpeedFarmingTab:AddSwitch("Fast Rep", function(value)
    fastRepEnabled = value
    
    if fastRepEnabled then
        task.spawn(fastRepLoop)
    end
end)

SpeedFarmingTab:AddLabel("Current Ping: 0ms").TextSize = 16

task.spawn(function()
    while true do
        if fastRepEnabled then
            local ping = getPing()
            local labels = SpeedFarmingTab:GetChildren()
            labels[#labels]:SetText("Current Ping: " .. ping .. "ms")
        end
        
        task.wait(0.5)
    end
end)

SpeedFarmingTab:AddLabel("Misc").TextSize = 20

local function useProteinEgg()
    local egg = LocalPlayer.Character:FindFirstChild("Protein Egg") or LocalPlayer.Backpack:FindFirstChild("Protein Egg")
    if egg then
        muscleEvent2:FireServer("proteinEgg", egg)
    end
end

local autoEggEnabled = false

task.spawn(function()
    while true do
        while autoEggEnabled do
            useProteinEgg()
            task.wait(1800)
        end
        
        task.wait(1)
    end
end)

SpeedFarmingTab:AddSwitch("Auto Egg", function(value)
    autoEggEnabled = value
    
    if value then
        useProteinEgg()
    end
end):Set(false)

local function useTropicalShake()
    local shake = LocalPlayer.Character:FindFirstChild("Tropical Shake") or LocalPlayer.Backpack:FindFirstChild("Tropical Shake")
    if shake then
        muscleEvent2:FireServer("tropicalShake", shake)
    end
end

local autoShakeEnabled = false

task.spawn(function()
    while true do
        while autoShakeEnabled do
            useTropicalShake()
            task.wait(900)
        end
        
        task.wait(1)
    end
end)

SpeedFarmingTab:AddSwitch("Auto Shake", function(value)
    autoShakeEnabled = value
    
    if value then
        useTropicalShake()
    end
end):Set(false)

SpeedFarmingTab:AddButton("Anti Lag", function()
    local playerGui = LocalPlayer:WaitForChild("PlayerGui")
    local lighting = game:GetService("Lighting")
    
    for _, gui in pairs(playerGui:GetChildren()) do
        if gui:IsA("ScreenGui") then
            gui:Destroy()
        end
    end
    
    for _, descendant in pairs(workspace:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant:Destroy()
        end
    end
    
    for _, descendant in pairs(workspace:GetDescendants()) do
        if descendant:IsA("PointLight") or descendant:IsA("SpotLight") or descendant:IsA("SurfaceLight") then
            descendant:Destroy()
        end
    end
    
    for _, sky in pairs(lighting:GetChildren()) do
        if sky:IsA("Sky") then
            sky:Destroy()
        end
    end
    
    local darkSky = Instance.new("Sky")
    darkSky.Name = "DarkSky"
    darkSky.SkyboxBk = "rbxassetid://0"
    darkSky.SkyboxDn = "rbxassetid://0"
    darkSky.SkyboxFt = "rbxassetid://0"
    darkSky.SkyboxLf = "rbxassetid://0"
    darkSky.SkyboxRt = "rbxassetid://0"
    darkSky.SkyboxUp = "rbxassetid://0"
    darkSky.Parent = lighting
    
    lighting.Brightness = 0
    lighting.ClockTime = 0
    lighting.TimeOfDay = "00:00:00"
    lighting.OutdoorAmbient = Color3.new(0, 0, 0)
    lighting.Ambient = Color3.new(0, 0, 0)
    lighting.FogColor = Color3.new(0, 0, 0)
    lighting.FogEnd = 100
    
    task.spawn(function()
        while true do
            task.wait(5)
            
            if not lighting:FindFirstChild("DarkSky") then
                darkSky:Clone().Parent = lighting
            end
            
            lighting.Brightness = 0
            lighting.ClockTime = 0
            lighting.OutdoorAmbient = Color3.new(0, 0, 0)
            lighting.Ambient = Color3.new(0, 0, 0)
            lighting.FogColor = Color3.new(0, 0, 0)
            lighting.FogEnd = 100
        end
    end)
end)

SpeedFarmingTab:AddLabel("Pets").TextSize = 20

SpeedFarmingTab:AddButton("Equip Swift Samurai", function()
    unequipAllPets()
    equipPet("Swift Samurai")
end)

SpeedFarmingTab:AddButton("Equip Tribal Overlord", function()
    unequipAllPets()
    equipPet("Tribal Overlord")
end)

local TeleportsTab = Window:AddTab("Teleports")

TeleportsTab:AddLabel("Main").TextSize = 20

TeleportsTab:AddButton("Tiny Island", function()
    (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-37.1, 9.2, 1919)
end)

TeleportsTab:AddButton("Main Island", function()
    (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart").CFrame = CFrame.new(16.07, 9.08, 133.8)
end)

TeleportsTab:AddButton("Beach", function()
    (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-8, 9, -169.2)
end)

TeleportsTab:AddLabel("Gyms").TextSize = 22

TeleportsTab:AddButton("Muscle King Gym", function()
    (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-8665.4, 17.21, -5792.9)
end)

TeleportsTab:AddButton("Jungle Gym", function()
    (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-8543, 6.8, 2400)
end)

TeleportsTab:AddButton("Legends Gym", function()
    (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart").CFrame = CFrame.new(4516, 991.5, -3856)
end)

TeleportsTab:AddButton("Infernal Gym", function()
    (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-6759, 7.36, -1284)
end)

TeleportsTab:AddButton("Mythical Gym", function()
    (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart").CFrame = CFrame.new(2250, 7.37, 1073.2)
end)

TeleportsTab:AddButton("Frost Gym", function()
    (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-2623, 7.36, -409)
end)

local InventoryTab = Window:AddTab("Inventory")

InventoryTab:AddLabel("Inventory:").TextSize = 20
InventoryTab:AddLabel("Get on a Machine while gifting!").TextSize = 17

local ProteinEggsLabel = InventoryTab:AddLabel("Protein Eggs: 0")
ProteinEggsLabel.TextSize = 18

local TropicalShakesLabel = InventoryTab:AddLabel("Tropical Shakes: 0")
TropicalShakesLabel.TextSize = 18

local function updateInventory()
    local eggCount = 0
    local shakeCount = 0
    local backpack = LocalPlayer:WaitForChild("Backpack")
    
    if backpack then
        for _, item in ipairs(backpack:GetChildren()) do
            if item.Name == "Protein Egg" then
                eggCount = eggCount + 1
            elseif item.Name == "Tropical Shake" then
                shakeCount = shakeCount + 1
            end
        end
    end
    
    ProteinEggsLabel.Text = "Protein Eggs: " .. eggCount
    TropicalShakesLabel.Text = "Tropical Shakes: " .. shakeCount
end

task.spawn(function()
    while true do
        updateInventory()
        task.wait(10)
    end
end)

InventoryTab:AddLabel("Egg Gifter").TextSize = 20

local eggGiftTarget = nil
local ChoosePlayerEgg = InventoryTab:AddDropdown("Choose Player", function(selected)
    local playerName = selected:match("| (.+)$")
    if playerName then
        eggGiftTarget = Players:FindFirstChild(playerName)
    end
end)

for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        ChoosePlayerEgg:Add(player.DisplayName .. " | " .. player.Name, player.Name)
    end
end

Players.PlayerAdded:Connect(function(player)
    if player ~= LocalPlayer then
        ChoosePlayerEgg:Add(player.DisplayName .. " | " .. player.Name, player.Name)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    for _, item in pairs(ChoosePlayerEgg:GetItems()) do
        if item.Text:match("| " .. player.Name .. "$") then
            ChoosePlayerEgg:Remove(item.Text)
            break
        end
    end
    
    if eggGiftTarget == player then
        eggGiftTarget = nil
    end
end)

local eggGiftAmount = 0

InventoryTab:AddTextBox("Amount", function(input)
    eggGiftAmount = tonumber(input)
end)

InventoryTab:AddButton("Start Gifting", function()
    if eggGiftTarget and eggGiftAmount and eggGiftAmount > 0 then
        for _ = 1, eggGiftAmount do
            local args = {
                "giftRequest",
                eggGiftTarget,
                LocalPlayer.consumablesFolder:FindFirstChild("Protein Egg"),
            }
            
            ReplicatedStorage.rEvents.giftRemote:InvokeServer(unpack(args))
        end
    end
end)

InventoryTab:AddLabel("Shake Gifter").TextSize = 20

local shakeGiftTarget = nil
local ChoosePlayerShake = InventoryTab:AddDropdown("Choose Player", function(selected)
    local playerName = selected:match("| (.+)$")
    if playerName then
        shakeGiftTarget = Players:FindFirstChild(playerName)
    end
end)

for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        ChoosePlayerShake:Add(player.DisplayName .. " | " .. player.Name, player.Name)
    end
end

Players.PlayerAdded:Connect(function(player)
    if player ~= LocalPlayer then
        ChoosePlayerShake:Add(player.DisplayName .. " | " .. player.Name, player.Name)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    for _, item in pairs(ChoosePlayerShake:GetItems()) do
        if item.Text:match("| " .. player.Name .. "$") then
            ChoosePlayerShake:Remove(item.Text)
            break
        end
    end
    
    if shakeGiftTarget == player then
        shakeGiftTarget = nil
    end
end)

local shakeGiftAmount = 0

InventoryTab:AddTextBox("Amount", function(input)
    shakeGiftAmount = tonumber(input)
end)

InventoryTab:AddButton("Start Gifting", function()
    if shakeGiftTarget and shakeGiftAmount and shakeGiftAmount > 0 then
        for _ = 1, shakeGiftAmount do
            local args = {
                "giftRequest",
                shakeGiftTarget,
                LocalPlayer.consumablesFolder:FindFirstChild("Tropical Shake"),
            }
            
            ReplicatedStorage.rEvents.giftRemote:InvokeServer(unpack(args))
        end
    end
end)

InventoryTab:AddLabel("Eater").TextSize = 20

local function useProteinEgg2()
    local egg = LocalPlayer.Character:FindFirstChild("Protein Egg") or LocalPlayer.Backpack:FindFirstChild("Protein Egg")
    if egg then
        muscleEvent2:FireServer("proteinEgg", egg)
    end
end

local eggDevourEnabled = false

task.spawn(function()
    while true do
        while eggDevourEnabled do
            useProteinEgg2()
            task.wait(0.3)
        end
        
        task.wait(0.5)
    end
end)

InventoryTab:AddSwitch("Egg Devour", function(value)
    eggDevourEnabled = value
    
    if value then
        useProteinEgg2()
    end
end):Set(false)

local consumableItems = {
    "Tropical Shake",
    "Energy Shake",
    "Protein Bar",
    "TOUGH Bar",
    "Protein Shake",
    "ULTRA Shake",
    "Energy Bar",
}

local function convertToEventName(itemName)
    local words = {}
    for word in itemName:gmatch("%S+") do
        table.insert(words, word:lower())
    end
    
    for i = 2, #words do
        words[i] = words[i]:sub(1, 1):upper() .. words[i]:sub(2)
    end
    
    return table.concat(words)
end

local function eatEverything()
    for _, itemName in ipairs(consumableItems) do
        local item = LocalPlayer.Character:FindFirstChild(itemName) or LocalPlayer.Backpack:FindFirstChild(itemName)
        if item then
            muscleEvent2:FireServer(convertToEventName(itemName), item)
        end
    end
end

local eatEverythingEnabled = false

task.spawn(function()
    while true do
        while eatEverythingEnabled do
            eatEverything()
            task.wait(0.1)
        end
        
        task.wait(0.5)
    end
end)

InventoryTab:AddSwitch("Eat Everything", function(value)
    eatEverythingEnabled = value
    
    if value then
        eatEverything()
    end
end):Set(false)

local StatsTab = Window:AddTab("Stats")

local leaderstats = LocalPlayer:WaitForChild("leaderstats")
local strengthStat = leaderstats:WaitForChild("Strength")
local rebirthsStat = leaderstats:WaitForChild("Rebirths")
local durabilityStat = LocalPlayer:WaitForChild("Durability")
local killsStat = leaderstats:WaitForChild("Kills")
local agilityStat = LocalPlayer:WaitForChild("Agility")
local evilKarmaStat = LocalPlayer:WaitForChild("evilKarma")
local goodKarmaStat = LocalPlayer:WaitForChild("goodKarma")
local brawlsStat = leaderstats:WaitForChild("Brawls")

local function formatStats(num)
    local isNegative = num < 0
    local absNum = math.abs(num)
    
    if absNum >= 1000000000000000 then
        return (isNegative and "-" or "") .. string.format("%.2fQa", absNum / 1000000000000000)
    elseif absNum >= 1000000000000 then
        return (isNegative and "-" or "") .. string.format("%.2fT", absNum / 1000000000000)
    elseif absNum >= 1000000000 then
        return (isNegative and "-" or "") .. string.format("%.2fB", absNum / 1000000000)
    elseif absNum >= 1000000 then
        return (isNegative and "-" or "") .. string.format("%.2fM", absNum / 1000000)
    elseif absNum >= 1000 then
        return (isNegative and "-" or "") .. string.format("%.2fK", absNum / 1000)
    else
        return (isNegative and "-" or "") .. string.format("%.2f", absNum)
    end
end

StatsTab:AddLabel("⏰ Time:").TextSize = 24

local TimeLabel = StatsTab:AddLabel("0d 0h 0m 0s")
TimeLabel.TextSize = 20

local ProjectedStrengthLabel = StatsTab:AddLabel("💪 Projected Strength: 0 /Hour | 0 /Day")
ProjectedStrengthLabel.TextSize = 20

local ProjectedDurabilityLabel = StatsTab:AddLabel("🛡️ Projected Durability: 0 /Hour | 0 /Day")
ProjectedDurabilityLabel.TextSize = 20

local ProjectedRebirthsLabel = StatsTab:AddLabel("🔄 Projected Rebirths: 0 /Hour | 0 /Day")
ProjectedRebirthsLabel.TextSize = 20

StatsTab:AddLabel("").TextSize = 10
StatsTab:AddLabel("📊 Stats:").TextSize = 24

local StrengthLabel = StatsTab:AddLabel("Strength: 0 | Gained: 0")
StrengthLabel.TextSize = 20

local DurabilityLabel = StatsTab:AddLabel("Durability: 0 | Gained: 0")
DurabilityLabel.TextSize = 20

local RebirthsLabel3 = StatsTab:AddLabel("Rebirths: 0 | Gained: 0")
RebirthsLabel3.TextSize = 20

local KillsLabel = StatsTab:AddLabel("Kills: 0 | Gained: 0")
KillsLabel.TextSize = 20

local AgilityLabel = StatsTab:AddLabel("Agility: 0 | Gained: 0")
AgilityLabel.TextSize = 20

local EvilKarmaLabel = StatsTab:AddLabel("Evil Karma: 0 | Gained: 0")
EvilKarmaLabel.TextSize = 20

local GoodKarmaLabel = StatsTab:AddLabel("Good Karma: 0 | Gained: 0")
GoodKarmaLabel.TextSize = 20

local BrawlsLabel = StatsTab:AddLabel("Brawls: 0 | Gained: 0")
BrawlsLabel.TextSize = 20

local startTime = tick()
local initialStrength = strengthStat.Value
local initialDurability = durabilityStat.Value
local initialRebirths = rebirthsStat.Value
local initialKills = killsStat.Value
local initialAgility = agilityStat.Value
local initialEvilKarma = evilKarmaStat.Value
local initialGoodKarma = goodKarmaStat.Value
local initialBrawls = brawlsStat.Value

task.spawn(function()
    local lastProjectionUpdate = 0
    
    while true do
        local currentTime = tick()
        local elapsedTime = currentTime - startTime
        local days = math.floor(elapsedTime / 86400)
        local hours = math.floor(elapsedTime % 86400 / 3600)
        local minutes = math.floor(elapsedTime % 3600 / 60)
        local seconds = math.floor(elapsedTime % 60)
        
        TimeLabel.Text = string.format("%dd %dh %dm %ds", days, hours, minutes, seconds)
        
        local currentStrength = strengthStat.Value
        local currentRebirths = rebirthsStat.Value
        local currentDurability = durabilityStat.Value
        local currentKills = killsStat.Value
        local currentAgility = agilityStat.Value
        local currentEvilKarma = evilKarmaStat.Value
        local currentGoodKarma = goodKarmaStat.Value
        local currentBrawls = brawlsStat.Value
        
        local strengthGained = currentStrength - initialStrength
        local durabilityGained = currentDurability - initialDurability
        local rebirthsGained = currentRebirths - initialRebirths
        local killsGained = currentKills - initialKills
        local agilityGained = currentAgility - initialAgility
        local evilKarmaGained = currentEvilKarma - initialEvilKarma
        local goodKarmaGained = currentGoodKarma - initialGoodKarma
        local brawlsGained = currentBrawls - initialBrawls
        
        StrengthLabel.Text = "💪 Strength: " .. formatStats(currentStrength) .. " | Gained: " .. formatStats(strengthGained)
        DurabilityLabel.Text = "🛡️ Durability: " .. formatStats(currentDurability) .. " | Gained: " .. formatStats(durabilityGained)
        RebirthsLabel3.Text = "🔄 Rebirths: " .. formatStats(currentRebirths) .. " | Gained: " .. formatStats(rebirthsGained)
        AgilityLabel.Text = "🏃 Agility: " .. formatStats(currentAgility) .. " | Gained: " .. formatStats(agilityGained)
        KillsLabel.Text = "⚔️ Kills: " .. formatStats(currentKills) .. " | Gained: " .. formatStats(killsGained)
        EvilKarmaLabel.Text = "😈 Evil Karma: " .. formatStats(currentEvilKarma) .. " | Gained: " .. formatStats(evilKarmaGained)
        GoodKarmaLabel.Text = "😇 Good Karma: " .. formatStats(currentGoodKarma) .. " | Gained: " .. formatStats(goodKarmaGained)
        BrawlsLabel.Text = "👊 Brawls: " .. formatStats(currentBrawls) .. " | Gained: " .. formatStats(brawlsGained)
        
        if currentTime - lastProjectionUpdate >= 6 then
            local rebirthsPerSecond = rebirthsGained / elapsedTime
            local strengthPerSecond = strengthGained / elapsedTime
            local durabilityPerSecond = durabilityGained / elapsedTime
            local hourSeconds = 3600
            local daySeconds = 86400
            
            local rebirthsPerHour = math.floor(rebirthsPerSecond * hourSeconds)
            local strengthPerHour = math.floor(strengthPerSecond * hourSeconds)
            local durabilityPerHour = math.floor(durabilityPerSecond * hourSeconds)
            local rebirthsPerDay = math.floor(rebirthsPerSecond * daySeconds)
            local strengthPerDay = math.floor(strengthPerSecond * daySeconds)
            local durabilityPerDay = math.floor(durabilityPerSecond * daySeconds)
            
            ProjectedStrengthLabel.Text = "💪 Strength Pace: " .. formatStats(strengthPerHour) .. "/Hour | " .. formatStats(strengthPerDay) .. "/Day"
            ProjectedDurabilityLabel.Text = "🛡️ Durability Pace: " .. formatStats(durabilityPerHour) .. "/Hour | " .. formatStats(durabilityPerDay) .. "/Day"
            ProjectedRebirthsLabel.Text = "🔄 Rebirth Pace: " .. formatStats(rebirthsPerHour) .. "/Hour | " .. formatStats(rebirthsPerDay) .. "/Day"
            
            lastProjectionUpdate = currentTime
        end
        
        task.wait(0.05)
    end
end)
