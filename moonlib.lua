local MoonLib = {
    Themes = {
        Main = Color3.fromRGB(13, 13, 13),
        Accent = Color3.fromRGB(120, 0, 255), -- Roxo Moon Cat
        Section = Color3.fromRGB(20, 20, 20),
        Text = Color3.fromRGB(255, 255, 255)
    }
}

local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TS = game:GetService("TweenService")

local function Ripple(obj)
    obj.MouseButton1Click:Connect(function()
        local r = Instance.new("Frame", obj)
        r.BackgroundColor3 = Color3.fromRGB(255,255,255)
        r.BackgroundTransparency = 0.8
        r.Size = UDim2.new(0,0,0,0)
        Instance.new("UICorner", r).CornerRadius = UDim.new(1,0)
        r:TweenSizeAndPosition(UDim2.new(1,0,1,0), UDim2.new(0,0,0,0), "Out", "Quart", 0.3)
        task.wait(0.3)
        TS:Create(r, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
        task.wait(0.2)
        r:Destroy()
    end)
end

function MoonLib:CreateLib(Config)
    local Screen = Instance.new("ScreenGui", CoreGui)
    Screen.Name = "MoonCat_V3"

    local Main = Instance.new("Frame", Screen)
    Main.Size = UDim2.new(0, 480, 0, 320)
    Main.Position = UDim2.new(0.5, -240, 0.5, -160)
    Main.BackgroundColor3 = MoonLib.Themes.Main
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
    
    local Glow = Instance.new("UIStroke", Main)
    Glow.Color = MoonLib.Themes.Accent
    Glow.Thickness = 1.5
    Glow.Transparency = 0.4

    local Sidebar = Instance.new("Frame", Main)
    Sidebar.Size = UDim2.new(0, 140, 1, 0)
    Sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 10)

    local TabContainer = Instance.new("ScrollingFrame", Sidebar)
    TabContainer.Size = UDim2.new(1, 0, 1, -40)
    TabContainer.Position = UDim2.new(0, 0, 0, 40)
    TabContainer.BackgroundTransparency = 1
    TabContainer.ScrollBarThickness = 0
    Instance.new("UIListLayout", TabContainer).Padding = UDim.new(0, 5)

    local Container = Instance.new("Frame", Main)
    Container.Size = UDim2.new(1, -150, 1, -10)
    Container.Position = UDim2.new(0, 145, 0, 5)
    Container.BackgroundTransparency = 1

    local Lib = {}
    function Lib:CreateTab(tName)
        local Page = Instance.new("ScrollingFrame", Container)
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.BackgroundTransparency = 1
        Page.Visible = false
        Page.ScrollBarThickness = 0
        local Layout = Instance.new("UIListLayout", Page)
        Layout.Padding = UDim.new(0, 8)
        
        -- Auto-Canvas Size
        Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Page.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y)
        end)

        local TabBtn = Instance.new("TextButton", TabContainer)
        TabBtn.Size = UDim2.new(1, -10, 0, 35)
        TabBtn.BackgroundColor3 = MoonLib.Themes.Section
        TabBtn.Text = tName
        TabBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
        TabBtn.Font = "GothamSemibold"
        Instance.new("UICorner", TabBtn)
        
        TabBtn.MouseButton1Click:Connect(function()
            for _, v in pairs(Container:GetChildren()) do v.Visible = false end
            Page.Visible = true
        end)

        local Items = {}
        function Items:NewSection(sName)
            local Section = {}
            function Section:AddToggle(text, callback)
                local Tgl = Instance.new("TextButton", Page)
                Tgl.Size = UDim2.new(1, 0, 0, 40)
                Tgl.BackgroundColor3 = MoonLib.Themes.Section
                Tgl.Text = "   " .. text
                Tgl.TextColor3 = MoonLib.Themes.Text
                Tgl.TextXAlignment = "Left"
                Instance.new("UICorner", Tgl)

                local BG = Instance.new("Frame", Tgl)
                BG.Size = UDim2.new(0, 35, 0, 18)
                BG.Position = UDim2.new(1, -45, 0.5, -9)
                BG.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                Instance.new("UICorner", BG).CornerRadius = UDim.new(1, 0)

                local Dot = Instance.new("Frame", BG)
                Dot.Size = UDim2.new(0, 14, 0, 14)
                Dot.Position = UDim2.new(0, 2, 0.5, -7)
                Dot.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
                Instance.new("UICorner", Dot).CornerRadius = UDim.new(1, 0)

                local state = false
                Tgl.MouseButton1Click:Connect(function()
                    state = not state
                    TS:Create(Dot, TweenInfo.new(0.2), {Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)}):Play()
                    TS:Create(BG, TweenInfo.new(0.2), {BackgroundColor3 = state and MoonLib.Themes.Accent or Color3.fromRGB(40, 40, 40)}):Play()
                    callback(state)
                end)
            end
            return Section
        end
        return Items
    end
    return Lib
end
return MoonLib
