-- ===== FIFA SUPER SOCCER HUB LITE (GUI YOK) =====
-- Çalışırsa, GUI'li sürüme geçeriz

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local WS = game:GetService("Workspace")
local LP = Players.LocalPlayer

local toggles = {
    speed = false, speed2 = false, stamina = false,
    shot = false, autogoal = false, freeze = false,
    teleport = false, esp = false
}

local mult = { speed = 3, speed2 = 6, shot = 5, goalSpeed = 120, heightOff = 3 }

print("=== FIFA HUB LITE YUKLENDI ===")
print("F1=Speed | F2=Stamina | F3=Shot | F4=Goal")
print("F5=Freeze | F6=Teleport | F7=ESP | F8=Turbo")

UIS.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.F1 then
        toggles.speed = not toggles.speed
        print("Speed Boost: " .. tostring(toggles.speed))
    elseif input.KeyCode == Enum.KeyCode.F8 then
        toggles.speed2 = not toggles.speed2
        print("Turbo Speed: " .. tostring(toggles.speed2))
    elseif input.KeyCode == Enum.KeyCode.F2 then
        toggles.stamina = not toggles.stamina
        print("Inf Stamina: " .. tostring(toggles.stamina))
    elseif input.KeyCode == Enum.KeyCode.F3 then
        toggles.shot = not toggles.shot
        print("Shot Power: " .. tostring(toggles.shot))
    elseif input.KeyCode == Enum.KeyCode.F4 then
        toggles.autogoal = not toggles.autogoal
        print("Auto Goal: " .. tostring(toggles.autogoal))
    elseif input.KeyCode == Enum.KeyCode.F5 then
        toggles.freeze = not toggles.freeze
        print("Freeze: " .. tostring(toggles.freeze))
    elseif input.KeyCode == Enum.KeyCode.F6 then
        toggles.teleport = not toggles.teleport
        print("Teleport: " .. tostring(toggles.teleport))
    elseif input.KeyCode == Enum.KeyCode.F7 then
        toggles.esp = not toggles.esp
        print("ESP: " .. tostring(toggles.esp))
        if not toggles.esp then removeESP() end
    elseif input.KeyCode == Enum.KeyCode.F9 then
        print("=== STATUS ===")
        for k, v in pairs(toggles) do print(k .. ": " .. tostring(v)) end
    elseif input.KeyCode == Enum.KeyCode.F10 then
        for k, _ in pairs(toggles) do toggles[k] = false end
        unFreezeAll()
        removeESP()
        print("HERSEY KAPATILDI")
    end
end)

RS.RenderStepped:Connect(function()
    if not LP.Character then return end
    local hum = LP.Character:FindFirstChild("Humanoid")
    if not hum then return end
    
    if toggles.speed then
        hum.WalkSpeed = 16 * mult.speed
    elseif toggles.speed2 then
        hum.WalkSpeed = 16 * mult.speed2
    elseif not toggles.freeze then
        hum.WalkSpeed = 16
        hum.JumpPower = 50
    end

    if toggles.stamina and LP.Character then
        local s = LP.Character:FindFirstChild("Stamina")
        if s then s.Value = s.MaxValue or 100 end
        local e = LP.Character:FindFirstChild("Energy")
        if e then e.Value = e.MaxValue or 100 end
    end

    if toggles.freeze then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character then
                local h = p.Character:FindFirstChild("Humanoid")
                if h then h.WalkSpeed = 0; h.JumpPower = 0 end
                local r = p.Character:FindFirstChild("HumanoidRootPart")
                if r then r.Anchored = true end
            end
        end
    end

    if toggles.teleport and LP.Character then
        local root = LP.Character:FindFirstChild("HumanoidRootPart")
        if root then
            local ball = WS:FindFirstChildWhichIsA("Part")
            if ball and ball.Name:lower():find("ball") then
                root.CFrame = CFrame.new(ball.Position + Vector3.new(0, mult.heightOff, 0))
            end
        end
    end

    if toggles.esp then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character then
                local r = p.Character:FindFirstChild("HumanoidRootPart")
                if r and not r:FindFirstChild("ESP_Label") then
                    local bill = Instance.new("BillboardGui")
                    bill.Name = "ESP_Label"
                    bill.Size = UDim2.new(0, 200, 0, 50)
                    bill.AlwaysOnTop = true
                    local lbl = Instance.new("TextLabel")
                    lbl.Size = UDim2.new(1, 0, 1, 0)
                    lbl.BackgroundTransparency = 1
                    lbl.Text = "[" .. p.Name .. "]"
                    lbl.TextColor3 = Color3.fromRGB(255, 50, 50)
                    lbl.TextScaled = true
                    lbl.Font = Enum.Font.GothamBold
                    lbl.Parent = bill
                    bill.Parent = r
                end
            end
        end
    end
end)

WS.ChildAdded:Connect(function(child)
    if not (toggles.autogoal or toggles.shot) then return end
    if not child:IsA("Part") then return end
    if not child.Name:lower():find("ball") then return end
    
    child.Touched:Connect(function(hit)
        if not hit.Parent or hit.Parent ~= LP.Character then return end
        
        if toggles.autogoal then
            local best, bestD = nil, math.huge
            for _, v in pairs(WS:GetDescendants()) do
                if v:IsA("Part") and (v.Name:lower():find("goal") or v.Name:lower():find("kale")) then
                    local d = (v.Position - child.Position).Magnitude
                    if d < bestD then bestD = d; best = v end
                end
            end
            if best then
                child.Velocity = (best.Position - child.Position).Unit * mult.goalSpeed
            end
        end
        
        if toggles.shot and child.Velocity.Magnitude > 1 then
            child.Velocity = child.Velocity * mult.shot
        end
    end)
end)

function unFreezeAll()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            local h = p.Character:FindFirstChild("Humanoid")
            if h then h.WalkSpeed = 16; h.JumpPower = 50 end
            local r = p.Character:FindFirstChild("HumanoidRootPart")
            if r then r.Anchored = false end
        end
    end
end

function removeESP()
    for _, p in pairs(Players:GetPlayers()) do
        if p.Character then
            local r = p.Character:FindFirstChild("HumanoidRootPart")
            if r then
                local e = r:FindFirstChild("ESP_Label")
                if e then e:Destroy() end
            end
        end
    end
end
