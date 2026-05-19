local imgui = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/HacksCreator102/ImGUI-/refs/heads/main/source.lua"
))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local lp = Players.LocalPlayer

--// SETTINGS
local running = false
local currentPosition = 0
local teleportDelay = 1.2

local autoPlatform = true
local platformTransparency = 0
local platformMaterial = Enum.Material.Neon

local walkSpeedValue = 16
local jumpPowerValue = 50

local spawnedPlatforms = {}

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
    CFrame.new(-55.7065125, -358.739624, 9492.35645)
}

--// HELPERS
local function getCharacter()
    return lp.Character or lp.CharacterAdded:Wait()
end

local function getHRP()
    return getCharacter():WaitForChild("HumanoidRootPart")
end

local function getHumanoid()
    return getCharacter():WaitForChild("Humanoid")
end

--// PLATFORM
local function createPlatform(cf)

    if not autoPlatform then
        return
    end

    local platform = Instance.new("Part")

    platform.Name = "BABFT_PLATFORM"
    platform.Anchored = true
    platform.CanCollide = true
    platform.Size = Vector3.new(30,1,30)

    --// -5 below player
    platform.CFrame = cf * CFrame.new(0,-5,0)

    platform.Material = platformMaterial
    platform.Transparency = platformTransparency

    platform.Color = Color3.fromRGB(0,255,255)

    platform.Parent = workspace

    table.insert(spawnedPlatforms, platform)
end

local function clearPlatforms()

    for _,v in pairs(spawnedPlatforms) do
        pcall(function()
            v:Destroy()
        end)
    end

    table.clear(spawnedPlatforms)

    imgui:notify(
        "Platforms",
        "Cleared all platforms",
        "rbxassetid://6031071053"
    )
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

                        createPlatform(cf)

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
    }
})

--// AUTOFARM TAB
local autofarm = window:createTab("Autofarm")

local statusLabel = autofarm:AddLabel("Status : Stopped")
local positionLabel = autofarm:AddLabel("Position : 0")

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

autofarm:AddToggle({
    Name = "Auto Platform",
    Default = true,

    Callback = function(v)

        autoPlatform = v

        imgui:notify(
            "Platform",
            "Auto Platform : "..tostring(v),
            "rbxassetid://6031280882"
        )
    end
})

autofarm:AddSlider({
    Name = "Teleport Delay",
    Min = 1,
    Max = 10,
    Default = 1,

    Callback = function(v)

        teleportDelay = v
    end
})

autofarm:AddSlider({
    Name = "Platform Transparency",
    Min = 0,
    Max = 10,
    Default = 0,

    Callback = function(v)

        platformTransparency = v / 10
    end
})

autofarm:AddButton({
    Name = "Clear Platforms",

    Callback = function()
        clearPlatforms()
    end
})

autofarm:AddButton({
    Name = "Teleport To End",

    Callback = function()

        local hrp = getHRP()

        if hrp then
            hrp.CFrame = positions[#positions]
        end
    end
})

--// PLAYER TAB
local player = window:createTab("Player")

player:AddSlider({
    Name = "WalkSpeed",
    Min = 16,
    Max = 200,
    Default = 16,

    Callback = function(v)

        walkSpeedValue = v

        local hum = getHumanoid()

        if hum then
            hum.WalkSpeed = v
        end
    end
})

player:AddSlider({
    Name = "JumpPower",
    Min = 50,
    Max = 300,
    Default = 50,

    Callback = function(v)

        jumpPowerValue = v

        local hum = getHumanoid()

        if hum then
            hum.JumpPower = v
        end
    end
})

player:AddButton({
    Name = "Infinite Jump",

    Callback = function()

        imgui:notify(
            "Infinite Jump",
            "Enabled",
            "rbxassetid://6031075938"
        )

        local UIS = game:GetService("UserInputService")

        UIS.JumpRequest:Connect(function()

            local hum = getHumanoid()

            if hum then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end
})

player:AddButton({
    Name = "Fly",

    Callback = function()

        local hrp = getHRP()

        local bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(999999,999999,999999)
        bv.Velocity = Vector3.zero
        bv.Parent = hrp

        RunService.RenderStepped:Connect(function()

            bv.Velocity =
                workspace.CurrentCamera.CFrame.LookVector * 80
        end)

        imgui:notify(
            "Fly",
            "Fly Enabled",
            "rbxassetid://6031075938"
        )
    end
})

--// VISUAL TAB
local visual = window:createTab("Visual")

visual:AddButton({
    Name = "Neon Platforms",

    Callback = function()

        platformMaterial = Enum.Material.Neon

        imgui:notify(
            "Visual",
            "Neon Material Enabled",
            "rbxassetid://6031280882"
        )
    end
})

visual:AddButton({
    Name = "ForceField Platforms",

    Callback = function()

        platformMaterial = Enum.Material.ForceField

        imgui:notify(
            "Visual",
            "ForceField Material Enabled",
            "rbxassetid://6031280882"
        )
    end
})

visual:AddButton({
    Name = "Glass Platforms",

    Callback = function()

        platformMaterial = Enum.Material.Glass

        imgui:notify(
            "Visual",
            "Glass Material Enabled",
            "rbxassetid://6031280882"
        )
    end
})

--// MISC TAB
local misc = window:createTab("Misc")

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

misc:AddButton({
    Name = "Rejoin",

    Callback = function()

        game:GetService("TeleportService"):Teleport(
            game.PlaceId,
            lp
        )
    end
})

--// UPDATE LOOP
task.spawn(function()

    while task.wait(0.2) do

        statusLabel:SetText(
            "Status : "..(running and "Running" or "Stopped")
        )

        positionLabel:SetText(
            "Position : "..tostring(currentPosition)
        )
    end
end)