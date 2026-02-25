local MoonLib = {Themes = {Main = Color3.fromRGB(15,15,15), Accent = Color3.fromRGB(120,0,255)}}
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

function MoonLib:CreateLib(Config)
    local WindowName = Config.Name or "Moon Cat Hub"
    local Screen = Instance.new("ScreenGui", CoreGui)
    
    local Main = Instance.new("Frame", Screen)
    Main.BackgroundColor3 = MoonLib.Themes.Main
    Main.Size = UDim2.new(0, 500, 0, 350)
    Main.Position = UDim2.new(0.5, -250, 0.5, -175)
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)
    
    local AccentLine = Instance.new("Frame", Main)
    AccentLine.Size = UDim2.new(1, 0, 0, 2)
    AccentLine.BackgroundColor3 = MoonLib.Themes.Accent
    AccentLine.BorderSizePixel = 0

    local Sidebar = Instance.new("Frame", Main)
    Sidebar.Size = UDim2.new(0, 140, 1, -2)
    Sidebar.Position = UDim2.new(0, 0, 0, 2)
    Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", Sidebar)

    local Title = Instance.new("TextLabel", Sidebar)
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.Text = WindowName
    Title.TextColor3 = MoonLib.Themes.Accent
    Title.BackgroundTransparency = 1
    Title.Font = "GothamBold"

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
        Instance.new("UIListLayout", Page).Padding = UDim.new(0, 5)

        local TabBtn = Instance.new("TextButton", Sidebar)
        TabBtn.Size = UDim2.new(1, -10, 0, 30)
        TabBtn.Text = tName
        TabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        Instance.new("UICorner", TabBtn)
        
        TabBtn.MouseButton1Click:Connect(function()
            for _, v in pairs(Container:GetChildren()) do v.Visible = false end
            Page.Visible = true
        end)

        local Items = {}
        function Items:NewSection(sName)
            local Sec = {}
            function Sec:AddButton(bName, callback)
                local Btn = Instance.new("TextButton", Page)
                Btn.Size = UDim2.new(1, 0, 0, 35)
                Btn.Text = bName
                Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                Instance.new("UICorner", Btn)
                Btn.MouseButton1Click:Connect(callback)
            end
            return Sec
        end
        return Items
    end
    return Lib
end
return MoonLib
