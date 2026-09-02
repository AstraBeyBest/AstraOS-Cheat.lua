--[================================================================]--
--  AstraOS FPS Game Cheat
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

-- MOBIL ARAYÜZ ELEMANLARI
local MobileScreenGui = Instance.new("ScreenGui")
MobileScreenGui.Name = "AstraOS_MobileOverlay"
MobileScreenGui.ResetOnSpawn = false
pcall(function()
    MobileScreenGui.Parent = CoreGui
end)
if not MobileScreenGui.Parent then
    MobileScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- ÇİZİMLERİ VE ARAYÜZÜ TAMAMEN KAPATMA (UNLOAD - GÜNCELLENDİ)
local activeDrawings = {}
local activeTracers = {}
local fovCircleRage = Drawing.new("Circle")
local fovCircleLegit = Drawing.new("Circle")
local isScriptLoaded = true -- Unload kontrol bayrağı

local function unloadScript()
    isScriptLoaded = false -- Tüm arka plan döngülerini ve render bağlantılarını durdurur
    
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
    
    -- Chams, Highlight ve Hitbox düzeltmelerini temizle
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character then
            pcall(function()
                local hlLegit = player.Character:FindFirstChild("LegitHighlight")
                if hlLegit then hlLegit:Destroy() end
                
                local hlRage = player.Character:FindFirstChild("AstraRageHighlight")
                if hlRage then hlRage:Destroy() end
                
                local head = player.Character:FindFirstChild("Head")
                if head then
                    head.Size = Vector3.new(2, 1, 1)
                    head.Transparency = 0
                end
            end)
        end
    end

    pcall(function() ScreenGui:Destroy() end)
    pcall(function() MobileScreenGui:Destroy() end)
end

-- GÜNCELLEME GÜNLÜKLERİ EKRANI (EN BAŞTA GELEN MENÜ)
local UpdateLogScreen = Instance.new("Frame")
UpdateLogScreen.Size = UDim2.new(0, 340, 0, 220)
UpdateLogScreen.Position = UDim2.new(0.5, -170, 0.5, -110)
UpdateLogScreen.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
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
UpdateTitle.Text = "Güncelleme Günlükleri"
UpdateTitle.TextColor3 = Color3.fromRGB(220, 220, 255)
UpdateTitle.TextSize = 14
UpdateTitle.Font = Enum.Font.GothamBold
UpdateTitle.Parent = UpdateLogScreen

local UpdateDesc = Instance.new("TextLabel")
UpdateDesc.Size = UDim2.new(1, -40, 0, 90)
UpdateDesc.Position = UDim2.new(0, 20, 0, 60)
UpdateDesc.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
UpdateDesc.BorderSizePixel = 0
UpdateDesc.Text = "[ + ] Misc Sekmesi Eklendi\n" ..
                "[ + ] Whitelist Eklendi\n" ..
                "[ + ] Unload Script Eklendi\n" ..
                "[ + ] Rage-Legit Arasında Geçiş Eklendi"
UpdateDesc.TextColor3 = Color3.fromRGB(255, 255, 255)
UpdateDesc.TextSize = 12
UpdateDesc.Font = Enum.Font.GothamMedium
UpdateDesc.TextWrapped = true
UpdateDesc.Parent = UpdateLogScreen

local UpdateDescCorner = Instance.new("UICorner")
UpdateDescCorner.CornerRadius = UDim.new(0, 8)
UpdateDescCorner.Parent = UpdateDesc

local UpdateNextBtn = Instance.new("TextButton")
UpdateNextBtn.Size = UDim2.new(1, -40, 0, 38)
UpdateNextBtn.Position = UDim2.new(0, 20, 0, 165)
UpdateNextBtn.BackgroundColor3 = Color3.fromRGB(40, 120, 60)
UpdateNextBtn.BorderSizePixel = 0
UpdateNextBtn.Text = "Devam Et"
UpdateNextBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
UpdateNextBtn.TextSize = 12
UpdateNextBtn.Font = Enum.Font.GothamBold
UpdateNextBtn.Parent = UpdateLogScreen

local UpdateNextCorner = Instance.new("UICorner")
UpdateNextCorner.CornerRadius = UDim.new(0, 8)
UpdateNextCorner.Parent = UpdateNextBtn

-- KEY SISTEMI EKRANI (Başta Gizli, Güncelleme Günlükleri geçilince açılacak)
local KeyScreen = Instance.new("Frame")
KeyScreen.Size = UDim2.new(0, 320, 0, 200)
KeyScreen.Position = UDim2.new(0.5, -160, 0.5, -100)
KeyScreen.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
KeyScreen.BorderSizePixel = 0
KeyScreen.Active = true
KeyScreen.Draggable = true
KeyScreen.Visible = false
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
KeyBox.PlaceholderText = "Hile Keyini Girin (YT BAK)"
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

-- MOBIL KONTROL DURUMLARI
local mobileAimToggled = false

-- Menü Aç/Kapat Butonu
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

-- Otomatik Aim / Hedef Alma Butonu
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
AimMobBtn.Visible = false
AimMobBtn.Parent = MobileScreenGui

local MobAimCorner = Instance.new("UICorner")
MobAimCorner.CornerRadius = UDim.new(1, 0)
MobAimCorner.Parent = AimMobBtn

local MobAimStroke = Instance.new("UIStroke")
MobAimStroke.Color = Color3.fromRGB(255, 90, 90)
MobAimStroke.Thickness = 2
MobAimStroke.Parent = AimMobBtn

-- FOV Çemberleri Özellikleri
fovCircleRage.Visible = false
fovCircleRage.Transparency = 0.6
fovCircleRage.Color = Color3.fromRGB(255, 50, 50)
fovCircleRage.Thickness = 1.5
fovCircleRage.NumSides = 32
fovCircleRage.Radius = settingsRage.FOVRadius
fovCircleRage.Filled = false

fovCircleLegit.Visible = false
fovCircleLegit.Transparency = 0.4
fovCircleLegit.Color = Color3.fromRGB(50, 120, 255)
fovCircleLegit.Thickness = 1
fovCircleLegit.NumSides = 32
fovCircleLegit.Radius = settingsLegit.FOVRadius
fovCircleLegit.Filled = false

-- ESP ve Bilgi Çizimleri (Box, Name, Distance)
local function createDrawings(player)
    if activeDrawings[player] then return end
    
    local box = Drawing.new("Square")
    box.Visible = false
    box.Color = Color3.fromRGB(255, 50, 50)
    box.Thickness = 1.5
    box.Filled = false
    
    local nameText = Drawing.new("Text")
    nameText.Visible = false
    nameText.Color = Color3.fromRGB(255, 255, 255)
    nameText.Size = 13
    nameText.Center = true
    nameText.Outline = true
    
    local distText = Drawing.new("Text")
    distText.Visible = false
    distText.Color = Color3.fromRGB(200, 200, 200)
    distText.Size = 12
    distText.Center = true
    distText.Outline = true

    activeDrawings[player] = {Box = box, Name = nameText, Dist = distText}
end

local function removeDrawings(player)
    if activeDrawings[player] then
        pcall(function()
            activeDrawings[player].Box:Remove()
            activeDrawings[player].Name:Remove()
            activeDrawings[player].Dist:Remove()
        end)
        activeDrawings[player] = nil
    end
end

for _, p in ipairs(Players:GetPlayers()) do
    if p ~= LocalPlayer then createDrawings(p) end
end
Players.PlayerAdded:Connect(function(p)
    if p ~= LocalPlayer then createDrawings(p) end
end)
Players.PlayerRemoving:Connect(removeDrawings)

-- Tracer Çizgileri
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
                if isScriptLoaded then
                    pcall(function() killSound:Play() end)
                end
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

ToggleMenuMobBtn.MouseButton1Click:Connect(function()
    if selectedMode == "Legit" then
        MainFrameLegit.Visible = not MainFrameLegit.Visible
    elseif selectedMode == "Rage" then
        MainFrameRage.Visible = not MainFrameRage.Visible
    end
end)

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

        -- WHITELIST PANELİ OLUŞTURUCU FONKSİYON
        local function createWhitelistPanel(parentPage)
            local Card = Instance.new("Frame")
            Card.Size = UDim2.new(1, -6, 0, 110)
            Card.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
            Card.BorderSizePixel = 0
            Card.Parent = parentPage

            local CardCorner = Instance.new("UICorner")
            CardCorner.CornerRadius = UDim.new(0, 8)
            CardCorner.Parent = Card

            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, -20, 0, 25)
            Label.Position = UDim2.new(0, 12, 0, 5)
            Label.BackgroundTransparency = 1
            Label.Text = "🛡️ Whitelist Yönetimi (Kullanıcı Adı Ekle)"
            Label.TextColor3 = Color3.fromRGB(210, 210, 230)
            Label.TextSize = 11
            Label.Font = Enum.Font.GothamBold
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = Card

            local WlBox = Instance.new("TextBox")
            WlBox.Size = UDim2.new(1, -24, 0, 32)
            WlBox.Position = UDim2.new(0, 12, 0, 32)
            WlBox.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
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
            AddBtn.Size = UDim2.new(0.48, 0, 0, 30)
            AddBtn.Position = UDim2.new(0, 12, 0, 70)
            AddBtn.BackgroundColor3 = Color3.fromRGB(40, 120, 60)
            AddBtn.BorderSizePixel = 0
            AddBtn.Text = "Listeye Ekle"
            AddBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            AddBtn.TextSize = 10
            AddBtn.Font = Enum.Font.GothamBold
            AddBtn.Parent = Card

            local AddCorner = Instance.new("UICorner")
            AddCorner.CornerRadius = UDim.new(0, 6)
            AddCorner.Parent = AddBtn

            local RemoveBtn = Instance.new("TextButton")
            RemoveBtn.Size = UDim2.new(0.48, 0, 0, 30)
            RemoveBtn.Position = UDim2.new(0.51, 0, 0, 70)
            RemoveBtn.BackgroundColor3 = Color3.fromRGB(140, 40, 40)
            RemoveBtn.BorderSizePixel = 0
            RemoveBtn.Text = "Listeden Çıkar"
            RemoveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            RemoveBtn.TextSize = 10
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
                    WlBox.Text = "Listede bulunamadı!"
                    task.wait(1.5)
                    WlBox.Text = ""
                end
            end)
        end

        -- MOD DEĞİŞTİRME PANELİ
        local function createModeSwitchPanel(parentPage)
            local Card = Instance.new("Frame")
            Card.Size = UDim2.new(1, -6, 0, 85)
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
            Label.Text = "🔄 Mod Değiştirici"
            Label.TextColor3 = Color3.fromRGB(210, 210, 230)
            Label.TextSize = 11
            Label.Font = Enum.Font.GothamBold
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = Card

            local SwitchBtn = Instance.new("TextButton")
            SwitchBtn.Size = UDim2.new(1, -24, 0, 32)
            SwitchBtn.Position = UDim2.new(0, 12, 0, 32)
            SwitchBtn.BackgroundColor3 = selectedMode == "Rage" and Color3.fromRGB(30, 80, 160) or Color3.fromRGB(140, 30, 30)
            SwitchBtn.BorderSizePixel = 0
            SwitchBtn.Text = selectedMode == "Rage" and "🛡️ Legit Menüye Geç (Rage'i Kapat)" or "🔥 Rage Menüye Geç (Legit'i Kapat)"
            SwitchBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            SwitchBtn.TextSize = 10
            SwitchBtn.Font = Enum.Font.GothamBold
            SwitchBtn.Parent = Card

            local SwitchCorner = Instance.new("UICorner")
            SwitchCorner.CornerRadius = UDim.new(0, 6)
            SwitchCorner.Parent = SwitchBtn

            SwitchBtn.MouseButton1Click:Connect(function()
                if selectedMode == "Rage" then
                    selectedMode = "Legit"
                    MainFrameRage.Visible = false
                    AimMobBtn.BackgroundColor3 = Color3.fromRGB(30, 80, 160)
                    MobAimStroke.Color = Color3.fromRGB(90, 150, 255)
                    startLoadingAndBuildUI(false)
                else
                    selectedMode = "Rage"
                    MainFrameLegit.Visible = false
                    AimMobBtn.BackgroundColor3 = Color3.fromRGB(120, 30, 30)
                    MobAimStroke.Color = Color3.fromRGB(255, 90, 90)
                    startLoadingAndBuildUI(true)
                end
            end)
        end

        -- UNLOAD PANELİ OLUŞTURUCU FONKSİYON
        local function createUnloadPanel(parentPage)
            local Card = Instance.new("Frame")
            Card.Size = UDim2.new(1, -6, 0, 65)
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
            Label.Text = "⚠️ Script Kontrolü"
            Label.TextColor3 = Color3.fromRGB(210, 210, 230)
            Label.TextSize = 11
            Label.Font = Enum.Font.GothamBold
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = Card

            local UnloadBtn = Instance.new("TextButton")
            UnloadBtn.Size = UDim2.new(1, -24, 0, 28)
            UnloadBtn.Position = UDim2.new(0, 12, 0, 28)
            UnloadBtn.BackgroundColor3 = Color3.fromRGB(160, 40, 40)
            UnloadBtn.BorderSizePixel = 0
            UnloadBtn.Text = "Scripti Tamamen Kapat (Unload)"
            UnloadBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            UnloadBtn.TextSize = 11
            UnloadBtn.Font = Enum.Font.GothamBold
            UnloadBtn.Parent = Card

            local UnloadCorner = Instance.new("UICorner")
            UnloadCorner.CornerRadius = UDim.new(0, 6)
            UnloadCorner.Parent = UnloadBtn

            UnloadBtn.MouseButton1Click:Connect(function()
                unloadScript()
            end)
        end

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
                sf.CanvasSize = UDim2.new(0, 0, 0, 550)
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
            local legitMiscPage = createLegitTabContent("Misc")

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
            createLegitTabButton("⚙️ Misc", "Misc")

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

            createModeSwitchPanel(legitMiscPage)
            createWhitelistPanel(legitMiscPage)
            createUnloadPanel(legitMiscPage)

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
                sf.CanvasSize = UDim2.new(0, 0, 0, 680)
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
            local miscPage = createTabContent("Misc")

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
            createTabButton("⚙️ Misc", "Misc")

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

            createModeSwitchPanel(miscPage)
            createWhitelistPanel(miscPage)
            createUnloadPanel(miscPage)
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

-- EN YAKIN HEDEF BULUCU (LEGIT)
local function getLegitTarget()
    local bestTarget = nil
    local shortestDist = settingsLegit.FOVRadius
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

    for _, player in ipairs(Players:GetPlayers()) do
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

-- EN YAKIN HEDEF (RAGE)
local function getRageTarget()
    local bestTarget = nil
    local shortestDist = settingsRage.FOVRadius
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    for _, player in ipairs(Players:GetPlayers()) do
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

-- ATEŞ ETME FONKSİYONU
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

-- ANA RENDER DÖNGÜSÜ
RunService.RenderStepped:Connect(function()
    if not isScriptLoaded then return end

    if selectedMode == "Legit" then
        if settingsLegit.FOVEnabled and settingsLegit.LegitFOVVisible then
            fovCircleLegit.Visible = true
            fovCircleLegit.Radius = settingsLegit.FOVRadius
            fovCircleLegit.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        else
            fovCircleLegit.Visible = false
        end

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
            if settingsRage.RageLock and (mobileAimToggled or not UserInputService.TouchEnabled) then
                Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, targetHead.Position)
            end
            if settingsRage.AutoShoot then
                triggerShoot(targetHead)
            end
        end
    end
end)

-- ARKAPLAN GÖRSEL GÜNCELLEMELERİ VE ESP DÖNGÜSÜ
task.spawn(function()
    while isScriptLoaded do
        pcall(function()
            if not isScriptLoaded then return end

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

            -- ESP Box, Name ve Distance Güncellemeleri
            for player, drawings in pairs(activeDrawings) do
                local char = player.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                local humanoid = char and char:FindFirstChildOfClass("Humanoid")
                
                local boxActive = isScriptLoaded and ((selectedMode == "Legit" and settingsLegit.ESPBox) or (selectedMode == "Rage" and settingsRage.ESPBox))
                local nameActive = isScriptLoaded and ((selectedMode == "Legit" and settingsLegit.NameESP) or (selectedMode == "Rage" and settingsRage.NameESP))
                local distActive = isScriptLoaded and ((selectedMode == "Legit" and settingsLegit.DistanceESP) or (selectedMode == "Rage" and settingsRage.DistanceESP))

                if hrp and humanoid and humanoid.Health > 0 and isScriptLoaded then
                    local vector, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                    if onScreen then
                        local head = char:FindFirstChild("Head")
                        local leg = char:FindFirstChild("LeftFoot") or hrp
                        
                        if head and leg then
                            local topPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                            local botPos = Camera:WorldToViewportPoint(leg.Position - Vector3.new(0, 2, 0))
                            local height = math.abs(topPos.Y - botPos.Y)
                            local width = height / 2

                            -- Box Çizimi
                            if boxActive then
                                drawings.Box.Size = Vector2.new(width, height)
                                drawings.Box.Position = Vector2.new(vector.X - width / 2, topPos.Y)
                                drawings.Box.Visible = true
                            else
                                drawings.Box.Visible = false
                            end

                            -- İsim Çizimi
                            if nameActive then
                                drawings.Name.Text = player.Name
                                drawings.Name.Position = Vector2.new(vector.X, topPos.Y - 15)
                                drawings.Name.Visible = true
                            else
                                drawings.Name.Visible = false
                            end

                            -- Mesafe Çizimi
                            if distActive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                local distance = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude)
                                drawings.Dist.Text = "[" .. tostring(distance) .. "m]"
                                drawings.Dist.Position = Vector2.new(vector.X, botPos.Y + 2)
                                drawings.Dist.Visible = true
                            else
                                drawings.Dist.Visible = false
                            end
                        else
                            drawings.Box.Visible = false
                            drawings.Name.Visible = false
                            drawings.Dist.Visible = false
                        end
                    else
                        drawings.Box.Visible = false
                        drawings.Name.Visible = false
                        drawings.Dist.Visible = false
                    end
                else
                    drawings.Box.Visible = false
                    drawings.Name.Visible = false
                    drawings.Dist.Visible = false
                end
            end

            -- Tracers Güncellemeleri
            for player, line in pairs(activeTracers) do
                local char = player.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                local humanoid = char and char:FindFirstChildOfClass("Humanoid")

                local tracersActive = isScriptLoaded and ((selectedMode == "Legit" and settingsLegit.Tracers) or (selectedMode == "Rage" and settingsRage.Tracers))

                if tracersActive and hrp and humanoid and humanoid.Health > 0 and isScriptLoaded then
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
