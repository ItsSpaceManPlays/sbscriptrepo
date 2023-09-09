local slapGoal = slap_ammount
local startingSlaps = slap_start
local serverIndex = slap_index
local slapsGained = slap_gain

local function ReturnGui()
    local ScreenGui = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local TextLabel = Instance.new("TextLabel")
    local TextLabel_2 = Instance.new("TextLabel")

    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true

    Frame.Parent = ScreenGui
    Frame.BackgroundColor3 = Color3.fromRGB(47, 47, 47)
    Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BorderSizePixel = 0
    Frame.Size = UDim2.new(1, 0, 1, 0)

    TextLabel.Parent = Frame
    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.BackgroundTransparency = 1.000
    TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel.BorderSizePixel = 0
    TextLabel.Position = UDim2.new(0.300717145, 0, 0.423312902, 0)
    TextLabel.Size = UDim2.new(0.398155838, 0, 0.0754601136, 0)
    TextLabel.Font = Enum.Font.Ubuntu
    TextLabel.Text = "0 / 500 of 1000 slaps"
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextScaled = true
    TextLabel.TextSize = 14.000
    TextLabel.TextWrapped = true
    TextLabel.Name = "Stats"

    TextLabel_2.Parent = Frame
    TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel_2.BackgroundTransparency = 1.000
    TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel_2.BorderSizePixel = 0
    TextLabel_2.Position = UDim2.new(0.311475337, 0, 0.515337467, 0)
    TextLabel_2.Size = UDim2.new(0.376639456, 0, 0.0611451827, 0)
    TextLabel_2.Font = Enum.Font.Ubuntu
    TextLabel_2.Text = "Epic slap autofarm frfr"
    TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel_2.TextScaled = true
    TextLabel_2.TextSize = 14.000
    TextLabel_2.TextWrapped = true
    TextLabel_2.Name = "Gained"
    return ScreenGui
end

local function formatServerIdList()
    local serverIdTable = {}
    local success, err = pcall(function()
        local servers = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/6403373529/servers/Public?sortOrder=Asc&limit=100"))
        for _, server in pairs(servers.data) do
            serverIdTable[#serverIdTable+1] = server.id
        end
    end)
    if success then return serverIdTable end
    return nil
end

local serverList
repeat task.wait(0.5)
    serverList = formatServerIdList()
until serverList ~= nil

if serverIndex > 100 then
    serverIndex = 1
end

local server = serverList[serverIndex]
serverIndex += 1

repeat task.wait()
    
until game:IsLoaded()
task.wait(0.5)

local player = game:GetService("Players").LocalPlayer

if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("entered") then
    firetouchinterest(workspace.Lobby.Teleport1, game.Players.LocalPlayer.Character:WaitForChild("Head"), 0)
    firetouchinterest(workspace.Lobby.Teleport1, game.Players.LocalPlayer.Character:WaitForChild("Head"), 1)
end

task.wait(0.5)

for _, slapple in pairs(workspace:FindFirstChild("Arena"):FindFirstChild("island5"):FindFirstChild("Slapples"):GetChildren()) do
    if slapple:FindFirstChild("Glove") ~= nil and slapple:FindFirstChild("Glove").Transparency < 1 then
        firetouchinterest(game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart"), slapple:FindFirstChild("Glove"), 0)
        firetouchinterest(game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart"), slapple:FindFirstChild("Glove"), 1)
    end
end

task.wait(3)

local currentSlaps = player.leaderstats.Slaps.Value
slapsGained = currentSlaps - slapsGained

if currentSlaps - startingSlaps >= slapGoal then
    -- TODO load normal script again
else
    -- TODO load this script
    local teleportFunc = queueonteleport or queue_on_teleport or syn and syn.queue_on_teleport
    if teleportFunc then
        teleportFunc([[
            task.wait(1)
            slap_ammount = ]]..slapGoal..[[
            slap_start = ]]..startingSlaps..[[
            slap_index = ]]..serverIndex..[[
            slap_gain = ]]..currentSlaps..[[
            loadstring(game:HttpGet("https://raw.githubusercontent.com/ItsSpaceManPlays/sbscriptrepo/main/slapple%20quick%20farm.lua"))()
        ]])
    end
    local gui = ReturnGui()
    gui.Frame.Stats.Text = currentSlaps - startingSlaps.." / "..slapGoal.." to "..startingSlaps + slapGoal.." slaps"
    if slapsGained > 0 then
        gui.Frame.Gained.Text = "+"slapsGained" slaps gained!"
    else
        gui.Frame.Gained.Text = "No slaps gained."
    end
    game:GetService("TeleportService"):TeleportToPlaceInstance(6403373529, server, player, nil, nil, gui)
end
