-- Moon Cat Hub (Propriedade: MoonCat / Redz)
-- versão beta proibido divulgar sem autorização

local RedzLib = {}

function RedzLib:CreateWindow(Config)
    local Title = Config.Title or "Redz Hub"
    local Subtitle = Config.SubTitle or "versão beta proibido divulgar sem autorização"
    
    -- [ UI PRINCIPAL ]
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    local Main = Instance.new("Frame", ScreenGui) -- O retângulo principal
    Main.Size = UDim2.new(0, 550, 0, 350)
    Main.Position = UDim2.new(0.5, -275, 0.5, -175)
    Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15) -- Fundo Dark Redz
    
    -- [ CORNERS - O arredondado clássico ]
    local UICorner = Instance.new("UICorner", Main)
    UICorner.CornerRadius = UDim.new(0, 8)

    -- [ SIDEBAR - Onde ficam os ícones ]
    local SideBar = Instance.new("Frame", Main)
    SideBar.Size = UDim2.new(0, 150, 1, 0)
    SideBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    
    local SideCorner = Instance.new("UICorner", SideBar)
    
    -- [ TÍTULO E SUBTÍTULO ]
    local TxtTitle = Instance.new("TextLabel", SideBar)
    TxtTitle.Text = Title
    TxtTitle.Position = UDim2.new(0, 15, 0, 20)
    TxtTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    TxtTitle.TextXAlignment = Enum.TextXAlignment.Left
    TxtTitle.Font = Enum.Font.GothamBold
    
    local TxtSub = Instance.new("TextLabel", SideBar)
    TxtSub.Text = Subtitle
    TxtSub.Size = UDim2.new(0, 120, 0, 20)
    TxtSub.Position = UDim2.new(0, 15, 0, 35)
    TxtSub.TextColor3 = Color3.fromRGB(150, 150, 150)
    TxtSub.TextSize = 10
    TxtSub.TextWrapped = true
    TxtSub.BackgroundTransparency = 1

    -- [ CONTAINER DE ABAS ]
    local TabContainer = Instance.new("ScrollingFrame", SideBar)
    TabContainer.Size = UDim2.new(1, 0, 1, -70)
    TabContainer.Position = UDim2.new(0, 0, 0, 70)
    TabContainer.BackgroundTransparency = 1
    
    return {
        CreateTab = function(self, name)
            -- Lógica de criação de botões idênticos aos da Redz
            local TabBtn = Instance.new("TextButton", TabContainer)
            TabBtn.Size = UDim2.new(1, -20, 0, 30)
            -- ... (Aqui entra o efeito de hover e o clique)
        end
    }
end

return RedzLib
