--[================================================================]--
--  AstraOS Suite - Mobil Uyumlu Güncellenmiş Sürüm (Mobile Support + Whitelist)
--[================================================================]--

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

--------------------------------------------------------------------------------
-- [ YENİ ] WHITELIST (BEYAZ LİSTE) AYARLARI
-- Aim almasını istemediğin oyuncuların kullanıcı adlarını (Username) buraya ekle.
-- Örnek: {"KullaniciAdi1", "KullaniciAdi2"}
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

-- OYUN ANALİZİ (RemoteEvent, RemoteFunction ve Shoot Remote Tespiti)
local detectedShootRemote = nil
local allRemotes = {}

local function scanForRemotes(parent)
    for _, child in ipairs(parent:GetChildren()) do
        if child:IsA("RemoteEvent") or child:IsA("RemoteFunction") then
            table.insert(allRemotes, child)
            local nameLower = string.lower(child.Name)
            if nameLower:find("shoot") or nameLower:find("fire") or nameLower:find("gun") or nameLower:find("bullet") or nameLower:find("hit") or nameLower:find("damage") or nameLower:find("weapon") or nameLower:find("attack") then
                detectedShootRemote = child
            end
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

-- MODERN SCREEN GUI OLUŞTURMA
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AstraOS_Suite"
ScreenGui.ResetOnSpawn = false
pcall(function()
    ScreenGui.Parent = CoreGui
end)
if not ScreenGui.Parent then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- KEY SISTEMI EKRANI
local KeyScreen = Instance.new("Frame")
KeyScreen.Size = UDim2.new(0, 320, 0, 200)
KeyScreen.Position = UDim2.new(0.5, -160, 0.5, -100)
KeyScreen.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
KeyScreen.BorderSizePixel = 0
KeyScreen.Active = true
KeyScreen.Draggable = true
KeyScreen.Parent = ScreenGui

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 14)
KeyCorner.Parent = KeyScreen

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Color = Color3.fromRGB(150, 40, 40)
KeyStroke.Thickness = 1.8
KeyStroke.Parent = KeyScreen

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 40)
KeyTitle.Position = UDim2.new(0, 0, 0, 15)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "AstraOS - Key Girişi"
KeyTitle.TextColor3 = Color3.fromRGB(255, 90, 90)
KeyTitle.TextSize = 14
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.Parent = KeyScreen

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(1, -40, 0, 40)
KeyBox.Position = UDim2.new(0, 20, 0, 65)
KeyBox.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
KeyBox.BorderSizePixel = 0
KeyBox.PlaceholderText = "Key'i buraya girin (AstraRage)"
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
LoginBtn.BackgroundColor3 = Color3.fromRGB(120, 30, 30)
LoginBtn.BorderSizePixel = 0
LoginBtn.Text = "Devam Et"
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

-- MOD SEÇİM EKRANI (Legit / Rage)
local ModeScreen = Instance.new("Frame")
ModeScreen.Size = UDim2.new(0, 340, 0, 180)
ModeScreen.Position = UDim2.new(0.5, -170, 0.5, -90)
ModeScreen.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
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
ModeTitle.TextColor3 = Color3.fromRGB(220, 220, 255)
ModeTitle.TextSize = 13
ModeTitle.Font = Enum.Font.GothamBold
ModeTitle.Parent = ModeScreen

local LegitSelectBtn = Instance.new("TextButton")
LegitSelectBtn.Size = UDim2.new(1, -40, 0, 45)
LegitSelectBtn.Position = UDim2.new(0, 20, 0, 65)
LegitSelectBtn.BackgroundColor3 = Color3.fromRGB(30, 80, 160)
LegitSelectBtn.BorderSizePixel = 0
LegitSelectBtn.Text = "🛡️ Legit Mod (Smooth & Gizli)"
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
RageSelectBtn.BackgroundColor3 = Color3.fromRGB(140, 30, 30)
RageSelectBtn.BorderSizePixel = 0
RageSelectBtn.Text = "🔥 Rage Mod (Aimbot & Full Güç)"
RageSelectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RageSelectBtn.TextSize = 12
RageSelectBtn.Font = Enum.Font.GothamBold
RageSelectBtn.Parent = ModeScreen

local RageCorner = Instance.new("UICorner")
RageCorner.CornerRadius = UDim.new(0, 8)
RageCorner.Parent = RageSelectBtn

-- YÜKLENME EKRANI
local LoadScreen = Instance.new("Frame")
LoadScreen.Size = UDim2.new(0, 300, 0, 110)
LoadScreen.Position = UDim2.new(0.5, -150, 0.5, -55)
LoadScreen.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
LoadScreen.BorderSizePixel = 0
LoadScreen.Visible = false
LoadScreen.Parent = ScreenGui

local LoadCorner = Instance.new("UICorner")
LoadCorner.CornerRadius = UDim.new(0, 14)
LoadCorner.Parent = LoadScreen

local LoadStroke = Instance.new("UIStroke")
LoadStroke.Color = Color3.fromRGB(150, 40, 40)
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
LoadBarBack.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
LoadBarBack.BorderSizePixel = 0
LoadBarBack.Parent = LoadScreen

local BarCorner = Instance.new("UICorner")
BarCorner.CornerRadius = UDim.new(0, 4)
BarCorner.Parent = LoadBarBack

local LoadBarFill = Instance.new("Frame")
LoadBarFill.Size = UDim2.new(0, 0, 1, 0)
LoadBarFill.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
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

-- ANA PANELLER
local MainFrameRage = Instance.new("Frame")
MainFrameRage.Size = UDim2.new(0, 520, 0, 480)
MainFrameRage.Position = UDim2.new(0.5, -260, 0.5, -240)
MainFrameRage.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrameRage.BorderSizePixel = 0
MainFrameRage.Active = true
MainFrameRage.Draggable = true
MainFrameRage.Visible = false
MainFrameRage.Parent = ScreenGui

local MainFrameLegit = Instance.new("Frame")
MainFrameLegit.Size = UDim2.new(0, 520, 0, 480)
MainFrameLegit.Position = UDim2.new(0.5, -260, 0.5, -240)
MainFrameLegit.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrameLegit.BorderSizePixel = 0
MainFrameLegit.Active = true
MainFrameLegit.Draggable = true
MainFrameLegit.Visible = false
MainFrameLegit.Parent = ScreenGui

-- Ayarlar (Rage ve Legit)
local settingsRage = {
    RageLock = false,
    SilentAim = false,
    AutoShoot = false,
    FOVEnabled = true,
    FOVRadius = 300,
    WallCheck = true,
    
    ESPBox = false,
    Tracers = true,
    NameESP = false,
    DistanceESP = false,
    Chams = false,
    
    SpeedBoost = false,
    JumpBoost = false,
    Bhop = false,
    Noclip = false,
    Fly = false,
    Spinbot = false,
    HitboxExpander = true,
    HitboxSize = 6
}

local settingsLegit = {
    LegitAim = false,
    Smoothness = 5,
    FOVEnabled = true,
    FOVRadius = 150,
    WallCheck = true,
    LegitFOVVisible = true,
    
    ESPBox = true,
    Tracers = false,
    NameESP = true,
    DistanceESP = true,
    Chams = false
}

local rightMouseDown = false
local leftMouseDown = false
local baseWalkSpeed = 16
local baseJumpPower = 50
local lastShootTick = 0
local shootCooldown = 0.04
local selectedMode = nil
local toggleReferences = {}

-- MOBIL KONTROL DURUMLARI (Button States)
local mobileAimToggled = false

-- MOBIL ARAYÜZ ELEMANLARI (Floating Buttons for Mobile)
local MobileScreenGui = Instance.new("ScreenGui")
MobileScreenGui.Name = "AstraOS_MobileOverlay"
MobileScreenGui.ResetOnSpawn = false
pcall(function()
    MobileScreenGui.Parent = CoreGui
end)
if not MobileScreenGui.Parent then
    MobileScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- 1. Menü Aç/Kapat Butonu
local ToggleMenuMobBtn = Instance.new("TextButton")
ToggleMenuMobBtn.Size = UDim2.new(0, 55, 0, 55)
ToggleMenuMobBtn.Position = UDim2.new(0, 20, 0.4, 0)
ToggleMenuMobBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
ToggleMenuMobBtn.BorderSizePixel = 0
ToggleMenuMobBtn.Text = "📂 MENÜ"
ToggleMenuMobBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleMenuMobBtn.TextSize = 10
ToggleMenuMobBtn.Font = Enum.Font.GothamBold
ToggleMenuMobBtn.Active = true
ToggleMenuMobBtn.Draggable = true
ToggleMenuMobBtn.Parent = MobileScreenGui

local MobMenuCorner = Instance.new("UICorner")
MobMenuCorner.CornerRadius = UDim.new(1, 0)
MobMenuCorner.Parent = ToggleMenuMobBtn

local MobMenuStroke = Instance.new("UIStroke")
MobMenuStroke.Color = Color3.fromRGB(150, 40, 40)
MobMenuStroke.Thickness = 2
MobMenuStroke.Parent = ToggleMenuMobBtn

-- 2. Otomatik Aim / Hedef Alma Butonu (Rage / Legit için dinamik)
local AimMobBtn = Instance.new("TextButton")
AimMobBtn.Size = UDim2.new(0, 65, 0, 65)
AimMobBtn.Position = UDim2.new(1, -85, 0.5, -30)
AimMobBtn.BackgroundColor3 = Color3.fromRGB(120, 30, 30)
AimMobBtn.BorderSizePixel = 0
AimMobBtn.Text = "🎯 AIM: KAPALI"
AimMobBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AimMobBtn.TextSize = 9
AimMobBtn.Font = Enum.Font.GothamBold
AimMobBtn.Active = true
AimMobBtn.Draggable = true
AimMobBtn.Visible = false -- Mod seçildikten sonra aktif olacak
AimMobBtn.Parent = MobileScreenGui

local MobAimCorner = Instance.new("UICorner")
MobAimCorner.CornerRadius = UDim.new(1, 0)
MobAimCorner.Parent = AimMobBtn

local MobAimStroke = Instance.new("UIStroke")
MobAimStroke.Color = Color3.fromRGB(255, 90, 90)
MobAimStroke.Thickness = 2
MobAimStroke.Parent = AimMobBtn

-- FOV Çemberleri
local fovCircleRage = Drawing.new("Circle")
fovCircleRage.Visible = false
fovCircleRage.Transparency = 0.6
fovCircleRage.Color = Color3.fromRGB(255, 50, 50)
fovCircleRage.Thickness = 1.5
fovCircleRage.NumSides = 32
fovCircleRage.Radius = settingsRage.FOVRadius
fovCircleRage.Filled = false

local fovCircleLegit = Drawing.new("Circle")
fovCircleLegit.Visible = false
fovCircleLegit.Transparency = 0.4
fovCircleLegit.Color = Color3.fromRGB(50, 120, 255)
fovCircleLegit.Thickness = 1
fovCircleLegit.NumSides = 32
fovCircleLegit.Radius = settingsLegit.FOVRadius
fovCircleLegit.Filled = false

-- Tracer Çizgileri
local activeTracers = {}

local function createTracer(player)
    if activeTracers[player] then return end
    local line = Drawing.new("Line")
    line.Visible = false
    line.Color = Color3.fromRGB(255, 50, 50)
    line.Thickness = 1.2
    line.Transparency = 0.7
    activeTracers[player] = line
end

local function removeTracer(player)
    if activeTracers[player] then
        activeTracers[player]:Remove()
        activeTracers[player] = nil
    end
end

for _, p in ipairs(Players:GetPlayers()) do
    if p ~= LocalPlayer then createTracer(p) end
end
Players.PlayerAdded:Connect(function(p)
    if p ~= LocalPlayer then createTracer(p) end
end)
Players.PlayerRemoving:Connect(removeTracer)

-- Kill Sound
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
                pcall(function() killSound:Play() end)
            end)
        end
    end
    player.CharacterAdded:Connect(onCharacterAdded)
    if player.Character then onCharacterAdded(player.Character) end
end

for _, p in ipairs(Players:GetPlayers()) do monitorPlayerDeath(p) end
Players.PlayerAdded:Connect(monitorPlayerDeath)

-- Mouse Tuşları
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.MouseButton2 then rightMouseDown = true
    elseif input.UserInputType == Enum.UserInputType.MouseButton1 then leftMouseDown = true end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then rightMouseDown = false
    elseif input.UserInputType == Enum.UserInputType.MouseButton1 then leftMouseDown = false end
end)

-- Mobil Menü Açma/Kapatma Buton İşlevi
ToggleMenuMobBtn.MouseButton1Click:Connect(function()
    if selectedMode == "Legit" then
        MainFrameLegit.Visible = not MainFrameLegit.Visible
    elseif selectedMode == "Rage" then
        MainFrameRage.Visible = not MainFrameRage.Visible
    end
end)

-- Mobil Aim Butonu İşlevi (Aç/Kapat Toggle)
AimMobBtn.MouseButton1Click:Connect(function()
    mobileAimToggled = not mobileAimToggled
    if mobileAimToggled then
        AimMobBtn.Text = "🎯 AIM: AÇIK"
        AimMobBtn.BackgroundColor3 = Color3.fromRGB(40, 140, 60)
        MobAimStroke.Color = Color3.fromRGB(90, 255, 140)
    else
        AimMobBtn.Text = "🎯 AIM: KAPALI"
        AimMobBtn.BackgroundColor3 = Color3.fromRGB(120, 30, 30)
        MobAimStroke.Color = Color3.fromRGB(255, 90, 90)
    end
end)

-- Key Onaylama
LoginBtn.MouseButton1Click:Connect(function()
    if KeyBox.Text == "AstraRage" then
        KeyScreen:Destroy()
        ModeScreen.Visible = true
    else
        StatusLabel.Text = "Geçersiz Key! Doğru Key: AstraRage"
        task.wait(2)
        StatusLabel.Text = ""
    end
end)

-- Mod Seçim Butonları
LegitSelectBtn.MouseButton1Click:Connect(function()
    selectedMode = "Legit"
    ModeScreen:Destroy()
    AimMobBtn.Visible = true
    AimMobBtn.BackgroundColor3 = Color3.fromRGB(30, 80, 160)
    MobAimStroke.Color = Color3.fromRGB(90, 150, 255)
    startLoadingAndBuildUI(false)
end)

RageSelectBtn.MouseButton1Click:Connect(function()
    selectedMode = "Rage"
    ModeScreen:Destroy()
    AimMobBtn.Visible = true
    startLoadingAndBuildUI(true)
end)

-- Yüklenme ve Arayüz Oluşturucu
function startLoadingAndBuildUI(isRage)
    LoadScreen.Visible = true
    LoadBarFill.BackgroundColor3 = isRage and Color3.fromRGB(220, 50, 50) or Color3.fromRGB(50, 120, 255)
    LoadStroke.Color = isRage and Color3.fromRGB(150, 40, 40) or Color3.fromRGB(40, 90, 180)

    task.spawn(function()
        LoadBarFill.Size = UDim2.new(0.3, 0, 1, 0)
        PercentLabel.Text = "%30 - Modüller yükleniyor..."
        task.wait(0.2)

        local targetFrame = isRage and MainFrameRage or MainFrameLegit
        
        local MainCorner = Instance.new("UICorner")
        MainCorner.CornerRadius = UDim.new(0, 14)
        MainCorner.Parent = targetFrame

        local MainStroke = Instance.new("UIStroke")
        MainStroke.Color = isRage and Color3.fromRGB(150, 40, 40) or Color3.fromRGB(40, 90, 180)
        MainStroke.Thickness = 1.8
        MainStroke.Parent = targetFrame

        local TopBar = Instance.new("Frame")
        TopBar.Size = UDim2.new(1, 0, 0, 50)
        TopBar.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
        TopBar.BorderSizePixel = 0
        TopBar.Parent = targetFrame

        local TopBarCorner = Instance.new("UICorner")
        TopBarCorner.CornerRadius = UDim.new(0, 14)
        TopBarCorner.Parent = TopBar

        local TopBarFix = Instance.new("Frame")
        TopBarFix.Size = UDim2.new(1, 0, 0, 10)
        TopBarFix.Position = UDim2.new(0, 0, 1, -10)
        TopBarFix.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
        TopBarFix.BorderSizePixel = 0
        TopBarFix.Parent = TopBar

        local Title = Instance.new("TextLabel")
        Title.Size = UDim2.new(1, -20, 1, 0)
        Title.Position = UDim2.new(0, 15, 0, 0)
        Title.BackgroundTransparency = 1
        Title.Text = isRage and "AstraOS [RAGE SUITE - MOBILE]" or "AstraOS [LEGIT SUITE - MOBILE]"
        Title.TextColor3 = isRage and Color3.fromRGB(255, 90, 90) or Color3.fromRGB(90, 150, 255)
        Title.TextSize = 15
        Title.Font = Enum.Font.GothamBold
        Title.TextXAlignment = Enum.TextXAlignment.Left
        Title.Parent = TopBar

        local SubTitle = Instance.new("TextLabel")
        SubTitle.Size = UDim2.new(1, -20, 1, 0)
        SubTitle.Position = UDim2.new(0, 15, 12, 0)
        SubTitle.BackgroundTransparency = 1
        SubTitle.Text = isRage and "[MENÜ Butonu]: Aç/Kapat | [AIM Butonu]: Otomatik Nişan" or "[MENÜ Butonu]: Aç/Kapat | [AIM Butonu]: Smooth Aim"
        SubTitle.TextColor3 = Color3.fromRGB(150, 150, 180)
        SubTitle.TextSize = 10
        SubTitle.Font = Enum.Font.Gotham
        SubTitle.TextXAlignment = Enum.TextXAlignment.Left
        SubTitle.Parent = TopBar

        LoadBarFill.Size = UDim2.new(0.8, 0, 1, 0)
        PercentLabel.Text = "%80 - Arayüz yerleştiriliyor..."
        task.wait(0.2)

        if not isRage then
            -- LEGIT MENÜ İÇERİĞİ
            local Sidebar = Instance.new("Frame")
            Sidebar.Size = UDim2.new(0, 130, 1, -60)
            Sidebar.Position = UDim2.new(0, 10, 0, 55)
            Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
            Sidebar.BorderSizePixel = 0
            Sidebar.Parent = MainFrameLegit

            local SidebarCorner = Instance.new("UICorner")
            SidebarCorner.CornerRadius = UDim.new(0, 10)
            SidebarCorner.Parent = Sidebar

            local SidebarLayout = Instance.new("UIListLayout")
            SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
            SidebarLayout.Padding = UDim.new(0, 6)
            SidebarLayout.Parent = Sidebar

            local ContentArea = Instance.new("Frame")
            ContentArea.Size = UDim2.new(1, -155, 1, -60)
            ContentArea.Position = UDim2.new(0, 145, 0, 55)
            ContentArea.BackgroundTransparency = 1
            ContentArea.Parent = MainFrameLegit

            local pages = {}
            local tabButtons = {}

            local function createLegitTabContent(key)
                local sf = Instance.new("ScrollingFrame")
                sf.Size = UDim2.new(1, 0, 1, 0)
                sf.BackgroundTransparency = 1
                sf.BorderSizePixel = 0
                sf.CanvasSize = UDim2.new(0, 0, 0, 450)
                sf.ScrollBarThickness = 3
                sf.ScrollBarImageColor3 = Color3.fromRGB(40, 90, 180)
                sf.Visible = (key == "Legit")
                sf.Parent = ContentArea

                local layout = Instance.new("UIListLayout")
                layout.SortOrder = Enum.SortOrder.LayoutOrder
                layout.Padding = UDim.new(0, 8)
                layout.Parent = sf

                pages[key] = sf
                return sf
            end

            local legitPage = createLegitTabContent("Legit")
            local legitVisualsPage = createLegitTabContent("Visuals")

            local function createLegitTabButton(name, key)
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, -12, 0, 38)
                btn.Position = UDim2.new(0, 6, 0, 0)
                btn.BackgroundColor3 = (key == "Legit") and Color3.fromRGB(30, 80, 160) or Color3.fromRGB(28, 28, 38)
                btn.BorderSizePixel = 0
                btn.Text = name
                btn.TextColor3 = (key == "Legit") and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(160, 160, 190)
                btn.TextSize = 12
                btn.Font = Enum.Font.GothamBold
                btn.Parent = Sidebar

                local corner = Instance.new("UICorner")
                corner.CornerRadius = UDim.new(0, 8)
                corner.Parent = btn

                btn.MouseButton1Click:Connect(function()
                    for k, page in pairs(pages) do page.Visible = (k == key) end
                    for k, b in pairs(tabButtons) do
                        b.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
                        b.TextColor3 = Color3.fromRGB(160, 160, 190)
                    end
                    btn.BackgroundColor3 = Color3.fromRGB(30, 80, 160)
                    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                end)

                tabButtons[key] = btn
            end

            createLegitTabButton("🛡️ Legit", "Legit")
            createLegitTabButton("👁️ Visuals", "Visuals")

            local function createLegitToggle(parentPage, name, settingKey)
                local Card = Instance.new("Frame")
                Card.Size = UDim2.new(1, -6, 0, 42)
                Card.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
                Card.BorderSizePixel = 0
                Card.Parent = parentPage

                local CardCorner = Instance.new("UICorner")
                CardCorner.CornerRadius = UDim.new(0, 8)
                CardCorner.Parent = Card

                local Label = Instance.new("TextLabel")
                Label.Size = UDim2.new(0.6, 0, 1, 0)
                Label.Position = UDim2.new(0, 12, 0, 0)
                Label.BackgroundTransparency = 1
                Label.Text = name
                Label.TextColor3 = Color3.fromRGB(210, 210, 230)
                Label.TextSize = 11
                Label.Font = Enum.Font.GothamMedium
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.Parent = Card

                local ToggleBtn = Instance.new("TextButton")
                ToggleBtn.Size = UDim2.new(0, 85, 0, 26)
                ToggleBtn.Position = UDim2.new(1, -95, 0.5, -13)
                ToggleBtn.BorderSizePixel = 0
                ToggleBtn.TextSize = 10
                ToggleBtn.Font = Enum.Font.GothamBold
                ToggleBtn.Parent = Card

                local BtnCorner = Instance.new("UICorner")
                BtnCorner.CornerRadius = UDim.new(0, 6)
                BtnCorner.Parent = ToggleBtn

                local function updateVisual()
                    if settingsLegit[settingKey] then
                        ToggleBtn.Text = "AÇIK"
                        ToggleBtn.TextColor3 = Color3.fromRGB(90, 255, 140)
                        ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 65, 40)
                    else
                        ToggleBtn.Text = "KAPALI"
                        ToggleBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
                        ToggleBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
                    end
                end
                updateVisual()

                ToggleBtn.MouseButton1Click:Connect(function()
                    settingsLegit[settingKey] = not settingsLegit[settingKey]
                    updateVisual()
                end)
            end

            local function createLegitSlider(parentPage, name, settingKey, minVal, maxVal)
                local Card = Instance.new("Frame")
                Card.Size = UDim2.new(1, -6, 0, 52)
                Card.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
                Card.BorderSizePixel = 0
                Card.Parent = parentPage

                local CardCorner = Instance.new("UICorner")
                CardCorner.CornerRadius = UDim.new(0, 8)
                CardCorner.Parent = Card

                local Label = Instance.new("TextLabel")
                Label.Size = UDim2.new(1, -20, 0, 20)
                Label.Position = UDim2.new(0, 12, 0, 6)
                Label.BackgroundTransparency = 1
                Label.Text = name .. ": " .. tostring(settingsLegit[settingKey])
                Label.TextColor3 = Color3.fromRGB(210, 210, 230)
                Label.TextSize = 11
                Label.Font = Enum.Font.GothamMedium
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.Parent = Card

                local SliderBar = Instance.new("Frame")
                SliderBar.Size = UDim2.new(1, -24, 0, 6)
                SliderBar.Position = UDim2.new(0, 12, 0, 34)
                SliderBar.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
                SliderBar.BorderSizePixel = 0
                SliderBar.Parent = Card

                local BarCorner = Instance.new("UICorner")
                BarCorner.CornerRadius = UDim.new(0, 3)
                BarCorner.Parent = SliderBar

                local SliderFill = Instance.new("Frame")
                local initPercent = (settingsLegit[settingKey] - minVal) / (maxVal - minVal)
                SliderFill.Size = UDim2.new(math.clamp(initPercent, 0, 1), 0, 1, 0)
                SliderFill.BackgroundColor3 = Color3.fromRGB(50, 120, 255)
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
                        local mousePos = input.Position
                        local barPos = SliderBar.AbsolutePosition
                        local barSize = SliderBar.AbsoluteSize
                        local percent = math.clamp((mousePos.X - barPos.X) / barSize.X, 0, 1)
                        SliderFill.Size = UDim2.new(percent, 0, 1, 0)
                        local val = math.floor(minVal + (maxVal - minVal) * percent + 0.5)
                        settingsLegit[settingKey] = val
                        Label.Text = name .. ": " .. tostring(val)
                    end
                end)
            end

            createLegitToggle(legitPage, "Legit Aim (Mobil Düğme ile Aktif)", "LegitAim")
            createLegitToggle(legitPage, "Duvar Arkası (WallCheck)", "WallCheck")
            createLegitToggle(legitPage, "Legit FOV Çemberini Göster", "LegitFOVVisible")
            createLegitSlider(legitPage, "Smoothness", "Smoothness", 1, 15)
            createLegitSlider(legitPage, "FOV Yarıçapı", "FOVRadius", 50, 300)

            createLegitToggle(legitVisualsPage, "ESP Box (Kutu)", "ESPBox")
            createLegitToggle(legitVisualsPage, "Tracers (Çizgi)", "Tracers")
            createLegitToggle(legitVisualsPage, "Name ESP (İsimler)", "NameESP")
            createLegitToggle(legitVisualsPage, "Distance ESP (Mesafe)", "DistanceESP")
            createLegitToggle(legitVisualsPage, "Chams (Model Aydınlatma)", "Chams")

        else
            -- RAGE MENÜ İÇERİĞİ
            local Sidebar = Instance.new("Frame")
            Sidebar.Size = UDim2.new(0, 130, 1, -60)
            Sidebar.Position = UDim2.new(0, 10, 0, 55)
            Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
            Sidebar.BorderSizePixel = 0
            Sidebar.Parent = MainFrameRage

            local SidebarCorner = Instance.new("UICorner")
            SidebarCorner.CornerRadius = UDim.new(0, 10)
            SidebarCorner.Parent = Sidebar

            local SidebarLayout = Instance.new("UIListLayout")
            SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
            SidebarLayout.Padding = UDim.new(0, 6)
            SidebarLayout.Parent = Sidebar

            local ContentArea = Instance.new("Frame")
            ContentArea.Size = UDim2.new(1, -155, 1, -60)
            ContentArea.Position = UDim2.new(0, 145, 0, 55)
            ContentArea.BackgroundTransparency = 1
            ContentArea.Parent = MainFrameRage

            local pages = {}
            local tabButtons = {}

            local function createTabContent(key)
                local sf = Instance.new("ScrollingFrame")
                sf.Size = UDim2.new(1, 0, 1, 0)
                sf.BackgroundTransparency = 1
                sf.BorderSizePixel = 0
                sf.CanvasSize = UDim2.new(0, 0, 0, 560)
                sf.ScrollBarThickness = 3
                sf.ScrollBarImageColor3 = Color3.fromRGB(120, 40, 40)
                sf.Visible = (key == "Rage")
                sf.Parent = ContentArea

                local layout = Instance.new("UIListLayout")
                layout.SortOrder = Enum.SortOrder.LayoutOrder
                layout.Padding = UDim.new(0, 8)
                layout.Parent = sf

                pages[key] = sf
                return sf
            end

            local ragePage = createTabContent("Rage")
            local visualsPage = createTabContent("Visuals")
            local movementPage = createTabContent("Movement")

            local function createTabButton(name, key)
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, -12, 0, 38)
                btn.Position = UDim2.new(0, 6, 0, 0)
                btn.BackgroundColor3 = (key == "Rage") and Color3.fromRGB(120, 30, 30) or Color3.fromRGB(28, 28, 38)
                btn.BorderSizePixel = 0
                btn.Text = name
                btn.TextColor3 = (key == "Rage") and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(160, 160, 190)
                btn.TextSize = 12
                btn.Font = Enum.Font.GothamBold
                btn.Parent = Sidebar

                local corner = Instance.new("UICorner")
                corner.CornerRadius = UDim.new(0, 8)
                corner.Parent = btn

                btn.MouseButton1Click:Connect(function()
                    for k, page in pairs(pages) do page.Visible = (k == key) end
                    for k, b in pairs(tabButtons) do
                        b.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
                        b.TextColor3 = Color3.fromRGB(160, 160, 190)
                    end
                    btn.BackgroundColor3 = Color3.fromRGB(120, 30, 30)
                    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                end)

                tabButtons[key] = btn
            end

            createTabButton("🔥 Rage", "Rage")
            createTabButton("👁️ Visuals", "Visuals")
            createTabButton("🏃 Movement", "Movement")

            local function createAbilityToggle(parentPage, name, settingKey)
                local Card = Instance.new("Frame")
                Card.Size = UDim2.new(1, -6, 0, 42)
                Card.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
                Card.BorderSizePixel = 0
                Card.Parent = parentPage

                local CardCorner = Instance.new("UICorner")
                CardCorner.CornerRadius = UDim.new(0, 8)
                CardCorner.Parent = Card

                local Label = Instance.new("TextLabel")
                Label.Size = UDim2.new(0.6, 0, 1, 0)
                Label.Position = UDim2.new(0, 12, 0, 0)
                Label.BackgroundTransparency = 1
                Label.Text = name
                Label.TextColor3 = Color3.fromRGB(210, 210, 230)
                Label.TextSize = 11
                Label.Font = Enum.Font.GothamMedium
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.Parent = Card

                local ToggleBtn = Instance.new("TextButton")
                ToggleBtn.Size = UDim2.new(0, 85, 0, 26)
                ToggleBtn.Position = UDim2.new(1, -95, 0.5, -13)
                ToggleBtn.BorderSizePixel = 0
                ToggleBtn.TextSize = 10
                ToggleBtn.Font = Enum.Font.GothamBold
                ToggleBtn.Parent = Card

                local BtnCorner = Instance.new("UICorner")
                BtnCorner.CornerRadius = UDim.new(0, 6)
                BtnCorner.Parent = ToggleBtn

                local function updateVisual()
                    if settingsRage[settingKey] then
                        ToggleBtn.Text = "AÇIK"
                        ToggleBtn.TextColor3 = Color3.fromRGB(90, 255, 140)
                        ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 65, 40)
                    else
                        ToggleBtn.Text = "KAPALI"
                        ToggleBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
                        ToggleBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
                    end
                end

                updateVisual()

                ToggleBtn.MouseButton1Click:Connect(function()
                    settingsRage[settingKey] = not settingsRage[settingKey]
                    updateVisual()
                end)

                toggleReferences[settingKey] = updateVisual
            end

            local function createSlider(parentPage, name, settingKey, minVal, maxVal)
                local Card = Instance.new("Frame")
                Card.Size = UDim2.new(1, -6, 0, 52)
                Card.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
                Card.BorderSizePixel = 0
                Card.Parent = parentPage

                local CardCorner = Instance.new("UICorner")
                CardCorner.CornerRadius = UDim.new(0, 8)
                CardCorner.Parent = Card

                local Label = Instance.new("TextLabel")
                Label.Size = UDim2.new(1, -20, 0, 20)
                Label.Position = UDim2.new(0, 12, 0, 6)
                Label.BackgroundTransparency = 1
                Label.Text = name .. ": " .. tostring(settingsRage[settingKey])
                Label.TextColor3 = Color3.fromRGB(210, 210, 230)
                Label.TextSize = 11
                Label.Font = Enum.Font.GothamMedium
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.Parent = Card

                local SliderBar = Instance.new("Frame")
                SliderBar.Size = UDim2.new(1, -24, 0, 6)
                SliderBar.Position = UDim2.new(0, 12, 0, 34)
                SliderBar.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
                SliderBar.BorderSizePixel = 0
                SliderBar.Parent = Card

                local BarCorner = Instance.new("UICorner")
                BarCorner.CornerRadius = UDim.new(0, 3)
                BarCorner.Parent = SliderBar

                local SliderFill = Instance.new("Frame")
                local initPercent = (settingsRage[settingKey] - minVal) / (maxVal - minVal)
                SliderFill.Size = UDim2.new(math.clamp(initPercent, 0, 1), 0, 1, 0)
                SliderFill.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
                SliderFill.BorderSizePixel = 0
                SliderFill.Parent = SliderBar

                local FillCorner = Instance.new("UICorner")
                FillCorner.CornerRadius = UDim.new(0, 3)
                FillCorner.Parent = SliderFill

                local dragging = false
                SliderBar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = true end
                end)
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
                end)
                UserInputService.InputChanged:Connect(function(input)
                    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        local mousePos = input.Position
                        local barPos = SliderBar.AbsolutePosition
                        local barSize = SliderBar.AbsoluteSize
                        local percent = math.clamp((mousePos.X - barPos.X) / barSize.X, 0, 1)
                        
                        SliderFill.Size = UDim2.new(percent, 0, 1, 0)
                        local val = math.floor(minVal + (maxVal - minVal) * percent + 0.5)
                        
                        settingsRage[settingKey] = val
                        Label.Text = name .. ": " .. tostring(val)
                    end
                end)
            end

            createAbilityToggle(ragePage, "Rage Snapline (Mobil Düğme ile Aktif)", "RageLock")
            createAbilityToggle(ragePage, "Auto-Shoot (Kafaya Bakınca Otomatik Vur)", "AutoShoot")
            createAbilityToggle(ragePage, "WallCheck (Duvar Arkası Engelle)", "WallCheck")
            createAbilityToggle(ragePage, "FOV Çemberi", "FOVEnabled")
            createAbilityToggle(ragePage, "Hitbox Expander (Kafaları Büyüt)", "HitboxExpander")
            createSlider(ragePage, "FOV Yarıçapı", "FOVRadius", 50, 600)
            createSlider(ragePage, "Hitbox Boyutu (Güvenli: 4-5)", "HitboxSize", 2, 12)

            createAbilityToggle(visualsPage, "Tracers (Çizgi Takibi)", "Tracers")
            createAbilityToggle(visualsPage, "ESP Box (Kutu)", "ESPBox")
            createAbilityToggle(visualsPage, "Name ESP (İsimler)", "NameESP")
            createAbilityToggle(visualsPage, "Distance ESP (Mesafe)", "DistanceESP")
            createAbilityToggle(visualsPage, "Chams (Model Aydınlatma)", "Chams")

            createAbilityToggle(movementPage, "Hızlı Koşma (Speed - Anti-AC 0.4x)", "SpeedBoost")
            createAbilityToggle(movementPage, "Yüksek Zıplama", "JumpBoost")
            createAbilityToggle(movementPage, "Bunny Hop (Bhop)", "Bhop")
            createAbilityToggle(movementPage, "Noclip (Duvar Geçme)", "Noclip")
            createAbilityToggle(movementPage, "Fly (Uçma Modu)", "Fly")
            createAbilityToggle(movementPage, "Spinbot (Hızlı Dönüş)", "Spinbot")
        end

        LoadBarFill.Size = UDim2.new(1, 0, 1, 0)
        PercentLabel.Text = "%100 - Hazır!"
        task.wait(0.2)
        LoadScreen:Destroy()
        targetFrame.Visible = true
    end)
end

-- GÖRÜNÜRLÜK (WALLCHECK)
local function isVisible(targetPart, isLegit)
    local check = isLegit and settingsLegit.WallCheck or settingsRage.WallCheck
    if not check then return true end
    local camPos = Camera.CFrame.Position
    local direction = targetPart.Position - camPos
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    if LocalPlayer.Character then raycastParams.FilterDescendantsInstances = {LocalPlayer.Character} end
    raycastParams.IgnoreWater = true
    
    local result = workspace:Raycast(camPos, direction, raycastParams)
    if result then
        local hitCharacter = result.Instance:FindFirstAncestorOfClass("Model")
        if hitCharacter == targetPart.Parent then return true end
    else
        return true
    end
    return false
end

-- EN YAKIN HEDEF BULUCU (LEGİT İÇİN SMOOTH)
local function getLegitTarget()
    local bestTarget = nil
    local shortestDist = settingsLegit.FOVRadius
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

    for _, player in ipairs(Players:GetPlayers()) do
        -- Whitelist kontrolü eklenmiştir
        if player ~= LocalPlayer and not isWhitelisted(player) and player.Character then
            local head = player.Character:FindFirstChild("Head")
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if head and humanoid and humanoid.Health > 0 then
                if isVisible(head, true) then
                    local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
                    if onScreen then
                        local mouseDist = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
                        if mouseDist < shortestDist then
                            shortestDist = mouseDist
                            bestTarget = head
                        end
                    end
                end
            end
        end
    end
    return bestTarget
end

-- EN YAKIN HEDEF (RAGE İÇİN)
local function getRageTarget()
    local bestTarget = nil
    local shortestDist = settingsRage.FOVRadius
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    for _, player in ipairs(Players:GetPlayers()) do
        -- Whitelist kontrolü eklenmiştir
        if player ~= LocalPlayer and not isWhitelisted(player) and player.Character then
            local head = player.Character:FindFirstChild("Head")
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if head and humanoid and humanoid.Health > 0 then
                if isVisible(head, false) then
                    local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
                    if onScreen then
                        local mouseDist = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
                        if mouseDist < shortestDist then
                            shortestDist = mouseDist
                            bestTarget = head
                        end
                    end
                end
            end
        end
    end
    return bestTarget
end

-- ATEŞ ETME FONKSİYONU (Rage için)
local function triggerShoot(targetHead)
    local currentTime = tick()
    if currentTime - lastShootTick < shootCooldown then return end
    lastShootTick = currentTime

    if detectedShootRemote then
        pcall(function()
            if detectedShootRemote:IsA("RemoteEvent") then
                detectedShootRemote:FireServer(targetHead.Position)
            elseif detectedShootRemote:IsA("RemoteFunction") then
                detectedShootRemote:InvokeServer(targetHead.Position)
            end
        end)
    else
        local character = LocalPlayer.Character
        if character then
            local tool = character:FindFirstChildOfClass("Tool")
            if tool then
                pcall(function() tool:Activate() end)
            end
        end
    end
end

-- ANA RENDER DÖNGÜSÜ (Optimizasyonlu & Mobil Uyumlu)
RunService.RenderStepped:Connect(function()
    if selectedMode == "Legit" then
        if settingsLegit.FOVEnabled and settingsLegit.LegitFOVVisible then
            fovCircleLegit.Visible = true
            fovCircleLegit.Radius = settingsLegit.FOVRadius
            fovCircleLegit.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        else
            fovCircleLegit.Visible = false
        end

        -- Smooth Legit Aim (PC'de sağ tık veya Mobilde Ekrandaki AIM Butonu basılı/açıkken)
        if (settingsLegit.LegitAim and rightMouseDown) or (mobileAimToggled and settingsLegit.LegitAim) then
            local target = getLegitTarget()
            if target then
                local currentCamCF = Camera.CFrame
                local targetCF = CFrame.lookAt(Camera.CFrame.Position, target.Position)
                local alpha = math.clamp(1 / settingsLegit.Smoothness, 0.05, 1)
                Camera.CFrame = currentCamCF:Lerp(targetCF, alpha)
            end
        end

    elseif selectedMode == "Rage" then
        if settingsRage.FOVEnabled then
            fovCircleRage.Visible = true
            fovCircleRage.Radius = settingsRage.FOVRadius
            fovCircleRage.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        else
            fovCircleRage.Visible = false
        end

        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            local hrp = character:FindFirstChild("HumanoidRootPart")

            if humanoid then
                humanoid.WalkSpeed = settingsRage.SpeedBoost and (baseWalkSpeed + (36 - baseWalkSpeed) * 0.4) or baseWalkSpeed
                if settingsRage.JumpBoost then
                    if humanoid.UseJumpPower then humanoid.JumpPower = 65 else humanoid.JumpHeight = 9.5 end
                else
                    if humanoid.UseJumpPower then humanoid.JumpPower = baseJumpPower else humanoid.JumpHeight = 7.2 end
                end

                if settingsRage.Bhop and humanoid.FloorMaterial ~= Enum.Material.Air and humanoid.MoveDirection.Magnitude > 0 then
                    humanoid.Jump = true
                end
            end

            if settingsRage.Spinbot and hrp then
                hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(250), 0)
            end

            if settingsRage.Noclip then
                for _, part in ipairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end

            if settingsRage.Fly and hrp then
                hrp.Velocity = Vector3.new(0, 1.5, 0)
            end
        end

        local targetHead = getRageTarget()
        if targetHead then
            -- Rage Snapline / Lock (Mobilde ekran butonuna bağlı veya PC'de ayarlıysa)
            if settingsRage.RageLock and (mobileAimToggled or not UserInputService.TouchEnabled) then
                Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, targetHead.Position)
            end
            if settingsRage.AutoShoot then
                triggerShoot(targetHead)
            end
        end
    end
end)

-- ARKAPLAN GÖRSEL GÜNCELLEMELERİ (ESP, Tracers, Chams, Hitbox)
task.spawn(function()
    while true do
        pcall(function()
            if selectedMode == "Legit" then
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character then
                        local char = player.Character
                        local highlight = char:FindFirstChild("LegitHighlight")
                        if settingsLegit.Chams then
                            if not highlight then
                                highlight = Instance.new("Highlight")
                                highlight.Name = "LegitHighlight"
                                highlight.FillTransparency = 0.4
                                highlight.FillColor = Color3.fromRGB(50, 120, 255)
                                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                                highlight.Parent = char
                            end
                        elseif highlight then
                            highlight:Destroy()
                        end
                    end
                end
            elseif selectedMode == "Rage" then
                -- Hitbox Expander (Sunucu donmalarını engellemek için kullanıcı boyutu makul tutabilir)
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character then
                        local head = player.Character:FindFirstChild("Head")
                        if head then
                            if settingsRage.HitboxExpander then
                                head.Size = Vector3.new(settingsRage.HitboxSize, settingsRage.HitboxSize, settingsRage.HitboxSize)
                                head.Transparency = 0.5
                                head.CanCollide = false
                            else
                                head.Size = Vector3.new(2, 1, 1)
                                head.Transparency = 0
                            end
                        end
                    end
                end

                -- Chams / Highlight Yönetimi
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character then
                        local char = player.Character
                        local existingHighlight = char:FindFirstChild("AstraRageHighlight")

                        if settingsRage.Chams then
                            if not existingHighlight then
                                existingHighlight = Instance.new("Highlight")
                                existingHighlight.Name = "AstraRageHighlight"
                                existingHighlight.FillTransparency = 0.3
                                existingHighlight.OutlineColor = Color3.fromRGB(255, 50, 50)
                                existingHighlight.FillColor = Color3.fromRGB(150, 0, 0)
                                existingHighlight.Parent = char
                            end
                        elseif existingHighlight then
                            existingHighlight:Destroy()
                        end
                    end
                end
            end

            -- Tracers Görsel Güncellemesi
            for player, line in pairs(activeTracers) do
                local char = player.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                local humanoid = char and char:FindFirstChildOfClass("Humanoid")

                local tracersActive = (selectedMode == "Legit" and settingsLegit.Tracers) or (selectedMode == "Rage" and settingsRage.Tracers)

                if tracersActive and hrp and humanoid and humanoid.Health > 0 then
                    local screenPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                    if onScreen then
                        line.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                        line.To = Vector2.new(screenPos.X, screenPos.Y)
                        line.Visible = true
                    else
                        line.Visible = false
                    end
                else
                    line.Visible = false
                end
            end
        end)

        task.wait(0.05)
    end
end)