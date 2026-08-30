local Services = {
    Players = game:GetService("Players"),
    Workspace = game:GetService("Workspace"),
    RunService = game:GetService("RunService"),
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
    VirtualUser = game:GetService("VirtualUser"),
    UserInputService = game:GetService("UserInputService"),
    TeleportService = game:GetService("TeleportService"),
    StarterGui = game:GetService("StarterGui"),
    Lighting = game:GetService("Lighting")
}

local LocalPlayer = Services.Players.LocalPlayer

local CONFIG = {
    Rocks = {
        ["Jungle Rock (10M)"] = {name = "Ancient Jungle Rock", delay = 0.0001},
        ["King Rock (5M)"] = {name = "Muscle King Mountain", delay = 0.0001},
        ["Legends Rock (1M)"] = {name = "Rock Of Legends", delay = 0.01},
        ["Inferno Rock (750K)"] = {name = "Inferno Rock", delay = 0.01},
        ["Mystic Rock (400K)"] = {name = 6, delay = 0.01},
        ["Frozen Rock (150K)"] = {name = "Frozen Rock", delay = 0.01},
        ["Golden Rock (5K)"] = {name = "Punching Rock", delay = 0.01},
        ["Tiny Rock (0)"] = {name = "Tiny Rock", delay = 0.01}
    },
    Tools = {
        Weight = {toolName = "Weight", fireEvent = true, description = "Auto weight lifting"},
        Pushups = {toolName = "Pushups", fireEvent = true, description = "Auto pushups"},
        Handstands = {toolName = "Handstands", fireEvent = true, description = "Auto handstands"},
        Situps = {toolName = "Situps", fireEvent = true, description = "Auto situps"},
        Punch = {toolName = "Punch", fireEvent = false, special = true, description = "Auto punch"}
    },
    ComboTools = {
        Pushups = "Pushups",
        Situps = "Situps",
        Handstands = "Handstands",
        Weight = "Weight"
    },
    FastToolSpeeds = {
        {"Punch", "attackTime", 0, 0.35},
        {"Ground Slam", "attackTime", 0, 6},
        {"Stomp", "attackTime", 0, 7},
        {"Handstands", "repTime", 0, 1},
        {"Pushups", "repTime", 0, 1},
        {"Weight", "repTime", 0, 1},
        {"Situps", "repTime", 0, 1}
    },
    WaterWalk = {
        PartSize = 2048,
        TotalDistance = 50000,
        StartPosition = Vector3.new(-2, -9.5, -2)
    },
    Rebirth = {
        TargetValue = 100,
        KingPosition = Vector3.new(-8636, 17, -5759)
    },
    Character = {
        DefaultSpeed = 16,
        DefaultJump = 50,
        DefaultSize = 2
    },
    Crystals = {
        ["Blue Crystal"] = {
            {name = "Blue Birdie", rarity = "Basic"},
            {name = "Orange Hedgehog", rarity = "Basic"},
            {name = "Blue Aura", rarity = "Basic"},
            {name = "Red Kitty", rarity = "Basic"},
            {name = "Dark Vampy", rarity = "Advanced"},
            {name = "Blue Bunny", rarity = "Basic"},
            {name = "Red Aura", rarity = "Basic"},
            {name = "Green Aura", rarity = "Basic"},
            {name = "Purple Aura", rarity = "Basic"},
            {name = "Yellow Aura", rarity = "Basic"}
        },
        ["Green Crystal"] = {
            {name = "Silver Dog", rarity = "Basic"},
            {name = "Green Aura", rarity = "Advanced"},
            {name = "Dark Golem", rarity = "Advanced"},
            {name = "Green Butterfly", rarity = "Advanced"},
            {name = "Crimson Falcon", rarity = "Rare"},
            {name = "Red Aura", rarity = "Basic"},
            {name = "Blue Aura", rarity = "Basic"},
            {name = "Purple Aura", rarity = "Basic"},
            {name = "Yellow Aura", rarity = "Basic"}
        },
        ["Frost Crystal"] = {
            {name = "Yellow Butterfly", rarity = "Advanced"},
            {name = "Purple Dragon", rarity = "Rare"},
            {name = "Blue Pheonix", rarity = "Epic"},
            {name = "Orange Pegasus", rarity = "Rare"},
            {name = "Lightning", rarity = "Rare"},
            {name = "Electro", rarity = "Advanced"}
        },
        ["Mythical Crystal"] = {
            {name = "Purple Falcon", rarity = "Rare"},
            {name = "Red Dragon", rarity = "Rare"},
            {name = "Blue Firecaster", rarity = "Epic"},
            {name = "Golden Pheonix", rarity = "Epic"},
            {name = "Power Lightning", rarity = "Rare"},
            {name = "Dark Lightning", rarity = "Epic"}
        },
        ["Inferno Crystal"] = {
            {name = "Red Firecaster", rarity = "Epic"},
            {name = "Infernal Dragon", rarity = "Unique"},
            {name = "White Pegasus", rarity = "Rare"},
            {name = "Golden Pheonix", rarity = "Epic"},
            {name = "Inferno", rarity = "Epic"},
            {name = "Dark Storm", rarity = "Unique"}
        },
        ["Legends Crystal"] = {
            {name = "Ultra Birdie", rarity = "Unique"},
            {name = "Magic Butterfly", rarity = "Unique"},
            {name = "Green Firecaster", rarity = "Epic"},
            {name = "White Pheonix", rarity = "Epic"},
            {name = "Supernova", rarity = "Epic"},
            {name = "Purple Nova", rarity = "Unique"}
        },
        ["Muscle Elite Crystal"] = {
            {name = "Frostwave Legends Penguin", rarity = "Rare"},
            {name = "Phantom Genesis Dragon", rarity = "Rare"},
            {name = "Dark Legends Manticore", rarity = "Epic"},
            {name = "Ultimate Supernova Pegasus", rarity = "Epic"},
            {name = "Aether Spirit Bunny", rarity = "Unique"},
            {name = "Cybernetic Showdown Dragon", rarity = "Unique"}
        },
        ["Galaxy Oracle Crystal"] = {
            {name = "Eternal Strike Leviathan", rarity = "Rare"},
            {name = "Lightning Strike Phantom", rarity = "Epic"},
            {name = "Darkstar Hunter", rarity = "Unique"},
            {name = "Muscle King", rarity = "Unique"},
            {name = "Azure Tundra", rarity = "Epic"},
            {name = "Ultra Inferno", rarity = "Rare"}
        },
        ["Jungle Crystal"] = {
            {name = "Entropic Blast", rarity = "Unique"},
            {name = "Muscle Sensei", rarity = "Unique"},
            {name = "Grand Supernova", rarity = "Epic"},
            {name = "Neon Guardian", rarity = "Unique"},
            {name = "Eternal Megastrike", rarity = "Unique"},
            {name = "Golden Viking", rarity = "Epic"},
            {name = "Astral Electro", rarity = "Epic"},
            {name = "Dark Electro", rarity = "Epic"},
            {name = "Enchanted Mirage", rarity = "Epic"},
            {name = "Ultra Mirage", rarity = "Unique"},
            {name = "Unstable Mirage", rarity = "Unique"}
        }
    },
    Ultimates = {
        "+1 Daily Spin",
        "+1 Pet Slot",
        "+10 Item Capacity",
        "+5% Rep Speed",
        "Demon Damage",
        "Galaxy Gains",
        "Golden Rebirth",
        "Jungle Swift",
        "Muscle Mind",
        "x2 Chest Rewards",
        "x2 Quest Rewards"
    }
}

local STATE = {
    Toggles = {
        autoWinBrawl = false,
        autoJoinBrawl = false,
        autoPunchRock = false,
        AutoTool = false,
        FastTools = false,
        AutoComboTool = false,
        targetRebirthActive = false,
        infiniteRebirthActive = false,
        autoSizeActive = false,
        autoSetSizeEnabled = false,
        SafeZone = false,
        AutoSpinWheel = false,
        godMode = false,
        autoEat30 = false,
        autoEat60 = false,
        autoSetSize = false,
        autoSpeed = false,
        autoJump = false,
        noclip = false,
        infiniteJump = false,
        waterWalk = false,
        AutoBuyPet = false,
        AutoBuyAura = false,
        AutoUpgradeUltimate = false
    },
    Selections = {
        Rock = nil,
        Tool = nil,
        ComboTool = nil,
        Pet = "",
        Aura = "",
        Ultimate = ""
    },
    Values = {
        TargetRebirths = 100,
        Size = 2,
        Speed = 16,
        Jump = 50
    },
    Connections = {
        Speed = nil,
        Jump = nil,
        Noclip = nil,
        InfiniteJump = nil,
        AntiAFK = nil
    },
    Cache = {
        OriginalCanCollide = {},
        WaterWalkParts = {}
    }
}

task.spawn(function()
    while true do
        pcall(function()
            Services.VirtualUser:CaptureController()
            Services.VirtualUser:ClickButton2(Vector2.new())
        end)
        task.wait(300)
    end
end)

if STATE.Connections.AntiAFK then
    STATE.Connections.AntiAFK:Disconnect()
end

STATE.Connections.AntiAFK = LocalPlayer.Idled:Connect(function()
    pcall(function()
        Services.VirtualUser:CaptureController()
        Services.VirtualUser:ClickButton2(Vector2.new())
    end)
end)

local function findCrystalForItem(itemName)
    for crystalName, pets in pairs(CONFIG.Crystals) do
        for _, pet in ipairs(pets) do
            if pet.name == itemName then
                return crystalName
            end
        end
    end
    return nil
end

local function reapplyToggles()
    if STATE.Toggles.AutoTool and STATE.Selections.Tool and CONFIG.Tools[STATE.Selections.Tool] then
        task.wait(0.5)
        pcall(function()
            local tool = LocalPlayer.Backpack:FindFirstChild(CONFIG.Tools[STATE.Selections.Tool].toolName)
            if tool and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid:EquipTool(tool)
            end
        end)
    end
    
    if STATE.Toggles.AutoComboTool and STATE.Selections.ComboTool then
        task.wait(0.5)
        pcall(function()
            local tool = LocalPlayer.Backpack:FindFirstChild(CONFIG.ComboTools[STATE.Selections.ComboTool])
            if tool and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid:EquipTool(tool)
            end
        end)
    end
    
    if STATE.Toggles.autoSpeed then
        task.wait(0.5)
        local humanoid = LocalPlayer.Character and LocalPlayer.Character:WaitForChild("Humanoid", 5)
        if humanoid then
            humanoid.WalkSpeed = STATE.Values.Speed
        end
    end
    
    if STATE.Toggles.autoJump then
        task.wait(0.5)
        local humanoid = LocalPlayer.Character and LocalPlayer.Character:WaitForChild("Humanoid", 5)
        if humanoid then
            humanoid.JumpPower = STATE.Values.Jump
        end
    end
    
    if STATE.Toggles.noclip then
        STATE.Cache.OriginalCanCollide = {}
        task.wait(0.1)
        if STATE.Connections.Noclip then
            STATE.Connections.Noclip:Disconnect()
        end
        STATE.Connections.Noclip = Services.RunService.Stepped:Connect(function()
            if not STATE.Toggles.noclip then return end
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                for _, part in pairs(char:GetChildren()) do
                    if part:IsA("BasePart") then
                        if STATE.Cache.OriginalCanCollide[part] == nil then
                            STATE.Cache.OriginalCanCollide[part] = part.CanCollide
                        end
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
    
    if STATE.Toggles.infiniteJump then
        task.wait(0.1)
        if STATE.Connections.InfiniteJump then
            STATE.Connections.InfiniteJump:Disconnect()
        end
        STATE.Connections.InfiniteJump = Services.UserInputService.JumpRequest:Connect(function()
            if not STATE.Toggles.infiniteJump then return end
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end
end

LocalPlayer.CharacterAdded:Connect(function(character)
    reapplyToggles()
end)

if LocalPlayer.Character then
    reapplyToggles()
end

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/1NFERNO-HUB/Main/refs/heads/main/Settings/UI/1NFERNO_Library.lua"))()

local Window = Library:CreateWindow({
    Title = "Mystery Hub v1.0.0",
    Description = "Muscle Legends Version",
    ["Tab Width"] = 120,
    SizeUi = UDim2.fromOffset(550, 315),
    Image = "rbxassetid://111540401810376"
})

local HomeTab = Window:CreateTab({Name = "Home", Icon = "rbxassetid://10723407389"})

HomeTab:AddParagraph({
    Title = "Welcome To Mystery Hub",
    Content = "Muscle Legends Script"
})

HomeTab:AddButton({
    Title = "Discord Server",
    Description = "Join our Discord server to receive future updates",
    Icon = "rbxassetid://10734898355",
    Callback = function()
        if setclipboard then
            setclipboard("https://discord.gg/sm28dye2vK")
        end
    end
})

HomeTab:AddLine()

HomeTab:AddParagraph({
    Title = "Dev",
    Content = [[
Sherya
Discord : Miss.Sherya
Roblox : MissSherya
Tik Tok : xvisherys
]]
})

HomeTab:AddParagraph({
    Title = "Dev",
    Content = [[
Havoc
Discord : 1nfernohubontop
Roblox : seanxisabella
]]
})

HomeTab:AddParagraph({
    Title = "Contributors",
    Content = [[
None at the moment
Upcoming applications on our Discord server
]]
})

HomeTab:AddSeperator({
    Title = "Mystery Hub On Top"
})

local MainTab = Window:CreateTab({Name = "Main", Icon = "rbxassetid://10723354671"})
local BrawlsSection = MainTab:AddSection("Auto Brawls", false)

BrawlsSection:AddToggle({
    Title = "God Mode Brawl",
    Content = "Spam join brawl instantly",
    Default = false,
    Callback = function(state)
        STATE.Toggles.godMode = state
        if state then
            task.spawn(function()
                while STATE.Toggles.godMode and task.wait(0) do
                    pcall(function()
                        Services.ReplicatedStorage.rEvents.brawlEvent:FireServer("joinBrawl")
                    end)
                end
            end)
        end
    end
})

BrawlsSection:AddToggle({
    Title = "Auto Win Brawls",
    Content = "Automatically win brawls",
    Default = false,
    Callback = function(bool)
        STATE.Toggles.autoWinBrawl = bool

        local function equipPunch()
            if not STATE.Toggles.autoWinBrawl then return end
            local character = LocalPlayer.Character
            if not character then return false end
            if character:FindFirstChild("Punch") then return true end
            local backpack = LocalPlayer.Backpack
            if not backpack then return false end
            for _, tool in pairs(backpack:GetChildren()) do
                if tool:IsA("Tool") and tool.Name == "Punch" then
                    tool.Parent = character
                    return true
                end
            end
            return false
        end

        local function isValidTarget(player)
            if not player or player == LocalPlayer then return false end
            local character = player.Character
            if not character then return false end
            local humanoid = character:FindFirstChild("Humanoid")
            if not humanoid or humanoid.Health <= 0 then return false end
            if humanoid:GetState() == Enum.HumanoidStateType.Dead then return false end
            return character:FindFirstChild("HumanoidRootPart") ~= nil
        end

        local function isLocalPlayerReady()
            local char = LocalPlayer.Character
            if not char then return false end
            local hum = char:FindFirstChild("Humanoid")
            if not hum or hum.Health <= 0 then return false end
            return char:FindFirstChild("LeftHand") or char:FindFirstChild("RightHand")
        end

        local function safeTouchInterest(target, hand)
            pcall(function()
                firetouchinterest(target, hand, 0)
                task.wait(0.01)
                firetouchinterest(target, hand, 1)
            end)
        end

        if bool then
            task.spawn(function()
                while task.wait(0.5) do
                    if not STATE.Toggles.autoWinBrawl then break end
                    pcall(function()
                        if LocalPlayer.PlayerGui and LocalPlayer.PlayerGui:FindFirstChild("gameGui") then
                            if LocalPlayer.PlayerGui.gameGui.brawlJoinLabel.Visible then
                                Services.ReplicatedStorage.rEvents.brawlEvent:FireServer("joinBrawl")
                                LocalPlayer.PlayerGui.gameGui.brawlJoinLabel.Visible = false
                            end
                        end
                    end)
                end
            end)

            task.spawn(function()
                while task.wait(0.5) do
                    if not STATE.Toggles.autoWinBrawl then break end
                    equipPunch()
                end
            end)

            task.spawn(function()
                while task.wait(0.1) do
                    if not STATE.Toggles.autoWinBrawl then break end
                    if isLocalPlayerReady() and Services.ReplicatedStorage.brawlInProgress.Value then
                        pcall(function() LocalPlayer.muscleEvent:FireServer("punch", "rightHand") end)
                        pcall(function() LocalPlayer.muscleEvent:FireServer("punch", "leftHand") end)
                    end
                end
            end)

            task.spawn(function()
                while task.wait(0.05) do
                    if not STATE.Toggles.autoWinBrawl then break end
                    if isLocalPlayerReady() and Services.ReplicatedStorage.brawlInProgress.Value then
                        local char = LocalPlayer.Character
                        if not char then continue end
                        local lh = char:FindFirstChild("LeftHand")
                        local rh = char:FindFirstChild("RightHand")
                        for _, plr in pairs(Services.Players:GetPlayers()) do
                            if isValidTarget(plr) then
                                local root = plr.Character.HumanoidRootPart
                                if lh then safeTouchInterest(root, lh) end
                                if rh then safeTouchInterest(root, rh) end
                            end
                        end
                    end
                end
            end)
        end
    end
})

BrawlsSection:AddToggle({
    Title = "Auto Join Brawls",
    Content = "Automatically join brawls when available",
    Default = false,
    Callback = function(bool)
        STATE.Toggles.autoJoinBrawl = bool
        if bool then
            task.spawn(function()
                while task.wait(0.5) do
                    if not STATE.Toggles.autoJoinBrawl then break end
                    pcall(function()
                        if LocalPlayer.PlayerGui and LocalPlayer.PlayerGui:FindFirstChild("gameGui") then
                            if LocalPlayer.PlayerGui.gameGui.brawlJoinLabel.Visible then
                                Services.ReplicatedStorage.rEvents.brawlEvent:FireServer("joinBrawl")
                                LocalPlayer.PlayerGui.gameGui.brawlJoinLabel.Visible = false
                            end
                        end
                    end)
                end
            end)
        end
    end
})

local RockSection = MainTab:AddSection("Auto Rocks", false)

RockSection:AddDropdown({
    Title = "Select Rock",
    Content = "Choose which rock to auto punch",
    Multi = false,
    Options = {"Jungle Rock (10M)", "King Rock (5M)", "Legends Rock (1M)", "Inferno Rock (750K)", "Mystic Rock (400K)", "Frozen Rock (150K)", "Golden Rock (5K)", "Tiny Rock (0)"},
    Default = {"Jungle Rock (10M)"},
    Callback = function(selected)
        STATE.Selections.Rock = selected[1]
    end
})

RockSection:AddToggle({
    Title = "Auto Punch",
    Content = "Automatically punch selected rock and equip punch tool",
    Default = false,
    Callback = function(state)
        STATE.Toggles.autoPunchRock = state
        if state then
            task.spawn(function()
                while STATE.Toggles.autoPunchRock do
                    if STATE.Selections.Rock and CONFIG.Rocks[STATE.Selections.Rock] then
                        local config = CONFIG.Rocks[STATE.Selections.Rock]
                        local rock
                        if tonumber(config.name) then
                            pcall(function()
                                rock = Services.Workspace.machinesFolder:GetChildren()[tonumber(config.name)]
                            end)
                        else
                            rock = Services.Workspace.machinesFolder:FindFirstChild(config.name)
                        end
                        if rock and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("LeftHand") then
                            pcall(function()
                                firetouchinterest(rock.Rock, LocalPlayer.Character.LeftHand, 0)
                                task.wait(config.delay)
                                firetouchinterest(rock.Rock, LocalPlayer.Character.LeftHand, 1)
                            end)
                        end
                    end
                    Services.RunService.Heartbeat:Wait()
                end
            end)
            task.spawn(function()
                while STATE.Toggles.autoPunchRock do
                    local char = LocalPlayer.Character
                    if not char then 
                        task.wait(1)
                        continue 
                    end
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum then
                        local punchTool = LocalPlayer.Backpack:FindFirstChild("Punch")
                        if punchTool then 
                            hum:EquipTool(punchTool) 
                        end
                        pcall(function()
                            LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
                            LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
                        end)
                    end
                    Services.RunService.Heartbeat:Wait()
                end
            end)
        end
    end
})

local ToolsSection = MainTab:AddSection("Auto Tools", false)

ToolsSection:AddDropdown({
    Title = "Select Tool",
    Content = "Choose which tool to auto equip",
    Multi = false,
    Options = {"Weight", "Pushups", "Handstands", "Situps", "Punch"},
    Default = {"Weight"},
    Callback = function(selected)
        STATE.Selections.Tool = selected[1]
    end
})

ToolsSection:AddToggle({
    Title = "Activate",
    Content = "Activate the selected tool automatically",
    Default = false,
    Callback = function(state)
        STATE.Toggles.AutoTool = state
        if state and STATE.Selections.Tool and CONFIG.Tools[STATE.Selections.Tool] then
            local config = CONFIG.Tools[STATE.Selections.Tool]
            task.spawn(function()
                while STATE.Toggles.AutoTool do
                    pcall(function()
                        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                            local tool = LocalPlayer.Backpack:FindFirstChild(config.toolName)
                            if tool then
                                LocalPlayer.Character.Humanoid:EquipTool(tool)
                            end
                        end
                    end)
                    task.wait(1)
                end
            end)
            if config.special then
                task.spawn(function()
                    while STATE.Toggles.AutoTool do
                        pcall(function()
                            local punch = LocalPlayer.Backpack:FindFirstChild("Punch")
                            if punch then
                                punch.Parent = LocalPlayer.Character
                                if punch:FindFirstChild("attackTime") then
                                    punch.attackTime.Value = 0
                                end
                            end
                        end)
                        task.wait(0.1)
                    end
                end)
                task.spawn(function()
                    while STATE.Toggles.AutoTool do
                        if LocalPlayer.Character then
                            pcall(function()
                                LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
                                LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
                                local punchTool = LocalPlayer.Character:FindFirstChild("Punch")
                                if punchTool then
                                    punchTool:Activate()
                                end
                            end)
                        end
                        task.wait(0)
                    end
                end)
            elseif config.fireEvent then
                task.spawn(function()
                    while STATE.Toggles.AutoTool do
                        pcall(function()
                            LocalPlayer.muscleEvent:FireServer("rep")
                        end)
                        task.wait(0.1)
                    end
                end)
            end
        else
            if STATE.Selections.Tool and CONFIG.Tools[STATE.Selections.Tool] then
                pcall(function()
                    if LocalPlayer.Character then
                        local equipped = LocalPlayer.Character:FindFirstChild(CONFIG.Tools[STATE.Selections.Tool].toolName)
                        if equipped then
                            equipped.Parent = LocalPlayer.Backpack
                        end
                    end
                end)
            end
        end
    end
})

ToolsSection:AddLine()

ToolsSection:AddButton({
    Title = "Unlock AutoLift Gamepass",
    Description = "Get the AutoLift gamepass for free",
    Icon = "rbxassetid://10734898355",
    Callback = function()
        pcall(function()
            local gamepassFolder = Services.ReplicatedStorage.gamepassIds
            for _, gamepass in pairs(gamepassFolder:GetChildren()) do
                local value = Instance.new("IntValue")
                value.Name = gamepass.Name
                value.Value = gamepass.Value
                value.Parent = LocalPlayer.ownedGamepasses
            end
        end)
    end
})

ToolsSection:AddLine()

ToolsSection:AddToggle({
    Title = "Fast Tools",
    Content = "Accelerate all tools speed",
    Default = false,
    Callback = function(state)
        STATE.Toggles.FastTools = state
        for _, toolInfo in ipairs(CONFIG.FastToolSpeeds) do
            pcall(function()
                local tool = LocalPlayer.Backpack:FindFirstChild(toolInfo[1])
                if tool and tool:FindFirstChild(toolInfo[2]) then
                    tool[toolInfo[2]].Value = state and toolInfo[3] or toolInfo[4]
                end
                if LocalPlayer.Character then
                    local equippedTool = LocalPlayer.Character:FindFirstChild(toolInfo[1])
                    if equippedTool and equippedTool:FindFirstChild(toolInfo[2]) then
                        equippedTool[toolInfo[2]].Value = state and toolInfo[3] or toolInfo[4]
                    end
                end
            end)
        end
    end
})

ToolsSection:AddLine()

ToolsSection:AddDropdown({
    Title = "Combo Tool + Jungle Rock",
    Content = "Select tool to use with Jungle Rock",
    Multi = false,
    Options = {"Pushups", "Situps", "Handstands", "Weight"},
    Default = {"Pushups"},
    Callback = function(selected)
        STATE.Selections.ComboTool = selected[1]
    end
})

ToolsSection:AddToggle({
    Title = "Activate Combo",
    Content = "Auto Tool + Auto Punch Jungle Rock",
    Default = false,
    Callback = function(state)
        STATE.Toggles.AutoComboTool = state
        if state and STATE.Selections.ComboTool then
            local toolName = CONFIG.ComboTools[STATE.Selections.ComboTool]
            local function EquipTool()
                pcall(function()
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                        local bp = LocalPlayer:FindFirstChild("Backpack")
                        local tool = bp and bp:FindFirstChild(toolName)
                        if tool and not LocalPlayer.Character:FindFirstChild(toolName) then
                            LocalPlayer.Character.Humanoid:EquipTool(tool)
                        end
                    end
                end)
            end
            EquipTool()
            task.spawn(function()
                while STATE.Toggles.AutoComboTool do
                    if not LocalPlayer.Character then
                        task.wait(1)
                        continue
                    end
                    pcall(function()
                        LocalPlayer.muscleEvent:FireServer("rep")
                    end)
                    pcall(function()
                        local rock = Services.Workspace.machinesFolder:FindFirstChild("Ancient Jungle Rock")
                        if rock and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("LeftHand") then
                            firetouchinterest(rock.Rock, LocalPlayer.Character.LeftHand, 0)
                            task.wait(0.0001)
                            firetouchinterest(rock.Rock, LocalPlayer.Character.LeftHand, 1)
                        end
                    end)
                    pcall(function()
                        local char = LocalPlayer.Character
                        local hum = char and char:FindFirstChildOfClass("Humanoid")
                        if hum then
                            local punchTool = LocalPlayer.Backpack:FindFirstChild("Punch")
                            if punchTool then 
                                hum:EquipTool(punchTool) 
                            end
                            LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
                            LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
                        end
                    end)
                    Services.RunService.RenderStepped:Wait()
                    EquipTool()
                end
            end)
        else
            if STATE.Selections.ComboTool then
                pcall(function()
                    if LocalPlayer.Character then
                        local toolName = CONFIG.ComboTools[STATE.Selections.ComboTool]
                        local equipped = LocalPlayer.Character:FindFirstChild(toolName)
                        if equipped then
                            equipped.Parent = LocalPlayer.Backpack
                        end
                    end
                end)
            end
        end
    end
})

task.spawn(function()
    while true do
        if STATE.Toggles.autoEat30 then
            pcall(function()
                Services.ReplicatedStorage.rEvents.eatProteinEggRemote:InvokeServer()
            end)
            task.wait(1800)
        else
            task.wait(1)
        end
    end
end)

task.spawn(function()
    while true do
        if STATE.Toggles.autoEat60 then
            pcall(function()
                Services.ReplicatedStorage.rEvents.eatProteinEggRemote:InvokeServer()
            end)
            task.wait(3600)
        else
            task.wait(1)
        end
    end
end)

ToolsSection:AddToggle({
    Title = "Auto Eat Egg (30 Min)",
    Content = "Eat protein egg every 30 minutes",
    Default = false,
    Callback = function(value)
        STATE.Toggles.autoEat30 = value
    end
})

ToolsSection:AddToggle({
    Title = "Auto Eat Egg (1 Hour)",
    Content = "Eat protein egg every 1 hour",
    Default = false,
    Callback = function(value)
        STATE.Toggles.autoEat60 = value
    end
})

local RebirthSection = MainTab:AddSection("Auto Rebirths", false)

local function updateStats()
    pcall(function()
        Services.StarterGui:SetCore("SendNotification", {
            Title = "Target Updated",
            Text = "New target: " .. tostring(STATE.Values.TargetRebirths) .. " rebirths",
            Duration = 3
        })
    end)
end

RebirthSection:AddInput({
    Title = "Rebirth Target",
    Content = "Set your rebirth target goal",
    Placeholder = "Enter number...",
    Callback = function(text)
        local newValue = tonumber(text)
        if newValue and newValue > 0 then
            STATE.Values.TargetRebirths = newValue
            updateStats()
        else
            pcall(function()
                Services.StarterGui:SetCore("SendNotification", {
                    Title = "Invalid Input",
                    Text = "Please enter a valid number greater than 0",
                    Duration = 3
                })
            end)
        end
    end
})

RebirthSection:AddToggle({
    Title = "Auto Rebirth Target",
    Content = "Auto rebirth until reaching target",
    Default = false,
    Callback = function(bool)
        STATE.Toggles.targetRebirthActive = bool
        if bool then
            if STATE.Toggles.infiniteRebirthActive then
                STATE.Toggles.infiniteRebirthActive = false
            end
            task.spawn(function()
                while task.wait(0.1) do
                    if not STATE.Toggles.targetRebirthActive then break end
                    pcall(function()
                        if LocalPlayer.leaderstats and LocalPlayer.leaderstats:FindFirstChild("Rebirths") then
                            local currentRebirths = LocalPlayer.leaderstats.Rebirths.Value
                            if currentRebirths >= STATE.Values.TargetRebirths then
                                STATE.Toggles.targetRebirthActive = false
                                Services.StarterGui:SetCore("SendNotification", {
                                    Title = "Target Reached!",
                                    Text = "You have reached " .. tostring(STATE.Values.TargetRebirths) .. " rebirths",
                                    Duration = 5
                                })
                                return
                            end
                            Services.ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
                        end
                    end)
                end
            end)
        end
    end
})

RebirthSection:AddToggle({
    Title = "Auto Rebirth (Infinite)",
    Content = "Continuous rebirth without stopping",
    Default = false,
    Callback = function(bool)
        STATE.Toggles.infiniteRebirthActive = bool
        if bool then
            if STATE.Toggles.targetRebirthActive then
                STATE.Toggles.targetRebirthActive = false
            end
            task.spawn(function()
                while task.wait(0.1) do
                    if not STATE.Toggles.infiniteRebirthActive then break end
                    pcall(function()
                        Services.ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
                    end)
                end
            end)
        end
    end
})

RebirthSection:AddLine()

RebirthSection:AddToggle({
    Title = "Auto Size 1",
    Content = "Set character size to 1 continuously",
    Default = false,
    Callback = function(bool)
        STATE.Toggles.autoSizeActive = bool
        if bool then
            task.spawn(function()
                while task.wait(0) do
                    if not STATE.Toggles.autoSizeActive then break end
                    pcall(function()
                        Services.ReplicatedStorage.rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", 1)
                    end)
                end
            end)
        end
    end
})

RebirthSection:AddToggle({
    Title = "Auto Set Size 2",
    Content = "Automatically set custom size",
    Default = false,
    Callback = function(state)
        STATE.Toggles.autoSetSize = state
        STATE.Toggles.autoSetSizeEnabled = state
        if state then
            task.spawn(function()
                while task.wait(0.01) do
                    if not STATE.Toggles.autoSetSize or not STATE.Toggles.autoSetSizeEnabled then break end
                    pcall(function()
                        Services.ReplicatedStorage.rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", STATE.Values.Size)
                    end)
                end
            end)
        end
    end
})

RebirthSection:AddLine()

RebirthSection:AddToggle({
    Title = "Auto Teleport King",
    Content = "Teleport to King area continuously",
    Default = false,
    Callback = function(state)
        STATE.Toggles.SafeZone = state
        if state then
            task.spawn(function()
                while task.wait(0.001) do
                    if not STATE.Toggles.SafeZone then break end
                    pcall(function()
                        local char = LocalPlayer.Character
                        if char and char:FindFirstChild("HumanoidRootPart") then
                            char.HumanoidRootPart.CFrame = CFrame.new(CONFIG.Rebirth.KingPosition)
                        end
                    end)
                end
            end)
        end
    end
})

RebirthSection:AddButton({
    Title = "Anti Rebirth",
    Description = "Block rebirth requests (anti-troll)",
    Icon = "rbxassetid://10734898355",
    Callback = function()
        pcall(function()
            local oldNamecall
            oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
                local args = {...}
                if self.Name == "rebirthRemote" and args[1] == "rebirthRequest" then
                    return 
                end
                return oldNamecall(self, unpack(args))
            end)
            Services.StarterGui:SetCore("SendNotification", {
                Title = "Anti Rebirth",
                Text = "Rebirth protection enabled!",
                Duration = 3
            })
        end)
    end
})

local CrystalTab = Window:CreateTab({Name = "Crystals", Icon = "rbxassetid://10723345518"})

CrystalTab:AddSeperator({Title = "Buy Pets and Auras"})

CrystalTab:AddDropdown({
    Title = "Select Pet",
    Content = "Choose a pet to auto buy",
    Multi = false,
    Options = {
        "Blue Birdie (Basic)",
        "Orange Hedgehog (Basic)",
        "Red Kitty (Basic)",
        "Blue Bunny (Basic)",
        "Silver Dog (Basic)",
        "Dark Vampy (Advanced)",
        "Dark Golem (Advanced)",
        "Green Butterfly (Advanced)",
        "Yellow Butterfly (Advanced)",
        "Crimson Falcon (Rare)",
        "Purple Dragon (Rare)",
        "Orange Pegasus (Rare)",
        "Purple Falcon (Rare)",
        "Red Dragon (Rare)",
        "White Pegasus (Rare)",
        "Frostwave Legends Penguin (Rare)",
        "Phantom Genesis Dragon (Rare)",
        "Eternal Strike Leviathan (Rare)",
        "Blue Pheonix (Epic)",
        "Blue Firecaster (Epic)",
        "Golden Pheonix (Epic)",
        "Red Firecaster (Epic)",
        "Green Firecaster (Epic)",
        "White Pheonix (Epic)",
        "Dark Legends Manticore (Epic)",
        "Ultimate Supernova Pegasus (Epic)",
        "Lightning Strike Phantom (Epic)",
        "Golden Viking (Epic)",
        "Infernal Dragon (Unique)",
        "Ultra Birdie (Unique)",
        "Magic Butterfly (Unique)",
        "Aether Spirit Bunny (Unique)",
        "Cybernetic Showdown Dragon (Unique)",
        "Darkstar Hunter (Unique)",
        "Muscle Sensei (Unique)",
        "Neon Guardian (Unique)"
    },
    Default = {"Blue Birdie (Basic)"},
    Callback = function(selected)
        STATE.Selections.Pet = selected[1]
    end
})

CrystalTab:AddDropdown({
    Title = "Select Aura",
    Content = "Choose an aura to auto buy",
    Multi = false,
    Options = {
        "Blue Aura (Basic)",
        "Green Aura (Basic)",
        "Purple Aura (Basic)",
        "Red Aura (Basic)",
        "Yellow Aura (Basic)",
        "Ultra Inferno (Rare)",
        "Azure Tundra (Epic)",
        "Grand Supernova (Epic)",
        "Muscle King (Unique)",
        "Entropic Blast (Unique)",
        "Eternal Megastrike (Unique)"
    },
    Default = {"Blue Aura (Basic)"},
    Callback = function(selected)
        STATE.Selections.Aura = selected[1]
    end
})

CrystalTab:AddLine()
CrystalTab:AddSeperator({Title = "Auto Buy System"})

CrystalTab:AddToggle({
    Title = "Auto Buy Pet",
    Content = "Automatically buy selected pet",
    Default = false,
    Callback = function(bool)
        STATE.Toggles.AutoBuyPet = bool
        if bool then
            if STATE.Selections.Pet == "" then
                return
            end
            local petName = STATE.Selections.Pet:match("^(.-)%s*%(")
            if not petName then
                petName = STATE.Selections.Pet
            end
            task.spawn(function()
                while STATE.Toggles.AutoBuyPet and STATE.Selections.Pet ~= "" do
                    pcall(function()
                        local petToBuy = Services.ReplicatedStorage.cPetShopFolder:FindFirstChild(petName)
                        if petToBuy then
                            Services.ReplicatedStorage.cPetShopRemote:InvokeServer(petToBuy)
                        end
                    end)
                    task.wait(0.1)
                end
            end)
        end
    end
})

CrystalTab:AddToggle({
    Title = "Auto Buy Aura",
    Content = "Automatically buy selected aura",
    Default = false,
    Callback = function(bool)
        STATE.Toggles.AutoBuyAura = bool
        if bool then
            if STATE.Selections.Aura == "" then
                return
            end
            local auraName = STATE.Selections.Aura:match("^(.-)%s*%(")
            if not auraName then
                auraName = STATE.Selections.Aura
            end
            task.spawn(function()
                while STATE.Toggles.AutoBuyAura and STATE.Selections.Aura ~= "" do
                    pcall(function()
                        local auraToBuy = Services.ReplicatedStorage.cPetShopFolder:FindFirstChild(auraName)
                        if auraToBuy then
                            Services.ReplicatedStorage.cPetShopRemote:InvokeServer(auraToBuy)
                        end
                    end)
                    task.wait(0.1)
                end
            end)
        end
    end
})

CrystalTab:AddLine()
CrystalTab:AddSeperator({Title = "Buy Ultimates"})

CrystalTab:AddDropdown({
    Title = "Select Ultimate",
    Content = "Choose an ultimate to auto upgrade",
    Multi = false,
    Options = CONFIG.Ultimates,
    Default = {"+1 Daily Spin"},
    Callback = function(selected)
        STATE.Selections.Ultimate = selected[1]
    end
})

CrystalTab:AddToggle({
    Title = "Auto Buy Ultimates",
    Content = "Automatically upgrade selected ultimate",
    Default = false,
    Callback = function(bool)
        STATE.Toggles.AutoUpgradeUltimate = bool
        if bool then
            if STATE.Selections.Ultimate == "" then
                return
            end
            task.spawn(function()
                while STATE.Toggles.AutoUpgradeUltimate and STATE.Selections.Ultimate ~= "" do
                    pcall(function()
                        Services.ReplicatedStorage.rEvents.ultimatesRemote:InvokeServer("upgradeUltimate", STATE.Selections.Ultimate)
                    end)
                    task.wait(1)
                end
            end)
        end
    end
})

local MiscTab = Window:CreateTab({Name = "Misc", Icon = "rbxassetid://10723387721"})

MiscTab:AddSeperator({Title = "Character Settings"})

MiscTab:AddSlider({
    Title = "Auto Size",
    Content = "Adjust your character size",
    Increment = 0.1,
    Min = 0.5,
    Max = 10,
    Default = 2,
    Callback = function(value)
        STATE.Values.Size = value
        if STATE.Toggles.autoSetSize then
            pcall(function()
                Services.ReplicatedStorage.rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", STATE.Values.Size)
            end)
        end
    end
})

MiscTab:AddToggle({
    Title = "Auto Set Size",
    Content = "Automatically set your size",
    Default = false,
    Callback = function(bool)
        STATE.Toggles.autoSetSize = bool
        if STATE.Toggles.autoSetSize then
            task.spawn(function()
                while STATE.Toggles.autoSetSize do
                    pcall(function()
                        Services.ReplicatedStorage.rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", STATE.Values.Size)
                    end)
                    task.wait(0.1)
                end
            end)
        end
    end
})

MiscTab:AddSlider({
    Title = "Auto Speed",
    Content = "Adjust your walk speed",
    Increment = 1,
    Min = 200,
    Max = 500,
    Default = 200,
    Callback = function(value)
        STATE.Values.Speed = value
        if STATE.Toggles.autoSpeed and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = STATE.Values.Speed
        end
    end
})

MiscTab:AddToggle({
    Title = "Auto Set Speed",
    Content = "Automatically set your speed",
    Default = true,
    Callback = function(bool)
        STATE.Toggles.autoSpeed = bool
        if STATE.Toggles.autoSpeed then
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = STATE.Values.Speed
            end
            if STATE.Connections.Speed then
                STATE.Connections.Speed:Disconnect()
            end
            STATE.Connections.Speed = LocalPlayer.CharacterAdded:Connect(function(character)
                task.wait(0.5)
                local humanoid = character:WaitForChild("Humanoid", 5)
                if humanoid and STATE.Toggles.autoSpeed then
                    humanoid.WalkSpeed = STATE.Values.Speed
                end
            end)
        else
            if STATE.Connections.Speed then
                STATE.Connections.Speed:Disconnect()
                STATE.Connections.Speed = nil
            end
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = CONFIG.Character.DefaultSpeed
            end
        end
    end
})

MiscTab:AddSlider({
    Title = "Auto Jump Power",
    Content = "Adjust your jump power",
    Increment = 1,
    Min = 50,
    Max = 200,
    Default = 50,
    Callback = function(value)
        STATE.Values.Jump = value
        if STATE.Toggles.autoJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = STATE.Values.Jump
        end
    end
})

MiscTab:AddToggle({
    Title = "Auto Set Jump Power",
    Content = "Automatically set your jump power",
    Default = false,
    Callback = function(bool)
        STATE.Toggles.autoJump = bool
        if STATE.Toggles.autoJump then
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.JumpPower = STATE.Values.Jump
            end
            if STATE.Connections.Jump then
                STATE.Connections.Jump:Disconnect()
            end
            STATE.Connections.Jump = LocalPlayer.CharacterAdded:Connect(function(character)
                task.wait(0.5)
                local humanoid = character:WaitForChild("Humanoid", 5)
                if humanoid and STATE.Toggles.autoJump then
                    humanoid.JumpPower = STATE.Values.Jump
                end
            end)
        else
            if STATE.Connections.Jump then
                STATE.Connections.Jump:Disconnect()
                STATE.Connections.Jump = nil
            end
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.JumpPower = CONFIG.Character.DefaultJump
            end
        end
    end
})

MiscTab:AddLine()
MiscTab:AddSeperator({Title = "External Scripts"})

MiscTab:AddButton({
    Title = "Infinite Yield",
    Description = "Load Infinite Yield admin commands",
    Icon = "rbxassetid://10734898355",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end
})

MiscTab:AddButton({
    Title = "GhostX Hub",
    Description = "Load GhostX Hub",
    Icon = "rbxassetid://10734898355",
    Callback = function()
        loadstring(game:HttpGet("https://scriptblox.com/raw/Universal-Script-GhostX-Hub-7158"))()
    end
})

MiscTab:AddButton({
    Title = "Permanent Shiftlock",
    Description = "Enable permanent shiftlock",
    Icon = "rbxassetid://10734898355",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/CjNsnSDy"))()
    end
})

MiscTab:AddButton({
    Title = "All Emotes",
    Description = "Load all emotes",
    Icon = "rbxassetid://10734898355",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/7yd7/Hub/refs/heads/Branch/GUIS/Emotes.lua"))()
    end
})

MiscTab:AddLine()
MiscTab:AddSeperator({Title = "Movement Features"})

local function toggleNoclip(enabled)
    if enabled then
        if STATE.Connections.Noclip then
            STATE.Connections.Noclip:Disconnect()
        end
        STATE.Connections.Noclip = Services.RunService.Stepped:Connect(function()
            if not STATE.Toggles.noclip then
                if STATE.Connections.Noclip then
                    STATE.Connections.Noclip:Disconnect()
                    STATE.Connections.Noclip = nil
                end
                return
            end
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                for _, part in pairs(char:GetChildren()) do
                    if part:IsA("BasePart") then
                        if STATE.Cache.OriginalCanCollide[part] == nil then
                            STATE.Cache.OriginalCanCollide[part] = part.CanCollide
                        end
                        part.CanCollide = false
                    end
                end
            end
        end)
        Services.StarterGui:SetCore("SendNotification", {
            Title = "No-Clip",
            Text = "No-Clip enabled! You can walk through objects.",
            Duration = 3
        })
    else
        if STATE.Connections.Noclip then
            STATE.Connections.Noclip:Disconnect()
            STATE.Connections.Noclip = nil
        end
        local character = LocalPlayer.Character
        if character then
            for _, part in pairs(character:GetChildren()) do
                if part:IsA("BasePart") and STATE.Cache.OriginalCanCollide[part] ~= nil then
                    part.CanCollide = STATE.Cache.OriginalCanCollide[part]
                end
            end
        end
        STATE.Cache.OriginalCanCollide = {}
        Services.StarterGui:SetCore("SendNotification", {
            Title = "No-Clip",
            Text = "No-Clip disabled! Collisions restored.",
            Duration = 3
        })
    end
end

local function toggleInfiniteJump(enabled)
    if enabled then
        if STATE.Connections.InfiniteJump then
            STATE.Connections.InfiniteJump:Disconnect()
        end
        STATE.Connections.InfiniteJump = Services.UserInputService.JumpRequest:Connect(function()
            if not STATE.Toggles.infiniteJump then
                if STATE.Connections.InfiniteJump then
                    STATE.Connections.InfiniteJump:Disconnect()
                    STATE.Connections.InfiniteJump = nil
                end
                return
            end
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("Humanoid") then
                character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
        Services.StarterGui:SetCore("SendNotification", {
            Title = "Infinite Jump",
            Text = "Infinite Jump enabled! Jump infinitely.",
            Duration = 3
        })
    else
        if STATE.Connections.InfiniteJump then
            STATE.Connections.InfiniteJump:Disconnect()
            STATE.Connections.InfiniteJump = nil
        end
        Services.StarterGui:SetCore("SendNotification", {
            Title = "Infinite Jump",
            Text = "Infinite Jump disabled! Normal jump restored.",
            Duration = 3
        })
    end
end

MiscTab:AddToggle({
    Title = "No-Clip",
    Content = "Walk through walls and objects",
    Default = false,
    Callback = function(enabled)
        STATE.Toggles.noclip = enabled
        toggleNoclip(enabled)
    end
})

MiscTab:AddToggle({
    Title = "Infinite Jump",
    Content = "Jump infinitely in the air",
    Default = false,
    Callback = function(enabled)
        STATE.Toggles.infiniteJump = enabled
        toggleInfiniteJump(enabled)
    end
})

MiscTab:AddLine()
MiscTab:AddSeperator({Title = "World Settings"})

MiscTab:AddButton({
    Title = "Change Time: Night",
    Description = "Set time to night (0:00)",
    Icon = "rbxassetid://10734898355",
    Callback = function()
        Services.Lighting.ClockTime = 0
    end
})

MiscTab:AddButton({
    Title = "Change Time: Day",
    Description = "Set time to day (12:00)",
    Icon = "rbxassetid://10734898355",
    Callback = function()
        Services.Lighting.ClockTime = 12
    end
})

MiscTab:AddButton({
    Title = "Change Time: Midnight",
    Description = "Set time to midnight (6:00)",
    Icon = "rbxassetid://10734898355",
    Callback = function()
        Services.Lighting.ClockTime = 6
    end
})

MiscTab:AddLine()
MiscTab:AddSeperator({Title = "Server & Game"})

MiscTab:AddButton({
    Title = "Rejoin Server",
    Description = "Rejoin current server",
    Icon = "rbxassetid://10734898355",
    Callback = function()
        local success, result = pcall(function()
            Services.TeleportService:TeleportToPlaceInstance(game.PlaceId, nil, LocalPlayer)
        end)
        if not success then
            Services.TeleportService:Teleport(game.PlaceId, LocalPlayer)
        end
    end
})

MiscTab:AddButton({
    Title = "Remove Portals",
    Description = "Remove Roblox ad portals",
    Icon = "rbxassetid://10734898355",
    Callback = function()
        for _, portal in pairs(game:GetDescendants()) do
            if portal.Name == "RobloxForwardPortals" then
                portal:Destroy()
            end
        end
        if _G.AdRemovalConnection then
            _G.AdRemovalConnection:Disconnect()
        end
        _G.AdRemovalConnection = game.DescendantAdded:Connect(function(descendant)
            if descendant.Name == "RobloxForwardPortals" then
                descendant:Destroy()
            end
        end)
        Services.StarterGui:SetCore("SendNotification", {
            Title = "Ads Removed",
            Text = "Roblox ads have been removed",
            Duration = 3
        })
    end
})

MiscTab:AddToggle({
    Title = "Auto Spin Wheel",
    Content = "Automatically spin fortune wheel",
    Default = false,
    Callback = function(bool)
        STATE.Toggles.AutoSpinWheel = bool
        if bool then
            task.spawn(function()
                while STATE.Toggles.AutoSpinWheel and task.wait(1) do
                    pcall(function()
                        Services.ReplicatedStorage.rEvents.openFortuneWheelRemote:InvokeServer("openFortuneWheel", Services.ReplicatedStorage.fortuneWheelChances["Fortune Wheel"])
                    end)
                end
            end)
        end
    end
})

MiscTab:AddLine()
MiscTab:AddSeperator({Title = "Water Walking"})

local function createWaterWalkParts()
    for _, part in ipairs(STATE.Cache.WaterWalkParts) do
        if part and part.Parent then
            part:Destroy()
        end
    end
    STATE.Cache.WaterWalkParts = {}
    
    local numberOfParts = math.ceil(CONFIG.WaterWalk.TotalDistance / CONFIG.WaterWalk.PartSize)
    
    for x = 0, numberOfParts - 1 do
        for z = 0, numberOfParts - 1 do
            local positions = {
                Vector3.new(x * CONFIG.WaterWalk.PartSize, 0, z * CONFIG.WaterWalk.PartSize),
                Vector3.new(-x * CONFIG.WaterWalk.PartSize, 0, z * CONFIG.WaterWalk.PartSize),
                Vector3.new(-x * CONFIG.WaterWalk.PartSize, 0, -z * CONFIG.WaterWalk.PartSize),
                Vector3.new(x * CONFIG.WaterWalk.PartSize, 0, -z * CONFIG.WaterWalk.PartSize)
            }
            for i, offset in ipairs(positions) do
                local newPart = Instance.new("Part")
                newPart.Size = Vector3.new(CONFIG.WaterWalk.PartSize, 1, CONFIG.WaterWalk.PartSize)
                newPart.Position = CONFIG.WaterWalk.StartPosition + offset
                newPart.Anchored = true
                newPart.Transparency = 1
                newPart.CanCollide = true
                newPart.Name = "WaterWalkPart_" .. x .. "_" .. z .. "_" .. i
                newPart.Parent = Services.Workspace
                table.insert(STATE.Cache.WaterWalkParts, newPart)
            end
        end
    end
end

local function removeWaterWalkParts()
    for _, part in ipairs(STATE.Cache.WaterWalkParts) do
        if part and part.Parent then
            part:Destroy()
        end
    end
    STATE.Cache.WaterWalkParts = {}
end

MiscTab:AddToggle({
    Title = "Full Walk on Water",
    Content = "Walk on water surfaces",
    Default = false,
    Callback = function(bool)
        STATE.Toggles.waterWalk = bool
        if bool then
            createWaterWalkParts()
        else
            removeWaterWalkParts()
        end
    end
})

local KillerTab = Window:CreateTab({Name = "Killler", Icon = "rbxassetid://10734962068"})

local autoKill = false
local playerWhitelist = {}
local friendWhitelistActive = false
local whitelistDropdownEnabled = false
local targetPlayerNames = {}
local killTarget = false
local spying = false
local targetPlayerName = nil

local function getDisplayNames()
    local options = {}
    for _, player in ipairs(Services.Players:GetPlayers()) do
        if player ~= LocalPlayer then
            table.insert(options, player.DisplayName)
        end
    end
    return options
end

-- =====================
-- SELECT PET
-- =====================

KillerTab:AddSeperator({Title = "Select Pet"})

local petsFolder = LocalPlayer.petsFolder

KillerTab:AddDropdown({
    Title = "Select Pet",
    Content = "Select the pet to equip",
    Multi = false,
    Options = {"Wild Wizard", "Mighty Monster"},
    Default = {"None"},
    Callback = function(selected)
        local petName = selected[1]
        if not petName then return end

        for _, folder in pairs(petsFolder:GetChildren()) do
            if folder:IsA("Folder") then
                for _, pet in pairs(folder:GetChildren()) do
                    Services.ReplicatedStorage.rEvents.equipPetEvent:FireServer("unequipPet", pet)
                end
            end
        end
        task.wait(0.2)

        local petsToEquip = {}
        for _, pet in pairs(petsFolder.Unique:GetChildren()) do
            if pet.Name == petName then
                table.insert(petsToEquip, pet)
            end
        end

        local equippedCount = math.min(#petsToEquip, 8)
        for i = 1, equippedCount do
            Services.ReplicatedStorage.rEvents.equipPetEvent:FireServer("equipPet", petsToEquip[i])
            task.wait(0.1)
        end
    end
})

-- =====================
-- KILL EVERYONE
-- =====================

KillerTab:AddSeperator({Title = "Kill Everyone"})

KillerTab:AddToggle({
    Title = "Auto Kill",
    Content = "Automatically kills all non-whitelisted players",
    Default = false,
    Callback = function(value)
        autoKill = value

        task.spawn(function()
            while autoKill do
                local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                local rightHand = character:FindFirstChild("RightHand")
                local leftHand = character:FindFirstChild("LeftHand")

                local punch = LocalPlayer.Backpack:FindFirstChild("Punch")
                if punch and not character:FindFirstChild("Punch") then
                    punch.Parent = character
                end

                if rightHand and leftHand then
                    for _, target in ipairs(Services.Players:GetPlayers()) do
                        if target ~= LocalPlayer and not playerWhitelist[target.Name] then
                            local targetChar = target.Character
                            local rootPart = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
                            if rootPart then
                                pcall(function()
                                    firetouchinterest(rightHand, rootPart, 1)
                                    firetouchinterest(leftHand, rootPart, 1)
                                    firetouchinterest(rightHand, rootPart, 0)
                                    firetouchinterest(leftHand, rootPart, 0)
                                end)
                            end
                        end
                    end
                end

                task.wait(0.05)
            end
        end)
    end
})

KillerTab:AddToggle({
    Title = "Auto Whitelist Friends",
    Content = "Automatically whitelists all your friends in the server",
    Default = false,
    Callback = function(value)
        friendWhitelistActive = value

        if value then
            for _, player in ipairs(Services.Players:GetPlayers()) do
                if player ~= LocalPlayer and LocalPlayer:IsFriendsWith(player.UserId) then
                    playerWhitelist[player.Name] = true
                end
            end

            Services.Players.PlayerAdded:Connect(function(player)
                if friendWhitelistActive and player ~= LocalPlayer and LocalPlayer:IsFriendsWith(player.UserId) then
                    playerWhitelist[player.Name] = true
                end
            end)
        else
            for name in pairs(playerWhitelist) do
                local friend = Services.Players:FindFirstChild(name)
                if friend and LocalPlayer:IsFriendsWith(friend.UserId) then
                    playerWhitelist[name] = nil
                end
            end
        end
    end
})

KillerTab:AddDropdown({
    Title = "Whitelist Players",
    Content = "Select players to whitelist from auto kill",
    Multi = true,
    Options = getDisplayNames(),
    Default = {},
    Callback = function(selected)
        if not whitelistDropdownEnabled then return end

        for name in pairs(playerWhitelist) do
            playerWhitelist[name] = nil
        end

        for _, displayName in pairs(selected) do
            for _, player in ipairs(Services.Players:GetPlayers()) do
                if player.DisplayName == displayName then
                    playerWhitelist[player.Name] = true
                end
            end
        end
    end
})

KillerTab:AddButton({
    Title = "Refresh Whitelist",
    Content = "Update the whitelist player list",
    Icon = "rbxassetid://10734898355",
    Callback = function()
        local options = getDisplayNames()
        if whitelistDropdown.SetOptions then
            whitelistDropdown:SetOptions(options)
        elseif whitelistDropdown.Refresh then
            whitelistDropdown:Refresh(options)
        elseif whitelistDropdown.Update then
            whitelistDropdown:Update(options)
        elseif whitelistDropdown.Clear then
            whitelistDropdown:Clear()
            for _, option in ipairs(options) do
                whitelistDropdown:Add(option)
            end
        end
    end
})

KillerTab:AddToggle({
    Title = "Player Whitelist",
    Content = "Enable manual player whitelisting from dropdown",
    Default = false,
    Callback = function(value)
        whitelistDropdownEnabled = value

        if not value then
            for name in pairs(playerWhitelist) do
                local player = Services.Players:FindFirstChild(name)
                if player then
                    playerWhitelist[name] = nil
                end
            end
        end
    end
})

-- =====================
-- KARMA SYSTEM
-- =====================

KillerTab:AddSeperator({Title = "Karma System"})

local autoGoodKarma = false
local autoBadKarma = false

KillerTab:AddToggle({
    Title = "Auto Good Karma",
    Content = "Automatically hits players with more evil karma than good karma",
    Default = false,
    Callback = function(value)
        autoGoodKarma = value

        task.spawn(function()
            while autoGoodKarma do
                local playerChar = LocalPlayer.Character
                local rightHand = playerChar and playerChar:FindFirstChild("RightHand")
                local leftHand = playerChar and playerChar:FindFirstChild("LeftHand")

                if playerChar and rightHand and leftHand then
                    for _, target in ipairs(Services.Players:GetPlayers()) do
                        if target ~= LocalPlayer then
                            local evilKarma = target:FindFirstChild("evilKarma")
                            local goodKarma = target:FindFirstChild("goodKarma")
                            if evilKarma and goodKarma and evilKarma:IsA("IntValue") and goodKarma:IsA("IntValue") and evilKarma.Value > goodKarma.Value then
                                local rootPart = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
                                if rootPart then
                                    firetouchinterest(rightHand, rootPart, 1)
                                    firetouchinterest(leftHand, rootPart, 1)
                                    firetouchinterest(rightHand, rootPart, 0)
                                    firetouchinterest(leftHand, rootPart, 0)
                                end
                            end
                        end
                    end
                end

                task.wait(0.01)
            end
        end)
    end
})

KillerTab:AddToggle({
    Title = "Auto Bad Karma",
    Content = "Automatically hits players with more good karma than evil karma",
    Default = false,
    Callback = function(value)
        autoBadKarma = value

        task.spawn(function()
            while autoBadKarma do
                local playerChar = LocalPlayer.Character
                local rightHand = playerChar and playerChar:FindFirstChild("RightHand")
                local leftHand = playerChar and playerChar:FindFirstChild("LeftHand")

                if playerChar and rightHand and leftHand then
                    for _, target in ipairs(Services.Players:GetPlayers()) do
                        if target ~= LocalPlayer then
                            local evilKarma = target:FindFirstChild("evilKarma")
                            local goodKarma = target:FindFirstChild("goodKarma")
                            if evilKarma and goodKarma and evilKarma:IsA("IntValue") and goodKarma:IsA("IntValue") and goodKarma.Value > evilKarma.Value then
                                local rootPart = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
                                if rootPart then
                                    firetouchinterest(rightHand, rootPart, 1)
                                    firetouchinterest(leftHand, rootPart, 1)
                                    firetouchinterest(rightHand, rootPart, 0)
                                    firetouchinterest(leftHand, rootPart, 0)
                                end
                            end
                        end
                    end
                end

                task.wait(0.01)
            end
        end)
    end
})

-- =====================
-- KILLER PLAYER
-- =====================

KillerTab:AddSeperator({Title = "Killer Player"})

KillerTab:AddDropdown({
    Title = "Select Target",
    Content = "Select players to kill",
    Multi = true,
    Options = getDisplayNames(),
    Default = {},
    Callback = function(selected)
        targetPlayerNames = {}
        for _, displayName in pairs(selected) do
            for _, player in ipairs(Services.Players:GetPlayers()) do
                if player.DisplayName == displayName then
                    table.insert(targetPlayerNames, player.Name)
                end
            end
        end
    end
})

KillerTab:AddButton({
    Title = "Refresh Target",
    Content = "Update the target player list",
    Icon = "rbxassetid://10734898355",
    Callback = function()
        local options = getDisplayNames()
        if targetDropdown.SetOptions then
            targetDropdown:SetOptions(options)
        elseif targetDropdown.Refresh then
            targetDropdown:Refresh(options)
        elseif targetDropdown.Update then
            targetDropdown:Update(options)
        elseif targetDropdown.Clear then
            targetDropdown:Clear()
            for _, option in ipairs(options) do
                targetDropdown:Add(option)
            end
        end
    end
})

KillerTab:AddToggle({
    Title = "Start Kill Target",
    Content = "Automatically kills the selected target players",
    Default = false,
    Callback = function(value)
        killTarget = value

        task.spawn(function()
            while killTarget do
                local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

                local punch = LocalPlayer.Backpack:FindFirstChild("Punch")
                if punch and not character:FindFirstChild("Punch") then
                    punch.Parent = character
                end

                local rightHand = character:FindFirstChild("RightHand")
                local leftHand = character:FindFirstChild("LeftHand")

                if rightHand and leftHand then
                    for _, name in ipairs(targetPlayerNames) do
                        local target = Services.Players:FindFirstChild(name)
                        if target and target ~= LocalPlayer and target.Character then
                            local rootPart = target.Character:FindFirstChild("HumanoidRootPart")
                            local humanoid = target.Character:FindFirstChild("Humanoid")
                            if rootPart and humanoid and humanoid.Health > 0 then
                                pcall(function()
                                    firetouchinterest(rightHand, rootPart, 1)
                                    firetouchinterest(leftHand, rootPart, 1)
                                    firetouchinterest(rightHand, rootPart, 0)
                                    firetouchinterest(leftHand, rootPart, 0)
                                end)
                            end
                        end
                    end
                end

                task.wait(0.05)
            end
        end)
    end
})

KillerTab:AddDropdown({
    Title = "Select View Target",
    Content = "Select a player to spectate",
    Multi = false,
    Options = getDisplayNames(),
    Default = {},
    Callback = function(selected)
        local displayName = selected[1]
        if not displayName then return end
        for _, player in ipairs(Services.Players:GetPlayers()) do
            if player.DisplayName == displayName then
                targetPlayerName = player.Name
                break
            end
        end
    end
})

KillerTab:AddButton({
    Title = "Refresh Spy",
    Content = "Update the spy player list",
    Icon = "rbxassetid://10734898355",
    Callback = function()
        local options = getDisplayNames()
        if spyDropdown.SetOptions then
            spyDropdown:SetOptions(options)
        elseif spyDropdown.Refresh then
            spyDropdown:Refresh(options)
        elseif spyDropdown.Update then
            spyDropdown:Update(options)
        elseif spyDropdown.Clear then
            spyDropdown:Clear()
            for _, option in ipairs(options) do
                spyDropdown:Add(option)
            end
        end
    end
})

KillerTab:AddToggle({
    Title = "View Player",
    Content = "Spectate the selected player",
    Default = false,
    Callback = function(value)
        spying = value

        if not value then
            local cam = Services.Workspace.CurrentCamera
            local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
            cam.CameraSubject = humanoid or LocalPlayer
            return
        end

        task.spawn(function()
            while spying do
                local target = Services.Players:FindFirstChild(targetPlayerName)
                if target and target ~= LocalPlayer then
                    local humanoid = target.Character and target.Character:FindFirstChild("Humanoid")
                    if humanoid then
                        Services.Workspace.CurrentCamera.CameraSubject = humanoid
                    end
                end
                task.wait(0.1)
            end
        end)
    end
})

-- =====================
-- SETTINGS
-- =====================

KillerTab:AddSeperator({Title = "Settings"})

local function setupAnimationBlocking()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("Humanoid") then return end

    local humanoid = char:FindFirstChild("Humanoid")

    local blockedAnimations = {
        ["rbxassetid://3638729053"] = true,
        ["rbxassetid://3638767427"] = true,
    }

    for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
        if track.Animation then
            local animId = track.Animation.AnimationId
            local animName = track.Name:lower()
            if blockedAnimations[animId] or animName:match("punch") or animName:match("attack") or animName:match("right") then
                track:Stop()
            end
        end
    end

    if not _G.AnimBlockConnection then
        _G.AnimBlockConnection = humanoid.AnimationPlayed:Connect(function(track)
            if track.Animation then
                local animId = track.Animation.AnimationId
                local animName = track.Name:lower()
                if blockedAnimations[animId] or animName:match("punch") or animName:match("attack") or animName:match("right") then
                    track:Stop()
                end
            end
        end)
    end
end

local function overrideToolActivation()
    local blockedAnimations = {
        ["rbxassetid://3638729053"] = true,
        ["rbxassetid://3638767427"] = true,
    }

    local function processTool(tool)
        if tool and (tool.Name == "Punch" or tool.Name:match("Attack") or tool.Name:match("Right")) then
            if not tool:GetAttribute("ActivatedOverride") then
                tool:SetAttribute("ActivatedOverride", true)

                local connection = tool.Activated:Connect(function()
                    task.wait(0.05)
                    local char = LocalPlayer.Character
                    if char and char:FindFirstChild("Humanoid") then
                        for _, track in pairs(char.Humanoid:GetPlayingAnimationTracks()) do
                            if track.Animation then
                                local animId = track.Animation.AnimationId
                                local animName = track.Name:lower()
                                if blockedAnimations[animId] or animName:match("punch") or animName:match("attack") or animName:match("right") then
                                    track:Stop()
                                end
                            end
                        end
                    end
                end)

                if not _G.ToolConnections then _G.ToolConnections = {} end
                _G.ToolConnections[tool] = connection
            end
        end
    end

    for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
        processTool(tool)
    end

    local char = LocalPlayer.Character
    if char then
        for _, tool in pairs(char:GetChildren()) do
            if tool:IsA("Tool") then processTool(tool) end
        end
    end

    if not _G.BackpackAddedConnection then
        _G.BackpackAddedConnection = LocalPlayer.Backpack.ChildAdded:Connect(function(child)
            if child:IsA("Tool") then task.wait(0.1) processTool(child) end
        end)
    end

    if not _G.CharacterToolAddedConnection and char then
        _G.CharacterToolAddedConnection = char.ChildAdded:Connect(function(child)
            if child:IsA("Tool") then task.wait(0.1) processTool(child) end
        end)
    end

    if not _G.AnimMonitorConnection then
        _G.AnimMonitorConnection = Services.RunService.Heartbeat:Connect(function()
            if tick() % 0.5 < 0.01 then
                local c = LocalPlayer.Character
                if c and c:FindFirstChild("Humanoid") then
                    for _, track in pairs(c.Humanoid:GetPlayingAnimationTracks()) do
                        if track.Animation then
                            local animId = track.Animation.AnimationId
                            local animName = track.Name:lower()
                            if blockedAnimations[animId] or animName:match("punch") or animName:match("attack") or animName:match("right") then
                                track:Stop()
                            end
                        end
                    end
                end
            end
        end)
    end

    if not _G.CharacterAddedConnection then
        _G.CharacterAddedConnection = LocalPlayer.CharacterAdded:Connect(function(newChar)
            task.wait(1)
            setupAnimationBlocking()
            overrideToolActivation()

            if _G.CharacterToolAddedConnection then
                _G.CharacterToolAddedConnection:Disconnect()
            end

            _G.CharacterToolAddedConnection = newChar.ChildAdded:Connect(function(child)
                if child:IsA("Tool") then task.wait(0.1) processTool(child) end
            end)
        end)
    end
end

local function RecoveryPunch()
    if _G.AnimBlockConnection then _G.AnimBlockConnection:Disconnect() _G.AnimBlockConnection = nil end
    if _G.AnimMonitorConnection then _G.AnimMonitorConnection:Disconnect() _G.AnimMonitorConnection = nil end
    if _G.ToolConnections then
        for _, conn in pairs(_G.ToolConnections) do if conn then conn:Disconnect() end end
        _G.ToolConnections = nil
    end
    if _G.BackpackAddedConnection then _G.BackpackAddedConnection:Disconnect() _G.BackpackAddedConnection = nil end
    if _G.CharacterToolAddedConnection then _G.CharacterToolAddedConnection:Disconnect() _G.CharacterToolAddedConnection = nil end
    if _G.CharacterAddedConnection then _G.CharacterAddedConnection:Disconnect() _G.CharacterAddedConnection = nil end
end

KillerTab:AddButton({
    Title = "Remove Punch Anim",
    Content = "Blocks punch animations from playing",
    Icon = "rbxassetid://10734898355",
    Callback = function()
        setupAnimationBlocking()
        overrideToolActivation()
    end
})

KillerTab:AddButton({
    Title = "Recover Punch Anim",
    Content = "Restores punch animations back to normal",
    Icon = "rbxassetid://10734898355",
    Callback = function()
        RecoveryPunch()
    end
})

KillerTab:AddToggle({
    Title = "Auto Punch",
    Content = "Automatically punches using the punch tool",
    Default = false,
    Callback = function(value)
        _G.fastHitActive = value

        if value then
            local function startAutoPunch()
                task.spawn(function()
                    while _G.fastHitActive do
                        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                        local punch = LocalPlayer.Backpack:FindFirstChild("Punch")
                        if punch then
                            punch.Parent = character
                            if punch:FindFirstChild("attackTime") then
                                punch.attackTime.Value = 0
                            end
                        end
                        task.wait(0.1)
                    end
                end)

                task.spawn(function()
                    while _G.fastHitActive do
                        local character = LocalPlayer.Character
                        local punch = character and character:FindFirstChild("Punch")
                        if punch then
                            punch:Activate()
                        end
                        task.wait(0.1)
                    end
                end)
            end

            startAutoPunch()
            LocalPlayer.CharacterAdded:Connect(function()
                if _G.fastHitActive then
                    task.wait(1)
                    startAutoPunch()
                end
            end)
        else
            local punch = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Punch")
            if punch then
                punch.Parent = LocalPlayer.Backpack
            end
        end
    end
})

KillerTab:AddToggle({
    Title = "Fast Punch",
    Content = "Punches as fast as possible with no delay",
    Default = false,
    Callback = function(value)
        _G.autoPunchActive = value

        if value then
            local function startFastPunch()
                task.spawn(function()
                    while _G.autoPunchActive do
                        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                        local punch = LocalPlayer.Backpack:FindFirstChild("Punch")
                        if punch then
                            punch.Parent = character
                            if punch:FindFirstChild("attackTime") then
                                punch.attackTime.Value = 0
                            end
                        end
                        task.wait()
                    end
                end)

                task.spawn(function()
                    while _G.autoPunchActive do
                        local character = LocalPlayer.Character
                        local punch = character and character:FindFirstChild("Punch")
                        if punch then
                            punch:Activate()
                        end
                        task.wait()
                    end
                end)
            end

            startFastPunch()
            LocalPlayer.CharacterAdded:Connect(function()
                if _G.autoPunchActive then
                    task.wait(1)
                    startFastPunch()
                end
            end)
        else
            local punch = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Punch")
            if punch then
                punch.Parent = LocalPlayer.Backpack
            end
        end
    end
})

local TeleportTab = Window:CreateTab({Name = "Teleport", Icon = "rbxassetid://10734886004"})

local function teleportTo(position)
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = position
end

TeleportTab:AddSeperator({
    Title = "Main Island"
})

TeleportTab:AddButton({
    Title = "Spawn",
    Description = "Teleport to spawn area",
    Icon = "rbxassetid://10734898355",
    Callback = function()
        teleportTo(CFrame.new(2, 8, 115))
    end
})

TeleportTab:AddLine()

TeleportTab:AddSeperator({
    Title = "Islands"
})

TeleportTab:AddButton({
    Title = "Tiny Island",
    Description = "Teleport to tiny island",
    Icon = "rbxassetid://10734898355",
    Callback = function()
        teleportTo(CFrame.new(-34, 7, 1903))
    end
})

TeleportTab:AddButton({
    Title = "Frozen Island",
    Description = "Teleport to frozen island",
    Icon = "rbxassetid://10734898355",
    Callback = function()
        teleportTo(CFrame.new(-2600.00244, 3.67686558, -403.884369, 0.0873617008, 1.0482899e-09, 0.99617666, 3.07204253e-08, 1, -3.7464023e-09, -0.99617666, 3.09302628e-08, 0.0873617008))
    end
})

TeleportTab:AddButton({
    Title = "Mythical Island",
    Description = "Teleport to mythical island",
    Icon = "rbxassetid://10734898355",
    Callback = function()
        teleportTo(CFrame.new(2255, 7, 1071))
    end
})

TeleportTab:AddButton({
    Title = "Hell Island",
    Description = "Teleport to hell island",
    Icon = "rbxassetid://10734898355",
    Callback = function()
        teleportTo(CFrame.new(-6768, 7, -1287))
    end
})

TeleportTab:AddButton({
    Title = "Legend Island",
    Description = "Teleport to legend island",
    Icon = "rbxassetid://10734898355",
    Callback = function()
        teleportTo(CFrame.new(4604, 991, -3887))
    end
})

TeleportTab:AddButton({
    Title = "Muscle King Island",
    Description = "Teleport to muscle king island",
    Icon = "rbxassetid://10734898355",
    Callback = function()
        teleportTo(CFrame.new(-8646, 17, -5738))
    end
})

TeleportTab:AddButton({
    Title = "Jungle Island",
    Description = "Teleport to jungle island",
    Icon = "rbxassetid://10734898355",
    Callback = function()
        teleportTo(CFrame.new(-8659, 6, 2384))
    end
})

TeleportTab:AddLine()

TeleportTab:AddSeperator({
    Title = "Special Areas"
})

TeleportTab:AddButton({
    Title = "Secret Area",
    Description = "Teleport to secret area",
    Icon = "rbxassetid://10734898355",
    Callback = function()
        teleportTo(CFrame.new(1947, 2, 6191))
    end
})

TeleportTab:AddLine()

TeleportTab:AddSeperator({
    Title = "Brawl Arenas"
})

TeleportTab:AddButton({
    Title = "Brawl Regular",
    Description = "Teleport to regular brawl arena",
    Icon = "rbxassetid://10734898355",
    Callback = function()
        teleportTo(CFrame.new(-1849, 20, -6335))
    end
})

TeleportTab:AddButton({
    Title = "Brawl Desert",
    Description = "Teleport to desert brawl arena",
    Icon = "rbxassetid://10734898355",
    Callback = function()
        teleportTo(CFrame.new(960, 17, -7398))
    end
})

TeleportTab:AddButton({
    Title = "Brawl Lava",
    Description = "Teleport to lava brawl arena",
    Icon = "rbxassetid://10734898355",
    Callback = function()
        teleportTo(CFrame.new(4471, 119, -8836))
    end
})

Library:SetNotification({
    Title = "Welcome",
    Description = "Loaded",
    Content = "Mystery Hub On Top",
    Time = 0.5,
    Delay = 3
})
