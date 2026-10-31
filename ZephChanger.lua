--========================================================--
--              ZEPH GRAPHICS PREMIUM V2                  --
--             PURPLE / CYAN / BLUE EDITION               --
--========================================================--
-- LOCATION:
-- StarterPlayer > StarterPlayerScripts > LocalScript
--
-- KEY: ZEPH-ULTRA-2026
--
-- SIX TABS:
-- Visuals / Lighting / Effects
-- Performance / Auto / Settings
--
-- FUTURISTIC NEON INTERFACE
--========================================================--

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--========================================================--
-- CONFIGURATION
--========================================================--

local ACCESS_KEY = "ZEPH-ULTRA-2026"

local WIDTH = 470
local HEIGHT = 325

local BLUE = Color3.fromRGB(35, 115, 255)
local CYAN = Color3.fromRGB(0, 235, 255)
local PURPLE = Color3.fromRGB(155, 65, 255)

local BG = Color3.fromRGB(9, 8, 22)
local PANEL = Color3.fromRGB(19, 15, 38)
local BUTTON = Color3.fromRGB(29, 24, 55)

local WHITE = Color3.fromRGB(235, 240, 255)
local MUTED = Color3.fromRGB(145, 135, 180)

local NEON_COLORS = {
    PURPLE,
    CYAN,
    BLUE
}

--========================================================--
-- CLEAN OLD GUI
--========================================================--

local old = PlayerGui:FindFirstChild("ZephGraphicsPremium")

if old then
    old:Destroy()
end

--========================================================--
-- SAVE ORIGINAL LIGHTING
--========================================================--

local Original = {
    Brightness = Lighting.Brightness,
    ClockTime = Lighting.ClockTime,
    GlobalShadows = Lighting.GlobalShadows,
    Ambient = Lighting.Ambient,
    OutdoorAmbient = Lighting.OutdoorAmbient,
    FogColor = Lighting.FogColor,
    FogStart = Lighting.FogStart,
    FogEnd = Lighting.FogEnd,
    Exposure = Lighting.ExposureCompensation,
    ColorTop = Lighting.ColorShift_Top,
    ColorBottom = Lighting.ColorShift_Bottom,
    Diffuse = Lighting.EnvironmentDiffuseScale,
    Specular = Lighting.EnvironmentSpecularScale
}

local Effects = {}
local ParticleOriginals = {}

--========================================================--
-- HELPER FUNCTIONS
--========================================================--

local function tween(object, duration, properties, style)
    local t = TweenService:Create(
        object,
        TweenInfo.new(
            duration,
            style or Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out
        ),
        properties
    )

    t:Play()
    return t
end

local function create(class, properties, parent)
    local object = Instance.new(class)

    for key, value in pairs(properties) do
        object[key] = value
    end

    object.Parent = parent

    return object
end

local function corner(object, radius)
    create("UICorner", {
        CornerRadius = UDim.new(0, radius)
    }, object)
end

local function stroke(object, color, thickness)
    return create("UIStroke", {
        Color = color,
        Thickness = thickness or 1,
        Transparency = 0.15
    }, object)
end

local function label(parent, text, size, color)
    return create("TextLabel", {
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = color or WHITE,
        Font = Enum.Font.GothamMedium,
        TextSize = size or 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center
    }, parent)
end

local function makeButton(parent, text)
    local button = create("TextButton", {
        BackgroundColor3 = BUTTON,
        BorderSizePixel = 0,
        Text = text,
        TextColor3 = WHITE,
        Font = Enum.Font.GothamBold,
        TextSize = 10,
        AutoButtonColor = false
    }, parent)

    corner(button, 6)

    local outline = stroke(button, BLUE, 1)

    button.MouseEnter:Connect(function()
        tween(button, 0.15, {
            BackgroundColor3 = Color3.fromRGB(48, 35, 85)
        })

        tween(outline, 0.15, {
            Color = CYAN
        })
    end)

    button.MouseLeave:Connect(function()
        tween(button, 0.15, {
            BackgroundColor3 = BUTTON
        })

        tween(outline, 0.15, {
            Color = BLUE
        })
    end)

    return button
end

--========================================================--
-- SCREEN GUI
--========================================================--

local GUI = create("ScreenGui", {
    Name = "ZephGraphicsPremium",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
}, PlayerGui)

--========================================================--
-- BOOT SCREEN
--========================================================--

local Boot = create("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = BG,
    BorderSizePixel = 0,
    ZIndex = 100
}, GUI)

local BootGradient = create("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, BG),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(35, 12, 65)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 25, 65))
    }),
    Rotation = 45
}, Boot)

local BootLogo = label(Boot, "Z", 65, CYAN)

BootLogo.Size = UDim2.new(0, 140, 0, 100)
BootLogo.AnchorPoint = Vector2.new(0.5, 0.5)
BootLogo.Position = UDim2.fromScale(0.5, 0.38)
BootLogo.TextXAlignment = Enum.TextXAlignment.Center
BootLogo.Font = Enum.Font.GothamBlack
BootLogo.ZIndex = 101

stroke(BootLogo, PURPLE, 2)

local BootTitle = label(
    Boot,
    "Z E P H   S Y S T E M S",
    13,
    WHITE
)

BootTitle.Size = UDim2.new(1, 0, 0, 30)
BootTitle.Position = UDim2.fromScale(0, 0.49)
BootTitle.TextXAlignment = Enum.TextXAlignment.Center
BootTitle.Font = Enum.Font.GothamBold
BootTitle.ZIndex = 101

local BootSubtitle = label(
    Boot,
    "GRAPHICS PREMIUM INITIALIZATION",
    9,
    CYAN
)

BootSubtitle.Size = UDim2.new(1, 0, 0, 25)
BootSubtitle.Position = UDim2.fromScale(0, 0.55)
BootSubtitle.TextXAlignment = Enum.TextXAlignment.Center
BootSubtitle.ZIndex = 101

local BootBar = create("Frame", {
    Size = UDim2.new(0, 240, 0, 5),
    Position = UDim2.new(0.5, -120, 0.65, 0),
    BackgroundColor3 = BUTTON,
    BorderSizePixel = 0,
    ZIndex = 101
}, Boot)

corner(BootBar, 5)

local BootFill = create("Frame", {
    Size = UDim2.new(0, 0, 1, 0),
    BackgroundColor3 = CYAN,
    BorderSizePixel = 0,
    ZIndex = 102
}, BootBar)

corner(BootFill, 5)

local BootStatus = label(
    Boot,
    "PREPARING SYSTEM...",
    9,
    MUTED
)

BootStatus.Size = UDim2.new(1, 0, 0, 20)
BootStatus.Position = UDim2.fromScale(0, 0.68)
BootStatus.TextXAlignment = Enum.TextXAlignment.Center
BootStatus.ZIndex = 101

local BootPercent = label(Boot, "0%", 10, PURPLE)

BootPercent.Size = UDim2.new(1, 0, 0, 20)
BootPercent.Position = UDim2.fromScale(0, 0.72)
BootPercent.TextXAlignment = Enum.TextXAlignment.Center
BootPercent.ZIndex = 101

--========================================================--
-- BOOT COLOR ANIMATION
--========================================================--

local bootConnection
local bootColorIndex = 1

bootConnection = RunService.RenderStepped:Connect(function(dt)
    if not Boot.Parent then
        bootConnection:Disconnect()
        return
    end

    BootGradient.Rotation =
        (BootGradient.Rotation + dt * 5) % 360
end)

task.spawn(function()
    while Boot.Parent do
        bootColorIndex = bootColorIndex % 3 + 1

        tween(BootLogo, 0.8, {
            TextColor3 = NEON_COLORS[bootColorIndex]
        })

        task.wait(0.8)
    end
end)

--========================================================--
-- KEY PANEL
--========================================================--

local KeyPanel = create("Frame", {
    Size = UDim2.new(0, 300, 0, 210),
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    BackgroundColor3 = PANEL,
    BorderSizePixel = 0,
    Visible = false,
    ZIndex = 110
}, GUI)

corner(KeyPanel, 12)

local KeyStroke = stroke(KeyPanel, PURPLE, 2)

local KeyGradient = create("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 20, 65)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(15, 35, 75)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 15, 55))
    }),
    Rotation = 35
}, KeyPanel)

local KeyTitle = label(KeyPanel, "PREMIUM ACCESS", 16, CYAN)

KeyTitle.Position = UDim2.new(0, 18, 0, 15)
KeyTitle.Size = UDim2.new(1, -36, 0, 30)
KeyTitle.Font = Enum.Font.GothamBlack
KeyTitle.ZIndex = 112

local KeyDescription = label(
    KeyPanel,
    "ENTER YOUR ZEPH ACCESS KEY",
    9,
    MUTED
)

KeyDescription.Position = UDim2.new(0, 18, 0, 48)
KeyDescription.Size = UDim2.new(1, -36, 0, 20)
KeyDescription.ZIndex = 112

local KeyInput = create("TextBox", {
    Size = UDim2.new(1, -36, 0, 38),
    Position = UDim2.new(0, 18, 0, 82),
    BackgroundColor3 = BG,
    BorderSizePixel = 0,
    Text = "",
    PlaceholderText = "Enter access key...",
    PlaceholderColor3 = MUTED,
    TextColor3 = WHITE,
    Font = Enum.Font.Gotham,
    TextSize = 11,
    ClearTextOnFocus = false,
    ZIndex = 112
}, KeyPanel)

corner(KeyInput, 7)
stroke(KeyInput, BLUE, 1)

local Verify = makeButton(KeyPanel, "UNLOCK PREMIUM")

Verify.Size = UDim2.new(1, -36, 0, 35)
Verify.Position = UDim2.new(0, 18, 0, 135)
Verify.BackgroundColor3 = Color3.fromRGB(65, 30, 130)
Verify.TextColor3 = CYAN
Verify.ZIndex = 112

local KeyStatus = label(KeyPanel, "SYSTEM LOCKED", 9, MUTED)

KeyStatus.Position = UDim2.new(0, 18, 0, 175)
KeyStatus.Size = UDim2.new(1, -36, 0, 20)
KeyStatus.TextXAlignment = Enum.TextXAlignment.Center
KeyStatus.ZIndex = 112

--========================================================--
-- MAIN HUB
--========================================================--

local Main = create("Frame", {
    Name = "Main",
    Size = UDim2.new(0, WIDTH, 0, HEIGHT),
    Position = UDim2.new(0.5, -WIDTH / 2, 0.5, -HEIGHT / 2),
    BackgroundColor3 = BG,
    BorderSizePixel = 0,
    Visible = false,
    ClipsDescendants = false
}, GUI)

corner(Main, 12)

local MainStroke = stroke(Main, CYAN, 1.5)

local MainGradient = create("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, PURPLE),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(18, 35, 85)),
        ColorSequenceKeypoint.new(1, CYAN)
    }),
    Rotation = 35
}, Main)

--========================================================--
-- OUTER GLOW
--========================================================--

local Glow = create("ImageLabel", {
    Size = UDim2.new(1, 40, 1, 40),
    Position = UDim2.new(0, -20, 0, -20),
    BackgroundTransparency = 1,
    Image = "rbxassetid://5028857084",
    ImageColor3 = PURPLE,
    ImageTransparency = 0.45,
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(24, 24, 276, 276),
    ZIndex = 0
}, Main)

task.spawn(function()
    local index = 1

    while Main.Parent do
        index = index % 3 + 1

        tween(Glow, 1.3, {
            ImageColor3 = NEON_COLORS[index],
            ImageTransparency = 0.35
        })

        tween(MainStroke, 1.3, {
            Color = NEON_COLORS[index]
        })

        task.wait(1.3)
    end
end)

--========================================================--
-- HEADER
--========================================================--

local Header = create("Frame", {
    Size = UDim2.new(1, 0, 0, 38),
    BackgroundColor3 = Color3.fromRGB(24, 20, 52),
    BorderSizePixel = 0
}, Main)

corner(Header, 12)

local HeaderLine = create("Frame", {
    Size = UDim2.new(1, -20, 0, 1),
    Position = UDim2.new(0, 10, 1, -1),
    BackgroundColor3 = CYAN,
    BackgroundTransparency = 0.25,
    BorderSizePixel = 0
}, Header)

local HubTitle = label(
    Header,
    "ZEPH  /  GRAPHICS PREMIUM",
    12,
    CYAN
)

HubTitle.Position = UDim2.new(0, 13, 0, 0)
HubTitle.Size = UDim2.new(1, -110, 1, 0)
HubTitle.Font = Enum.Font.GothamBlack

local Status = label(Header, "● ONLINE", 8, Color3.fromRGB(70, 255, 170))

Status.Position = UDim2.new(1, -105, 0, 0)
Status.Size = UDim2.new(0, 52, 1, 0)

local Minimize = makeButton(Header, "—")

Minimize.Size = UDim2.new(0, 25, 0, 24)
Minimize.Position = UDim2.new(1, -53, 0, 7)
Minimize.TextColor3 = CYAN

local Close = makeButton(Header, "×")

Close.Size = UDim2.new(0, 25, 0, 24)
Close.Position = UDim2.new(1, -26, 0, 7)
Close.TextColor3 = PURPLE

--========================================================--
-- SIDEBAR
--========================================================--

local Sidebar = create("Frame", {
    Position = UDim2.new(0, 0, 0, 38),
    Size = UDim2.new(0, 112, 1, -38),
    BackgroundColor3 = Color3.fromRGB(15, 12, 32),
    BorderSizePixel = 0
}, Main)

create("UIPadding", {
    PaddingTop = UDim.new(0, 10),
    PaddingLeft = UDim.new(0, 7),
    PaddingRight = UDim.new(0, 7)
}, Sidebar)

create("UIListLayout", {
    Padding = UDim.new(0, 7),
    SortOrder = Enum.SortOrder.LayoutOrder
}, Sidebar)

--========================================================--
-- CONTENT
--========================================================--

local Content = create("Frame", {
    Position = UDim2.new(0, 112, 0, 38),
    Size = UDim2.new(1, -112, 1, -38),
    BackgroundTransparency = 1
}, Main)

local ContentTitle = label(Content, "VISUALS", 13, CYAN)

ContentTitle.Position = UDim2.new(0, 13, 0, 9)
ContentTitle.Size = UDim2.new(1, -26, 0, 22)
ContentTitle.Font = Enum.Font.GothamBlack

local ContentSubtitle = label(Content, "SYSTEM CONTROL PANEL", 8, MUTED)

ContentSubtitle.Position = UDim2.new(0, 13, 0, 29)
ContentSubtitle.Size = UDim2.new(1, -26, 0, 16)

local Scroll = create("ScrollingFrame", {
    Position = UDim2.new(0, 9, 0, 51),
    Size = UDim2.new(1, -18, 1, -60),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = PURPLE,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y
}, Content)

local FeatureList = create("UIListLayout", {
    Padding = UDim.new(0, 7),
    SortOrder = Enum.SortOrder.LayoutOrder
}, Scroll)

--========================================================--
-- EFFECT SYSTEM
--========================================================--

local function getEffect(name, className)
    if Effects[name] and Effects[name].Parent then
        return Effects[name]
    end

    local effect = Instance.new(className)

    effect.Name = "ZEPH_" .. name
    effect.Parent = Lighting

    Effects[name] = effect

    if effect:IsA("PostEffect") then
        effect.Enabled = false
    end

    return effect
end

local function bloom()
    return getEffect("Bloom", "BloomEffect")
end

local function blur()
    return getEffect("Blur", "BlurEffect")
end

local function sunRays()
    return getEffect("SunRays", "SunRaysEffect")
end

local function correction()
    return getEffect("ColorCorrection", "ColorCorrectionEffect")
end

local function depthOfField()
    return getEffect("DepthOfField", "DepthOfFieldEffect")
end

local function atmosphere()
    return getEffect("Atmosphere", "Atmosphere")
end

--========================================================--
-- RESET LIGHTING
--========================================================--

local function resetLighting()
    Lighting.Brightness = Original.Brightness
    Lighting.ClockTime = Original.ClockTime
    Lighting.GlobalShadows = Original.GlobalShadows
    Lighting.Ambient = Original.Ambient
    Lighting.OutdoorAmbient = Original.OutdoorAmbient
    Lighting.FogColor = Original.FogColor
    Lighting.FogStart = Original.FogStart
    Lighting.FogEnd = Original.FogEnd
    Lighting.ExposureCompensation = Original.Exposure
    Lighting.ColorShift_Top = Original.ColorTop
    Lighting.ColorShift_Bottom = Original.ColorBottom
    Lighting.EnvironmentDiffuseScale = Original.Diffuse
    Lighting.EnvironmentSpecularScale = Original.Specular

    for name, effect in pairs(Effects) do
        if effect and effect.Parent then
            effect:Destroy()
        end

        Effects[name] = nil
    end
end

local function resetParticles()
    for object, original in pairs(ParticleOriginals) do
        if object and object.Parent then
            object.Enabled = original
        end
    end

    table.clear(ParticleOriginals)
end

--========================================================--
-- PRESETS
--========================================================--

local function SummerRise()
    resetLighting()

    Lighting.ClockTime = 14
    Lighting.Brightness = 3
    Lighting.GlobalShadows = true
    Lighting.Ambient = Color3.fromRGB(150, 145, 125)
    Lighting.OutdoorAmbient = Color3.fromRGB(190, 180, 150)
    Lighting.ColorShift_Top = Color3.fromRGB(255, 220, 170)
    Lighting.ColorShift_Bottom = Color3.fromRGB(255, 240, 200)
    Lighting.ExposureCompensation = 0.2

    local a = atmosphere()
    a.Color = Color3.fromRGB(255, 230, 190)
    a.Decay = Color3.fromRGB(255, 210, 150)
    a.Density = 0.2
    a.Haze = 1

    local r = sunRays()
    r.Enabled = true
    r.Intensity = 0.08
    r.Spread = 0.8
end

local function FrostView()
    resetLighting()

    Lighting.ClockTime = 13
    Lighting.Brightness = 2
    Lighting.GlobalShadows = true
    Lighting.Ambient = Color3.fromRGB(130, 160, 190)
    Lighting.OutdoorAmbient = Color3.fromRGB(170, 195, 220)
    Lighting.FogColor = Color3.fromRGB(190, 220, 255)
    Lighting.FogStart = 0
    Lighting.FogEnd = 350

    local a = atmosphere()
    a.Color = Color3.fromRGB(190, 220, 255)
    a.Decay = Color3.fromRGB(150, 190, 230)
    a.Density = 0.35
    a.Haze = 2

    local c = correction()
    c.Enabled = true
    c.TintColor = Color3.fromRGB(200, 225, 255)
    c.Saturation = -0.15
    c.Contrast = 0.08
end

local function MoonShine()
    resetLighting()

    Lighting.ClockTime = 0
    Lighting.Brightness = 0.8
    Lighting.GlobalShadows = true
    Lighting.Ambient = Color3.fromRGB(30, 40, 75)
    Lighting.OutdoorAmbient = Color3.fromRGB(45, 55, 95)
    Lighting.FogColor = Color3.fromRGB(20, 30, 55)
    Lighting.FogStart = 0
    Lighting.FogEnd = 250

    local a = atmosphere()
    a.Color = Color3.fromRGB(70, 90, 150)
    a.Decay = Color3.fromRGB(20, 30, 65)
    a.Density = 0.4
    a.Haze = 2.5

    local c = correction()
    c.Enabled = true
    c.TintColor = Color3.fromRGB(130, 150, 220)
    c.Contrast = 0.15
    c.Saturation = -0.2

    local b = bloom()
    b.Enabled = true
    b.Intensity = 0.3
    b.Size = 20
end

local function BreezeCool()
    resetLighting()

    Lighting.ClockTime = 12
    Lighting.Brightness = 2

    local c = correction()
    c.Enabled = true
    c.TintColor = Color3.fromRGB(220, 235, 255)
    c.Saturation = 0.05
    c.Contrast = 0.05

    local a = atmosphere()
    a.Color = Color3.fromRGB(220, 235, 255)
    a.Decay = Color3.fromRGB(170, 190, 220)
    a.Density = 0.15
    a.Haze = 0.5
end

local function SunFall()
    resetLighting()

    Lighting.ClockTime = 17.8
    Lighting.Brightness = 2
    Lighting.GlobalShadows = true
    Lighting.Ambient = Color3.fromRGB(140, 90, 80)
    Lighting.OutdoorAmbient = Color3.fromRGB(190, 120, 90)
    Lighting.FogColor = Color3.fromRGB(255, 160, 110)
    Lighting.FogStart = 0
    Lighting.FogEnd = 600

    local a = atmosphere()
    a.Color = Color3.fromRGB(255, 170, 110)
    a.Decay = Color3.fromRGB(190, 90, 70)
    a.Density = 0.25
    a.Haze = 1.5

    local c = correction()
    c.Enabled = true
    c.TintColor = Color3.fromRGB(255, 190, 140)
    c.Saturation = 0.15
    c.Contrast = 0.08

    local r = sunRays()
    r.Enabled = true
    r.Intensity = 0.12
    r.Spread = 0.8
end

--========================================================--
-- PARTICLES
--========================================================--

local function setParticles(disabled)
    for _, object in ipairs(Workspace:GetDescendants()) do
        if object:IsA("ParticleEmitter")
            or object:IsA("Trail")
            or object:IsA("Beam") then

            if ParticleOriginals[object] == nil then
                ParticleOriginals[object] = object.Enabled
            end

            object.Enabled = not disabled
        end
    end
end

--========================================================--
-- FPS DISPLAY
--========================================================--

local FPSLabel
local FPSConnection

local function toggleFPS(enabled)
    if FPSConnection then
        FPSConnection:Disconnect()
        FPSConnection = nil
    end

    if FPSLabel then
        FPSLabel:Destroy()
        FPSLabel = nil
    end

    if not enabled then
        return
    end

    FPSLabel = create("TextLabel", {
        Size = UDim2.new(0, 110, 0, 25),
        Position = UDim2.new(0, 12, 0, 12),
        BackgroundColor3 = BG,
        BackgroundTransparency = 0.1,
        TextColor3 = CYAN,
        Font = Enum.Font.GothamBold,
        TextSize = 11,
        Text = "FPS: --"
    }, GUI)

    corner(FPSLabel, 6)
    stroke(FPSLabel, PURPLE)

    local elapsed = 0
    local frames = 0

    FPSConnection = RunService.RenderStepped:Connect(function(dt)
        elapsed += dt
        frames += 1

        if elapsed >= 1 then
            FPSLabel.Text = "FPS: " .. math.floor(frames / elapsed)
            elapsed = 0
            frames = 0
        end
    end)
end

--========================================================--
-- PERFORMANCE MONITOR
--========================================================--

local MonitorLabel
local MonitorConnection

local function toggleMonitor(enabled)
    if MonitorConnection then
        MonitorConnection:Disconnect()
        MonitorConnection = nil
    end

    if MonitorLabel then
        MonitorLabel:Destroy()
        MonitorLabel = nil
    end

    if not enabled then
        return
    end

    MonitorLabel = create("TextLabel", {
        Size = UDim2.new(0, 145, 0, 27),
        Position = UDim2.new(0, 12, 0, 42),
        BackgroundColor3 = BG,
        TextColor3 = CYAN,
        TextSize = 9,
        Font = Enum.Font.GothamBold,
        Text = "SYSTEM MONITOR"
    }, GUI)

    corner(MonitorLabel, 6)
    stroke(MonitorLabel, PURPLE)

    local elapsed = 0
    local frames = 0

    MonitorConnection = RunService.RenderStepped:Connect(function(dt)
        elapsed += dt
        frames += 1

        if elapsed >= 1 then
            MonitorLabel.Text = "CLIENT FPS: " .. math.floor(frames / elapsed)
            elapsed = 0
            frames = 0
        end
    end)
end

--========================================================--
-- FEATURE ROW
--========================================================--

local function feature(name, callback)
    local row = create("Frame", {
        Size = UDim2.new(1, -5, 0, 35),
        BackgroundColor3 = PANEL,
        BorderSizePixel = 0
    }, Scroll)

    corner(row, 7)
    stroke(row, Color3.fromRGB(60, 40, 100))

    local title = label(row, name, 10, WHITE)
    title.Position = UDim2.new(0, 10, 0, 0)
    title.Size = UDim2.new(1, -75, 1, 0)

    local button = makeButton(row, "OFF")
    button.Size = UDim2.new(0, 48, 0, 23)
    button.Position = UDim2.new(1, -55, 0.5, -11)

    local enabled = false

    button.MouseButton1Click:Connect(function()
        enabled = not enabled

        if enabled then
            button.Text = "ON"
            button.TextColor3 = CYAN
            button.BackgroundColor3 = Color3.fromRGB(50, 25, 100)
        else
            button.Text = "OFF"
            button.TextColor3 = WHITE
            button.BackgroundColor3 = BUTTON
        end

        if callback then
            callback(enabled)
        end
    end)

    return row
end

--========================================================--
-- SLIDER
--========================================================--

local ActiveSlider

local function slider(name, minValue, maxValue, defaultValue, callback)
    local row = create("Frame", {
        Size = UDim2.new(1, -5, 0, 53),
        BackgroundColor3 = PANEL,
        BorderSizePixel = 0
    }, Scroll)

    corner(row, 7)
    stroke(row, Color3.fromRGB(60, 40, 100))

    local title = label(row, name, 10, WHITE)
    title.Position = UDim2.new(0, 10, 0, 3)
    title.Size = UDim2.new(0.7, 0, 0, 18)

    local valueLabel = label(row, tostring(defaultValue), 9, CYAN)
    valueLabel.Position = UDim2.new(1, -60, 0, 3)
    valueLabel.Size = UDim2.new(0, 48, 0, 18)
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right

    local track = create("Frame", {
        Size = UDim2.new(1, -20, 0, 6),
        Position = UDim2.new(0, 10, 0, 34),
        BackgroundColor3 = BUTTON,
        BorderSizePixel = 0
    }, row)

    corner(track, 5)

    local initial = math.clamp(
        (defaultValue - minValue) / (maxValue - minValue),
        0,
        1
    )

    local fill = create("Frame", {
        Size = UDim2.new(initial, 0, 1, 0),
        BackgroundColor3 = PURPLE,
        BorderSizePixel = 0
    }, track)

    corner(fill, 5)

    local knob = create("Frame", {
        Size = UDim2.new(0, 13, 0, 13),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(initial, 0, 0.5, 0),
        BackgroundColor3 = CYAN,
        BorderSizePixel = 0
    }, track)

    corner(knob, 20)
    stroke(knob, BLUE, 1)

    local function update(position)
        local percent = math.clamp(
            (position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X,
            0,
            1
        )

        local value = minValue + (maxValue - minValue) * percent
        value = math.floor(value * 100) / 100

        fill.Size = UDim2.new(percent, 0, 1, 0)
        knob.Position = UDim2.new(percent, 0, 0.5, 0)
        valueLabel.Text = tostring(value)

        if callback then
            callback(value)
        end
    end

    track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

            ActiveSlider = {
                Track = track,
                Update = update
            }

            update(input.Position)
        end
    end)

    return row
end

UserInputService.InputChanged:Connect(function(input)
    if ActiveSlider then
        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then

            ActiveSlider.Update(input.Position)
        end
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        ActiveSlider = nil
    end
end)

--========================================================--
-- TAB SYSTEM
--========================================================--

local Tabs = {
    "Visuals",
    "Lighting",
    "Effects",
    "Performance",
    "Auto",
    "Settings"
}

local TabButtons = {}
local ActiveTab = "Visuals"

local function clearFeatures()
    ActiveSlider = nil

    for _, child in ipairs(Scroll:GetChildren()) do
        if child:IsA("GuiObject") and child ~= FeatureList then
            child:Destroy()
        end
    end
end

--========================================================--
-- BUILD TAB
--========================================================--

local function buildTab(tabName)
    clearFeatures()

    ActiveTab = tabName
    ContentTitle.Text = string.upper(tabName)

    ContentSubtitle.Text = "ZEPH SYSTEM CONTROL / " .. string.upper(tabName)

    for name, button in pairs(TabButtons) do
        if name == tabName then
            button.BackgroundColor3 = Color3.fromRGB(50, 25, 100)
            button.TextColor3 = CYAN
        else
            button.BackgroundColor3 = BUTTON
            button.TextColor3 = WHITE
        end
    end

    if tabName == "Visuals" then
        slider("Brightness", 0, 5, Lighting.Brightness, function(v)
            Lighting.Brightness = v
        end)

        feature("Global Shadows", function(v)
            Lighting.GlobalShadows = v
        end)

        feature("Terrain Decoration", function(v)
            local terrain = Workspace:FindFirstChildOfClass("Terrain")

            if terrain then
                terrain.Decoration = v
            end
        end)

        slider("Contrast", -1, 1, 0, function(v)
            correction().Enabled = true
            correction().Contrast = v
        end)

        slider("Saturation", -1, 1, 0, function(v)
            correction().Enabled = true
            correction().Saturation = v
        end)

        slider("Exposure", -2, 2, Lighting.ExposureCompensation, function(v)
            Lighting.ExposureCompensation = v
        end)

        feature("Reset Visuals", function(v)
            if v then
                resetLighting()
            end
        end)

    elseif tabName == "Lighting" then
        feature("Full Bright", function(v)
            if v then
                Lighting.Brightness = 3
                Lighting.ClockTime = 14
                Lighting.GlobalShadows = false
                Lighting.Ambient = Color3.new(1, 1, 1)
                Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
            else
                resetLighting()
            end
        end)

        feature("Ambient White", function(v)
            Lighting.Ambient = v and Color3.new(1, 1, 1) or Original.Ambient
        end)

        feature("Outdoor Ambient", function(v)
            Lighting.OutdoorAmbient = v and Color3.new(1, 1, 1) or Original.OutdoorAmbient
        end)

        slider("Clock Time", 0, 24, Lighting.ClockTime, function(v)
            Lighting.ClockTime = v
        end)

        slider("Fog Distance", 50, 2000, Lighting.FogEnd, function(v)
            Lighting.FogEnd = v
        end)

        feature("Bloom", function(v)
            bloom().Enabled = v
            bloom().Intensity = 0.5
        end)

        feature("Color Correction", function(v)
            correction().Enabled = v
        end)

    elseif tabName == "Effects" then
        feature("Bloom", function(v)
            bloom().Enabled = v
        end)

        feature("Blur", function(v)
            blur().Enabled = v
        end)

        feature("Sun Rays", function(v)
            sunRays().Enabled = v
        end)

        feature("Depth Of Field", function(v)
            depthOfField().Enabled = v
        end)

        feature("Atmosphere", function(v)
            local a = atmosphere()
            a.Density = v and 0.3 or 0
        end)

        feature("Hide Particles", function(v)
            setParticles(v)
        end)

        slider("Effect Intensity", 0, 2, 1, function(v)
            bloom().Intensity = v
            blur().Size = v * 10
            sunRays().Intensity = v * 0.1
        end)

    elseif tabName == "Performance" then
        feature("FPS Display", toggleFPS)

        feature("Low Graphics Mode", function(v)
            Lighting.GlobalShadows = not v

            for _, effect in ipairs(Lighting:GetChildren()) do
                if effect:IsA("PostEffect") then
                    effect.Enabled = not v
                end
            end
        end)

        feature("Reduce Effects", function(v)
            for _, effect in ipairs(Lighting:GetChildren()) do
                if effect:IsA("PostEffect") then
                    effect.Enabled = not v
                end
            end
        end)

        feature("Simplify Lighting", function(v)
            Lighting.EnvironmentDiffuseScale = v and 0 or Original.Diffuse
            Lighting.EnvironmentSpecularScale = v and 0 or Original.Specular
        end)

        feature("Disable Particles", setParticles)

        feature("Reduce Shadows", function(v)
            Lighting.GlobalShadows = not v
        end)

        feature("Performance Monitor", toggleMonitor)

    elseif tabName == "Auto" then
        local presets = {
            {"SummerRise", SummerRise},
            {"FrostView", FrostView},
            {"MoonShine", MoonShine},
            {"BreezeCool", BreezeCool},
            {"SunFall", SunFall}
        }

        for _, preset in ipairs(presets) do
            feature(preset[1], function(v)
                if v then
                    preset[2]()
                end
            end)
        end

        feature("Restore Original", function(v)
            if v then
                resetLighting()
            end
        end)

    elseif tabName == "Settings" then
        slider("Hub Scale", 0.7, 1.3, 1, function(v)
            Main.Size = UDim2.new(
                0,
                WIDTH * v,
                0,
                HEIGHT * v
            )
        end)

        slider("Hub Transparency", 0, 0.5, 0, function(v)
            Main.BackgroundTransparency = v
        end)

        slider("Glow Intensity", 0, 1, 0.55, function(v)
            Glow.ImageTransparency = 1 - v
            MainStroke.Transparency = 1 - v
        end)

        feature("Restore Lighting", function(v)
            if v then
                resetLighting()
                resetParticles()
            end
        end)

        feature("Reset Hub Size", function(v)
            if v then
                Main.Size = UDim2.new(0, WIDTH, 0, HEIGHT)
            end
        end)

        feature("Minimize Hub", function(v)
            if v then
                Main.Visible = false
            end
        end)

        feature("Close Hub", function(v)
            if v then
                resetLighting()
                resetParticles()
                GUI:Destroy()
            end
        end)
    end
end

--========================================================--
-- CREATE TABS
--========================================================--

for index, tabName in ipairs(Tabs) do
    local button = makeButton(Sidebar, tabName)

    button.Size = UDim2.new(1, 0, 0, 34)
    button.LayoutOrder = index
    button.TextSize = 9

    TabButtons[tabName] = button

    button.MouseButton1Click:Connect(function()
        buildTab(tabName)
    end)
end

--========================================================--
-- DRAG SYSTEM
--========================================================--

local dragging = false
local dragStart
local startPosition

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPosition = Main.Position

        tween(MainStroke, 0.15, {
            Thickness = 2.5,
            Color = CYAN
        })

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false

                tween(MainStroke, 0.15, {
                    Thickness = 1.5,
                    Color = BLUE
                })
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging then
        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then

            local delta = input.Position - dragStart

            Main.Position = UDim2.new(
                startPosition.X.Scale,
                startPosition.X.Offset + delta.X,
                startPosition.Y.Scale,
                startPosition.Y.Offset + delta.Y
            )
        end
    end
end)

--========================================================--
-- MINIMIZE
--========================================================--

local minimized = false

Minimize.MouseButton1Click:Connect(function()
    minimized = not minimized

    if minimized then
        Sidebar.Visible = false
        Content.Visible = false

        tween(Main, 0.2, {
            Size = UDim2.new(0, 230, 0, 38)
        })

        Minimize.Text = "+"
    else
        Sidebar.Visible = true
        Content.Visible = true

        tween(Main, 0.2, {
            Size = UDim2.new(0, WIDTH, 0, HEIGHT)
        })

        Minimize.Text = "—"
    end
end)

--========================================================--
-- CLOSE
--========================================================--

Close.MouseButton1Click:Connect(function()
    resetLighting()
    resetParticles()
    GUI:Destroy()
end)

--========================================================--
-- PREMIUM LOADING
--========================================================--

local function premiumLoading()
    local statuses = {
        "VERIFYING GRAPHICS MODULES...",
        "LOADING LIGHTING ENGINE...",
        "INITIALIZING VISUAL SYSTEM...",
        "PREPARING PREMIUM INTERFACE...",
        "CALIBRATING NEON EFFECTS...",
        "SYSTEM READY..."
    }

    for index, status in ipairs(statuses) do
        BootStatus.Text = status

        local percent = index / #statuses

        tween(BootFill, 0.35, {
            Size = UDim2.new(percent, 0, 1, 0)
        })

        BootPercent.Text = math.floor(percent * 100) .. "%"

        task.wait(0.38)
    end

    task.wait(0.3)

    Main.Visible = true
    Main.Size = UDim2.new(0, 0, 0, 0)
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)

    local reveal = tween(Main, 0.55, {
        Size = UDim2.new(0, WIDTH, 0, HEIGHT),
        Position = UDim2.new(0.5, -WIDTH / 2, 0.5, -HEIGHT / 2)
    }, Enum.EasingStyle.Back)

    reveal.Completed:Wait()

    tween(Boot, 0.35, {
        BackgroundTransparency = 1
    })

    for _, object in ipairs(Boot:GetDescendants()) do
        if object:IsA("TextLabel") then
            tween(object, 0.25, {
                TextTransparency = 1
            })
        elseif object:IsA("Frame") then
            tween(object, 0.25, {
                BackgroundTransparency = 1
            })
        end
    end

    task.wait(0.4)
    Boot:Destroy()
end

--========================================================--
-- KEY VERIFICATION
--========================================================--

local unlocked = false

local function verifyKey()
    if unlocked then
        return
    end

    if KeyInput.Text == ACCESS_KEY then
        unlocked = true

        KeyStatus.Text = "ACCESS GRANTED"
        KeyStatus.TextColor3 = Color3.fromRGB(70, 255, 170)

        Verify.Text = "ACCESS CONFIRMED"

        tween(KeyPanel, 0.3, {
            Size = UDim2.new(0, 0, 0, 0)
        }, Enum.EasingStyle.Back)

        task.wait(0.35)

        KeyPanel.Visible = false

        premiumLoading()
    else
        KeyStatus.Text = "INVALID ACCESS KEY"
        KeyStatus.TextColor3 = Color3.fromRGB(255, 85, 110)

        KeyInput.Text = ""

        tween(KeyPanel, 0.07, {
            Position = UDim2.new(0.5, -155, 0.5, 0)
        })

        task.wait(0.08)

        tween(KeyPanel, 0.07, {
            Position = UDim2.fromScale(0.5, 0.5)
        })
    end
end

Verify.MouseButton1Click:Connect(verifyKey)

KeyInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        verifyKey()
    end
end)

--========================================================--
-- INITIALIZE
--========================================================--

buildTab("Visuals")

task.spawn(function()
    tween(BootFill, 1.2, {
        Size = UDim2.new(0.45, 0, 1, 0)
    })

    task.wait(1.2)

    BootStatus.Text = "WAITING FOR PREMIUM AUTHENTICATION"

    tween(BootLogo, 0.4, {
        TextColor3 = PURPLE
    })

    task.wait(0.3)

    Boot:Destroy()

    KeyPanel.Visible = true
    KeyPanel.Size = UDim2.new(0, 0, 0, 0)

    tween(KeyPanel, 0.5, {
        Size = UDim2.new(0, 300, 0, 210)
    }, Enum.EasingStyle.Back)
end)

print("ZEPH GRAPHICS PREMIUM V2 - NEON EDITION LOADED")
