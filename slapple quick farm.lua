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
    slap_ammount = slapGoal
    slap_start = startingSlaps
    --here
end
