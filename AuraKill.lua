-- [[ DARCO V4 - AuraKill.lua ]]
-- Dev by Darkness | True Authority | Darkaura
-- Optimized for 2026 Blox Fruits Mechanics

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local VIM = game:GetService("VirtualInputManager")

local LP = Players.LocalPlayer
local AuraKill = {
    AttackDelay = 0.05, -- 2026 high-speed threshold
    Active = true,
    CurrentTarget = nil
}

-- [[ MELEE PRIORITY SYSTEM ]]
-- Automatically detects and equips the strongest available melee
local MeleePriority = {
    "Dragon Talon",
    "Cursed Dual Katana",
    "Hallow Scythe",
    "Yama",
    "Tushita"
}

function AuraKill:EquipBestMelee()
    if not LP.Character then return end
    local Humanoid = LP.Character:FindFirstChildOfClass("Humanoid")
    if not Humanoid then return end

    for _, meleeName in ipairs(MeleePriority) do
        local tool = LP.Backpack:FindFirstChild(meleeName) or LP.Character:FindFirstChild(meleeName)
        if tool then
            if tool.Parent ~= LP.Character then
                Humanoid:EquipTool(tool)
            end
            return tool
        end
    end
end

-- [[ FAST ATTACK ENGINE ]]
-- Uses 2026 Remote Validation to maximize damage without kicks
function AuraKill:FastAttack(Target)
    if not Target or not Target:FindFirstChild("Humanoid") or Target.Humanoid.Health <= 0 then 
        self.CurrentTarget = nil
        return 
    end

    self.CurrentTarget = Target
    local Tool = self:EquipBestMelee()
    
    if Tool then
        -- High-frequency attack packet
        task.spawn(function()
            -- Attack Validator Bypass (2026 Standard)
            local args = {
                [1] = math.floor(tick() * 1000),
                [2] = "Melee",
                [3] = Target.HumanoidRootPart.Position
            }
            ReplicatedStorage.Remotes.Validator:FireServer(unpack(args))
            
            -- Main Attack Remote
            ReplicatedStorage.Modules.Net:FireServer("Attack", {
                ["Target"] = Target,
                ["Tool"] = Tool.Name,
                ["Type"] = "Melee"
            })
        end)

        -- Skill Z Auto-Rotation
        if getgenv().DarcoConfig.Settings.UseSkills then
            task.spawn(function()
                VIM:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
                task.wait(0.1)
                VIM:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
            end)
        end
    end
end

-- [[ MAGNET SYSTEM ]]
-- Pulls enemies together to maximize AoE efficiency
function AuraKill:StartMagnet()
    task.spawn(function()
        while task.wait(0.3) do
            if not getgenv().DarcoConfig.Settings.AutoKaitun then continue end
            
            local myPos = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") and LP.Character.HumanoidRootPart.Position
            if not myPos then continue end

            for _, enemy in pairs(game.Workspace.Enemies:GetChildren()) do
                if enemy:FindFirstChild("HumanoidRootPart") and (enemy.HumanoidRootPart.Position - myPos).Magnitude < getgenv().DarcoConfig.Settings.MagnetDistance then
                    enemy.HumanoidRootPart.CFrame = LP.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
                    enemy.HumanoidRootPart.CanCollide = false
                    enemy.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                end
            end
        end
    end)
end

-- Start the Magnet logic upon module load
AuraKill:StartMagnet()

print("[DARCO V4] AuraKill: True Authority Module Active.")
return AuraKill-- [[ DARCO V4 - AuraKill.lua ]]
-- Dev by Darkness | True Authority | Darkaura
-- Optimized for 2026 Blox Fruits Mechanics

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local VIM = game:GetService("VirtualInputManager")

local LP = Players.LocalPlayer
local AuraKill = {
    AttackDelay = 0.05, -- 2026 high-speed threshold
    Active = true,
    CurrentTarget = nil
}

-- [[ MELEE PRIORITY SYSTEM ]]
-- Automatically detects and equips the strongest available melee
local MeleePriority = {
    "Dragon Talon",
    "Cursed Dual Katana",
    "Hallow Scythe",
    "Yama",
    "Tushita"
}

function AuraKill:EquipBestMelee()
    if not LP.Character then return end
    local Humanoid = LP.Character:FindFirstChildOfClass("Humanoid")
    if not Humanoid then return end

    for _, meleeName in ipairs(MeleePriority) do
        local tool = LP.Backpack:FindFirstChild(meleeName) or LP.Character:FindFirstChild(meleeName)
        if tool then
            if tool.Parent ~= LP.Character then
                Humanoid:EquipTool(tool)
            end
            return tool
        end
    end
end

-- [[ FAST ATTACK ENGINE ]]
-- Uses 2026 Remote Validation to maximize damage without kicks
function AuraKill:FastAttack(Target)
    if not Target or not Target:FindFirstChild("Humanoid") or Target.Humanoid.Health <= 0 then 
        self.CurrentTarget = nil
        return 
    end

    self.CurrentTarget = Target
    local Tool = self:EquipBestMelee()
    
    if Tool then
        -- High-frequency attack packet
        task.spawn(function()
            -- Attack Validator Bypass (2026 Standard)
            local args = {
                [1] = math.floor(tick() * 1000),
                [2] = "Melee",
                [3] = Target.HumanoidRootPart.Position
            }
            ReplicatedStorage.Remotes.Validator:FireServer(unpack(args))
            
            -- Main Attack Remote
            ReplicatedStorage.Modules.Net:FireServer("Attack", {
                ["Target"] = Target,
                ["Tool"] = Tool.Name,
                ["Type"] = "Melee"
            })
        end)

        -- Skill Z Auto-Rotation
        if getgenv().DarcoConfig.Settings.UseSkills then
            task.spawn(function()
                VIM:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
                task.wait(0.1)
                VIM:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
            end)
        end
    end
end

-- [[ MAGNET SYSTEM ]]
-- Pulls enemies together to maximize AoE efficiency
function AuraKill:StartMagnet()
    task.spawn(function()
        while task.wait(0.3) do
            if not getgenv().DarcoConfig.Settings.AutoKaitun then continue end
            
            local myPos = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") and LP.Character.HumanoidRootPart.Position
            if not myPos then continue end

            for _, enemy in pairs(game.Workspace.Enemies:GetChildren()) do
                if enemy:FindFirstChild("HumanoidRootPart") and (enemy.HumanoidRootPart.Position - myPos).Magnitude < getgenv().DarcoConfig.Settings.MagnetDistance then
                    enemy.HumanoidRootPart.CFrame = LP.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
                    enemy.HumanoidRootPart.CanCollide = false
                    enemy.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                end
            end
        end
    end)
end

-- Start the Magnet logic upon module load
AuraKill:StartMagnet()

print("[DARCO V4] AuraKill: True Authority Module Active.")
return AuraKill
