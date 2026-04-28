-- [[ DARCO V4 - Tween.lua ]]
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer

local TweenModule = {}

function TweenModule:To(TargetCFrame)
    if not LP.Character or not LP.Character:FindFirstChild("HumanoidRootPart") then return end
    
    local Distance = (LP.Character.HumanoidRootPart.Position - TargetCFrame.Position).Magnitude
    local Speed = getgenv().DarcoConfig.Settings.TweenSpeed
    local Time = Distance / Speed
    
    -- Noclip to prevent getting stuck
    task.spawn(function()
        while task.wait() do
            if not _G.Tweening then break end
            for _, v in pairs(LP.Character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end)

    _G.Tweening = true
    local Tween = TweenService:Create(LP.Character.HumanoidRootPart, TweenInfo.new(Time, Enum.EasingStyle.Linear), {CFrame = TargetCFrame})
    Tween:Play()
    
    Tween.Completed:Wait()
    _G.Tweening = false
end

print("[DARCO V4] Tween Engine Loaded.")
return TweenModule
