local slapGoal = slap_ammount
local startingSlaps = slap_start

repeat task.wait()
    
until game.IsLoaded
task.wait(2)

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

if currentSlaps - startingSlaps == slapGoal then
    -- TODO load normal script again
else
    -- TODO load this script
    local teleportFunc = queueonteleport or queue_on_teleport or syn and syn.queue_on_teleport
    if teleportFunc then
        teleportFunc([[
            slap_ammount = ]]..slapGoal..[[
            slap_start = ]]..startingSlaps..[[
            loadstring(game:HttpGet("https://raw.githubusercontent.com/ItsSpaceManPlays/sbscriptrepo/main/slapple%20quick%20farm.lua"))()
        ]])
    end
    game:GetService("TeleportService"):Teleport(6403373529, player)
end
