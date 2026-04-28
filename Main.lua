-- [[ DARCO V4 - MAIN LOADER ]]
-- Dev by Darkness | True Authority | Darkaura
-- Target: Blox Fruits 2026 (Draco V4 Update)

repeat task.wait() until game:IsLoaded()

-- [[ REPOSITORY CONFIGURATION ]]
local GithubUser = "rafetnoob731-coder"
local RepoName = "DARCO-V4-KAITUN"
local Branch = "main"

local function GetRaw(File)
    return "https://raw.githubusercontent.com/" .. GithubUser .. "/" .. RepoName .. "/" .. Branch .. "/" .. File
end

-- [[ LOAD CORE MODULES ]]
print("[DARCO V4] Initializing System...")
local Config = loadstring(game:HttpGet(GetRaw("Config.lua")))()
local Tween = loadstring(game:HttpGet(GetRaw("Tween.lua")))()
local Aura = loadstring(game:HttpGet(GetRaw("AuraKill.lua")))()
local GUI = loadstring(game:HttpGet(GetRaw("GUI.lua")))()

-- [[ LOCAL HELPERS ]]
local LP = game.Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")

local function CheckTarget(Name)
    for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
        if v.Name == Name and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            return v
        end
    end
    return nil
end

-- [[ DRIVING LOGIC LOOP ]]
task.spawn(function()
    while task.wait(0.2) do
        if not getgenv().DarcoConfig.Settings.AutoKaitun then 
            getgenv().DarcoConfig.Status = "System Paused"
            continue 
        end

        pcall(function()
            -- 1. PRIORITY: FLAMES OF HEARTH (Ember Selection After Trial)
            if game.Workspace:FindFirstChild("FlamesOfHearth") then
                getgenv().DarcoConfig.Status = "Selecting Best Gear (Priority: Thorn Mail)"
                Tween:To(Config.Locations.FlamesOfHearth)
                
                -- Auto Select logic based on Priority List
                for _, emberName in ipairs(Config.Priority.Embers) do
                    local remote = RS:FindFirstChild("Remotes") and RS.Remotes:FindFirstChild("EmberRemote")
                    if remote then
                        remote:InvokeServer("SelectEmber", emberName)
                        task.wait(1)
                    end
                end
                
                if Config.Settings.RepeatTrial then
                    RS.Remotes.CommF_:InvokeServer("ResetTrialState") -- 2026 mechanic
                end

            -- 2. PRIORITY: DRACO TRIAL (Trial of Flames)
            elseif game.Workspace:FindFirstChild("DracoTrialArena") then
                getgenv().DarcoConfig.Status = "Completing Trial of Flames"
                local Target = CheckTarget("Trial Guardian") or CheckTarget("Inferno Soul")
                
                if Target then
                    if (LP.Character.HumanoidRootPart.Position - Target.HumanoidRootPart.Position).Magnitude > 15 then
                        LP.Character.HumanoidRootPart.CFrame = Target.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                    end
                    Aura:FastAttack(Target)
                else
                    Tween:To(Config.Locations.TrialEntrance)
                end

            -- 3. PRIORITY: VOLCANO EVENT (Lava Golems & Relic)
            elseif game.Workspace:FindFirstChild("VolcanoEvent") then
                getgenv().DarcoConfig.Status = "Protecting Relic: Killing Lava Golems"
                local Golem = CheckTarget("Lava Golem")
                
                if Golem then
                    -- Magnet logic is already running in AuraKill.lua
                    if (LP.Character.HumanoidRootPart.Position - Golem.HumanoidRootPart.Position).Magnitude > 20 then
                        Tween:To(Golem.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0))
                    end
                    Aura:FastAttack(Golem)
                else
                    Tween:To(Config.Locations.VolcanoArena)
                end

            -- 4. DEFAULT: PREHISTORIC ISLAND FARMING
            else
                getgenv().DarcoConfig.Status = "Tweening to Prehistoric Island"
                if (LP.Character.HumanoidRootPart.Position - Config.Locations.PrehistoricIsland.Position).Magnitude > 500 then
                    Tween:To(Config.Locations.PrehistoricIsland)
                else
                    getgenv().DarcoConfig.Status = "Awaiting Volcano Event / Trial"
                    -- Auto farm mobs in area while waiting
                    local Mob = CheckTarget("Prehistoric Beast") or CheckTarget("Cave Guard")
                    if Mob then
                        Aura:FastAttack(Mob)
                    end
                end
            end
        end)
    end
end)

-- [[ ANTI-AFK & SECURITY ]]
task.spawn(function()
    local VirtualUser = game:GetService("VirtualUser")
    LP.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new(0,0))
    end)
end)

print("---------------------------------------")
print("DARCO V4 KAITUN FULLY OPERATIONAL")
print("STATUS: " .. getgenv().DarcoConfig.Status)
print("---------------------------------------")
