local MoonLib = {}
MoonLib.Themes = {Main = Color3.fromRGB(15,15,15), Accent = Color3.fromRGB(120,0,255)}

function MoonLib:CreateLib(Config)
    local Screen = Instance.new("ScreenGui", game:GetService("CoreGui"))
    
    local Main = Instance.new("Frame", Screen)
    Main.Size = UDim2.new(0, 450, 0, 300)
    Main.Position = UDim2.new(0.5, -225, 0.5, -150)
    Main.BackgroundColor3 = MoonLib.Themes.Main
    Instance.new("UICorner", Main)

    local Title = Instance.new("TextLabel", Main)
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.Text = Config.Name or "Moon Cat Hub"
    Title.TextColor3 = MoonLib.Themes.Accent
    Title.BackgroundTransparency = 1
    Title.TextSize = 20

    local Lib = {}
    function Lib:CreateTab(tName)
        local Page = Instance.new("ScrollingFrame", Main)
        Page.Size = UDim2.new(1, -20, 1, -50)
        Page.Position = UDim2.new(0, 10, 0, 45)
        Page.BackgroundTransparency = 1
        return {
            NewSection = function()
                return {
                    AddButton = function(_, bName, cb)
                        local b = Instance.new("TextButton", Page)
                        b.Size = UDim2.new(1, 0, 0, 35)
                        b.Text = bName
                        b.MouseButton1Click:Connect(cb)
                    end
                }
            end
        }
    end
    return Lib
end
return MoonLib
