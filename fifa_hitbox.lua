-- ===== FIFA HITBOX EXTENDER =====
-- Sadece hitbox büyütme + aç/kapa

local LP = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")

local enabled = false
local sizeMult = 2.5  -- istersen değiştir

UIS.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.F1 then
        enabled = not enabled
        if enabled then
            print("🟢 Hitbox EXTENDED (x" .. sizeMult .. ")")
        else
            print("🔴 Hitbox normal")
            resetHitbox()
        end
    end
end)

RS.RenderStepped:Connect(function()
    if not enabled then return end
    if not LP.Character then return end
    
    for _, part in pairs(LP.Character:GetChildren()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            part.Size = part.Size.Magnitude > 0 and Vector3.new(part.Size.X * 1.02 + 0.05, part.Size.Y * 1.02 + 0.05, part.Size.Z * 1.02 + 0.05) or part.Size
            part.CanCollide = false
        end
    end
    
    local root = LP.Character:FindFirstChild("HumanoidRootPart")
    if root then
        root.Size = Vector3.new(8, 8, 8)
        root.CanCollide = false
        root.Transparency = 0.8
    end
end)

function resetHitbox()
    if not LP.Character then return end
    for _, part in pairs(LP.Character:GetChildren()) do
        if part:IsA("BasePart") then
            part.Size = part:FindFirstChild("OriginalSize") and part.OriginalSize.Value or part.Size
        end
    end
end

print("✅ Hitbox Extender Yuklendi")
print("F1 = Ac/Kapat")
