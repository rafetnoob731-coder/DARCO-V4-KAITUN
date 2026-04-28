-- [[ DARCO V4 - GUI.lua ]]
local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()

local Window = Library:CreateWindow({
    Title = 'DARCO V4 | True Authority Kaitun (2026)',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local Tabs = {
    Main = Window:AddTab('Main Kaitun'),
    Trial = Window:AddTab('Draco Trial'),
    Settings = Window:AddTab('Settings')
}

local GeneralBox = Tabs.Main:AddLeftGroupbox('Automation')
local StatusLabel = Tabs.Main:AddRightGroupbox('Live Status')

-- Live Status Label
local Label = StatusLabel:AddLabel("Current Status: " .. getgenv().DarcoConfig.Status)

task.spawn(function()
    while task.wait(0.5) do
        Label:SetText("Status: " .. getgenv().DarcoConfig.Status)
    end
end)

GeneralBox:AddToggle('AutoKaitun', {
    Text = 'Auto Draco Kaitun',
    Default = false,
    Callback = function(Value)
        getgenv().DarcoConfig.Settings.AutoKaitun = Value
    end
})

GeneralBox:AddToggle('AutoTrial', {
    Text = 'Auto Trial of Flames',
    Default = false,
    Callback = function(Value)
        getgenv().DarcoConfig.Settings.AutoTrial = Value
    end
})

Library:Notify("DARCO V4 Loaded Successfully!")
print("[DARCO V4] GUI Engine Ready.")
