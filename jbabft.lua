local imgui = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/HacksCreator102/ImGUI-/refs/heads/main/source.lua"
))()

local Players = game:GetService("Players")
local lp = Players.LocalPlayer

--// SETTINGS
local running = false
local currentPosition = 0
local teleportDelay = 1.2

local positions = {
    CFrame.new(-51.5656433, 65.0000458, 1369.09009),
    CFrame.new(-51.5656433, 65.0000458, 2139.09009),
    CFrame.new(-51.5656433, 65.0000458, 2909.09009),
    CFrame.new(-51.5656433, 65.0000458, 3679.09009),
    CFrame.new(-51.5656433, 65.0000458, 4449.08984),
    CFrame.new(-53.5669785, 72.6005325, 5218.14209),
    CFrame.new(-51.5656433, 65.0000458, 5989.08984),
    CFrame.new(-51.5656433, 65.0000458, 6759.08984),
    CFrame.new(-51.5656433, 65.0000458, 7529.08984),
    CFrame.new(-51.5656433, 65.0000458, 8299.08984),
    CFrame.new(-55.7065125, -358.739624, 9492.35645, 0, 0, -1, 0, 1, 0, 1, 0, 0)
}

--// HELPERS
local function getCharacter()
    return lp.Character or lp.CharacterAdded:Wait()
end

local function getHRP()
    return getCharacter():WaitForChild("HumanoidRootPart")
end

--// AUTOFARM
local function stopFarm()

    running = false

    imgui:notify(
        "BABFT",
        "Autofarm Disabled",
        "rbxassetid://6031091004"
    )
end

local function startFarm()

    if running then
        return
    end

    running = true

    imgui:notify(
        "BABFT",
        "Autofarm Enabled",
        "rbxassetid://6031075938"
    )

    task.spawn(function()

        while running do

            for i, cf in ipairs(positions) do

                if not running then
                    break
                end

                pcall(function()

                    local hrp = getHRP()

                    if hrp then
                        hrp.CFrame = cf
                        currentPosition = i
                    end
                end)

                task.wait(teleportDelay)
            end

            task.wait(25)
        end
    end)
end

--// WINDOW
local window = imgui:createWindow({

    Main = {
        Name = "VCL Hub",
        Creator = "Denis"
    },

    Discord = {
        Enabled = false,
        Link = ""
    }
})

--// AUTOFARM TAB
local autofarm = window:createTab("Autofarm")

local statusLabel = autofarm:AddLabel("Status : Stopped")
local posLabel = autofarm:AddLabel("Position : 0")

autofarm:AddToggle({
    Name = "Enable Autofarm",
    Default = false,

    Callback = function(v)

        if v then
            startFarm()
        else
            stopFarm()
        end
    end
})

autofarm:AddSlider({
    Name = "Teleport Delay",
    Min = 1,
    Max = 10,
    Default = 1,

    Callback = function(v)

        teleportDelay = v

        imgui:notify(
            "Delay",
            "Delay set to "..v,
            "rbxassetid://6031280882"
        )
    end
})

autofarm:AddButton({
    Name = "Teleport To End",

    Callback = function()

        local hrp = getHRP()

        if hrp then

            hrp.CFrame = positions[#positions]

            imgui:notify(
                "Teleport",
                "Teleported to end",
                "rbxassetid://6031071053"
            )
        end
    end
})

autofarm:AddButton({
    Name = "Stop Autofarm",

    Callback = function()
        stopFarm()
    end
})

--// PLAYER TAB
local playerTab = window:createTab("Player")

playerTab:AddTextbox({
    Name = "WalkSpeed",
    Placeholder = "Enter speed...",

    Callback = function(text)

        local speed = tonumber(text)

        if speed then

            local hum = getCharacter():FindFirstChildOfClass("Humanoid")

            if hum then
                hum.WalkSpeed = speed
            end
        end
    end
})

playerTab:AddTextbox({
    Name = "JumpPower",
    Placeholder = "Enter jump power...",

    Callback = function(text)

        local jp = tonumber(text)

        if jp then

            local hum = getCharacter():FindFirstChildOfClass("Humanoid")

            if hum then
                hum.JumpPower = jp
            end
        end
    end
})

playerTab:AddButton({
    Name = "Reset Character",

    Callback = function()

        local char = getCharacter()

        if char then
            char:BreakJoints()
        end
    end
})

--// MISC TAB
local misc = window:createTab("Misc")

misc:AddTextbox({
    Name = "Notification",
    Placeholder = "Type text...",

    Callback = function(text)

        imgui:notify(
            "Custom Notification",
            text,
            "rbxassetid://6031280882"
        )
    end
})

misc:AddButton({
    Name = "Copy Discord",

    Callback = function()

        setclipboard("discord.gg/example")

        imgui:notify(
            "Discord",
            "Copied invite",
            "rbxassetid://6031075938"
        )
    end
})

misc:AddButton({
    Name = "Destroy UI",

    Callback = function()

        for _,v in pairs(game.CoreGui:GetChildren()) do

            if v.Name == "VCL Hub" then
                v:Destroy()
            end
        end
    end
})

--// UPDATE LOOP
task.spawn(function()

    while task.wait(0.2) do

        statusLabel:SetText(
            "Status : "..(running and "Running" or "Stopped")
        )

        posLabel:SetText(
            "Position : "..tostring(currentPosition)
        )
    end
end)