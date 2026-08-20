local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Stats = game:GetService("Stats")

local function dec(bytes)
    local t = {}
    for _, b in ipairs(bytes) do
        table.insert(t, string.char(b))
    end
    return table.concat(t)
end

local encryptedKeys = {
    {79,83,84,82,65,45,57,88,50,77,45,52,76,56,75},
    {79,83,84,82,65,45,55,66,51,80,45,49,72,53,78},
    {79,83,84,82,65,45,53,68,56,87,45,57,90,50,88},
    {79,83,84,82,65,45,49,67,52,70,45,54,74,53,86},
    {79,83,84,82,65,45,56,82,56,84,45,50,75,57,89},
    {79,83,84,82,65,45,51,72,57,76,45,53,77,57,81},
    {79,83,84,82,65,45,54,78,50,86,45,56,80,49,87},
    {79,83,84,82,65,45,52,88,51,75,45,51,74,57,70},
    {79,83,84,82,65,45,57,90,56,89,45,49,84,57,72},
    {79,83,84,82,65,45,50,70,49,81,45,52,77,56,68}
}

local validKeys = {}
for _, v in ipairs(encryptedKeys) do
    validKeys[dec(v)] = true
end

if game:GetService("CoreGui"):FindFirstChild("Ostra19Hub") then
    game:GetService("CoreGui").Ostra19Hub:Destroy()
end

local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "Ostra19KeyGui"
KeyGui.Parent = game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui")
KeyGui.ResetOnSpawn = false

local KeyFrame = Instance.new("Frame", KeyGui)
KeyFrame.Size = UDim2.new(0, 300, 0, 180)
KeyFrame.Position = UDim2.new(0.5, -150, 0.5, -90)
KeyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
KeyFrame.Active = true
KeyFrame.Draggable = true
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 8)

local KeyTitle = Instance.new("TextLabel", KeyFrame)
KeyTitle.Size = UDim2.new(1, 0, 0, 40)
KeyTitle.Text = "Ostra 1.9 - Secure Login"
KeyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Font = Enum.Font.SourceSansBold
KeyTitle.TextSize = 18

local KeyBox = Instance.new("TextBox", KeyFrame)
KeyBox.Size = UDim2.new(0.85, 0, 0, 35)
KeyBox.Position = UDim2.new(0.075, 0, 0.35, 0)
KeyBox.PlaceholderText = "Paste your key here..."
KeyBox.Text = ""
KeyBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0, 4)

local StatusLabel = Instance.new("TextLabel", KeyFrame)
StatusLabel.Size = UDim2.new(1, 0, 0, 20)
StatusLabel.Position = UDim2.new(0, 0, 0.62, 0)
StatusLabel.Text = ""
StatusLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextSize = 14

local SubmitBtn = Instance.new("TextButton", KeyFrame)
SubmitBtn.Size = UDim2.new(0.85, 0, 0, 32)
SubmitBtn.Position = UDim2.new(0.075, 0, 0.75, 0)
SubmitBtn.Text = "Verify Key"
SubmitBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", SubmitBtn).CornerRadius = UDim.new(0, 4)

local function StartMainHub()
    KeyGui:Destroy()

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "Ostra19Hub"
    ScreenGui.Parent = game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.ResetOnSpawn = false

    local CrosshairFrame = Instance.new("Frame", ScreenGui)
    CrosshairFrame.Name = "Crosshair"
    CrosshairFrame.Size = UDim2.new(0, 16, 0, 16)
    CrosshairFrame.Position = UDim2.new(0.5, -8, 0.5, -8)
    CrosshairFrame.BackgroundTransparency = 1
    CrosshairFrame.Visible = false

    local HorizontalLine = Instance.new("Frame", CrosshairFrame)
    HorizontalLine.Size = UDim2.new(1, 0, 0, 2)
    HorizontalLine.Position = UDim2.new(0, 0, 0.5, -1)
    HorizontalLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    HorizontalLine.BorderSizePixel = 0

    local VerticalLine = Instance.new("Frame", CrosshairFrame)
    VerticalLine.Size = UDim2.new(0, 2, 1, 0)
    VerticalLine.Position = UDim2.new(0.5, -1, 0, 0)
    VerticalLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    VerticalLine.BorderSizePixel = 0

    local function CreateMiniBtn(name, pos, color, text)
        local btn = Instance.new("TextButton", ScreenGui)
        btn.Name = name
        btn.Size = UDim2.new(0, 50, 0, 50)
        btn.Position = pos
        btn.BackgroundColor3 = color
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.SourceSansBold
        btn.Active = true
        btn.Draggable = true
        btn.Visible = false
        Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
        return btn
    end

    local FlyToggleBtn = CreateMiniBtn("FlyQuickToggle", UDim2.new(0.02, 0, 0.32, 0), Color3.fromRGB(200, 50, 50), "FLY")
    local ShiftLockToggleBtn = CreateMiniBtn("ShiftLockQuickToggle", UDim2.new(0.02, 0, 0.45, 0), Color3.fromRGB(200, 200, 50), "LOCK")

    local ToggleBtn = Instance.new("ImageButton", ScreenGui)
    ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
    ToggleBtn.Position = UDim2.new(0.02, 0, 0.2, 0)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    ToggleBtn.Active = true
    ToggleBtn.Draggable = true
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 10)

    pcall(function()
        ToggleBtn.Image = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
    end)

    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 420, 0, 360)
    MainFrame.Position = UDim2.new(0.5, -210, 0.4, -180)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Visible = false
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

    ToggleBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)

    local TopBar = Instance.new("Frame", MainFrame)
    TopBar.Size = UDim2.new(1, 0, 0, 30)
    TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 8)

    local Title = Instance.new("TextLabel", TopBar)
    Title.Text = "  Ostra 1.9"
    Title.Size = UDim2.new(0.5, 0, 1, 0)
    Title.BackgroundTransparency = 1
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local WinButtonsFrame = Instance.new("Frame", TopBar)
    WinButtonsFrame.Size = UDim2.new(0, 100, 1, 0)
    WinButtonsFrame.Position = UDim2.new(1, -100, 0, 0)
    WinButtonsFrame.BackgroundTransparency = 1
    Instance.new("UIListLayout", WinButtonsFrame).FillDirection = Enum.FillDirection.Horizontal

    local isLocked = false
    local function CreateWinBtn(text, callback)
        local btn = Instance.new("TextButton", WinButtonsFrame)
        btn.Size = UDim2.new(0, 30, 1, 0)
        btn.Text = text
        btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.BorderSizePixel = 0
        btn.MouseButton1Click:Connect(callback)
        return btn
    end

    CreateWinBtn("L", function() isLocked = not isLocked; MainFrame.Draggable = not isLocked end)
    CreateWinBtn("_", function() MainFrame.Visible = false end)
    CreateWinBtn("X", function() ScreenGui:Destroy() end)

    local TabSidebar = Instance.new("Frame", MainFrame)
    TabSidebar.Size = UDim2.new(0, 110, 1, -30)
    TabSidebar.Position = UDim2.new(0, 0, 0, 30)
    TabSidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    Instance.new("UIListLayout", TabSidebar)

    local ContentArea = Instance.new("Frame", MainFrame)
    ContentArea.Size = UDim2.new(1, -115, 1, -35)
    ContentArea.Position = UDim2.new(0, 112, 0, 32)
    ContentArea.BackgroundTransparency = 1

    local tabs = {}
    local function CreateTab(name)
        local page = Instance.new("ScrollingFrame", ContentArea)
        page.Size = UDim2.new(1, 0, 1, 0)
        page.BackgroundTransparency = 1
        page.ScrollBarThickness = 4
        page.Visible = false
        Instance.new("UIListLayout", page).Padding = UDim.new(0, 5)

        local tabBtn = Instance.new("TextButton", TabSidebar)
        tabBtn.Size = UDim2.new(1, 0, 0, 35)
        tabBtn.Text = name
        tabBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        tabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        tabBtn.BorderSizePixel = 0
        
        tabBtn.MouseButton1Click:Connect(function()
            for _, t in pairs(tabs) do
                t.Page.Visible = false
                t.Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            end
            page.Visible = true
            tabBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        end)

        tabs[name] = {Page = page, Btn = tabBtn}
        return page
    end

    local MainTab = CreateTab("Main")
    local InfoTab = CreateTab("Info")
    local SpecTab = CreateTab("Spectator")
    local SettingsTab = CreateTab("Settings")
    local DevTab = CreateTab("Developer")

    tabs["Main"].Page.Visible = true
    tabs["Main"].Btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)

    local function CreateUIBtn(parent, text, callback)
        local btn = Instance.new("TextButton", parent)
        btn.Size = UDim2.new(0.95, 0, 0, 32)
        btn.Text = text
        btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
        btn.MouseButton1Click:Connect(callback)
        return btn
    end

    local function CreateInputBox(parent, placeholder, callback)
        local box = Instance.new("TextBox", parent)
        box.Size = UDim2.new(0.95, 0, 0, 30)
        box.PlaceholderText = placeholder
        box.Text = ""
        box.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        box.TextColor3 = Color3.fromRGB(255, 255, 255)
        Instance.new("UICorner", box).CornerRadius = UDim.new(0, 4)
        box.FocusLost:Connect(function() callback(box.Text) end)
        return box
    end

    local isFlying, isESP, isNoclip, isShiftLock = false, false, false, false
    local isSpeedEnabled, isStdJumpEnabled, isInfJumpEnabled = false, false, false
    local flySpeed, walkSpeed, jumpPower = 50, 50, 100
    local espColor = Color3.fromRGB(0, 150, 255)
    local bv, bg
    local selectedPlayer = nil

    CreateUIBtn(MainTab, "Toggle Fly Icon", function() FlyToggleBtn.Visible = not FlyToggleBtn.Visible end)
    CreateUIBtn(MainTab, "Toggle Shift Lock Icon", function() ShiftLockToggleBtn.Visible = not ShiftLockToggleBtn.Visible end)
    CreateInputBox(MainTab, "Fly Speed (50)", function(text) flySpeed = tonumber(text) or 50 end)

    local NoclipBtn = CreateUIBtn(MainTab, "Noclip: OFF", function() end)
    NoclipBtn.MouseButton1Click:Connect(function()
        isNoclip = not isNoclip
        NoclipBtn.Text = "Noclip: " .. (isNoclip and "ON" or "OFF")
        NoclipBtn.BackgroundColor3 = isNoclip and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(40, 40, 40)
    end)

    local SpeedBtn = CreateUIBtn(MainTab, "Speed: OFF", function() end)
    SpeedBtn.MouseButton1Click:Connect(function()
        isSpeedEnabled = not isSpeedEnabled
        SpeedBtn.Text = "Speed: " .. (isSpeedEnabled and "ON" or "OFF")
        SpeedBtn.BackgroundColor3 = isSpeedEnabled and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(40, 40, 40)
        if not isSpeedEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end)

    CreateInputBox(MainTab, "WalkSpeed (50)", function(text) walkSpeed = tonumber(text) or 50 end)

    local StdJumpBtn = CreateUIBtn(MainTab, "Jump (Std): OFF", function() end)
    StdJumpBtn.MouseButton1Click:Connect(function()
        isStdJumpEnabled = not isStdJumpEnabled
        StdJumpBtn.Text = "Jump (Std): " .. (isStdJumpEnabled and "ON" or "OFF")
        StdJumpBtn.BackgroundColor3 = isStdJumpEnabled and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(40, 40, 40)
    end)

    CreateInputBox(MainTab, "JumpPower (100)", function(text) jumpPower = tonumber(text) or 100 end)

    local InfJumpBtn = CreateUIBtn(MainTab, "Inf Jump: OFF", function() end)
    InfJumpBtn.MouseButton1Click:Connect(function()
        isInfJumpEnabled = not isInfJumpEnabled
        InfJumpBtn.Text = "Inf Jump: " .. (isInfJumpEnabled and "ON" or "OFF")
        InfJumpBtn.BackgroundColor3 = isInfJumpEnabled and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(40, 40, 40)
    end)

    local ShiftLockMainBtn = CreateUIBtn(SettingsTab, "Shift Lock: OFF", function() end)
    ShiftLockMainBtn.MouseButton1Click:Connect(function()
        isShiftLock = not isShiftLock
        ShiftLockMainBtn.Text = "Shift Lock: " .. (isShiftLock and "ON" or "OFF")
        ShiftLockMainBtn.BackgroundColor3 = isShiftLock and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(40, 40, 40)
        ShiftLockToggleBtn.Visible = isShiftLock
        CrosshairFrame.Visible = isShiftLock
        LocalPlayer.DevEnableMouseLock = true
    end)

    local function CreateInfoLabel(text)
        local lbl = Instance.new("TextLabel", InfoTab)
        lbl.Size = UDim2.new(0.95, 0, 0, 32)
        lbl.Text = text
        lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
        lbl.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        Instance.new("UICorner", lbl).CornerRadius = UDim.new(0, 4)
        return lbl
    end

    local timeLbl = CreateInfoLabel("Server Uptime: 00m:00s")
    local playersLbl = CreateInfoLabel("Players: " .. #Players:GetPlayers() .. "/" .. Players.MaxPlayers)
    local pingLbl = CreateInfoLabel("Ping: ... ms")

    task.spawn(function()
        while task.wait(1) do
            if ScreenGui and ScreenGui.Parent then
                local uptime = math.floor(workspace.DistributedGameTime)
                timeLbl.Text = string.format("Server Uptime: %02dm:%02ds", math.floor(uptime / 60), math.floor(uptime % 60))
                playersLbl.Text = "Players: " .. #Players:GetPlayers() .. "/" .. Players.MaxPlayers
                pcall(function()
                    pingLbl.Text = "Ping: " .. math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue()) .. " ms"
                end)
            end
        end
    end)

    local SelectedLabel = Instance.new("TextLabel", SpecTab)
    SelectedLabel.Size = UDim2.new(0.95, 0, 0, 25)
    SelectedLabel.Text = "Selected: None"
    SelectedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    SelectedLabel.BackgroundTransparency = 1

    CreateUIBtn(SpecTab, "Spectate", function()
        if selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("Humanoid") then
            workspace.CurrentCamera.CameraSubject = selectedPlayer.Character.Humanoid
        end
    end)

    CreateUIBtn(SpecTab, "Unspectate", function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            workspace.CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid
        end
    end)

    CreateUIBtn(SpecTab, "Teleport To Player", function()
        if selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = selectedPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
            end
        end
    end)

    local PlayerListFrame = Instance.new("ScrollingFrame", SpecTab)
    PlayerListFrame.Size = UDim2.new(0.95, 0, 0, 150)
    PlayerListFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    PlayerListFrame.ScrollBarThickness = 4
    Instance.new("UICorner", PlayerListFrame).CornerRadius = UDim.new(0, 4)
    local PlrListLayout = Instance.new("UIListLayout", PlayerListFrame)

    local function UpdatePlayerList()
        for _, item in pairs(PlayerListFrame:GetChildren()) do
            if item:IsA("TextButton") then item:Destroy() end
        end
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                local pBtn = Instance.new("TextButton", PlayerListFrame)
                pBtn.Size = UDim2.new(1, 0, 0, 28)
                pBtn.Text = p.DisplayName .. " (@" .. p.Name .. ")"
                pBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                pBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                pBtn.MouseButton1Click:Connect(function()
                    selectedPlayer = p
                    SelectedLabel.Text = "Selected: " .. p.DisplayName
                end)
            end
        end
    end
    Players.PlayerAdded:Connect(UpdatePlayerList)
    Players.PlayerRemoving:Connect(UpdatePlayerList)
    UpdatePlayerList()

    local EspToggleBtn = CreateUIBtn(SettingsTab, "ESP: OFF", function() end)
    EspToggleBtn.MouseButton1Click:Connect(function()
        isESP = not isESP
        EspToggleBtn.Text = "ESP: " .. (isESP and "ON" or "OFF")
        EspToggleBtn.BackgroundColor3 = isESP and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(40, 40, 40)
    end)

    local ColorHeader = Instance.new("TextLabel", SettingsTab)
    ColorHeader.Size = UDim2.new(0.95, 0, 0, 25)
    ColorHeader.Text = "ESP Color:"
    ColorHeader.TextColor3 = Color3.fromRGB(200, 200, 200)
    ColorHeader.BackgroundTransparency = 1

    local colors = {
        {"Cyan / Blue", Color3.fromRGB(0, 150, 255)},
        {"Red", Color3.fromRGB(255, 50, 50)},
        {"Green", Color3.fromRGB(50, 255, 50)},
        {"Yellow", Color3.fromRGB(255, 255, 50)},
        {"Purple", Color3.fromRGB(180, 50, 255)}
    }

    for _, c in ipairs(colors) do
        local cBtn = CreateUIBtn(SettingsTab, c[1], function()
            espColor = c[2]
        end)
        cBtn.BackgroundColor3 = c[2]
        cBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    end

    CreateUIBtn(DevTab, "@ocyzhdalkin (Copy)", function() pcall(function() setclipboard("@ocyzhdalkin") end) end)

    FlyToggleBtn.MouseButton1Click:Connect(function()
        isFlying = not isFlying
        FlyToggleBtn.BackgroundColor3 = isFlying and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
    end)

    ShiftLockToggleBtn.MouseButton1Click:Connect(function()
        isShiftLock = not isShiftLock
        ShiftLockMainBtn.Text = "Shift Lock: " .. (isShiftLock and "ON" or "OFF")
        ShiftLockMainBtn.BackgroundColor3 = isShiftLock and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(40, 40, 40)
        ShiftLockToggleBtn.BackgroundColor3 = isShiftLock and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
        CrosshairFrame.Visible = isShiftLock
        UserInputService.MouseBehavior = isShiftLock and Enum.MouseBehavior.LockCenter or Enum.MouseBehavior.Default
    end)

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.Space and isInfJumpEnabled and not isFlying then
            local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
            if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
        end
    end)

    RunService.RenderStepped:Connect(function()
        local char = LocalPlayer.Character
        if not char then return end
        local hum = char:FindFirstChild("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")

        if isNoclip then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end

        if isShiftLock and hrp then
            local cam = workspace.CurrentCamera
            local lookVec = cam.CFrame.LookVector
            local targetDir = Vector3.new(lookVec.X, 0, lookVec.Z)
            if targetDir.Magnitude > 0 then hrp.CFrame = CFrame.new(hrp.Position, hrp.Position + targetDir) end
            if hum then hum.AutoRotate = false end
            UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
        elseif hum then
            hum.AutoRotate = true
        end

        if hum then
            if isSpeedEnabled then hum.WalkSpeed = walkSpeed end
            if isStdJumpEnabled then
                hum.UseJumpPower = true
                hum.JumpPower = jumpPower
                hum.JumpHeight = jumpPower / 3
            end
        end

        -- НОВАЯ ЛОГИКА ПОЛЕТА ДЛЯ МОБИЛОК И ПК
        if isFlying and hrp then
            local cam = workspace.CurrentCamera
            if not bv then bv = Instance.new("BodyVelocity", hrp); bv.MaxForce = Vector3.new(1e5, 1e5, 1e5) end
            if not bg then bg = Instance.new("BodyGyro", hrp); bg.MaxTorque = Vector3.new(1e5, 1e5, 1e5) end
            
            if hum then
                hum.PlatformStand = true -- Отключаем физику ходьбы, чтобы не дрыгался
                local moveDir = hum.MoveDirection
                
                if moveDir.Magnitude > 0 then
                    -- Переводим направление джойстика в направление относительно камеры
                    local flatForward = Vector3.new(cam.CFrame.LookVector.X, 0, cam.CFrame.LookVector.Z).Unit
                    local flatRight = Vector3.new(cam.CFrame.RightVector.X, 0, cam.CFrame.RightVector.Z).Unit
                    
                    local yInput = flatForward:Dot(moveDir)
                    local xInput = flatRight:Dot(moveDir)
                    
                    local flyDir = (cam.CFrame.LookVector * yInput) + (cam.CFrame.RightVector * xInput)
                    
                    if flyDir.Magnitude > 0 then
                        bv.Velocity = flyDir.Unit * flySpeed
                    else
                        bv.Velocity = Vector3.new(0, 0, 0)
                    end
                else
                    bv.Velocity = Vector3.new(0, 0, 0) -- Мертвая остановка, когда джойстик отпущен
                end
            end
            bg.CFrame = cam.CFrame
        elseif bv then
            bv:Destroy(); bv = nil
            bg:Destroy(); bg = nil
            if hum then hum.PlatformStand = false end -- Включаем физику обратно
        end
        -- КОНЕЦ НОВОЙ ЛОГИКИ

        if isESP then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    local hl = p.Character:FindFirstChild("OstraHighlight")
                    if not hl then
                        hl = Instance.new("Highlight", p.Character)
                        hl.Name = "OstraHighlight"
                    end
                    hl.FillColor = espColor
                end
            end
        else
            for _, p in pairs(Players:GetPlayers()) do
                if p.Character and p.Character:FindFirstChild("OstraHighlight") then
                    p.Character.OstraHighlight:Destroy()
                end
            end
        end
    end)
end

SubmitBtn.MouseButton1Click:Connect(function()
    local enteredKey = KeyBox.Text
    if validKeys[enteredKey] then
        StatusLabel.TextColor3 = Color3.fromRGB(50, 255, 50)
        StatusLabel.Text = "Success! Loading..."
        task.wait(0.5)
        StartMainHub()
    else
        StatusLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
        StatusLabel.Text = "Invalid Key!"
    end
end)
