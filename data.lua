-- Engine de Movimentação e Ataque Pro
local MoonEngine = {
    Speed = 325,
    Distance = 10,
    Height = 12
}

-- Bypass de Teleporte (Anti-Kick)
function MoonEngine:Tween(targetCFrame)
    local char = game.Players.LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    local root = char.HumanoidRootPart
    local dist = (root.Position - targetCFrame.p).Magnitude
    local tween = game:GetService("TweenService"):Create(root, 
        TweenInfo.new(dist/self.Speed, Enum.EasingStyle.Linear), 
        {CFrame = targetCFrame}
    )
    
    -- Se o char cair no void ou for teleportado pra longe, cancela e reinicia
    tween:Play()
    return tween
end

-- Fast Attack Magnético (Dano em Área)
function MoonEngine:Attack(mob)
    local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
    if not tool then
        -- Auto Equip
        local backpack = game.Players.LocalPlayer.Backpack
        local weapon = backpack:FindFirstChild("Combat") or backpack:FindFirstChildOfClass("Tool")
        if weapon then weapon.Parent = game.Players.LocalPlayer.Character end
    end
    
    -- Registra o hit sem animação (Mais rápido que o clique)
    local args = { [1] = mob.Humanoid }
    game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange",tostring(tool))
    game:GetService("ReplicatedStorage").Remotes.Validator:FireServer(math.huge) -- Bypass de verificação
end

-- Loop de Farm "Imortal"
function MoonEngine:StartFarm(mobName, npcPos)
    _G.MoonFarm = true
    spawn(function()
        while _G.MoonFarm do
            task.wait()
            pcall(function()
                local mob = workspace.Enemies:FindFirstChild(mobName) or workspace.Enemies:FindFirstChild(mobName:sub(1,-2))
                
                if not mob then
                    -- Se não tem mob, vai pro NPC pegar missão
                    self:Tween(npcPos)
                else
                    -- Farm Inteligente: Fica em cima do mob girando para evitar hit
                    local root = game.Players.LocalPlayer.Character.HumanoidRootPart
                    root.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, self.Height, 0) * CFrame.Angles(math.rad(-90), 0, 0)
                    root.Velocity = Vector3.new(0,0,0) -- Bypass de queda
                    self:Attack(mob)
                end
            end)
        end
    end)
end

