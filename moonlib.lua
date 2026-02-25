-- [[ MOONCAT HUB - INTEGRADO ]]
-- Versão Beta: "quer divulgar divulgue mísera kk"

local MoonLib = {}
local Player = game.Players.LocalPlayer
_G.AutoLevel = false

-- === MOTOR DE FARM (LÓGICA) ===
local function GetQuest()
    local lvl = Player.Data.Level.Value
    if lvl <= 14 then
        return {Name = "Bandit", QuestName = "BanditQuest1", Level = 1, NPC = CFrame.new(1059.3, 15.4, 1549.2)}
    elseif lvl <= 29 then
        return {Name = "Monkey", QuestName = "MonkeyQuest1", Level = 1, NPC = CFrame.new(-1601.1, 36.8, 153.4)}
    else
        -- Fallback para o primeiro caso se o nível for maior (expanda depois)
        return {Name = "Bandit", QuestName = "BanditQuest1", Level = 1, NPC = CFrame.new(1059.3, 15.4, 1549.2)}
    end
end

function StartMoonFarm()
    task.spawn(function()
        while _G.AutoLevel do
            task.wait(0.3)
            pcall(function()
                local q = GetQuest()
                local hasQuest = Player.PlayerGui.Main.Quest.Visible
                
                if not hasQuest then
                    -- Teleporte para o NPC de Missão
                    Player.Character.HumanoidRootPart.CFrame = q.NPC
                    task.wait(0.5)
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", q.QuestName, q.Level)
                else
                    -- Procura o Inimigo para Farmar
                    for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                        if v.Name == q.Name and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            repeat
                                task.wait()
                                -- Posicionamento seguro (estilo HoHo)
                                Player.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)
                                -- Ataque
                                game:GetService("VirtualUser"):CaptureController()
                                game:GetService("VirtualUser"):ClickButton1(Vector2.new(850, 520))
                            until v.Humanoid.Health <= 0 or not _G.AutoLevel
                        end
                    end
                end
            end)
        end
    end)
end

-- === INTERFACE MOONLIB ===
-- Aqui eu uso o esqueleto da sua biblioteca para criar a janela
local Window = MoonLib:CreateLib({
    Name = "MoonCat Hub",
    Subtitle = "quer divulgar divulgue mísera kk",
    Color = Color3.fromRGB(170, 0, 255) -- Um roxo brabo pro gato
})

local MainTab = Window:CreateTab("Auto Farm")

MainTab:CreateToggle({
    Name = "Auto Level (Sea 1)",
    Default = false,
    Callback = function(Value)
        _G.AutoLevel = Value
        if Value then
            StartMoonFarm()
        else
            print("Farm Desativado")
        end
    end
})

local MiscTab = Window:CreateTab("Outros")
MiscTab:CreateButton({
    Name = "Rejoin Server",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, Player)
    end
})

print("MoonCat Hub carregado com sucesso!")
