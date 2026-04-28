-- [[ DARCO V4 - Config.lua ]]
getgenv().DarcoConfig = {
    Settings = {
        AutoKaitun = true,
        AutoTrial = true,
        RepeatTrial = true,
        FastAttack = true,
        MagnetDistance = 300,
        TweenSpeed = 250
    },
    Priority = {
        Melee = {"Dragon Talon", "Cursed Dual Katana", "Hallow Scythe", "Yama", "Tushita"},
        Embers = {"Thorn Mail", "Cosmic Field", "Damage Reflect", "Red Ember", "Blue Ember"}
    },
    Locations = {
        PrehistoricIsland = CFrame.new(-12500, 100, 8500),
        VolcanoArena = CFrame.new(-13200, 500, 9000),
        FlamesOfHearth = CFrame.new(-13500, 15, 9200),
        TrialEntrance = CFrame.new(-12800, 200, 8800)
    },
    Status = "Initializing System...",
    ExecutionDate = "2026"
}

print("[DARCO V4] Config Loaded.")
return getgenv().DarcoConfig
