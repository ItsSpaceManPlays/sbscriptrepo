local spawnLocation = workspace:WaitForChild("SpawnLocation")
local coverVoid = false
local autoHit = false
local autoTycoon = false

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Eternal bob", HidePremium = false, SaveConfig = false, ConfigFolder = "OrionTest"})

local function MakeVoidCover()
    
    local position = spawnLocation.Position - Vector3.new(0, -5)

    local part = Instance.new("Part")
    part.Size = Vector3.new(500, 1.5, 500)
    part.Anchored = true
    part.Position = position
    part.CanCollide = false
    part.Transparency = 1
    part.Name = "VoidCover"
    return part

end

local function getTycoon(playerName) -- returns tycoon model (click part is model.Click)
    local tycoonName = "\195\133".."Tycoon"..playerName
    if workspace:FindFirstChild(tycoonName) then
        return workspace:FindFirstChild(tycoonName)
    end
end

local thing = MakeVoidCover()
thing.Parent = workspace

local function HitBoss()
    workspace:WaitForChild("bobBoss"):WaitForChild("DamageEvent"):FireServer()
end

local mainTab = Window:MakeTab({
    Name = "Main",
    Icon = ""
})

mainTab:AddToggle({
    Name = "Void cover",
    Default = false,
    Callback = function(Value)
        if Value == true then
            thing.Transparency = 0.5
            thing.CanCollide = true
        else
            thing.Transparency = 1
            thing.CanCollide = false
        end
    end
})

mainTab:AddToggle({
    Name = "Auto damage",
    Default = false,
    Callback = function(Value)
        autoHit = Value
        if Value == true then
            while autoHit do
                task.wait(0.2)
                HitBoss()
            end
        end
    end
})

mainTab:AddToggle({
    Name = "Auto tycoon",
    Default = false,
    Callback = function(Value)
        autoTycoon = Value
        if Value == true then
            while autoTycoon do
                task.wait()
                for _, loopPlayer in pairs(game:GetService("Players"):GetPlayers()) do
                    local tycoonModel = getTycoon(loopPlayer.Name)
                    if tycoonModel then
                        local click = tycoonModel:FindFirstChild("Click")
                        if click then
                            fireclickdetector(click.ClickDetector)
                        end
                    end
                end
            end
        end
    end
})

mainTab:AddButton({
    Name = "Fly script",
    Callback = function()
        loadstring("\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\40\39\104\116\116\112\115\58\47\47\103\105\115\116\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\109\101\111\122\111\110\101\89\84\47\98\102\48\51\55\100\102\102\57\102\48\97\55\48\48\49\55\51\48\52\100\100\100\54\55\102\100\99\100\51\55\48\47\114\97\119\47\101\49\52\101\55\52\102\52\50\53\98\48\54\48\100\102\53\50\51\51\52\51\99\102\51\48\98\55\56\55\48\55\52\101\98\51\99\53\100\50\47\97\114\99\101\117\115\37\50\53\50\48\120\37\50\53\50\48\102\108\121\37\50\53\50\48\50\37\50\53\50\48\111\98\102\108\117\99\97\116\111\114\39\41\44\116\114\117\101\41\41\40\41\10\10")()
    end
})

OrionLib:Init()
