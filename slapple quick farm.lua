local slapGoal = slap_ammount
local startingSlaps = slap_start
local serverList = slap_server_list
local serverIndex = slap_index
local first = slap_first

if first == true then
    first = false
else
    serverList = game:GetService("HttpService"):JSONDecode(serverList)
end

if serverIndex > 100 then
    serverIndex = 1
end

local server = serverList[serverIndex]
serverIndex += 1

repeat task.wait()
    
until game:IsLoaded()
task.wait(2)

local HttpService = game:GetService("HttpService")

local player = game:GetService("Players").LocalPlayer

if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("entered") then
    firetouchinterest(workspace.Lobby.Teleport1, game.Players.LocalPlayer.Character:WaitForChild("Head"), 0)
    firetouchinterest(workspace.Lobby.Teleport1, game.Players.LocalPlayer.Character:WaitForChild("Head"), 1)
end

for _, slapple in pairs(workspace:FindFirstChild("Arena"):FindFirstChild("island5"):FindFirstChild("Slapples"):GetChildren()) do
    if slapple:FindFirstChild("Glove") ~= nil and slapple:FindFirstChild("Glove").Transparency < 1 then
        firetouchinterest(game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart"), slapple:FindFirstChild("Glove"), 0)
        firetouchinterest(game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart"), slapple:FindFirstChild("Glove"), 1)
    end
end

local currentSlaps = player.leaderstats.Slaps.Value

task.wait(3)

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
            slap_server_list = ]]..HttpService:JSONEncode(serverList)..[[
            slap_index = ]]..serverIndex..[[
            loadstring(game:HttpGet("https://raw.githubusercontent.com/ItsSpaceManPlays/sbscriptrepo/main/slapple%20quick%20farm.lua"))()
        ]])
    end
    game:GetService("TeleportService"):TeleportToPlaceInstance(6403373529, server, player)
end
