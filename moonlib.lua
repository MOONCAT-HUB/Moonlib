local MoonLib = {Themes = {Main = Color3.fromRGB(10,10,10), Accent = Color3.fromRGB(125,0,255), Section = Color3.fromRGB(20,20,20)}}
local UIS, CoreGui = game:GetService("UserInputService"), game:GetService("CoreGui")

local function Drag(gui)
    local d, i, s, p
    gui.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then d = true; s = input.Position; p = gui.Position end end)
    UIS.InputChanged:Connect(function(input) if d and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - s
        gui.Position = UDim2.new(p.X.Scale, p.X.Offset + delta.X, p.Y.Scale, p.Y.Offset + delta.Y)
    end end)
    UIS.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then d = false end end)
end

function MoonLib:CreateLib(Config)
    local Screen = Instance.new("ScreenGui", CoreGui)
    
    -- O "M" que você queria, mas com estilo neon
    local M = Instance.new("TextButton", Screen)
    M.Size = UDim2.new(0, 50, 0, 50); M.Position = UDim2.new(0, 20, 0, 20)
    M.BackgroundColor3 = MoonLib.Themes.Main; M.Text = "M"; M.TextColor3 = MoonLib.Themes.Accent
    M.Font = "GothamBold"; M.TextSize = 25; Instance.new("UICorner", M).CornerRadius = UDim.new(1,0)
    local StrokeM = Instance.new("UIStroke", M); StrokeM.Color = MoonLib.Themes.Accent; StrokeM.Thickness = 2
    Drag(M)

    local Main = Instance.new("Frame", Screen)
    Main.Size = UDim2.new(0, 480, 0, 320); Main.Position = UDim2.new(0.5, -240, 0.5, -160)
    Main.BackgroundColor3 = MoonLib.Themes.Main; Instance.new("UICorner", Main)
    local MainStroke = Instance.new("UIStroke", Main); MainStroke.Color = MoonLib.Themes.Accent; MainStroke.Transparency = 0.5
    Drag(Main)
    M.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

    local Side = Instance.new("Frame", Main)
    Side.Size = UDim2.new(0, 130, 1, 0); Side.BackgroundColor3 = Color3.fromRGB(15,15,15)
    Instance.new("UICorner", Side)

    local Container = Instance.new("Frame", Main)
    Container.Size = UDim2.new(1, -140, 1, -10); Container.Position = UDim2.new(0, 135, 0, 5); Container.BackgroundTransparency = 1

    local Lib = {}
    function Lib:CreateTab(tName)
        local Page = Instance.new("ScrollingFrame", Container)
        Page.Size = UDim2.new(1, 0, 1, 0); Page.BackgroundTransparency = 1; Page.Visible = false; Page.ScrollBarThickness = 0
        Instance.new("UIListLayout", Page).Padding = UDim.new(0, 6)

        local TabBtn = Instance.new("TextButton", Side)
        TabBtn.Size = UDim2.new(1, -10, 0, 32); TabBtn.Position = UDim2.new(0, 5, 0, #Side:GetChildren()*35)
        TabBtn.Text = tName; TabBtn.BackgroundColor3 = MoonLib.Themes.Section; TabBtn.TextColor3 = Color3.fromRGB(200,200,200)
        Instance.new("UICorner", TabBtn)
        TabBtn.MouseButton1Click:Connect(function() for _, v in pairs(Container:GetChildren()) do v.Visible = false end; Page.Visible = true end)

        local Items = {}
        function Items:NewSection(sName)
            return {
                AddButton = function(_, bName, cb)
                    local b = Instance.new("TextButton", Page)
                    b.Size = UDim2.new(1, 0, 0, 38); b.Text = bName; b.TextColor3 = Color3.fromRGB(255,255,255)
                    b.BackgroundColor3 = MoonLib.Themes.Section; Instance.new("UICorner", b); b.MouseButton1Click:Connect(cb)
                end,
                AddToggle = function(_, tName, cb)
                    local t = Instance.new("TextButton", Page)
                    t.Size = UDim2.new(1, 0, 0, 38); t.Text = "  " .. tName; t.TextXAlignment = "Left"; t.TextColor3 = Color3.fromRGB(255,255,255)
                    t.BackgroundColor3 = MoonLib.Themes.Section; Instance.new("UICorner", t)
                    local s = Instance.new("Frame", t); s.Size = UDim2.new(0, 18, 0, 18); s.Position = UDim2.new(1, -28, 0.5, -9)
                    s.BackgroundColor3 = Color3.fromRGB(40,40,40); Instance.new("UICorner", s).CornerRadius = UDim.new(1,0)
                    local val = false
                    t.MouseButton1Click:Connect(function() val = not val; s.BackgroundColor3 = val and MoonLib.Themes.Accent or Color3.fromRGB(40,40,40); cb(val) end)
                end
            }
        end
        return Items
    end
    return Lib
end
return MoonLib
