--[[
    FIFA Super Soccer Hub v3
    Tam GUI Menülü + Ayarlanabilir Keybindler
]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- ==================== AYARLAR ====================
local Config = {
    SpeedBoost = { Enabled = false, Multiplier = 3, Key = Enum.KeyCode.F1 },
    InfStamina = { Enabled = false, Key = Enum.KeyCode.F2 },
    ShotPower = { Enabled = false, Multiplier = 5, Key = Enum.KeyCode.F3 },
    AutoGoal = { Enabled = false, BallSpeed = 120, Key = Enum.KeyCode.F4 },
    FreezeOpps = { Enabled = false, AlsoAnchor = true, Key = Enum.KeyCode.F5 },
    TeleportBall = { Enabled = false, HeightOffset = 3, Key = Enum.KeyCode.F6 },
    ESP = { Enabled = false, Color = Color3.fromRGB(255, 50, 50), Key = Enum.KeyCode.F7 },
    SpeedBoost2 = { Enabled = false, Multiplier = 6, Key = Enum.KeyCode.F8 }
}

-- ==================== GUI OLUŞTURMA ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FIFA_Hub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Ana Çerçeve
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 460)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -230)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Gölge
local Shadow = Instance.new("ImageLabel")
Shadow.Size = UDim2.new(1, 10, 1, 10)
Shadow.Position = UDim2.new(0, -5, 0, -5)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://6014261993"
Shadow.ImageColor3 = Color3.new(0, 0, 0)
Shadow.ImageTransparency = 0.6
Shadow.Parent = MainFrame

-- Başlık Çubuğu
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 140, 60)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local UICorner_Title = Instance.new("UICorner")
UICorner_Title.CornerRadius = UDim.new(0, 8)
UICorner_Title.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -40, 1, 0)
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "⚽ FIFA Super Soccer Hub"
TitleLabel.TextColor3 = Color3.new(1, 1, 1)
TitleLabel.TextSize = 18
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

-- Kapatma Butonu
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = TitleBar

local UICorner_Close = Instance.new("UICorner")
UICorner_Close.CornerRadius = UDim.new(0, 6)
UICorner_Close.Parent = CloseBtn

-- Scroll Frame (içerik)
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, 0, 1, -50)
ScrollFrame.Position = UDim2.new(0, 0, 0, 45)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.BorderSizePixel = 0
ScrollFrame.ScrollBarThickness = 5
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(30, 140, 60)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.Parent = MainFrame

local UIGrid = Instance.new("UIGridLayout")
UIGrid.FillDirection = Enum.FillDirection.Vertical
UIGrid.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIGrid.VerticalAlignment = Enum.VerticalAlignment.Top
UIGrid.SortOrder = Enum.SortOrder.LayoutOrder
UIGrid.Padding = UDim.new(0, 6)
UIGrid.Parent = ScrollFrame

-- ==================== TOGGLE BUTONU OLUŞTURMA ====================
function createToggle(name, displayName, configRef)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(0, 295, 0, 50)
    row.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    row.BackgroundTransparency = 0.3
    row.BorderSizePixel = 0
    row.Parent = ScrollFrame
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = row
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 180, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = displayName
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextSize = 15
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = row
    
    -- key hint
    local keyName = tostring(configRef.Key):gsub("Enum.KeyCode.", "")
    local keyHint = Instance.new("TextLabel")
    keyHint.Size = UDim2.new(0, 40, 0, 20)
    keyHint.Position = UDim2.new(0, 185, 0, 15)
    keyHint.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    keyHint.Text = keyName
    keyHint.TextColor3 = Color3.fromRGB(180, 180, 200)
    keyHint.TextSize = 12
    keyHint.Font = Enum.Font.GothamBold
    keyHint.Parent = row
    
    local UICorner_Key = Instance.new("UICorner")
    UICorner_Key.CornerRadius = UDim.new(0, 4)
    UICorner_Key.Parent = keyHint
    
    -- Toggle butonu (daire)
    local ToggleBtn = Instance.new("Frame")
    ToggleBtn.Size = UDim2.new(0, 44, 0, 24)
    ToggleBtn.Position = UDim2.new(1, -54, 0, 13)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    ToggleBtn.BorderSizePixel = 0
    ToggleBtn.Parent = row
    
    local UICorner_Btn = Instance.new("UICorner")
    UICorner_Btn.CornerRadius = UDim.new(0, 12)
    UICorner_Btn.Parent = ToggleBtn
    
    local Circle = Instance.new("Frame")
    Circle.Size = UDim2.new(0, 18, 0, 18)
    Circle.Position = UDim2.new(0, 3, 0, 3)
    Circle.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
    Circle.BorderSizePixel = 0
    Circle.Parent = ToggleBtn
    
    local UICorner_Circle = Instance.new("UICorner")
    UICorner_Circle.CornerRadius = UDim.new(0, 9)
    UICorner_Circle.Parent = Circle
    
    -- Tıkla
    local Hitbox = Instance.new("TextButton")
    Hitbox.Size = UDim2.new(1, 0, 1, 0)
    Hitbox.BackgroundTransparency = 1
    Hitbox.Text = ""
    Hitbox.Parent = ToggleBtn
    
    local function updateToggleUI()
        if configRef.Enabled then
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 140, 60)
            Circle:TweenPosition(UDim2.new(0, 23, 0, 3), "Out", "Quad", 0.15, true)
            Circle.BackgroundColor3 = Color3.new(1, 1, 1)
        else
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
            Circle:TweenPosition(UDim2.new(0, 3, 0, 3), "Out", "Quad", 0.15, true)
            Circle.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
        end
    end
    
    Hitbox.MouseButton1Click:Connect(function()
        configRef.Enabled = not configRef.Enabled
        updateToggleUI()
        if not configRef.Enabled then
            if name == "FreezeOpps" then unFreeze() end
            if name == "ESP" then removeESP() end
        end
    end)
    
    return updateToggleUI
end

-- ==================== SLIDER ====================
function createSlider(name, displayName, configRef, field, min, max, step)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(0, 295, 0, 55)
    row.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    row.BackgroundTransparency = 0.3
    row.BorderSizePixel = 0
    row.Parent = ScrollFrame
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = row
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 180, 0, 20)
    label.Position = UDim2.new(0, 10, 0, 5)
    label.BackgroundTransparency = 1
    label.Text = displayName
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextSize = 14
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = row
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0, 50, 0, 20)
    valueLabel.Position = UDim2.new(1, -60, 0, 5)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(configRef[field])
    valueLabel.TextColor3 = Color3.fromRGB(30, 140, 60)
    valueLabel.TextSize = 14
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.Parent = row
    
    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(0, 275, 0, 6)
    sliderBg.Position = UDim2.new(0, 10, 0, 35)
    sliderBg.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    sliderBg.BorderSizePixel = 0
    sliderBg.Parent = row
    
    local UICorner_Slider = Instance.new("UICorner")
    UICorner_Slider.CornerRadius = UDim.new(0, 3)
    UICorner_Slider.Parent = sliderBg
    
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((configRef[field] - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(30, 140, 60)
    fill.BorderSizePixel = 0
    fill.Parent = sliderBg
    
    local UICorner_Fill = Instance.new("UICorner")
    UICorner_Fill.CornerRadius = UDim.new(0, 3)
    UICorner_Fill.Parent = fill
    
    local dragBtn = Instance.new("TextButton")
    dragBtn.Size = UDim2.new(1, 0, 4, 12)
    dragBtn.Position = UDim2.new(0, 0, 0, -3)
    dragBtn.BackgroundTransparency = 1
    dragBtn.Text = ""
    dragBtn.Parent = sliderBg
    
    local dragging = false
    dragBtn.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if not dragging then return end
        if input.UserInputType ~= Enum.UserInputType.MouseMovement then return end
        
        local mousePos = UserInputService:GetMouseLocation()
        local absPos = sliderBg.AbsolutePosition
        local absSize = sliderBg.AbsoluteSize
        local relX = math.clamp(mousePos.X - absPos.X, 0, absSize.X)
        local pct = relX / absSize.X
        local val = math.round((min + pct * (max - min)) / step) * step
        val = math.clamp(val, min, max)
        
        configRef[field] = val
        valueLabel.Text = tostring(val)
        fill.Size = UDim2.new(pct, 0, 1, 0)
    end)
end

-- ==================== CREATE COLOR PICKER ====================
function createColorPicker(name, displayName, configRef, field)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(0, 295, 0, 55)
    row.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    row.BackgroundTransparency = 0.3
    row.BorderSizePixel = 0
    row.Parent = ScrollFrame
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = row
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 200, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = displayName
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextSize = 14
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = row
    
    local colorBox = Instance.new("Frame")
    colorBox.Size = UDim2.new(0, 30, 0, 30)
    colorBox.Position = UDim2.new(1, -75, 0, 12)
    colorBox.BackgroundColor3 = configRef[field]
    colorBox.BorderSizePixel = 0
    colorBox.Parent = row
    
    local UICorner_Color = Instance.new("UICorner")
    UICorner_Color.CornerRadius = UDim.new(0, 6)
    UICorner_Color.Parent = colorBox
    
    -- renkleri döndür
    local colors = {
        Color3.fromRGB(255, 50, 50),
        Color3.fromRGB(50, 255, 50),
        Color3.fromRGB(50, 150, 255),
        Color3.fromRGB(255, 200, 0),
        Color3.fromRGB(255, 50, 255),
        Color3.fromRGB(255, 255, 255)
    }
    local colorIdx = 1
    
    local colorBtn = Instance.new("TextButton")
    colorBtn.Size = UDim2.new(1, 0, 1, 0)
    colorBtn.BackgroundTransparency = 1
    colorBtn.Text = ""
    colorBtn.Parent = colorBox
    
    colorBtn.MouseButton1Click:Connect(function()
        colorIdx = colorIdx % #colors + 1
        configRef[field] = colors[colorIdx]
        colorBox.BackgroundColor3 = configRef[field]
    end)
end

-- ==================== TOGGLE REF'LERİ ====================
local toggleRefs = {}
local toggleOrder = {
    "SpeedBoost", "SpeedBoost2", "InfStamina", "ShotPower",
    "AutoGoal", "FreezeOpps", "TeleportBall", "ESP"
}

local displayNames = {
    SpeedBoost = "Speed Boost",
    SpeedBoost2 = "Speed Boost (Turbo)",
    InfStamina = "Infinite Stamina",
    ShotPower = "Shot Power",
    AutoGoal = "Auto Goal",
    FreezeOpps = "Freeze Opponents",
    TeleportBall = "Teleport to Ball",
    ESP = "ESP"
}

for _, name in pairs(toggleOrder) do
    toggleRefs[name] = createToggle(name, displayNames[name], Config[name])
end

-- Ayırıcı
local spacer = Instance.new("Frame")
spacer.Size = UDim2.new(0, 295, 0, 10)
spacer.BackgroundTransparency = 1
spacer.Parent = ScrollFrame

-- Sliderlar
createSlider("speedMult", "Speed Multiplier", Config.SpeedBoost, "Multiplier", 1, 10, 0.5)
createSlider("speed2Mult", "Turbo Multiplier", Config.SpeedBoost2, "Multiplier", 1, 15, 0.5)
createSlider("shotMult", "Shot Power Multiplier", Config.ShotPower, "Multiplier", 1, 20, 0.5)
createSlider("ballSpeed", "Auto Goal Ball Speed", Config.AutoGoal, "BallSpeed", 30, 300, 5)
createSlider("heightOff", "Teleport Height", Config.TeleportBall, "HeightOffset", 0, 10, 0.5)

-- Renk seçici
createColorPicker("espColor", "ESP Color", Config.ESP, "Color")

-- Canvas boyutunu ayarla
local function updateCanvas()
    task.wait(0.1)
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, UIGrid.AbsoluteContentSize.Y + 20)
end
updateCanvas()

-- ==================== FONKSİYONLAR ====================
function unFreeze()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local hum = player.Character:FindFirstChild("Humanoid")
            if hum then
                hum.WalkSpeed = 16
                hum.JumpPower = 50
                hum.MaxHealth = 100
            end
            local root = player.Character:FindFirstChild("HumanoidRootPart")
            if root then root.Anchored = false end
        end
    end
end

function removeESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character then
            local root = player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local esp = root:FindFirstChild("ESP_Label")
                if esp then esp:Destroy() end
            end
        end
    end
end

-- ==================== LOOP'LAR ====================
RunService.RenderStepped:Connect(function()
    if not LocalPlayer.Character then return end
    local hum = LocalPlayer.Character:FindFirstChild("Humanoid")
    if not hum then return end
    
    -- Speed
    if Config.SpeedBoost.Enabled then
        hum.WalkSpeed = 16 * Config.SpeedBoost.Multiplier
    elseif Config.SpeedBoost2.Enabled then
        hum.WalkSpeed = 16 * Config.SpeedBoost2.Multiplier
    elseif not Config.FreezeOpps.Enabled then
        hum.WalkSpeed = 16
    end
    
    -- Stamina
    if Config.InfStamina.Enabled then
        local s = LocalPlayer.Character:FindFirstChild("Stamina")
        if s then s.Value = s.MaxValue or 100 end
        local e = LocalPlayer.Character:FindFirstChild("Energy")
        if e then e.Value = e.MaxValue or 100 end
    end
    
    -- Freeze
    if Config.FreezeOpps.Enabled then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local h = p.Character:FindFirstChild("Humanoid")
                if h then h.WalkSpeed = 0; h.JumpPower = 0 end
                if Config.FreezeOpps.AlsoAnchor then
                    local r = p.Character:FindFirstChild("HumanoidRootPart")
                    if r then r.Anchored = true end
                end
            end
        end
    end
    
    -- Teleport
    if Config.TeleportBall.Enabled and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local ball = Workspace:FindFirstChildWhichIsA("Part")
        if ball and ball.Name:lower():find("ball") then
            local root = LocalPlayer.Character.HumanoidRootPart
            root.CFrame = CFrame.new(ball.Position + Vector3.new(0, Config.TeleportBall.HeightOffset, 0))
        end
    end
    
    -- ESP
    if Config.ESP.Enabled then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local r = p.Character:FindFirstChild("HumanoidRootPart")
                if r and not r:FindFirstChild("ESP_Label") then
                    local bill = Instance.new("BillboardGui")
                    bill.Name = "ESP_Label"
                    bill.Size = UDim2.new(0, 200, 0, 50)
                    bill.AlwaysOnTop = true
                    bill.Enabled = true
                    local lbl = Instance.new("TextLabel")
                    lbl.Size = UDim2.new(1, 0, 1, 0)
                    lbl.BackgroundTransparency = 1
                    lbl.TextColor3 = Config.ESP.Color
                    lbl.TextStrokeTransparency = 0.3
                    lbl.Text = "[" .. p.Name .. "]"
                    lbl.TextScaled = true
                    lbl.Font = Enum.Font.GothamBold
                    lbl.Parent = bill
                    bill.Parent = r
                end
            end
        end
    else
        removeESP()
    end
end)

-- Auto Goal + Shot Power
Workspace.ChildAdded:Connect(function(child)
    if not (Config.AutoGoal.Enabled or Config.ShotPower.Enabled) then return end
    if not child:IsA("Part") or not child.Name:lower():find("ball") then return end
    
    child.Touched:Connect(function(hit)
        if not hit.Parent or hit.Parent ~= LocalPlayer.Character then return end
        
        if Config.AutoGoal.Enabled then
            local best, bestDist = nil, math.huge
            for _, v in pairs(Workspace:GetDescendants()) do
                if v:IsA("Part") and (v.Name:lower():find("goal") or v.Name:lower():find("kale")) then
                    local d = (v.Position - child.Position).Magnitude
                    if d < bestDist then bestDist = d; best = v end
                end
            end
            if best then
                child.Velocity = (best.Position - child.Position).Unit * Config.AutoGoal.BallSpeed
            end
        end
        
        if Config.ShotPower.Enabled and child.Velocity.Magnitude > 1 then
            child.Velocity = child.Velocity * Config.ShotPower.Multiplier
        end
    end)
end)

-- ==================== GLOBAL KEYBINDLER ====================
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    local key = input.KeyCode
    
    for name, cfg in pairs(Config) do
        if cfg.Key and key == cfg.Key then
            cfg.Enabled = not cfg.Enabled
            if toggleRefs[name] then toggleRefs[name]() end
            if not cfg.Enabled then
                if name == "FreezeOpps" then unFreeze() end
                if name == "ESP" then removeESP() end
            end
            break
        end
    end
    
    if key == Enum.KeyCode.F9 then
        print("=== STATUS ===")
        for n, c in pairs(Config) do
            print(n .. ": " .. tostring(c.Enabled))
        end
    end
    
    if key == Enum.KeyCode.F10 then
        for _, c in pairs(Config) do c.Enabled = false end
        for _, fn in pairs(toggleRefs) do fn() end
        unFreeze(); removeESP()
    end
end)

-- ==================== KAPATMA ====================
CloseBtn.MouseButton1Click:Connect(function()
    for _, c in pairs(Config) do c.Enabled = false end
    unFreeze(); removeESP()
    ScreenGui:Destroy()
end)

-- ==================== EKRANA EKLE ====================
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

print("✅ FIFA Super Soccer Hub v3 Yüklendi!")
print("GUI ekrana geldi, sürükleyip kullanabilirsin.")
print("F9 = Console durum | F10 = Hepsini kapat")
