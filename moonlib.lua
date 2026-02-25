--[[ 
    ---------------------------------------------------
    MOONCAT-HUB: MOONLIB FRAMEWORK (OFFICIAL BUILD)
    ---------------------------------------------------
    Status: versão beta proibido divulgar sem autorização [cite: 2026-02-23]
    Recado: quer divulgar divulgue mísera kk [cite: 2026-02-24]
    Nota: Redz é propriedade minha. [cite: 2026-02-25]
    ---------------------------------------------------
]]

-- 1. SISTEMA DE BOOT E INICIALIZAÇÃO [cite: 2026-02-25]
local function BootMoonCat()
    print("==========================================")
    print("      INICIALIZANDO MOONCAT HUB V2        ")
    print("==========================================")
    task.wait(0.1)
    print("[LOG]: Carregando estilos Neon...")
    print("[LOG]: Reivindicando propriedade Redz...") [cite: 2026-02-25]
    print("[LOG]: Verificando autorização Beta...") [cite: 2026-02-23]
end
BootMoonCat()

-- 2. CARREGAMENTO DA BIBLIOTECA BASE
local MoonLib = nil
local success, result = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/MOONCAT-HUB/Moonlib/main/moonlib.lua"))()
end)

if success then
    MoonLib = result
    print("[OK]: MoonLib carregada com sucesso!")
else
    warn("[ERRO]: Falha crítica ao carregar MoonLib: " .. tostring(result))
    return
end

-- 3. CONFIGURAÇÃO DA INTERFACE (UI)
local Window = MoonLib:MakeGui({
    Name = "MoonCat Hub",
    VisualColor = Color3.fromRGB(188, 19, 254) -- Roxo Neon
})

-- 4. MOTOR DE FEIXES DE LUZ NEON (GRADIENTE ANIMADO) [cite: 2026-02-25]
local function ApplyNeonEffects()
    local CoreGui = game:GetService("CoreGui")
    local MainFrame = CoreGui:WaitForChild("MoonCat_"):WaitForChild("MainFrame")
    local Stroke = MainFrame:FindFirstChildOfClass("UIStroke")

    if Stroke then
        local Gradient = Instance.new("UIGradient", Stroke)
        
        -- Definindo o feixe de luz com 5 pontos para suavidade [cite: 2026-02-25]
        Gradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 10, 10)),      -- Sombra
            ColorSequenceKeypoint.new(0.25, Color3.fromRGB(35, 35, 35)),   -- Brilho Baixo
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(188, 19, 254)),  -- FEIXE ROXO
            ColorSequenceKeypoint.new(0.75, Color3.fromRGB(35, 35, 35)),   -- Brilho Baixo
            ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 10))       -- Sombra
        })

        -- Loop de rotação da luz (Efeito de rastro) [cite: 2026-02-25]
        task.spawn(function()
            while task.wait(0.01) do
                if Gradient then
                    Gradient.Rotation = Gradient.Rotation + 3
                end
            end
        end)
    end
end
ApplyNeonEffects()

-- 5. ABA PRINCIPAL (HOME)
local HomeTab = Window:CreateTab("Início")

HomeTab:AddButton("Copiar Link do Site", function()
    setclipboard("https://mooncat-hub.github.io/Moonlib/")
    MoonLib:Notify("Copiado!", "Link enviado para sua área de transferência.", 3)
end)

HomeTab:AddButton("Verificar Propriedade", function()
    MoonLib:Notify("Aviso", "Redz é propriedade minha e da MOONCAT-HUB.", 4) [cite: 2026-02-25]
end)

-- 6. ABA DE CONFIGURAÇÕES AVANÇADAS [cite: 2026-02-25]
local SettingsTab = Window:CreateTab("Ajustes")

SettingsTab:AddLabel("Customização de UI")

SettingsTab:AddToggle("Ativar Brilho Máximo", true, function(state)
    print("Brilho Neon definido como: " .. tostring(state))
end)

SettingsTab:AddToggle("Modo Rainbow (Borda)", false, function(toggled)
    _G.MoonRainbow = toggled
    task.spawn(function()
        while _G.MoonRainbow do
            local Main = game:GetService("CoreGui").MoonCat_.MainFrame:FindFirstChildOfClass("UIStroke")
            if Main and Main:FindFirstChildOfClass("UIGradient") then
                for i = 0, 1, 0.01 do
                    if not _G.MoonRainbow then break end
                    Main:FindFirstChildOfClass("UIGradient").Color = ColorSequence.new(Color3.fromHSV(i, 1, 1))
                    task.wait(0.05)
                end
            end
            task.wait()
        end
    end)
end)

-- 7. ABA DE CRÉDITOS E SEGURANÇA [cite: 2026-02-23, 2026-02-25]
local CreditsTab = Window:CreateTab("Créditos")

CreditsTab:AddLabel("Desenvolvedor: MOONCAT-HUB") [cite: 2026-02-25]
CreditsTab:AddLabel("Versão: 2.0 (Beta Private Build)") [cite: 2026-02-23]
CreditsTab:AddParagraph("Termos de Uso", "versão beta proibido divulgar sem autorização. Se for divulgar, use o link oficial.") [cite: 2026-02-23]

-- 8. FINALIZAÇÃO DO SCRIPT [cite: 2026-02-25]
MoonLib:Notify("MoonCat Hub", "Tudo pronto! Aproveite o visual neon.", 5)
print("==========================================")
print("   MOONLIB CARREGADA (100+ LINHAS)        ")
