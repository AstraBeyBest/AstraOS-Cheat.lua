--[================================================================]--
--  AstraOS FPS Game Cheat - Ultimate Edition By AstraBey (Mobile Optimized & Notified)
--[================================================================]--

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

--------------------------------------------------------------------------------
-- MODERN STATUS NOTIFICATION SYSTEM (YENİ EKLENEN BİLDİRİM SİSTEMİ)
--------------------------------------------------------------------------------
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AstraOS_Suite_Pro"
ScreenGui.ResetOnSpawn = false
pcall(function()
    ScreenGui.Parent = CoreGui
end)
if not ScreenGui.Parent then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

local ActionNotificationHolder = Instance.new("Frame")
ActionNotificationHolder.Name = "ActionNotificationHolder"
ActionNotificationHolder.Size = UDim2.new(0, 300, 0, 400)
ActionNotificationHolder.Position = UDim2.new(1, -315, 1, -415)
ActionNotificationHolder.BackgroundTransparency = 1
ActionNotificationHolder.Parent = ScreenGui

local ActionNotifLayout = Instance.new("UIListLayout")
ActionNotifLayout.SortOrder = Enum.SortOrder.LayoutOrder
ActionNotifLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
ActionNotifLayout.Padding = UDim.new(0, 8)
ActionNotifLayout.Parent = ActionNotificationHolder

local function showActionNotification(featureName, state)
    task.spawn(function()
        local NotifCard = Instance.new("Frame")
        NotifCard.Size = UDim2.new(1, 0, 0, 50)
        NotifCard.BackgroundColor3 = Color3.fromRGB(15, 16, 24)
        NotifCard.BackgroundTransparency = 1
        NotifCard.BorderSizePixel = 0
        NotifCard.Parent = ActionNotificationHolder

        local CardCorner = Instance.new("UICorner")
        CardCorner.CornerRadius = UDim.new(0, 10)
        CardCorner.Parent = NotifCard

        local CardStroke = Instance.new("UIStroke")
        CardStroke.Color = state and Color3.fromRGB(90, 255, 150) or Color3.fromRGB(255, 90, 90)
        CardStroke.Transparency = 1
        CardStroke.Thickness = 1.5
        CardStroke.Parent = NotifCard

        local AccentBar = Instance.new("Frame")
        AccentBar.Size = UDim2.new(0, 4, 1, -12)
        AccentBar.Position = UDim2.new(0, 6, 0, 6)
        AccentBar.BackgroundColor3 = state and Color3.fromRGB(90, 255, 150) or Color3.fromRGB(255, 90, 90)
        AccentBar.BackgroundTransparency = 1
        AccentBar.BorderSizePixel = 0
        AccentBar.Parent = NotifCard

        local BarCorner = Instance.new("UICorner")
        BarCorner.CornerRadius = UDim.new(0, 2)
        BarCorner.Parent = AccentBar

        local IconLabel = Instance.new("TextLabel")
        IconLabel.Size = UDim2.new(0, 35, 1, 0)
        IconLabel.Position = UDim2.new(0, 15, 0, 0)
        IconLabel.BackgroundTransparency = 1
        IconLabel.Text = state and "✅" or "❌"
        IconLabel.TextTransparency = 1
        IconLabel.TextSize = 18
        IconLabel.Parent = NotifCard

        local TitleLabel = Instance.new("TextLabel")
        TitleLabel.Size = UDim2.new(1, -60, 0, 20)
        TitleLabel.Position = UDim2.new(0, 55, 0, 7)
        TitleLabel.BackgroundTransparency = 1
        TitleLabel.Text = string.upper(featureName)
        TitleLabel.TextColor3 = Color3.fromRGB(245, 245, 255)
        TitleLabel.TextTransparency = 1
        TitleLabel.TextSize = 11
        TitleLabel.Font = Enum.Font.GothamBold
        TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
        TitleLabel.Parent = NotifCard

        local DescLabel = Instance.new("TextLabel")
        DescLabel.Size = UDim2.new(1, -60, 0, 20)
        DescLabel.Position = UDim2.new(0, 55, 0, 23)
        DescLabel.BackgroundTransparency = 1
        DescLabel.Text = state and "Durum: AKTIF EDILDI" or "Durum: KAPATILDI"
        DescLabel.TextColor3 = state and Color3.fromRGB(90, 255, 150) or Color3.fromRGB(255, 100, 100)
        DescLabel.TextTransparency = 1
        DescLabel.TextSize = 10
        DescLabel.Font = Enum.Font.GothamMedium
        DescLabel.TextXAlignment = Enum.TextXAlignment.Left
        DescLabel.Parent = NotifCard

        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        TweenService:Create(NotifCard, tweenInfo, {BackgroundTransparency = 0.15}):Play()
        TweenService:Create(CardStroke, tweenInfo, {Transparency = 0.2}):Play()
        TweenService:Create(AccentBar, tweenInfo, {BackgroundTransparency = 0}):Play()
        TweenService:Create(IconLabel, tweenInfo, {TextTransparency = 0}):Play()
        TweenService:Create(TitleLabel, tweenInfo, {TextTransparency = 0}):Play()
        TweenService:Create(DescLabel, tweenInfo, {TextTransparency = 0}):Play()

        task.wait(2.2)

        local outTweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
        TweenService:Create(NotifCard, outTweenInfo, {BackgroundTransparency = 1}):Play()
        TweenService:Create(CardStroke, outTweenInfo, {Transparency = 1}):Play()
        TweenService:Create(AccentBar, outTweenInfo, {BackgroundTransparency = 1}):Play()
        TweenService:Create(IconLabel, outTweenInfo, {TextTransparency = 1}):Play()
        TweenService:Create(TitleLabel, outTweenInfo, {TextTransparency = 1}):Play()
        TweenService:Create(DescLabel, outTweenInfo, {TextTransparency = 1}):Play()

        task.wait(0.3)
        NotifCard:Destroy()
    end)
end

--------------------------------------------------------------------------------
-- AUTO SHOOT (OTOMATİK ATEŞ) TETİKLEYİCİSİ
--------------------------------------------------------------------------------
local lastAutoShoot = 0
local autoShootDelay = 0.08

local function triggerShoot()
    pcall(function()
        if typeof(mouse1click) == "function" then
            mouse1click()
        elseif typeof(mouse1press) == "function" and typeof(mouse1release) == "function" then
            mouse1press()
            task.wait(0.01)
            mouse1release()
        else
            local character = LocalPlayer.Character
            if character then
                local tool = character:FindFirstChildOfClass("Tool")
                if tool then
                    tool:Activate()
                end
            end
        end
    end)
end

--------------------------------------------------------------------------------
-- TUŞ ATAMA SİSTEMİ (KEYBIND SYSTEM)
--------------------------------------------------------------------------------
local keybinds = {
    RageLockKey = Enum.KeyCode.E,
    SpinbotKey = Enum.KeyCode.Q,
    AutoShootKey = Enum.KeyCode.V,
    MenuToggleKey = Enum.KeyCode.Insert
}

--------------------------------------------------------------------------------
-- WHITELIST (BEYAZ LİSTE) AYARLARI
--------------------------------------------------------------------------------
local WhitelistPlayers = {
    "ArkadasininAdi1",
    "ArkadasininAdi2"
}

local function isWhitelisted(player)
    if not player then return false end
    for _, name in ipairs(WhitelistPlayers) do
        if string.lower(player.Name) == string.lower(name) or string.lower(player.DisplayName) == string.lower(name) then
            return true
        end
    end
    return false
end

local allRemotes = {}
local function scanForRemotes(parent)
    for _, child in ipairs(parent:GetChildren()) do
        if child:IsA("RemoteEvent") or child:IsA("RemoteFunction") then
            table.insert(allRemotes, child)
        end
        if #child:GetChildren() > 0 then
            pcall(function() scanForRemotes(child) end)
        end
    end
end

pcall(function()
    scanForRemotes(ReplicatedStorage)
    scanForRemotes(workspace)
end)

local MobileScreenGui = Instance.new("ScreenGui")
MobileScreenGui.Name = "AstraOS_MobileOverlay"
MobileScreenGui.ResetOnSpawn = false
pcall(function()
    MobileScreenGui.Parent = CoreGui
end)
if not MobileScreenGui.Parent then
    MobileScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

--------------------------------------------------------------------------------
-- KILL NOTIFICATION
--------------------------------------------------------------------------------
local NotificationHolder = Instance.new("Frame")
NotificationHolder.Name = "NotificationHolder"
NotificationHolder.Size = UDim2.new(0, 300, 0, 400)
NotificationHolder.Position = UDim2.new(1, -315, 1, -415)
NotificationHolder.BackgroundTransparency = 1
NotificationHolder.Parent = ScreenGui

local NotifLayout = Instance.new("UIListLayout")
NotifLayout.SortOrder = Enum.SortOrder.LayoutOrder
NotifLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
NotifLayout.Padding = UDim.new(0, 8)
NotifLayout.Parent = NotificationHolder

local function showKillNotification(victimName, weaponName)
    task.spawn(function()
        local NotifCard = Instance.new("Frame")
        NotifCard.Size = UDim2.new(1, 0, 0, 55)
        NotifCard.BackgroundColor3 = Color3.fromRGB(15, 16, 24)
        NotifCard.BackgroundTransparency = 1
        NotifCard.BorderSizePixel = 0
        NotifCard.Parent = NotificationHolder

        local CardCorner = Instance.new("UICorner")
        CardCorner.CornerRadius = UDim.new(0, 10)
        CardCorner.Parent = NotifCard

        local CardStroke = Instance.new("UIStroke")
        CardStroke.Color = Color3.fromRGB(80, 120, 255)
        CardStroke.Transparency = 1
        CardStroke.Thickness = 1.5
        CardStroke.Parent = NotifCard

        local AccentBar = Instance.new("Frame")
        AccentBar.Size = UDim2.new(0, 4, 1, -12)
        AccentBar.Position = UDim2.new(0, 6, 0, 6)
        AccentBar.BackgroundColor3 = Color3.fromRGB(45, 100, 210)
        AccentBar.BackgroundTransparency = 1
        AccentBar.BorderSizePixel = 0
        AccentBar.Parent = NotifCard

        local BarCorner = Instance.new("UICorner")
        BarCorner.CornerRadius = UDim.new(0, 2)
        BarCorner.Parent = AccentBar

        local IconLabel = Instance.new("TextLabel")
        IconLabel.Size = UDim2.new(0, 35, 1, 0)
        IconLabel.Position = UDim2.new(0, 15, 0, 0)
        IconLabel.BackgroundTransparency = 1
        IconLabel.Text = "🎯"
        IconLabel.TextTransparency = 1
        IconLabel.TextSize = 20
        IconLabel.Parent = NotifCard

        local TitleLabel = Instance.new("TextLabel")
        TitleLabel.Size = UDim2.new(1, -60, 0, 20)
        TitleLabel.Position = UDim2.new(0, 55, 0, 9)
        TitleLabel.BackgroundTransparency = 1
        TitleLabel.Text = "HEDEFI ETKISIZ HALE GETIRDIN!"
        TitleLabel.TextColor3 = Color3.fromRGB(90, 255, 150)
        TitleLabel.TextTransparency = 1
        TitleLabel.TextSize = 10
        TitleLabel.Font = Enum.Font.GothamBold
        TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
        TitleLabel.Parent = NotifCard

        local DescLabel = Instance.new("TextLabel")
        DescLabel.Size = UDim2.new(1, -60, 0, 20)
        DescLabel.Position = UDim2.new(0, 55, 0, 26)
        DescLabel.BackgroundTransparency = 1
        DescLabel.Text = "Kurban: " .. tostring(victimName)
        DescLabel.TextColor3 = Color3.fromRGB(220, 225, 240)
        DescLabel.TextTransparency = 1
        DescLabel.TextSize = 11
        DescLabel.Font = Enum.Font.GothamMedium
        DescLabel.TextXAlignment = Enum.TextXAlignment.Left
        DescLabel.Parent = NotifCard

        local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        TweenService:Create(NotifCard, tweenInfo, {BackgroundTransparency = 0.15}):Play()
        TweenService:Create(CardStroke, tweenInfo, {Transparency = 0.2}):Play()
        TweenService:Create(AccentBar, tweenInfo, {BackgroundTransparency = 0}):Play()
        TweenService:Create(IconLabel, tweenInfo, {TextTransparency = 0}):Play()
        TweenService:Create(TitleLabel, tweenInfo, {TextTransparency = 0}):Play()
        TweenService:Create(DescLabel, tweenInfo, {TextTransparency = 0}):Play()

        task.wait(3.2)

        local outTweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
        TweenService:Create(NotifCard, outTweenInfo, {BackgroundTransparency = 1}):Play()
        TweenService:Create(CardStroke, outTweenInfo, {Transparency = 1}):Play()
        TweenService:Create(AccentBar, outTweenInfo, {BackgroundTransparency = 1}):Play()
        TweenService:Create(IconLabel, outTweenInfo, {TextTransparency = 1}):Play()
        TweenService:Create(TitleLabel, outTweenInfo, {TextTransparency = 1}):Play()
        TweenService:Create(DescLabel, outTweenInfo, {TextTransparency = 1}):Play()

        task.wait(0.4)
        NotifCard:Destroy()
    end)
end

-- ÇİZİMLERİ VE ARAYÜZÜ KAPATMA (UNLOAD)
local activeDrawings = {}
local activeTracers = {}
local activeSkeletons = {}
local fovCircleRage = Drawing.new("Circle")
local fovCircleLegit = Drawing.new("Circle")
local isScriptLoaded = true

local function unloadScript()
    isScriptLoaded = false
    pcall(function() fovCircleRage:Remove() end)
    pcall(function() fovCircleLegit:Remove() end)
    
    for _, drawings in pairs(activeDrawings) do
        pcall(function()
            drawings.Box:Remove()
            drawings.Name:Remove()
            drawings.Dist:Remove()
        end)
    end
    
    for _, line in pairs(activeTracers) do
        pcall(function() line:Remove() end)
    end

    for _, skel in pairs(activeSkeletons) do
        for _, boneLine in pairs(skel) do pcall(function() boneLine:Remove() end) end
    end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character then
            pcall(function()
                local hlChams = player.Character:FindFirstChild("AstraChams")
                if hlChams then hlChams:Destroy() end
                
                local head = player.Character:FindFirstChild("Head")
                if head then
                    head.Size = Vector3.new(2, 1, 1)
                    head.Transparency = 0
                end
                local hum = player.Character:FindFirstChildOfClass("Humanoid")
                if hum then
                    hum.WalkSpeed = 16
                    hum.JumpPower = 50
                end
            end)
        end
    end

    pcall(function() ScreenGui:Destroy() end)
    pcall(function() MobileScreenGui:Destroy() end)
end

-- EKRANLAR
local UpdateLogScreen = Instance.new("Frame")
UpdateLogScreen.Size = UDim2.new(0, 360, 0, 250)
UpdateLogScreen.Position = UDim2.new(0.5, -180, 0.5, -125)
UpdateLogScreen.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
UpdateLogScreen.BorderSizePixel = 0
UpdateLogScreen.Active = true
UpdateLogScreen.Draggable = true
UpdateLogScreen.Parent = ScreenGui

local UpdateCorner = Instance.new("UICorner")
UpdateCorner.CornerRadius = UDim.new(0, 14)
UpdateCorner.Parent = UpdateLogScreen

local UpdateStroke = Instance.new("UIStroke")
UpdateStroke.Color = Color3.fromRGB(80, 120, 255)
UpdateStroke.Thickness = 1.8
UpdateStroke.Parent = UpdateLogScreen

local UpdateTitle = Instance.new("TextLabel")
UpdateTitle.Size = UDim2.new(1, 0, 0, 40)
UpdateTitle.Position = UDim2.new(0, 0, 0, 15)
UpdateTitle.BackgroundTransparency = 1
UpdateTitle.Text = "⚡ AstraOS Güncelleme Günlükleri"
UpdateTitle.TextColor3 = Color3.fromRGB(245, 245, 255)
UpdateTitle.TextSize = 14
UpdateTitle.Font = Enum.Font.GothamBold
UpdateTitle.Parent = UpdateLogScreen

local UpdateDesc = Instance.new("TextLabel")
UpdateDesc.Size = UDim2.new(1, -40, 0, 115)
UpdateDesc.Position = UDim2.new(0, 20, 0, 55)
UpdateDesc.BackgroundColor3 = Color3.fromRGB(17, 18, 27)
UpdateDesc.BorderSizePixel = 0
UpdateDesc.Text = "[ + ] Mobil Dostu Yeni Arayüz ve Kontrol Butonları Eklendi\n" ..
                "[ + ] Dokunmatik Mobil Aim ve Hızlı Menü Kısayolları Optimize Edildi\n" ..
                "[ + ] Karakter iskelet ve kutu algoritmaları kusursuzlaştırıldı"
UpdateDesc.TextColor3 = Color3.fromRGB(220, 225, 240)
UpdateDesc.TextSize = 11
UpdateDesc.Font = Enum.Font.GothamMedium
UpdateDesc.TextWrapped = true
UpdateDesc.Parent = UpdateLogScreen

local UpdateDescCorner = Instance.new("UICorner")
UpdateDescCorner.CornerRadius = UDim.new(0, 8)
UpdateDescCorner.Parent = UpdateDesc

local UpdateNextBtn = Instance.new("TextButton")
UpdateNextBtn.Size = UDim2.new(1, -40, 0, 38)
UpdateNextBtn.Position = UDim2.new(0, 20, 0, 185)
UpdateNextBtn.BackgroundColor3 = Color3.fromRGB(45, 100, 210)
UpdateNextBtn.BorderSizePixel = 0
UpdateNextBtn.Text = "Devam Et"
UpdateNextBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
UpdateNextBtn.TextSize = 12
UpdateNextBtn.Font = Enum.Font.GothamBold
UpdateNextBtn.Parent = UpdateLogScreen

local UpdateNextCorner = Instance.new("UICorner")
UpdateNextCorner.CornerRadius = UDim.new(0, 8)
UpdateNextCorner.Parent = UpdateNextBtn

local KeyScreen = Instance.new("Frame")
KeyScreen.Size = UDim2.new(0, 320, 0, 200)
KeyScreen.Position = UDim2.new(0.5, -160, 0.5, -100)
KeyScreen.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
KeyScreen.BorderSizePixel = 0
KeyScreen.Active = true
KeyScreen.Draggable = true
KeyScreen.Visible = false
KeyScreen.Parent = ScreenGui

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 14)
KeyCorner.Parent = KeyScreen

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Color = Color3.fromRGB(80, 120, 255)
KeyStroke.Thickness = 1.8
KeyStroke.Parent = KeyScreen

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 40)
KeyTitle.Position = UDim2.new(0, 0, 0, 15)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "🔑 AstraOS - Key Sistemi"
KeyTitle.TextColor3 = Color3.fromRGB(245, 245, 255)
KeyTitle.TextSize = 14
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.Parent = KeyScreen

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(1, -40, 0, 40)
KeyBox.Position = UDim2.new(0, 20, 0, 65)
KeyBox.BackgroundColor3 = Color3.fromRGB(17, 18, 27)
KeyBox.BorderSizePixel = 0
KeyBox.PlaceholderText = "Hile Keyini Girin (Örn: OS BEST)"
KeyBox.PlaceholderColor3 = Color3.fromRGB(110, 110, 140)
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.TextSize = 12
KeyBox.Font = Enum.Font.GothamMedium
KeyBox.Parent = KeyScreen

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 8)
BoxCorner.Parent = KeyBox

local LoginBtn = Instance.new("TextButton")
LoginBtn.Size = UDim2.new(1, -40, 0, 38)
LoginBtn.Position = UDim2.new(0, 20, 0, 125)
LoginBtn.BackgroundColor3 = Color3.fromRGB(45, 100, 210)
LoginBtn.BorderSizePixel = 0
LoginBtn.Text = "Giriş Yap"
LoginBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LoginBtn.TextSize = 12
LoginBtn.Font = Enum.Font.GothamBold
LoginBtn.Parent = KeyScreen

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 8)
BtnCorner.Parent = LoginBtn

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 20)
StatusLabel.Position = UDim2.new(0, 0, 0, 170)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = ""
StatusLabel.TextColor3 = Color3.fromRGB(255, 90, 90)
StatusLabel.TextSize = 10
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Parent = KeyScreen

local ModeScreen = Instance.new("Frame")
ModeScreen.Size = UDim2.new(0, 340, 0, 180)
ModeScreen.Position = UDim2.new(0.5, -170, 0.5, -90)
ModeScreen.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
ModeScreen.BorderSizePixel = 0
ModeScreen.Visible = false
ModeScreen.Parent = ScreenGui

local ModeCorner = Instance.new("UICorner")
ModeCorner.CornerRadius = UDim.new(0, 14)
ModeCorner.Parent = ModeScreen

local ModeStroke = Instance.new("UIStroke")
ModeStroke.Color = Color3.fromRGB(80, 120, 255)
ModeStroke.Thickness = 1.8
ModeStroke.Parent = ModeScreen

local ModeTitle = Instance.new("TextLabel")
ModeTitle.Size = UDim2.new(1, 0, 0, 40)
ModeTitle.Position = UDim2.new(0, 0, 0, 15)
ModeTitle.BackgroundTransparency = 1
ModeTitle.Text = "Oynamak İstediğiniz Modu Seçin"
ModeTitle.TextColor3 = Color3.fromRGB(245, 245, 255)
ModeTitle.TextSize = 13
ModeTitle.Font = Enum.Font.GothamBold
ModeTitle.Parent = ModeScreen

local LegitSelectBtn = Instance.new("TextButton")
LegitSelectBtn.Size = UDim2.new(1, -40, 0, 45)
LegitSelectBtn.Position = UDim2.new(0, 20, 0, 65)
LegitSelectBtn.BackgroundColor3 = Color3.fromRGB(45, 100, 210)
LegitSelectBtn.BorderSizePixel = 0
LegitSelectBtn.Text = "🛡️ Legit Mod (Sağ Tık / Mobil Aimbot)"
LegitSelectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LegitSelectBtn.TextSize = 12
LegitSelectBtn.Font = Enum.Font.GothamBold
LegitSelectBtn.Parent = ModeScreen

local LegitCorner = Instance.new("UICorner")
LegitCorner.CornerRadius = UDim.new(0, 8)
LegitCorner.Parent = LegitSelectBtn

local RageSelectBtn = Instance.new("TextButton")
RageSelectBtn.Size = UDim2.new(1, -40, 0, 45)
RageSelectBtn.Position = UDim2.new(0, 20, 0, 120)
RageSelectBtn.BackgroundColor3 = Color3.fromRGB(160, 40, 40)
RageSelectBtn.BorderSizePixel = 0
RageSelectBtn.Text = "🔥 Rage Mod (360° Tam Kafa Otomatik Aim)"
RageSelectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RageSelectBtn.TextSize = 12
RageSelectBtn.Font = Enum.Font.GothamBold
RageSelectBtn.Parent = ModeScreen

local RageCorner = Instance.new("UICorner")
RageCorner.CornerRadius = UDim.new(0, 8)
RageCorner.Parent = RageSelectBtn

local LoadScreen = Instance.new("Frame")
LoadScreen.Size = UDim2.new(0, 300, 0, 110)
LoadScreen.Position = UDim2.new(0.5, -150, 0.5, -55)
LoadScreen.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
LoadScreen.BorderSizePixel = 0
LoadScreen.Visible = false
LoadScreen.Parent = ScreenGui

local LoadCorner = Instance.new("UICorner")
LoadCorner.CornerRadius = UDim.new(0, 14)
LoadCorner.Parent = LoadScreen

local LoadStroke = Instance.new("UIStroke")
LoadStroke.Color = Color3.fromRGB(80, 120, 255)
LoadStroke.Thickness = 1.8
LoadStroke.Parent = LoadScreen

local LoadTitle = Instance.new("TextLabel")
LoadTitle.Size = UDim2.new(1, 0, 0, 30)
LoadTitle.Position = UDim2.new(0, 0, 0, 15)
LoadTitle.BackgroundTransparency = 1
LoadTitle.Text = "Sistem Yükleniyor..."
LoadTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadTitle.TextSize = 13
LoadTitle.Font = Enum.Font.GothamBold
LoadTitle.Parent = LoadScreen

local LoadBarBack = Instance.new("Frame")
LoadBarBack.Size = UDim2.new(1, -40, 0, 8)
LoadBarBack.Position = UDim2.new(0, 20, 0, 60)
LoadBarBack.BackgroundColor3 = Color3.fromRGB(28, 32, 45)
LoadBarBack.BorderSizePixel = 0
LoadBarBack.Parent = LoadScreen

local BarCorner = Instance.new("UICorner")
BarCorner.CornerRadius = UDim.new(0, 4)
BarCorner.Parent = LoadBarBack

local LoadBarFill = Instance.new("Frame")
LoadBarFill.Size = UDim2.new(0, 0, 1, 0)
LoadBarFill.BackgroundColor3 = Color3.fromRGB(70, 130, 255)
LoadBarFill.BorderSizePixel = 0
LoadBarFill.Parent = LoadBarBack

local FillCorner = Instance.new("UICorner")
FillCorner.CornerRadius = UDim.new(0, 4)
FillCorner.Parent = LoadBarFill

local PercentLabel = Instance.new("TextLabel")
PercentLabel.Size = UDim2.new(1, 0, 0, 20)
PercentLabel.Position = UDim2.new(0, 0, 0, 75)
PercentLabel.BackgroundTransparency = 1
PercentLabel.Text = "%0"
PercentLabel.TextColor3 = Color3.fromRGB(150, 150, 180)
PercentLabel.TextSize = 10
PercentLabel.Font = Enum.Font.GothamMedium
PercentLabel.Parent = LoadScreen

local MainFrameRage = Instance.new("Frame")
MainFrameRage.Name = "AstraMainFrameRage"
MainFrameRage.Size = UDim2.new(0, 580, 0, 460)
MainFrameRage.Position = UDim2.new(0.5, -290, 0.5, -230)
MainFrameRage.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
MainFrameRage.BorderSizePixel = 0
MainFrameRage.Active = true
MainFrameRage.Draggable = true
MainFrameRage.Visible = false
MainFrameRage.Parent = ScreenGui

local MainFrameLegit = Instance.new("Frame")
MainFrameLegit.Name = "AstraMainFrameLegit"
MainFrameLegit.Size = UDim2.new(0, 580, 0, 460)
MainFrameLegit.Position = UDim2.new(0.5, -290, 0.5, -230)
MainFrameLegit.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
MainFrameLegit.BorderSizePixel = 0
MainFrameLegit.Active = true
MainFrameLegit.Draggable = true
MainFrameLegit.Visible = false
MainFrameLegit.Parent = ScreenGui

-- Ayarlar Yapısı
local settingsRage = {
    RageLock = true,
    Full360Aimbot = true,
    SilentAim = false,
    AutoShoot = false,
    FOVEnabled = true,
    FOVRadius = 300,
    WallCheck = false,
    TeamCheck = false,
    
    ESPBox = true,
    Tracers = true,
    NameESP = true,
    DistanceESP = true,
    Skeleton = true,
    Chams = true,
    
    Fly = false,
    Noclip = false,
    Spinbot = false,
    Speed = 16,
    JumpPower = 50,
    
    HitboxExpander = true,
    HitboxSize = 6
}

local settingsLegit = {
    LegitAim = true,
    Smoothness = 5,
    FOVEnabled = true,
    FOVRadius = 150,
    WallCheck = false,
    TeamCheck = false,
    LegitFOVVisible = true,
    
    ESPBox = true,
    Tracers = true,
    NameESP = true,
    DistanceESP = true,
    Skeleton = true,
    Chams = true
}

local rightMouseDown = false
local leftMouseDown = false
local selectedMode = nil
local mobileAimToggled = false

--------------------------------------------------------------------------------
-- YENİ MOBİL ÖZEL KONTROL BUTONLARI (MOBIL DOSTU GELİŞTİRMELER)
--------------------------------------------------------------------------------
local ToggleMenuMobBtn = Instance.new("TextButton")
ToggleMenuMobBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleMenuMobBtn.Position = UDim2.new(0, 20, 0.35, 0)
ToggleMenuMobBtn.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
ToggleMenuMobBtn.Text = "⚙️"
ToggleMenuMobBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleMenuMobBtn.TextSize = 20
ToggleMenuMobBtn.Active = true
ToggleMenuMobBtn.Draggable = true
ToggleMenuMobBtn.Parent = MobileScreenGui

local MobMenuCorner = Instance.new("UICorner")
MobMenuCorner.CornerRadius = UDim.new(1, 0)
MobMenuCorner.Parent = ToggleMenuMobBtn

local MobMenuStroke = Instance.new("UIStroke")
MobMenuStroke.Color = Color3.fromRGB(80, 120, 255)
MobMenuStroke.Thickness = 2
MobMenuStroke.Parent = ToggleMenuMobBtn

-- Ekstra Mobil Hızlı Kapat/Küçült Butonu (UI Kapatma)
local QuickHideMobBtn = Instance.new("TextButton")
QuickHideMobBtn.Size = UDim2.new(0, 40, 0, 40)
QuickHideMobBtn.Position = UDim2.new(0, 75, 0.35, 5)
QuickHideMobBtn.BackgroundColor3 = Color3.fromRGB(40, 20, 20)
QuickHideMobBtn.Text = "👁️‍🗨️"
QuickHideMobBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
QuickHideMobBtn.TextSize = 16
QuickHideMobBtn.Active = true
QuickHideMobBtn.Draggable = true
QuickHideMobBtn.Parent = MobileScreenGui

local QuickHideCorner = Instance.new("UICorner")
QuickHideCorner.CornerRadius = UDim.new(1, 0)
QuickHideCorner.Parent = QuickHideMobBtn

local QuickHideStroke = Instance.new("UIStroke")
QuickHideStroke.Color = Color3.fromRGB(255, 80, 80)
QuickHideStroke.Thickness = 1.5
QuickHideStroke.Parent = QuickHideMobBtn

-- Mobil Aimbot Tetikleme Yuvarlak Butonu (Sağ Tarafta)
local AimMobBtn = Instance.new("TextButton")
AimMobBtn.Size = UDim2.new(0, 65, 0, 65)
AimMobBtn.Position = UDim2.new(1, -85, 0.45, -32)
AimMobBtn.BackgroundColor3 = Color3.fromRGB(20, 25, 38)
AimMobBtn.Text = "🎯"
AimMobBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AimMobBtn.TextSize = 22
AimMobBtn.Font = Enum.Font.GothamBold
AimMobBtn.Active = true
AimMobBtn.Draggable = true
AimMobBtn.Visible = false
AimMobBtn.Parent = MobileScreenGui

local MobAimCorner = Instance.new("UICorner")
MobAimCorner.CornerRadius = UDim.new(1, 0)
MobAimCorner.Parent = AimMobBtn

local MobAimStroke = Instance.new("UIStroke")
MobAimStroke.Color = Color3.fromRGB(80, 120, 255)
MobAimStroke.Thickness = 2
MobAimStroke.Parent = AimMobBtn

fovCircleRage.Visible = false
fovCircleRage.Transparency = 1
fovCircleRage.Color = Color3.fromRGB(220, 50, 50)
fovCircleRage.Thickness = 1.5
fovCircleRage.NumSides = 48
fovCircleRage.Radius = settingsRage.FOVRadius
fovCircleRage.Filled = false

fovCircleLegit.Visible = false
fovCircleLegit.Transparency = 1
fovCircleLegit.Color = Color3.fromRGB(45, 100, 210)
fovCircleLegit.Thickness = 1.5
fovCircleLegit.NumSides = 48
fovCircleLegit.Radius = settingsLegit.FOVRadius
fovCircleLegit.Filled = false

local function createDrawings(player)
    if activeDrawings[player] then return end
    local box = Drawing.new("Square")
    box.Visible = false; box.Color = Color3.fromRGB(45, 100, 210); box.Thickness = 1.5; box.Filled = false; box.Transparency = 1
    
    local nameText = Drawing.new("Text")
    nameText.Visible = false; nameText.Color = Color3.fromRGB(255, 255, 255); nameText.Size = 12; nameText.Center = true; nameText.Outline = true; nameText.Transparency = 1
    
    local distText = Drawing.new("Text")
    distText.Visible = false; distText.Color = Color3.fromRGB(180, 190, 210); distText.Size = 11; distText.Center = true; distText.Outline = true; distText.Transparency = 1

    activeDrawings[player] = {Box = box, Name = nameText, Dist = distText}
end

local function removeDrawings(player)
    if activeDrawings[player] then
        pcall(function() activeDrawings[player].Box:Remove(); activeDrawings[player].Name:Remove(); activeDrawings[player].Dist:Remove() end)
        activeDrawings[player] = nil
    end
end

for _, p in ipairs(Players:GetPlayers()) do if p ~= LocalPlayer then createDrawings(p) end end
Players.PlayerAdded:Connect(function(p) if p ~= LocalPlayer then createDrawings(p) end end)
Players.PlayerRemoving:Connect(removeDrawings)

local function createTracer(player)
    if activeTracers[player] then return end
    local line = Drawing.new("Line")
    line.Visible = false; line.Color = Color3.fromRGB(45, 100, 210); line.Thickness = 1; line.Transparency = 1
    activeTracers[player] = line
end

local function removeTracer(player)
    if activeTracers[player] then activeTracers[player]:Remove(); activeTracers[player] = nil end
end

for _, p in ipairs(Players:GetPlayers()) do if p ~= LocalPlayer then createTracer(p) end end
Players.PlayerAdded:Connect(function(p) if p ~= LocalPlayer then createTracer(p) end end)
Players.PlayerRemoving:Connect(removeTracer)

local function createSkeleton(player)
    if activeSkeletons[player] then return end
    local bones = {}
    for i = 1, 14 do
        local line = Drawing.new("Line")
        line.Visible = false
        line.Color = Color3.fromRGB(45, 100, 210)
        line.Thickness = 1.2
        line.Transparency = 1
        table.insert(bones, line)
    end
    activeSkeletons[player] = bones
end

local function removeSkeleton(player)
    if activeSkeletons[player] then
        for _, line in ipairs(activeSkeletons[player]) do pcall(function() line:Remove() end) end
        activeSkeletons[player] = nil
    end
end

for _, p in ipairs(Players:GetPlayers()) do if p ~= LocalPlayer then createSkeleton(p) end end
Players.PlayerAdded:Connect(function(p) if p ~= LocalPlayer then createSkeleton(p) end end)
Players.PlayerRemoving:Connect(removeSkeleton)

local killSound = Instance.new("Sound")
killSound.SoundId = "rbxassetid://7968074794"
killSound.Volume = 2.5
killSound.Parent = ScreenGui

local function monitorPlayerDeath(player)
    if player == LocalPlayer then return end
    local function onCharacterAdded(char)
        local humanoid = char:WaitForChild("Humanoid", 5)
        if humanoid then
            humanoid.Died:Connect(function()
                if isScriptLoaded then
                    pcall(function() killSound:Play() end)
                    showKillNotification(player.Name, "AstraOS Weapon")
                end
            end)
        end
    end
    player.CharacterAdded:Connect(onCharacterAdded)
    if player.Character then onCharacterAdded(player.Character) end
end

for _, p in ipairs(Players:GetPlayers()) do monitorPlayerDeath(p) end
Players.PlayerAdded:Connect(monitorPlayerDeath)

local startLoadingAndBuildUI

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then 
        rightMouseDown = true
    elseif input.UserInputType == Enum.UserInputType.MouseButton1 then 
        leftMouseDown = true 
    end

    if gameProcessed then return end

    if input.KeyCode == keybinds.MenuToggleKey then
        if selectedMode == "Legit" then
            MainFrameLegit.Visible = not MainFrameLegit.Visible
            showActionNotification("Menü", MainFrameLegit.Visible)
        elseif selectedMode == "Rage" then
            MainFrameRage.Visible = not MainFrameRage.Visible
            showActionNotification("Menü", MainFrameRage.Visible)
        end
    elseif input.KeyCode == keybinds.SpinbotKey and selectedMode == "Rage" then
        settingsRage.Spinbot = not settingsRage.Spinbot
        showActionNotification("Spinbot", settingsRage.Spinbot)
    elseif input.KeyCode == keybinds.AutoShootKey and selectedMode == "Rage" then
        settingsRage.AutoShoot = not settingsRage.AutoShoot
        showActionNotification("Auto Shoot", settingsRage.AutoShoot)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then 
        rightMouseDown = false
    elseif input.UserInputType == Enum.UserInputType.MouseButton1 then 
        leftMouseDown = false 
    end
end)

ToggleMenuMobBtn.MouseButton1Click:Connect(function()
    if selectedMode == "Legit" then
        MainFrameLegit.Visible = not MainFrameLegit.Visible
        showActionNotification("Menü", MainFrameLegit.Visible)
    elseif selectedMode == "Rage" then
        MainFrameRage.Visible = not MainFrameRage.Visible
        showActionNotification("Menü", MainFrameRage.Visible)
    end
end)

-- Mobil Hızlı Gizleme Tuşu İşlevi
QuickHideMobBtn.MouseButton1Click:Connect(function()
    if MainFrameLegit.Visible then MainFrameLegit.Visible = false end
    if MainFrameRage.Visible then MainFrameRage.Visible = false end
    showActionNotification("Arayüz Gizlendi", false)
end)

AimMobBtn.MouseButton1Click:Connect(function()
    mobileAimToggled = not mobileAimToggled
    if selectedMode == "Legit" then
        settingsLegit.LegitAim = mobileAimToggled
        showActionNotification("Legit Aim", settingsLegit.LegitAim)
    else
        settingsRage.RageLock = mobileAimToggled
        showActionNotification("Rage Lock", settingsRage.RageLock)
    end
    AimMobBtn.BackgroundColor3 = mobileAimToggled and Color3.fromRGB(15, 55, 30) or Color3.fromRGB(20, 25, 38)
end)

UpdateNextBtn.MouseButton1Click:Connect(function()
    UpdateLogScreen:Destroy()
    KeyScreen.Visible = true
end)

LoginBtn.MouseButton1Click:Connect(function()
    if KeyBox.Text == "OS BEST" then
        KeyScreen:Destroy()
        ModeScreen.Visible = true
    else
        StatusLabel.Text = "Geçersiz Key!"
        task.wait(2)
        StatusLabel.Text = ""
    end
end)

LegitSelectBtn.MouseButton1Click:Connect(function()
    selectedMode = "Legit"
    ModeScreen:Destroy()
    AimMobBtn.Visible = true
    startLoadingAndBuildUI(false)
end)

RageSelectBtn.MouseButton1Click:Connect(function()
    selectedMode = "Rage"
    ModeScreen:Destroy()
    AimMobBtn.Visible = true
    startLoadingAndBuildUI(true)
end)

startLoadingAndBuildUI = function(isRage)
    local targetFrame = isRage and MainFrameRage or MainFrameLegit
    local oppositeFrame = isRage and MainFrameLegit or MainFrameRage
    
    oppositeFrame.Visible = false
    for _, child in ipairs(targetFrame:GetChildren()) do
        child:Destroy()
    end

    LoadScreen.Visible = true
    LoadBarFill.BackgroundColor3 = isRage and Color3.fromRGB(220, 50, 50) or Color3.fromRGB(45, 100, 210)
    LoadStroke.Color = Color3.fromRGB(80, 120, 255)

    task.spawn(function()
        LoadBarFill.Size = UDim2.new(0.4, 0, 1, 0)
        PercentLabel.Text = "%40 - Modüller yükleniyor..."
        task.wait(0.3)
        
        local MainCorner = Instance.new("UICorner")
        MainCorner.CornerRadius = UDim.new(0, 14)
        MainCorner.Parent = targetFrame

        local MainStroke = Instance.new("UIStroke")
        MainStroke.Color = Color3.fromRGB(50, 60, 90)
        MainStroke.Thickness = 1.8
        MainStroke.Parent = targetFrame

        local TopBar = Instance.new("Frame")
        TopBar.Size = UDim2.new(1, 0, 0, 50)
        TopBar.BackgroundColor3 = Color3.fromRGB(17, 18, 27)
        TopBar.BorderSizePixel = 0
        TopBar.Parent = targetFrame

        local TopCorner = Instance.new("UICorner")
        TopCorner.CornerRadius = UDim.new(0, 14)
        TopCorner.Parent = TopBar

        local TopFix = Instance.new("Frame")
        TopFix.Size = UDim2.new(1, 0, 0, 12)
        TopFix.Position = UDim2.new(0, 0, 1, -12)
        TopFix.BackgroundColor3 = Color3.fromRGB(17, 18, 27)
        TopFix.BorderSizePixel = 0
        TopFix.Parent = TopBar

        local Title = Instance.new("TextLabel")
        Title.Size = UDim2.new(1, -20, 1, 0)
        Title.Position = UDim2.new(0, 18, 0, 0)
        Title.BackgroundTransparency = 1
        Title.RichText = true
        Title.Text = isRage and "⚡ ASTRA OS <font color='#FF5050'>// Rage Suite (Mobile)</font>" or "⚡ ASTRA OS <font color='#5090FF'>// Legit Suite (Mobile)</font>"
        Title.TextColor3 = Color3.fromRGB(245, 245, 255)
        Title.TextSize = 14
        Title.Font = Enum.Font.GothamBold
        Title.TextXAlignment = Enum.TextXAlignment.Left
        Title.Parent = TopBar

        local AccentLine = Instance.new("Frame")
        AccentLine.Size = UDim2.new(1, 0, 0, 2)
        AccentLine.Position = UDim2.new(0, 0, 1, 0)
        AccentLine.BackgroundColor3 = isRage and Color3.fromRGB(220, 50, 50) or Color3.fromRGB(45, 100, 210)
        AccentLine.BorderSizePixel = 0
        AccentLine.Parent = TopBar

        LoadBarFill.Size = UDim2.new(0.9, 0, 1, 0)
        PercentLabel.Text = "%90 - Mobil Optimizasyonlar Yapılıyor..."
        task.wait(0.3)

        local function createWhitelistPanel(parentPage)
            local Card = Instance.new("Frame")
            Card.Size = UDim2.new(1, -6, 0, 110)
            Card.BackgroundColor3 = Color3.fromRGB(17, 18, 27)
            Card.BorderSizePixel = 0
            Card.Parent = parentPage

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 8)
            Corner.Parent = Card

            local Stroke = Instance.new("UIStroke")
            Stroke.Color = Color3.fromRGB(32, 36, 50)
            Stroke.Thickness = 1
            Stroke.Parent = Card

            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, -20, 0, 25)
            Label.Position = UDim2.new(0, 14, 0, 5)
            Label.BackgroundTransparency = 1
            Label.Text = "🛡️ Whitelist Yönetimi (Oyuncu Adı)"
            Label.TextColor3 = Color3.fromRGB(220, 225, 240)
            Label.TextSize = 11.5
            Label.Font = Enum.Font.GothamBold
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = Card

            local WlBox = Instance.new("TextBox")
            WlBox.Size = UDim2.new(1, -28, 0, 30)
            WlBox.Position = UDim2.new(0, 14, 0, 32)
            WlBox.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
            WlBox.BorderSizePixel = 0
            WlBox.PlaceholderText = "Eklenecek Oyuncu Adı..."
            WlBox.PlaceholderColor3 = Color3.fromRGB(110, 110, 140)
            WlBox.Text = ""
            WlBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            WlBox.TextSize = 11
            WlBox.Font = Enum.Font.GothamMedium
            WlBox.Parent = Card

            local BoxCorner = Instance.new("UICorner")
            BoxCorner.CornerRadius = UDim.new(0, 6)
            BoxCorner.Parent = WlBox

            local AddBtn = Instance.new("TextButton")
            AddBtn.Size = UDim2.new(0.48, 0, 0, 28)
            AddBtn.Position = UDim2.new(0, 14, 0, 70)
            AddBtn.BackgroundColor3 = Color3.fromRGB(15, 55, 30)
            AddBtn.BorderSizePixel = 0
            AddBtn.Text = "Ekle"
            AddBtn.TextColor3 = Color3.fromRGB(90, 255, 150)
            AddBtn.TextSize = 10.5
            AddBtn.Font = Enum.Font.GothamBold
            AddBtn.Parent = Card

            local AddCorner = Instance.new("UICorner")
            AddCorner.CornerRadius = UDim.new(0, 6)
            AddCorner.Parent = AddBtn

            local RemoveBtn = Instance.new("TextButton")
            RemoveBtn.Size = UDim2.new(0.48, 0, 0, 28)
            RemoveBtn.Position = UDim2.new(0.52, -2, 0, 70)
            RemoveBtn.BackgroundColor3 = Color3.fromRGB(55, 15, 15)
            RemoveBtn.BorderSizePixel = 0
            RemoveBtn.Text = "Çıkar"
            RemoveBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
            RemoveBtn.TextSize = 10.5
            RemoveBtn.Font = Enum.Font.GothamBold
            RemoveBtn.Parent = Card

            local RemCorner = Instance.new("UICorner")
            RemCorner.CornerRadius = UDim.new(0, 6)
            RemCorner.Parent = RemoveBtn

            AddBtn.MouseButton1Click:Connect(function()
                local name = WlBox.Text
                if name ~= "" then
                    local found = false
                    for _, v in ipairs(WhitelistPlayers) do
                        if string.lower(v) == string.lower(name) then found = true end
                    end
                    if not found then
                        table.insert(WhitelistPlayers, name)
                        WlBox.Text = "Eklendi: " .. name
                        task.wait(1.5)
                        WlBox.Text = ""
                    else
                        WlBox.Text = "Zaten listede var!"
                        task.wait(1.5)
                        WlBox.Text = ""
                    end
                end
            end)

            RemoveBtn.MouseButton1Click:Connect(function()
                local name = WlBox.Text
                if name ~= "" then
                    for i, v in ipairs(WhitelistPlayers) do
                        if string.lower(v) == string.lower(name) then
                            table.remove(WhitelistPlayers, i)
                            WlBox.Text = "Çıkarıldı: " .. name
                            task.wait(1.5)
                            WlBox.Text = ""
                            return
                        end
                    end
                    WlBox.Text = "Listede yok!"
                    task.wait(1.5)
                    WlBox.Text = ""
                end
            end)
        end

        local function createKeybindPanel(parentPage)
            local Card = Instance.new("Frame")
            Card.Size = UDim2.new(1, -6, 0, isRage and 150 or 115)
            Card.BackgroundColor3 = Color3.fromRGB(17, 18, 27)
            Card.BorderSizePixel = 0
            Card.Parent = parentPage

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 8)
            Corner.Parent = Card

            local Stroke = Instance.new("UIStroke")
            Stroke.Color = Color3.fromRGB(32, 36, 50)
            Stroke.Thickness = 1
            Stroke.Parent = Card

            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, -20, 0, 25)
            Label.Position = UDim2.new(0, 14, 0, 5)
            Label.BackgroundTransparency = 1
            Label.Text = "⌨️ Tuş Atama Sistemi (Keybinds)"
            Label.TextColor3 = Color3.fromRGB(220, 225, 240)
            Label.TextSize = 11.5
            Label.Font = Enum.Font.GothamBold
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = Card

            local function createBindRow(name, keyName, yPos)
                local RowLabel = Instance.new("TextLabel")
                RowLabel.Size = UDim2.new(0.6, 0, 0, 28)
                RowLabel.Position = UDim2.new(0, 14, 0, yPos)
                RowLabel.BackgroundTransparency = 1
                RowLabel.Text = name
                RowLabel.TextColor3 = Color3.fromRGB(180, 185, 210)
                RowLabel.TextSize = 11
                RowLabel.Font = Enum.Font.GothamMedium
                RowLabel.TextXAlignment = Enum.TextXAlignment.Left
                RowLabel.Parent = Card

                local BindBtn = Instance.new("TextButton")
                BindBtn.Size = UDim2.new(0, 110, 0, 26)
                BindBtn.Position = UDim2.new(1, -124, 0, yPos)
                BindBtn.BackgroundColor3 = Color3.fromRGB(25, 28, 40)
                BindBtn.BorderSizePixel = 0
                BindBtn.Text = tostring(keybinds[keyName].Name)
                BindBtn.TextColor3 = Color3.fromRGB(90, 160, 255)
                BindBtn.TextSize = 10.5
                BindBtn.Font = Enum.Font.GothamBold
                BindBtn.Parent = Card

                local BindCorner = Instance.new("UICorner")
                BindCorner.CornerRadius = UDim.new(0, 6)
                BindCorner.Parent = BindBtn

                BindBtn.MouseButton1Click:Connect(function()
                    BindBtn.Text = "..."
                    BindBtn.TextColor3 = Color3.fromRGB(255, 200, 50)
                    local connection
                    connection = UserInputService.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.Keyboard then
                            keybinds[keyName] = input.KeyCode
                            BindBtn.Text = tostring(input.KeyCode.Name)
                            BindBtn.TextColor3 = Color3.fromRGB(90, 160, 255)
                            connection:Disconnect()
                        end
                    end)
                end)
            end

            if isRage then
                createBindRow("Spinbot Tuşu", "SpinbotKey", 35)
                createBindRow("Auto-Shoot Tuşu", "AutoShootKey", 70)
                createBindRow("Menü Aç/Kapat Tuşu", "MenuToggleKey", 105)
            else
                createBindRow("Menü Aç/Kapat Tuşu", "MenuToggleKey", 35)
            end
        end

        local function createModeSwitchPanel(parentPage)
            local Card = Instance.new("Frame")
            Card.Size = UDim2.new(1, -6, 0, 60)
            Card.BackgroundColor3 = Color3.fromRGB(17, 18, 27)
            Card.BorderSizePixel = 0
            Card.Parent = parentPage

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 8)
            Corner.Parent = Card

            local Stroke = Instance.new("UIStroke")
            Stroke.Color = Color3.fromRGB(32, 36, 50)
            Stroke.Thickness = 1
            Stroke.Parent = Card

            local SwitchBtn = Instance.new("TextButton")
            SwitchBtn.Size = UDim2.new(1, -24, 0, 38)
            SwitchBtn.Position = UDim2.new(0, 12, 0.5, -19)
            SwitchBtn.BackgroundColor3 = isRage and Color3.fromRGB(45, 100, 210) or Color3.fromRGB(160, 40, 40)
            SwitchBtn.BorderSizePixel = 0
            SwitchBtn.Text = isRage and "🛡️ Legit Menüye Geç" or "🔥 Rage Menüye Geç"
            SwitchBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            SwitchBtn.TextSize = 11.5
            SwitchBtn.Font = Enum.Font.GothamBold
            SwitchBtn.Parent = Card

            local SwitchCorner = Instance.new("UICorner")
            SwitchCorner.CornerRadius = UDim.new(0, 6)
            SwitchCorner.Parent = SwitchBtn

            SwitchBtn.MouseButton1Click:Connect(function()
                if isRage then
                    selectedMode = "Legit"
                    MainFrameRage.Visible = false
                    startLoadingAndBuildUI(false)
                else
                    selectedMode = "Rage"
                    MainFrameLegit.Visible = false
                    startLoadingAndBuildUI(true)
                end
            end)
        end

        local function createUnloadPanel(parentPage)
            local Card = Instance.new("Frame")
            Card.Size = UDim2.new(1, -6, 0, 60)
            Card.BackgroundColor3 = Color3.fromRGB(17, 18, 27)
            Card.BorderSizePixel = 0
            Card.Parent = parentPage

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 8)
            Corner.Parent = Card

            local Stroke = Instance.new("UIStroke")
            Stroke.Color = Color3.fromRGB(50, 30, 30)
            Stroke.Thickness = 1
            Stroke.Parent = Card

            local UnloadBtn = Instance.new("TextButton")
            UnloadBtn.Size = UDim2.new(1, -24, 0, 38)
            UnloadBtn.Position = UDim2.new(0, 12, 0.5, -19)
            UnloadBtn.BackgroundColor3 = Color3.fromRGB(160, 40, 40)
            UnloadBtn.BorderSizePixel = 0
            UnloadBtn.Text = "Scripti Tamamen Kapat (Unload)"
            UnloadBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            UnloadBtn.TextSize = 11.5
            UnloadBtn.Font = Enum.Font.GothamBold
            UnloadBtn.Parent = Card

            local UnloadCorner = Instance.new("UICorner")
            UnloadCorner.CornerRadius = UDim.new(0, 6)
            UnloadCorner.Parent = UnloadBtn

            UnloadBtn.MouseButton1Click:Connect(function()
                unloadScript()
            end)
        end

        local Sidebar = Instance.new("Frame")
        Sidebar.Size = UDim2.new(0, 150, 1, -65)
        Sidebar.Position = UDim2.new(0, 12, 0, 56)
        Sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
        Sidebar.BorderSizePixel = 0
        Sidebar.Parent = targetFrame

        local SideCorner = Instance.new("UICorner")
        SideCorner.CornerRadius = UDim.new(0, 10)
        SideCorner.Parent = Sidebar

        local SideStroke = Instance.new("UIStroke")
        SideStroke.Color = Color3.fromRGB(35, 40, 60)
        SideStroke.Thickness = 1
        SideStroke.Parent = Sidebar

        local SideLayout = Instance.new("UIListLayout")
        SideLayout.SortOrder = Enum.SortOrder.LayoutOrder
        SideLayout.Padding = UDim.new(0, 8)
        SideLayout.Parent = Sidebar

        local ContentArea = Instance.new("Frame")
        ContentArea.Size = UDim2.new(1, -174, 1, -65)
        ContentArea.Position = UDim2.new(0, 168, 0, 56)
        ContentArea.BackgroundTransparency = 1
        ContentArea.Parent = targetFrame

        local pages = {}
        local tabButtons = {}

        local function createTabContent(key)
            local sf = Instance.new("ScrollingFrame")
            sf.Size = UDim2.new(1, 0, 1, 0)
            sf.BackgroundTransparency = 1
            sf.BorderSizePixel = 0
            sf.CanvasSize = UDim2.new(0, 0, 0, 750)
            sf.ScrollBarThickness = 3
            sf.ScrollBarImageColor3 = isRage and Color3.fromRGB(220, 50, 50) or Color3.fromRGB(45, 100, 210)
            sf.Visible = false
            sf.Parent = ContentArea

            local layout = Instance.new("UIListLayout")
            layout.SortOrder = Enum.SortOrder.LayoutOrder
            layout.Padding = UDim.new(0, 10)
            layout.Parent = sf

            pages[key] = sf
            return sf
        end

        local combatPage = createTabContent("Combat")
        local visualsPage = createTabContent("Visuals")
        local movementPage = isRage and createTabContent("Movement") or nil
        local miscPage = createTabContent("Misc")
        local settingsPage = createTabContent("Settings")

        combatPage.Visible = true

        local function createTabButton(name, key)
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -12, 0, 40)
            btn.Position = UDim2.new(0, 6, 0, 0)
            btn.BackgroundColor3 = (key == "Combat") and (isRage and Color3.fromRGB(160, 40, 40) or Color3.fromRGB(45, 100, 210)) or Color3.fromRGB(20, 21, 30)
            btn.BorderSizePixel = 0
            btn.Text = "   " .. name
            btn.TextColor3 = (key == "Combat") and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(160, 165, 190)
            btn.TextSize = 12
            btn.Font = Enum.Font.GothamBold
            btn.TextXAlignment = Enum.TextXAlignment.Left
            btn.Parent = Sidebar

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = btn

            btn.MouseButton1Click:Connect(function()
                for k, page in pairs(pages) do page.Visible = (k == key) end
                for k, b in pairs(tabButtons) do
                    b.BackgroundColor3 = Color3.fromRGB(20, 21, 30)
                    b.TextColor3 = Color3.fromRGB(160, 165, 190)
                end
                btn.BackgroundColor3 = isRage and Color3.fromRGB(160, 40, 40) or Color3.fromRGB(45, 100, 210)
                btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            end)

            tabButtons[key] = btn
        end

        createTabButton(isRage and "🔥 Rage Bot" or "🎯 Legit Bot", "Combat")
        createTabButton("👁️ Görseller", "Visuals")
        if isRage then
            createTabButton("🏃 Movement", "Movement")
        end
        createTabButton("⚡ Diğer (Misc)", "Misc")
        createTabButton("⚙️ Ayarlar", "Settings")

        local function createToggle(parentPage, name, settingKey)
            local targetSettings = isRage and settingsRage or settingsLegit
            local Card = Instance.new("Frame")
            Card.Size = UDim2.new(1, -6, 0, 46)
            Card.BackgroundColor3 = Color3.fromRGB(17, 18, 27)
            Card.BorderSizePixel = 0
            Card.Parent = parentPage

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 8)
            Corner.Parent = Card

            local Stroke = Instance.new("UIStroke")
            Stroke.Color = Color3.fromRGB(32, 36, 50)
            Stroke.Thickness = 1
            Stroke.Parent = Card

            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(0.6, 0, 1, 0)
            Label.Position = UDim2.new(0, 14, 0, 0)
            Label.BackgroundTransparency = 1
            Label.Text = name
            Label.TextColor3 = Color3.fromRGB(220, 225, 240)
            Label.TextSize = 11.5
            Label.Font = Enum.Font.GothamMedium
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = Card

            local ToggleBtn = Instance.new("TextButton")
            ToggleBtn.Size = UDim2.new(0, 86, 0, 28)
            ToggleBtn.Position = UDim2.new(1, -96, 0.5, -14)
            ToggleBtn.BorderSizePixel = 0
            ToggleBtn.TextSize = 10.5
            ToggleBtn.Font = Enum.Font.GothamBold
            ToggleBtn.Parent = Card

            local BtnCorner = Instance.new("UICorner")
            BtnCorner.CornerRadius = UDim.new(0, 6)
            BtnCorner.Parent = ToggleBtn

            local function updateVisual()
                if targetSettings[settingKey] then
                    ToggleBtn.Text = "AKTİF"
                    ToggleBtn.TextColor3 = Color3.fromRGB(90, 255, 150)
                    ToggleBtn.BackgroundColor3 = Color3.fromRGB(15, 55, 30)
                else
                    ToggleBtn.Text = "KAPALI"
                    ToggleBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
                    ToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 32, 45)
                end
            end
            updateVisual()

            ToggleBtn.MouseButton1Click:Connect(function()
                targetSettings[settingKey] = not targetSettings[settingKey]
                updateVisual()
                showActionNotification(name, targetSettings[settingKey])
            end)
        end

        local function createSlider(parentPage, name, settingKey, minVal, maxVal)
            local targetSettings = isRage and settingsRage or settingsLegit
            local Card = Instance.new("Frame")
            Card.Size = UDim2.new(1, -6, 0, 56)
            Card.BackgroundColor3 = Color3.fromRGB(17, 18, 27)
            Card.BorderSizePixel = 0
            Card.Parent = parentPage

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 8)
            Corner.Parent = Card

            local Stroke = Instance.new("UIStroke")
            Stroke.Color = Color3.fromRGB(32, 36, 50)
            Stroke.Thickness = 1
            Stroke.Parent = Card

            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, -24, 0, 20)
            Label.Position = UDim2.new(0, 14, 0, 8)
            Label.BackgroundTransparency = 1
            Label.Text = name .. ": " .. tostring(targetSettings[settingKey])
            Label.TextColor3 = Color3.fromRGB(220, 225, 240)
            Label.TextSize = 11.5
            Label.Font = Enum.Font.GothamMedium
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = Card

            local SliderBar = Instance.new("Frame")
            SliderBar.Size = UDim2.new(1, -28, 0, 6)
            SliderBar.Position = UDim2.new(0, 14, 0, 36)
            SliderBar.BackgroundColor3 = Color3.fromRGB(28, 32, 45)
            SliderBar.BorderSizePixel = 0
            SliderBar.Parent = Card

            local BarCorner = Instance.new("UICorner")
            BarCorner.CornerRadius = UDim.new(0, 3)
            BarCorner.Parent = SliderBar

            local SliderFill = Instance.new("Frame")
            local initPercent = (targetSettings[settingKey] - minVal) / (maxVal - minVal)
            SliderFill.Size = UDim2.new(math.clamp(initPercent, 0, 1), 0, 1, 0)
            SliderFill.BackgroundColor3 = isRage and Color3.fromRGB(220, 50, 50) or Color3.fromRGB(45, 100, 210)
            SliderFill.BorderSizePixel = 0
            SliderFill.Parent = SliderBar

            local FillCorner = Instance.new("UICorner")
            FillCorner.CornerRadius = UDim.new(0, 3)
            FillCorner.Parent = SliderFill

            local dragging = false
            SliderBar.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = true end end)
            UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end end)
            UserInputService.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    local percent = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
                    local val = math.floor(minVal + (maxVal - minVal) * percent + 0.5)
                    targetSettings[settingKey] = val
                    SliderFill.Size = UDim2.new(percent, 0, 1, 0)
                    Label.Text = name .. ": " .. tostring(val)
                end
            end)
        end

        if isRage then
            createToggle(combatPage, "Rage Lock", "RageLock")
            createToggle(combatPage, "360° Global Aimbot", "Full360Aimbot")
            createToggle(combatPage, "Silent Aim", "SilentAim")
            createToggle(combatPage, "Auto Shoot", "AutoShoot")
            createToggle(combatPage, "Duvar Arkası Kontrol", "WallCheck")
            createToggle(combatPage, "TeamCheck", "TeamCheck")
            createSlider(combatPage, "FOV Yarıçapı", "FOVRadius", 50, 500)

            createToggle(visualsPage, "ESP Box", "ESPBox")
            createToggle(visualsPage, "Tracers", "Tracers")
            createToggle(visualsPage, "Name ESP", "NameESP")
            createToggle(visualsPage, "Distance ESP", "DistanceESP")
            createToggle(visualsPage, "Skeleton", "Skeleton")
            createToggle(visualsPage, "Chams", "Chams")

            createToggle(movementPage, "Fly", "Fly")
            createToggle(movementPage, "Noclip", "Noclip")
            createToggle(movementPage, "Spinbot", "Spinbot")
            createSlider(movementPage, "Speed", "Speed", 16, 200)
            createSlider(movementPage, "Jump Power", "JumpPower", 50, 300)

            createToggle(miscPage, "Hitbox Expander", "HitboxExpander")
            createSlider(miscPage, "Hitbox Boyutu", "HitboxSize", 2, 15)

            createModeSwitchPanel(settingsPage)
            createKeybindPanel(settingsPage)
            createWhitelistPanel(settingsPage)
            createUnloadPanel(settingsPage)
        else
            createToggle(combatPage, "Legit Aim", "LegitAim")
            createToggle(combatPage, "WallCheck", "WallCheck")
            createToggle(combatPage, "TeamCheck", "TeamCheck")
            createToggle(combatPage, "Legit FOV Göster", "LegitFOVVisible")
            createSlider(combatPage, "Smoothness", "Smoothness", 1, 15)
            createSlider(combatPage, "FOV Yarıçapı", "FOVRadius", 50, 300)

            createToggle(visualsPage, "ESPBox", "ESPBox")
            createToggle(visualsPage, "Tracers", "Tracers")
            createToggle(visualsPage, "Name ESP", "NameESP")
            createToggle(visualsPage, "Distance ESP", "DistanceESP")
            createToggle(visualsPage, "Skeleton", "Skeleton")
            createToggle(visualsPage, "Chams", "Chams")

            createModeSwitchPanel(settingsPage)
            createKeybindPanel(settingsPage)
            createWhitelistPanel(settingsPage)
            createUnloadPanel(settingsPage)
        end

        LoadBarFill.Size = UDim2.new(1, 0, 1, 0)
        PercentLabel.Text = "%100 - Tamamlandı!"
        task.wait(0.4)
        LoadScreen.Visible = false
        targetFrame.Visible = true
    end)
end

local function isVisible(targetPart)
    local Camera = workspace.CurrentCamera
    if not Camera then return false end
    local check = selectedMode == "Rage" and settingsRage.WallCheck or settingsLegit.WallCheck
    if not check then return true end
    local camPos = Camera.CFrame.Position
    local direction = targetPart.Position - camPos
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    if LocalPlayer.Character then params.FilterDescendantsInstances = {LocalPlayer.Character} end
    params.IgnoreWater = true
    
    local result = workspace:Raycast(camPos, direction, params)
    if result then
        if result.Instance:FindFirstAncestorOfClass("Model") == targetPart.Parent then return true end
    else
        return true
    end
    return false
end

local function isValidTarget(player)
    if not player or player == LocalPlayer then return false end
    if isWhitelisted(player) then return false end
    
    local activeSettings = selectedMode == "Rage" and settingsRage or settingsLegit
    if activeSettings and activeSettings.TeamCheck then
        if player.Team and LocalPlayer.Team and player.Team == LocalPlayer.Team then
            return false
        end
    end
    return true
end

-- RENDER VE AIMBOT DÖNGÜSÜ
RunService.RenderStepped:Connect(function()
    if not isScriptLoaded then return end
    local Camera = workspace.CurrentCamera
    if not Camera then return end

    if selectedMode == "Legit" then
        if settingsLegit.FOVEnabled and settingsLegit.LegitFOVVisible then
            fovCircleLegit.Visible = true
            fovCircleLegit.Radius = settingsLegit.FOVRadius
            fovCircleLegit.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        else
            fovCircleLegit.Visible = false
        end
    elseif selectedMode == "Rage" then
        if settingsRage.FOVEnabled and not settingsRage.Full360Aimbot then
            fovCircleRage.Visible = true
            fovCircleRage.Radius = settingsRage.FOVRadius
            fovCircleRage.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        else
            fovCircleRage.Visible = false
        end

        if LocalPlayer.Character then
            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            
            if humanoid then
                humanoid.WalkSpeed = settingsRage.Speed
                humanoid.JumpPower = settingsRage.JumpPower
            end

            if settingsRage.Noclip then
                for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end

            if settingsRage.Spinbot and hrp then
                hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(45), 0)
            end

            if settingsRage.Fly and hrp then
                local bv = hrp:FindFirstChild("AstraFlyVelocity")
                if not bv then
                    bv = Instance.new("BodyVelocity")
                    bv.Name = "AstraFlyVelocity"
                    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                    bv.Velocity = Vector3.new(0, 0, 0)
                    bv.Parent = hrp
                end
                local moveDir = humanoid.MoveDirection * settingsRage.Speed
                bv.Velocity = Vector3.new(moveDir.X, 0, moveDir.Z)
            else
                if hrp then
                    local bv = hrp:FindFirstChild("AstraFlyVelocity")
                    if bv then bv:Destroy() end
                end
            end
        end
    end

    if selectedMode == "Rage" and settingsRage.HitboxExpander then
        for _, p in ipairs(Players:GetPlayers()) do
            if isValidTarget(p) and p.Character then
                local head = p.Character:FindFirstChild("Head")
                if head then
                    head.Size = Vector3.new(settingsRage.HitboxSize, settingsRage.HitboxSize, settingsRage.HitboxSize)
                    head.Transparency = 0.5
                    head.CanCollide = false
                end
            end
        end
    end

    -- AIMBOT VE OTOMATİK ATEŞ
    local shouldAim = false
    if selectedMode == "Legit" then
        if settingsLegit.LegitAim and (rightMouseDown or mobileAimToggled) then
            shouldAim = true
        end
    elseif selectedMode == "Rage" then
        if settingsRage.RageLock or mobileAimToggled or settingsRage.Full360Aimbot then
            shouldAim = true
        end
    end

    if shouldAim then
        local bestTarget = nil
        local shortestDist = 999999
        local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

        for _, player in ipairs(Players:GetPlayers()) do
            if isValidTarget(player) and player.Character then
                local head = player.Character:FindFirstChild("Head")
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                if head and humanoid and humanoid.Health > 0 then
                    if isVisible(head) then
                        if selectedMode == "Rage" and settingsRage.Full360Aimbot then
                            local localHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            if localHRP then
                                local dist3D = (head.Position - localHRP.Position).Magnitude
                                if dist3D < shortestDist then
                                    shortestDist = dist3D
                                    bestTarget = head
                                end
                            end
                        else
                            local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
                            if onScreen then
                                local mouseDist = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
                                local maxFov = selectedMode == "Legit" and settingsLegit.FOVRadius or settingsRage.FOVRadius
                                if mouseDist < maxFov and mouseDist < shortestDist then
                                    shortestDist = mouseDist
                                    bestTarget = head
                                end
                            end
                        end
                    end
                end
            end
        end

        if bestTarget then
            local targetCF = CFrame.lookAt(Camera.CFrame.Position, bestTarget.Position)
            if selectedMode == "Legit" then
                local alpha = math.clamp(1 / settingsLegit.Smoothness, 0.05, 1)
                Camera.CFrame = Camera.CFrame:Lerp(targetCF, alpha)
            else
                Camera.CFrame = targetCF
            end

            if selectedMode == "Rage" and settingsRage.AutoShoot then
                local currentTime = os.clock()
                if currentTime - lastAutoShoot >= autoShootDelay then
                    lastAutoShoot = currentTime
                    task.spawn(triggerShoot)
                end
            end
        end
    end

    local activeSettings = selectedMode == "Rage" and settingsRage or settingsLegit
    local dynamicColor = (selectedMode == "Rage") and Color3.fromRGB(220, 50, 50) or Color3.fromRGB(45, 100, 210)

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local isValid = isValidTarget(player)
            local chamsAct = activeSettings and activeSettings.Chams and isValid
            local highlight = player.Character:FindFirstChild("AstraChams")

            if chamsAct then
                if not highlight then
                    highlight = Instance.new("Highlight")
                    highlight.Name = "AstraChams"
                    highlight.FillColor = dynamicColor
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.FillTransparency = 0.5
                    highlight.OutlineTransparency = 0
                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    highlight.Parent = player.Character
                else
                    highlight.FillColor = dynamicColor
                    highlight.Enabled = true
                end
            else
                if highlight then highlight:Destroy() end
            end
        end
    end

    for player, drawings in pairs(activeDrawings) do
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local humanoid = char and char:FindFirstChildOfClass("Humanoid")
        
        local isValid = isValidTarget(player)
        local boxAct = activeSettings and activeSettings.ESPBox and isValid
        local nameAct = activeSettings and activeSettings.NameESP and isValid
        local distAct = activeSettings and activeSettings.DistanceESP and isValid

        drawings.Box.Color = dynamicColor

        if hrp and humanoid and humanoid.Health > 0 then
            local vector, onScreen = Camera:WorldToViewportPoint(hrp.Position)
            if onScreen then
                local head = char:FindFirstChild("Head")
                if head then
                    local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                    local rootPos = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
                    
                    local height = math.abs(headPos.Y - rootPos.Y)
                    local width = height / 2.2
                    local boxPosition = Vector2.new(vector.X - width / 2, headPos.Y)

                    if boxAct then
                        drawings.Box.Size = Vector2.new(width, height)
                        drawings.Box.Position = boxPosition
                        drawings.Box.Visible = true
                    else drawings.Box.Visible = false end

                    if nameAct then
                        drawings.Name.Text = player.Name
                        drawings.Name.Position = Vector2.new(boxPosition.X + (width / 2), boxPosition.Y - 16)
                        drawings.Name.Visible = true
                    else drawings.Name.Visible = false end

                    if distAct and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        local dist = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude)
                        drawings.Dist.Text = "[" .. tostring(dist) .. "m]"
                        drawings.Dist.Position = Vector2.new(boxPosition.X + (width / 2), boxPosition.Y + height + 2)
                        drawings.Dist.Visible = true
                    else drawings.Dist.Visible = false end
                else
                    drawings.Box.Visible = false; drawings.Name.Visible = false; drawings.Dist.Visible = false
                end
            else
                drawings.Box.Visible = false; drawings.Name.Visible = false; drawings.Dist.Visible = false
            end
        else
            drawings.Box.Visible = false; drawings.Name.Visible = false; drawings.Dist.Visible = false
        end
    end

    for player, line in pairs(activeTracers) do
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local humanoid = char and char:FindFirstChildOfClass("Humanoid")
        local isValid = isValidTarget(player)
        local tracerAct = activeSettings and activeSettings.Tracers and isValid

        line.Color = dynamicColor

        if tracerAct and hrp and humanoid and humanoid.Health > 0 then
            local screenPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
            if onScreen then
                line.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                line.To = Vector2.new(screenPos.X, screenPos.Y)
                line.Visible = true
            else line.Visible = false end
        else line.Visible = false end
    end

    for player, bones in pairs(activeSkeletons) do
        local char = player.Character
        local humanoid = char and char:FindFirstChildOfClass("Humanoid")
        local isValid = isValidTarget(player)
        local skelAct = activeSettings and activeSettings.Skeleton and isValid

        for _, boneLine in ipairs(bones) do boneLine.Color = dynamicColor end

        if skelAct and humanoid and humanoid.Health > 0 then
            local isR15 = humanoid.RigType == Enum.HumanoidRigType.R15
            local limbPairs = {}

            if isR15 then
                limbPairs = {
                    {char:FindFirstChild("Head"), char:FindFirstChild("UpperTorso")},
                    {char:FindFirstChild("UpperTorso"), char:FindFirstChild("LowerTorso")},
                    {char:FindFirstChild("UpperTorso"), char:FindFirstChild("LeftUpperArm")},
                    {char:FindFirstChild("LeftUpperArm"), char:FindFirstChild("LeftLowerArm")},
                    {char:FindFirstChild("LeftLowerArm"), char:FindFirstChild("LeftHand")},
                    {char:FindFirstChild("UpperTorso"), char:FindFirstChild("RightUpperArm")},
                    {char:FindFirstChild("RightUpperArm"), char:FindFirstChild("RightLowerArm")},
                    {char:FindFirstChild("RightLowerArm"), char:FindFirstChild("RightHand")},
                    {char:FindFirstChild("LowerTorso"), char:FindFirstChild("LeftUpperLeg")},
                    {char:FindFirstChild("LeftUpperLeg"), char:FindFirstChild("LeftLowerLeg")},
                    {char:FindFirstChild("LeftLowerLeg"), char:FindFirstChild("LeftFoot")},
                    {char:FindFirstChild("LowerTorso"), char:FindFirstChild("RightUpperLeg")},
                    {char:FindFirstChild("RightUpperLeg"), char:FindFirstChild("RightLowerLeg")},
                    {char:FindFirstChild("RightLowerLeg"), char:FindFirstChild("RightFoot")}
                }
            else
                local torso = char:FindFirstChild("Torso")
                limbPairs = {
                    {char:FindFirstChild("Head"), torso},
                    {torso, char:FindFirstChild("Left Arm")},
                    {torso, char:FindFirstChild("Right Arm")},
                    {torso, char:FindFirstChild("Left Leg")},
                    {torso, char:FindFirstChild("Right Leg")}
                }
            end

            for i = 1, #bones do
                local boneLine = bones[i]
                local pair = limbPairs[i]
                if pair and pair[1] and pair[2] and boneLine then
                    local posA, onA = Camera:WorldToViewportPoint(pair[1].Position)
                    local posB, onB = Camera:WorldToViewportPoint(pair[2].Position)
                    if onA or onB then
                        boneLine.From = Vector2.new(posA.X, posA.Y)
                        boneLine.To = Vector2.new(posB.X, posB.Y)
                        boneLine.Visible = true
                    else boneLine.Visible = false end
                else
                    if boneLine then boneLine.Visible = false end
                end
            end
        else
            for _, boneLine in ipairs(bones) do boneLine.Visible = false end

            print ("AstraOS Fps Game Cheat Hazır")
        end
    end
end)
