local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

local settings = HttpService:JSONDecode(readfile("sbglovefinder"))
local gloves = settings.gloves
local findAll = settings.selectiveMode

local function formatServerIdList()
    local serverIdTable = {}
    local success, err = pcall(function()
        local servers = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/6403373529/servers/Public?sortOrder=Desc&limit=100&exludeFullGames=true"))
        for _, server in pairs(servers.data) do
            serverIdTable[#serverIdTable+1] = server.id
        end
    end)
    if success then return serverIdTable end
    return nil
end

local servers = formatServerIdList()
local serverIndex = settings.serverIndex

local server = servers[serverIndex]

local function CheckGloves()
    
    if findAll == true then
        
        local glovesFound = 0
        local maxGloves = #gloves
        local foundGloves = {}
        for _, player in pairs(game:GetService("Players"):GetPlayers()) do

            if glovesFound >= maxGloves then
                return true
            end
            
            local glove = player.leaderstats.Glove.Value
            if not table.find(foundGloves, glove) and table.find(gloves, glove) then
                glovesFound += 1
                foundGloves[#foundGloves+1] = glove
            end

        end

    end
    if findAll == false then
        
        for _, player in pairs(game:GetService("Players"):GetPlayers()) do
            
            local glove = player.leaderstats.Glove.Value
            if table.find(gloves, glove) then
                return true
            end

        end

    end
    return false

end

repeat task.wait(1)

until game:IsLoaded()

local player = game:GetService("Players").LocalPlayer

local goodServer = CheckGloves()

if not goodServer then
    
    local teleportFunc = queueonteleport or queue_on_teleport or syn and syn.queue_on_teleport
    if teleportFunc then
        teleportFunc([[
            task.wait(1)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/ItsSpaceManPlays/sbscriptrepo/main/glove%20finder.lua"))()
        ]])
    end
    TeleportService:TeleportToPlaceInstance(6403373529, server, player)

else

    -- load main script

end
