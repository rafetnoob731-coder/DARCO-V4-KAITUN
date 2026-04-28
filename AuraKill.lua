-- [[ DARCO V4 - AuraKill.lua ]]
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local AuraKill = {}

function AuraKill:EquipBestMelee()
    local BackPack = LP.Backpack
    local Char = LP.Character
    local Priorities = getgenv().DarcoConfig.Priority.Melee
    
    for _, toolName in ipairs(Priorities) do
        local tool = BackPack:FindFirstChild(toolName) or Char:FindFirstChild(toolName)
        if tool then
            LP.Humanoid:EquipTool(tool)
            return tool
        end
    end
end

function AuraKill:Attack(Target)
    if not Target or not Target:FindFirstChild("Humanoid") or Target.Humanoid.Health <= 0 then return end
    
    local Tool = self:EquipBestMelee()
    if Tool then
        -- Fast Attack M1 Logic (2026 Optimized Remotes)
        ReplicatedStorage.Remotes.Validator:FireServer(math.floor(tick())) -- Anti-cheat bypass logic
        ReplicatedStorage.Modules.Net:FireServer("Attack", {
            ["Target"] = Target,
            ["Type"] = "Melee"
        })
        
        -- Auto Skill Z usage
        task.spawn(function()
            game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.Z, false, game)
        end)
    end
end

print("[DARCO V4] AuraKill Module Loaded.")
return AuraKill
