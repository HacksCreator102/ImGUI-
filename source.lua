local imgui = {}
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

mouse.Icon = "rbxassetid://84128666510737"
--// NOTIFY
function imgui:notify(title, text, icon)

    local TweenService = game:GetService("TweenService")
    local Debris = game:GetService("Debris")

    title = title or "Notification"
    text = text or "Hello world!"
    icon = icon or "rbxassetid://6031091004"

    local gui = Instance.new("ScreenGui")
    gui.Name = "imgui_notify"
    gui.ResetOnSpawn = false
    gui.Parent = game:GetService("CoreGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 80)
    frame.Position = UDim2.new(1, 320, 1, -100)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 0
    frame.Parent = gui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = frame

    local image = Instance.new("ImageLabel")
    image.Size = UDim2.new(0, 40, 0, 40)
    image.Position = UDim2.new(0, 15, 0.5, -20)
    image.BackgroundTransparency = 1
    image.Image = icon
    image.Parent = frame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -70, 0, 25)
    titleLabel.Position = UDim2.new(0, 60, 0, 10)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 16
    titleLabel.TextColor3 = Color3.new(1,1,1)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = frame

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, -70, 0, 35)
    textLabel.Position = UDim2.new(0, 60, 0, 35)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.Font = Enum.Font.Gotham
    textLabel.TextSize = 14
    textLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    textLabel.TextWrapped = true
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.TextYAlignment = Enum.TextYAlignment.Top
    textLabel.Parent = frame

    TweenService:Create(
        frame,
        TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        {Position = UDim2.new(1, -320, 1, -100)}
    ):Play()

    task.wait(3)

    local tween = TweenService:Create(
        frame,
        TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
        {Position = UDim2.new(1, 320, 1, -100)}
    )

    tween:Play()

    tween.Completed:Connect(function()
        gui:Destroy()
    end)

    Debris:AddItem(gui, 5)
end

--// WINDOW
function imgui:createWindow(settings)

    settings = settings or {}

    settings.Main = settings.Main or {}
    settings.Discord = settings.Discord or {}

    settings.Main.Name = settings.Main.Name or "ImGUI"
    settings.Main.Creator = settings.Main.Creator or "ShadowDev"

    local window = {}

    -- GUI
    local gui = Instance.new("ScreenGui")
    gui.Name = settings.Main.Name
    gui.ResetOnSpawn = false
    gui.Parent = game:GetService("CoreGui")

    -- MAIN
    local mainframe = Instance.new("Frame")
    mainframe.Parent = gui
    mainframe.Size = UDim2.new(0, 500, 0, 300)
    mainframe.Position = UDim2.new(0.5, -250, 0.5, -150)
    mainframe.BackgroundColor3 = Color3.fromRGB(25,25,25)
    mainframe.BorderSizePixel = 0
    mainframe.Active = true
    mainframe.Draggable = true

    local corner = Instance.new("UICorner")
    corner.Parent = mainframe
    corner.CornerRadius = UDim.new(0,8)

    -- TOPBAR
    local topbar = Instance.new("Frame")
    topbar.Parent = mainframe
    topbar.Size = UDim2.new(1,0,0,35)
    topbar.BackgroundColor3 = Color3.fromRGB(20,20,20)
    topbar.BorderSizePixel = 0

    local topcorner = Instance.new("UICorner")
    topcorner.Parent = topbar
    topcorner.CornerRadius = UDim.new(0,8)

    -- TITLE
    local title = Instance.new("TextLabel")
    title.Parent = topbar
    title.BackgroundTransparency = 1
    title.Size = UDim2.new(1,-10,1,0)
    title.Position = UDim2.new(0,10,0,0)
    title.Font = Enum.Font.GothamBold
    title.Text = settings.Main.Name .. " | " .. settings.Main.Creator
    title.TextColor3 = Color3.new(1,1,1)
    title.TextSize = 15
    title.TextXAlignment = Enum.TextXAlignment.Left
--// CLOSE BUTTON
local closeButton = Instance.new("TextButton")
closeButton.Parent = topbar
closeButton.Size = UDim2.new(0, 28, 0, 28)
closeButton.Position = UDim2.new(1, -34, 0, 3)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
closeButton.BorderSizePixel = 0
closeButton.Text = "X"
closeButton.Font = Enum.Font.GothamBold
closeButton.TextColor3 = Color3.new(1,1,1)
closeButton.TextSize = 14

local closeCorner = Instance.new("UICorner")
closeCorner.Parent = closeButton
closeCorner.CornerRadius = UDim.new(1,0)

closeButton.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

--// MINIMIZE BUTTON
local minimized = false
local oldSize = mainframe.Size

local miniButton = Instance.new("TextButton")
miniButton.Parent = topbar
miniButton.Size = UDim2.new(0, 28, 0, 28)
miniButton.Position = UDim2.new(1, -68, 0, 3)
miniButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
miniButton.BorderSizePixel = 0
miniButton.Text = "-"
miniButton.Font = Enum.Font.GothamBold
miniButton.TextColor3 = Color3.new(1,1,1)
miniButton.TextSize = 18

local miniCorner = Instance.new("UICorner")
miniCorner.Parent = miniButton
miniCorner.CornerRadius = UDim.new(1,0)

miniButton.MouseButton1Click:Connect(function()

    minimized = not minimized

    if minimized then

        oldSize = mainframe.Size

        contentHolder.Visible = false
        tabsHolder.Visible = false

        mainframe.Size = UDim2.new(
            oldSize.X.Scale,
            oldSize.X.Offset,
            0,
            35
        )

        miniButton.Text = "+"

    else

        contentHolder.Visible = true
        tabsHolder.Visible = true

        mainframe.Size = oldSize

        miniButton.Text = "-"
    end
end)
    -- TABS HOLDER
    local tabsHolder = Instance.new("Frame")
    tabsHolder.Parent = mainframe
    tabsHolder.Position = UDim2.new(0,0,0,35)
    tabsHolder.Size = UDim2.new(0,120,1,-35)
    tabsHolder.BackgroundColor3 = Color3.fromRGB(18,18,18)
    tabsHolder.BorderSizePixel = 0

    local tabsLayout = Instance.new("UIListLayout")
    tabsLayout.Parent = tabsHolder
    tabsLayout.Padding = UDim.new(0,5)

    -- CONTENT HOLDER
    local contentHolder = Instance.new("Frame")
    contentHolder.Parent = mainframe
    contentHolder.Position = UDim2.new(0,120,0,35)
    contentHolder.Size = UDim2.new(1,-120,1,-35)
    contentHolder.BackgroundTransparency = 1

    --// CREATE TAB
    function window:createTab(tabName)

        local tab = {}

        -- BUTTON
        local button = Instance.new("TextButton")
        button.Parent = tabsHolder
        button.Size = UDim2.new(1,-10,0,35)
        button.Position = UDim2.new(0,5,0,0)
        button.BackgroundColor3 = Color3.fromRGB(30,30,30)
        button.BorderSizePixel = 0
        button.Text = tabName or "Tab"
        button.Font = Enum.Font.Gotham
        button.TextColor3 = Color3.new(1,1,1)
        button.TextSize = 14

        local buttonCorner = Instance.new("UICorner")
        buttonCorner.Parent = button
        buttonCorner.CornerRadius = UDim.new(0,6)

        -- PAGE
        local page = Instance.new("Frame")
        page.Parent = contentHolder
        page.Size = UDim2.new(1,0,1,0)
        page.BackgroundTransparency = 1
        page.Visible = false

        -- PAGE HOLDER FIX
        local pageHolder = Instance.new("ScrollingFrame")
        pageHolder.Parent = page
        pageHolder.Size = UDim2.new(1,0,1,0)
        pageHolder.CanvasSize = UDim2.new(0,0,0,0)
        pageHolder.BackgroundTransparency = 1
        pageHolder.BorderSizePixel = 0
        pageHolder.ScrollBarThickness = 4

        local padding = Instance.new("UIPadding")
        padding.Parent = pageHolder
        padding.PaddingTop = UDim.new(0,5)
        padding.PaddingLeft = UDim.new(0,5)
        padding.PaddingRight = UDim.new(0,5)

        local layout = Instance.new("UIListLayout")
        layout.Parent = pageHolder
        layout.Padding = UDim.new(0,6)

        layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()

            pageHolder.CanvasSize = UDim2.new(
                0,
                0,
                0,
                layout.AbsoluteContentSize.Y + 10
            )
        end)

        -- TAB SWITCH
        button.MouseButton1Click:Connect(function()

            for _,v in pairs(contentHolder:GetChildren()) do
                if v:IsA("Frame") then
                    v.Visible = false
                end
            end

            page.Visible = true
        end)

        if #contentHolder:GetChildren() == 1 then
            page.Visible = true
        end

        --// BUTTON
        function tab:AddButton(settings)

            settings = settings or {}

            local button = Instance.new("TextButton")
            button.Parent = pageHolder
            button.Size = UDim2.new(1,-10,0,35)
            button.BackgroundColor3 = Color3.fromRGB(30,30,30)
            button.BorderSizePixel = 0
            button.Text = settings.Name or "Button"
            button.Font = Enum.Font.Gotham
            button.TextColor3 = Color3.new(1,1,1)
            button.TextSize = 14

            local corner = Instance.new("UICorner")
            corner.Parent = button
            corner.CornerRadius = UDim.new(0,6)

            button.MouseButton1Click:Connect(function()
                if settings.Callback then
                    settings.Callback()
                end
            end)
        end

        --// TOGGLE
        function tab:AddToggle(settings)

            settings = settings or {}

            local enabled = settings.Default or false

            local toggle = Instance.new("TextButton")
            toggle.Parent = pageHolder
            toggle.Size = UDim2.new(1,-10,0,35)
            toggle.BackgroundColor3 = Color3.fromRGB(30,30,30)
            toggle.BorderSizePixel = 0
            toggle.Text = (settings.Name or "Toggle").." : "..tostring(enabled)
            toggle.Font = Enum.Font.Gotham
            toggle.TextColor3 = Color3.new(1,1,1)
            toggle.TextSize = 14

            local corner = Instance.new("UICorner")
            corner.Parent = toggle
            corner.CornerRadius = UDim.new(0,6)

            toggle.MouseButton1Click:Connect(function()

                enabled = not enabled

                toggle.Text =
                    (settings.Name or "Toggle")
                    .." : "
                    ..tostring(enabled)

                if settings.Callback then
                    settings.Callback(enabled)
                end
            end)
        end

        --// LABEL
        function tab:AddLabel(text)

            local label = {}

            local lbl = Instance.new("TextLabel")
            lbl.Parent = pageHolder
            lbl.Size = UDim2.new(1,-10,0,30)
            lbl.BackgroundTransparency = 1
            lbl.Text = text or "Label"
            lbl.Font = Enum.Font.Gotham
            lbl.TextColor3 = Color3.new(1,1,1)
            lbl.TextSize = 14
            lbl.TextXAlignment = Enum.TextXAlignment.Left

            function label:SetText(newText)
                lbl.Text = newText
            end

            return label
        end

        --// TEXTBOX
        function tab:AddTextbox(settings)

            settings = settings or {}

            local textbox = Instance.new("TextBox")
            textbox.Parent = pageHolder
            textbox.Size = UDim2.new(1,-10,0,35)
            textbox.BackgroundColor3 = Color3.fromRGB(30,30,30)
            textbox.BorderSizePixel = 0
            textbox.PlaceholderText =
                settings.Placeholder or "Type here..."
            textbox.Text = ""
            textbox.Font = Enum.Font.Gotham
            textbox.TextColor3 = Color3.new(1,1,1)
            textbox.TextSize = 14

            local corner = Instance.new("UICorner")
            corner.Parent = textbox
            corner.CornerRadius = UDim.new(0,6)

            textbox.FocusLost:Connect(function(enterPressed)

                if enterPressed and settings.Callback then
                    settings.Callback(textbox.Text)
                end
            end)
        end

        --// ADVANCED SLIDER
function tab:AddSlider(settings)

    settings = settings or {}

    local UIS = game:GetService("UserInputService")
    local TweenService = game:GetService("TweenService")

    -- SETTINGS
    local min = settings.Min or 0
    local max = settings.Max or 100
    local default = settings.Default or min
    local increment = settings.Increment or 1

    local sliderColor = settings.SliderColor or Color3.fromRGB(255,255,255)
    local backgroundColor = settings.BackgroundColor or Color3.fromRGB(30,30,30)
    local barColor = settings.BarColor or Color3.fromRGB(45,45,45)

    local showValue = settings.ShowValue ~= false
    local precise = settings.Precise or false
    local suffix = settings.Suffix or ""

    local callback = settings.Callback

    local value = math.clamp(default, min, max)
    local dragging = false

    -- FRAME
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Parent = pageHolder
    sliderFrame.Size = UDim2.new(1,-10,0,65)
    sliderFrame.BackgroundColor3 = backgroundColor
    sliderFrame.BorderSizePixel = 0

    local frameCorner = Instance.new("UICorner")
    frameCorner.Parent = sliderFrame
    frameCorner.CornerRadius = UDim.new(0,8)

    -- STROKE
    local stroke = Instance.new("UIStroke")
    stroke.Parent = sliderFrame
    stroke.Color = Color3.fromRGB(55,55,55)
    stroke.Thickness = 1

    -- TITLE
    local title = Instance.new("TextLabel")
    title.Parent = sliderFrame
    title.BackgroundTransparency = 1
    title.Position = UDim2.new(0,12,0,5)
    title.Size = UDim2.new(1,-24,0,20)
    title.Font = Enum.Font.GothamBold
    title.TextColor3 = Color3.new(1,1,1)
    title.TextSize = 14
    title.TextXAlignment = Enum.TextXAlignment.Left

    -- VALUE LABEL
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Parent = sliderFrame
    valueLabel.BackgroundTransparency = 1
    valueLabel.Position = UDim2.new(1,-70,0,5)
    valueLabel.Size = UDim2.new(0,60,0,20)
    valueLabel.Font = Enum.Font.Gotham
    valueLabel.TextColor3 = Color3.fromRGB(220,220,220)
    valueLabel.TextSize = 13
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right

    -- BAR
    local bar = Instance.new("Frame")
    bar.Parent = sliderFrame
    bar.Position = UDim2.new(0,12,0,38)
    bar.Size = UDim2.new(1,-24,0,10)
    bar.BackgroundColor3 = barColor
    bar.BorderSizePixel = 0

    local barCorner = Instance.new("UICorner")
    barCorner.Parent = bar
    barCorner.CornerRadius = UDim.new(1,0)

    -- FILL
    local fill = Instance.new("Frame")
    fill.Parent = bar
    fill.Size = UDim2.new(0,0,1,0)
    fill.BackgroundColor3 = sliderColor
    fill.BorderSizePixel = 0

    local fillCorner = Instance.new("UICorner")
    fillCorner.Parent = fill
    fillCorner.CornerRadius = UDim.new(1,0)

    -- GLOW
    local glow = Instance.new("UIStroke")
    glow.Parent = fill
    glow.Color = sliderColor
    glow.Thickness = 1.5
    glow.Transparency = 0.4

    -- KNOB
    local knob = Instance.new("Frame")
    knob.Parent = bar
    knob.Size = UDim2.new(0,18,0,18)
    knob.AnchorPoint = Vector2.new(0.5,0.5)
    knob.Position = UDim2.new(0,0,0.5,0)
    knob.BackgroundColor3 = sliderColor
    knob.BorderSizePixel = 0

    local knobCorner = Instance.new("UICorner")
    knobCorner.Parent = knob
    knobCorner.CornerRadius = UDim.new(1,0)

    local knobStroke = Instance.new("UIStroke")
    knobStroke.Parent = knob
    knobStroke.Color = Color3.new(1,1,1)
    knobStroke.Thickness = 1

    -- SHADOW
    local shadow = Instance.new("ImageLabel")
    shadow.Parent = knob
    shadow.BackgroundTransparency = 1
    shadow.AnchorPoint = Vector2.new(0.5,0.5)
    shadow.Position = UDim2.new(0.5,0,0.5,0)
    shadow.Size = UDim2.new(1,14,1,14)
    shadow.Image = "rbxassetid://6015897843"
    shadow.ImageTransparency = 0.5
    shadow.ZIndex = 0

    -- RIPPLE
    local ripple = Instance.new("Frame")
    ripple.Parent = knob
    ripple.AnchorPoint = Vector2.new(0.5,0.5)
    ripple.Position = UDim2.new(0.5,0,0.5,0)
    ripple.Size = UDim2.new(0,0,0,0)
    ripple.BackgroundColor3 = sliderColor
    ripple.BackgroundTransparency = 0.5
    ripple.ZIndex = 0

    local rippleCorner = Instance.new("UICorner")
    rippleCorner.Parent = ripple
    rippleCorner.CornerRadius = UDim.new(1,0)

    -- ROUND FUNCTION
    local function round(num, step)

        if precise then
            return math.floor(num / step + 0.5) * step
        end

        return math.floor(num + 0.5)
    end

    -- UPDATE
    local function updateSlider(x)

        local percent = math.clamp(
            (x - bar.AbsolutePosition.X) / bar.AbsoluteSize.X,
            0,
            1
        )

        value = min + ((max - min) * percent)
        value = round(value, increment)

        local fillPercent = (value - min) / (max - min)

        -- TWEEN
        TweenService:Create(
            fill,
            TweenInfo.new(
                0.08,
                Enum.EasingStyle.Quart,
                Enum.EasingDirection.Out
            ),
            {
                Size = UDim2.new(fillPercent,0,1,0)
            }
        ):Play()

        TweenService:Create(
            knob,
            TweenInfo.new(
                0.08,
                Enum.EasingStyle.Quart,
                Enum.EasingDirection.Out
            ),
            {
                Position = UDim2.new(fillPercent,0,0.5,0),
                Size = dragging
                    and UDim2.new(0,22,0,22)
                    or UDim2.new(0,18,0,18)
            }
        ):Play()

        title.Text = settings.Name or "Slider"

        if showValue then
            valueLabel.Text = tostring(value)..suffix
        else
            valueLabel.Text = ""
        end

        if callback then
            callback(value)
        end
    end

    -- INITIAL
    task.defer(function()

        local startPercent = (value - min) / (max - min)

        fill.Size = UDim2.new(startPercent,0,1,0)
        knob.Position = UDim2.new(startPercent,0,0.5,0)

        title.Text = settings.Name or "Slider"

        if showValue then
            valueLabel.Text = tostring(value)..suffix
        end
    end)

    -- CLICK EFFECT
    local function rippleEffect()

        ripple.Size = UDim2.new(0,0,0,0)
        ripple.BackgroundTransparency = 0.5

        TweenService:Create(
            ripple,
            TweenInfo.new(
                0.35,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out
            ),
            {
                Size = UDim2.new(0,45,0,45),
                BackgroundTransparency = 1
            }
        ):Play()
    end

    -- HOVER
    knob.MouseEnter:Connect(function()

        TweenService:Create(
            knob,
            TweenInfo.new(0.15),
            {
                BackgroundColor3 = Color3.fromRGB(
                    math.clamp(sliderColor.R*255+25,0,255),
                    math.clamp(sliderColor.G*255+25,0,255),
                    math.clamp(sliderColor.B*255+25,0,255)
                )
            }
        ):Play()
    end)

    knob.MouseLeave:Connect(function()

        TweenService:Create(
            knob,
            TweenInfo.new(0.15),
            {
                BackgroundColor3 = sliderColor
            }
        ):Play()
    end)

    -- INPUT
    bar.InputBegan:Connect(function(input)

        if input.UserInputType == Enum.UserInputType.MouseButton1 then

            dragging = true

            rippleEffect()
            updateSlider(input.Position.X)

            TweenService:Create(
                stroke,
                TweenInfo.new(0.15),
                {
                    Color = sliderColor
                }
            ):Play()
        end
    end)

    UIS.InputChanged:Connect(function(input)

        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(input.Position.X)
        end
    end)

    UIS.InputEnded:Connect(function(input)

        if input.UserInputType == Enum.UserInputType.MouseButton1 then

            dragging = false

            TweenService:Create(
                knob,
                TweenInfo.new(0.1),
                {
                    Size = UDim2.new(0,18,0,18)
                }
            ):Play()

            TweenService:Create(
                stroke,
                TweenInfo.new(0.15),
                {
                    Color = Color3.fromRGB(55,55,55)
                }
            ):Play()
        end
    end)

    -- METHODS
    local sliderFunctions = {}

    function sliderFunctions:Set(v)

        value = math.clamp(v,min,max)
        updateSlider(
            bar.AbsolutePosition.X
            + ((value-min)/(max-min))*bar.AbsoluteSize.X
        )
    end

    function sliderFunctions:Get()
        return value
    end

    return sliderFunctions
end

        return tab
    end

    return window
end

return imgui