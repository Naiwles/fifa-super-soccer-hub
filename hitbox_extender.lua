-- Universal Hitbox Extender (Self-Contained, No External Dependencies)
-- Her oyunda calisir. F1 ile ac/kapa.

local LP = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local SG = Instance.new("ScreenGui")
SG.Name = "HitboxHub"
SG.ResetOnSpawn = false
SG.Parent = LP:WaitForChild("PlayerGui")

-- Ana Pencere
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 220, 0, 140)
Main.Position = UDim2.new(0.5, -110, 0.5, -70)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = SG

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(30, 140, 60)
Title.Text = "⚡ Hitbox Extender"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.Parent = Main

-- Durum yazisi
local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, 0, 0, 30)
Status.Position = UDim2.new(0, 0, 0, 35)
Status.BackgroundTransparency = 1
Status.Text = "🔴 KAPALI  |  F1 = Ac/Kapat"
Status.TextColor3 = Color3.fromRGB(200, 200, 200)
Status.TextSize = 13
Status.Font = Enum.Font.Gotham
Status.Parent = Main

-- Boyut slider
local SizeLabel = Instance.new("TextLabel")
SizeLabel.Size = UDim2.new(0, 80, 0, 25)
SizeLabel.Position = UDim2.new(0, 10, 0, 70)
SizeLabel.BackgroundTransparency = 1
SizeLabel.Text = "Boyut: 2.0x"
SizeLabel.TextColor3 = Color3.new(1, 1, 1)
SizeLabel.TextSize = 13
SizeLabel.Font = Enum.Font.Gotham
SizeLabel.TextXAlignment = Enum.TextXAlignment.Left
SizeLabel.Parent = Main

local SliderBg = Instance.new("Frame")
SliderBg.Size = UDim2.new(0, 120, 0, 6)
SliderBg.Position = UDim2.new(0, 90, 0, 82)
SliderBg.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
SliderBg.BorderSizePixel = 0
SliderBg.Parent = Main

local SliderFill = Instance.new("Frame")
SliderFill.Size = UDim2.new(0.25, 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(30, 140, 60)
SliderFill.BorderSizePixel = 0
SliderFill.Parent = SliderBg

local enabled = false
local sizeMult = 2.0

-- Slider kontrol
local dragging = false
local SliderBtn = Instance.new("TextButton")
SliderBtn.Size = UDim2.new(1, 0, 2, 10)
SliderBtn.Position = UDim2.new(0, 0, 0, -3)
SliderBtn.BackgroundTransparency = 1
SliderBtn.Text = ""
SliderBtn.Parent = SliderBg

SliderBtn.MouseButton1Down:Connect(function() dragging = true end)
UIS.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)
UIS.InputChanged:Connect(function(i)
    if not dragging or i.UserInputType ~= Enum.UserInputType.MouseMovement then return end
    local mx = UIS:GetMouseLocation()
    local ax, sx = SliderBg.AbsolutePosition.X, SliderBg.AbsoluteSize.X
    local rx = math.clamp((mx.X - ax) / sx, 0, 1)
    sizeMult = math.floor((1 + rx * 9) * 10) / 10
    SliderFill.Size = UDim2.new(rx, 0, 1, 0)
    SizeLabel.Text = "Boyut: " .. sizeMult .. "x"
end)

-- Ana loop
RS.RenderStepped:Connect(function()
    if not enabled or not LP.Character then return end
    
    local root = LP.Character:FindFirstChild("HumanoidRootPart")
    if root then
        root.Size = Vector3.new(sizeMult * 2, sizeMult * 2, sizeMult * 2)
        root.Transparency = 0.7
        root.CanCollide = false
    end
    
    for _, p in pairs(LP.Character:GetChildren()) do
        if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
            local orig = p.Size
            p.Size = Vector3.new(orig.X * 1.01 + 0.02, orig.Y * 1.01 + 0.02, orig.Z * 1.01 + 0.02)
            p.CanCollide = false
        end
    end
end)

-- Reset fonksiyonu
function resetChar()
    if not LP.Character then return end
    for _, p in pairs(LP.Character:GetChildren()) do
        if p:IsA("BasePart") then
            p.CanCollide = true
        end
    end
    local root = LP.Character:FindFirstChild("HumanoidRootPart")
    if root then
        root.Size = Vector3.new(2, 2, 1)
        root.Transparency = 1
    end
end

-- F1 toggle
UIS.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.F1 then
        enabled = not enabled
        if enabled then
            Status.Text = "🟢 ACIK  |  F1 = Ac/Kapat"
            Status.TextColor3 = Color3.fromRGB(30, 230, 60)
        else
            Status.Text = "🔴 KAPALI  |  F1 = Ac/Kapat"
            Status.TextColor3 = Color3.fromRGB(200, 200, 200)
            resetChar()
        end
    end
end)

print("✅ Hitbox Extender Yuklendi")
print("F1 = Ac/Kapat | Pencereyi surukleyebilirsin")
