local Kavo = {}

local tween = game:GetService("TweenService")
local tweeninfo = TweenInfo.new
local input = game:GetService("UserInputService")
local run = game:GetService("RunService")

local Utility = {}
local Objects = {}
function Kavo:DraggingEnabled(frame, parent)
        
    parent = parent or frame
    
    -- stolen from wally or kiriot, kek
    local dragging = false
    local dragInput, mousePos, framePos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = parent.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    input.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            parent.Position  = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
        end
    end)
end

function Utility:TweenObject(obj, properties, duration, ...)
    tween:Create(obj, tweeninfo(duration, ...), properties):Play()
end


local themes = {
    SchemeColor = Color3.fromRGB(74, 99, 135),
    Background = Color3.fromRGB(36, 37, 43),
    Header = Color3.fromRGB(28, 29, 34),
    TextColor = Color3.fromRGB(255,255,255),
    ElementColor = Color3.fromRGB(32, 32, 38)
}
local themeStyles = {
  
    DarkTheme = {
        SchemeColor = Color3.fromRGB(64, 64, 64),
        Background = Color3.fromRGB(0, 0, 0),
        Header = Color3.fromRGB(0, 0, 0),
        TextColor = Color3.fromRGB(255,255,255),
        ElementColor = Color3.fromRGB(20, 20, 20)
    },
    LightTheme = {
        SchemeColor = Color3.fromRGB(150, 150, 150),
        Background = Color3.fromRGB(255,255,255),
        Header = Color3.fromRGB(200, 200, 200),
        TextColor = Color3.fromRGB(0,0,0),
        ElementColor = Color3.fromRGB(224, 224, 224)
    },
    BloodTheme = {
        SchemeColor = Color3.fromRGB(227, 27, 27),
        Background = Color3.fromRGB(10, 10, 10),
        Header = Color3.fromRGB(5, 5, 5),
        TextColor = Color3.fromRGB(255,255,255),
        ElementColor = Color3.fromRGB(20, 20, 20)
    },
    GrapeTheme = {
        SchemeColor = Color3.fromRGB(166, 71, 214),
        Background = Color3.fromRGB(64, 50, 71),
        Header = Color3.fromRGB(36, 28, 41),
        TextColor = Color3.fromRGB(255,255,255),
        ElementColor = Color3.fromRGB(74, 58, 84)
    },
    Ocean = {
        SchemeColor = Color3.fromRGB(86, 76, 251),
        Background = Color3.fromRGB(26, 32, 58),
        Header = Color3.fromRGB(38, 45, 71),
        TextColor = Color3.fromRGB(200, 200, 200),
        ElementColor = Color3.fromRGB(38, 45, 71)
    },
    Midnight = {
        SchemeColor = Color3.fromRGB(26, 189, 158),
        Background = Color3.fromRGB(44, 62, 82),
        Header = Color3.fromRGB(57, 81, 105),
        TextColor = Color3.fromRGB(255, 255, 255),
        ElementColor = Color3.fromRGB(52, 74, 95)
    },
    Sentinel = {
        SchemeColor = Color3.fromRGB(230, 35, 69),
        Background = Color3.fromRGB(32, 32, 32),
        Header = Color3.fromRGB(24, 24, 24),
        TextColor = Color3.fromRGB(119, 209, 138),
        ElementColor = Color3.fromRGB(24, 24, 24)
    },
    Synapse = {
        SchemeColor = Color3.fromRGB(46, 48, 43),
        Background = Color3.fromRGB(13, 15, 12),
        Header = Color3.fromRGB(36, 38, 35),
        TextColor = Color3.fromRGB(152, 99, 53),
        ElementColor = Color3.fromRGB(24, 24, 24)
    },
    Serpent = {
        SchemeColor = Color3.fromRGB(0, 166, 58),
        Background = Color3.fromRGB(31, 41, 43),
        Header = Color3.fromRGB(22, 29, 31),
        TextColor = Color3.fromRGB(255,255,255),
        ElementColor = Color3.fromRGB(22, 29, 31)
    }
}
local oldTheme = ""

local SettingsT = {

}

local Name = "KavoConfig.JSON"

pcall(function()

if not pcall(function() readfile(Name) end) then
writefile(Name, game:service'HttpService':JSONEncode(SettingsT))
end

Settings = game:service'HttpService':JSONEncode(readfile(Name))
end)

local LibName = tostring(math.random(1, 100))..tostring(math.random(1,50))..tostring(math.random(1, 100))

function Kavo:ToggleUI()
    if game.CoreGui[LibName].Enabled then
        game.CoreGui[LibName].Enabled = false
    else
        game.CoreGui[LibName].Enabled = true
    end
end

function Kavo.CreateLib(kavName, themeList)
    if not themeList then
        themeList = themes
    end
    if themeList == "DarkTheme" then
        themeList = themeStyles.DarkTheme
    elseif themeList == "LightTheme" then
        themeList = themeStyles.LightTheme
    elseif themeList == "BloodTheme" then
        themeList = themeStyles.BloodTheme
    elseif themeList == "GrapeTheme" then
        themeList = themeStyles.GrapeTheme
    elseif themeList == "Ocean" then
        themeList = themeStyles.Ocean
    elseif themeList == "Midnight" then
        themeList = themeStyles.Midnight
    elseif themeList == "Sentinel" then
        themeList = themeStyles.Sentinel
    elseif themeList == "Synapse" then
        themeList = themeStyles.Synapse
    elseif themeList == "Serpent" then
        themeList = themeStyles.Serpent
    else
        if themeList.SchemeColor == nil then
            themeList.SchemeColor = Color3.fromRGB(74, 99, 135)
        elseif themeList.Background == nil then
            themeList.Background = Color3.fromRGB(36, 37, 43)
        elseif themeList.Header == nil then
            themeList.Header = Color3.fromRGB(28, 29, 34)
        elseif themeList.TextColor == nil then
            themeList.TextColor = Color3.fromRGB(255,255,255)
        elseif themeList.ElementColor == nil then
            themeList.ElementColor = Color3.fromRGB(32, 32, 38)
        end
    end

    themeList = themeList or {}
    local selectedTab 
    kavName = kavName or "Library"
    table.insert(Kavo, kavName)
    for i,v in pairs(game.CoreGui:GetChildren()) do
        if v:IsA("ScreenGui") and v.Name == kavName then
            v:Destroy()
        end
    end
    local ScreenGui = Instance.new("ScreenGui")
    local Main = Instance.new("Frame")
    local MainCorner = Instance.new("UICorner")
    local MainHeader = Instance.new("Frame")
    local headerCover = Instance.new("UICorner")
    local coverup = Instance.new("Frame")
    local title = Instance.new("TextLabel")
    local close = Instance.new("ImageButton")
    local MainSide = Instance.new("Frame")
    local sideCorner = Instance.new("UICorner")
    local coverup_2 = Instance.new("Frame")
    local tabFrames = Instance.new("Frame")
    local tabListing = Instance.new("UIListLayout")
    local pages = Instance.new("Frame")
    local Pages = Instance.new("Folder")
    local infoContainer = Instance.new("Frame")

    local blurFrame = Instance.new("Frame")

    Kavo:DraggingEnabled(MainHeader, Main)

    blurFrame.Name = "blurFrame"
    blurFrame.Parent = pages
    blurFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    blurFrame.BackgroundTransparency = 1
    blurFrame.BorderSizePixel = 0
    blurFrame.Position = UDim2.new(-0.0222222228, 0, -0.0371747203, 0)
    blurFrame.Size = UDim2.new(0, 376, 0, 289)
    blurFrame.ZIndex = 999

    ScreenGui.Parent = game.CoreGui
    ScreenGui.Name = LibName
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false

    Main.Name = "Main"
    Main.Parent = ScreenGui
    Main.BackgroundColor3 = themeList.Background
    Main.ClipsDescendants = true
    Main.Position = UDim2.new(0.336503863, 0, 0.275485456, 0)
    Main.Size = UDim2.new(0, 525, 0, 318)

    MainCorner.CornerRadius = UDim.new(0, 4)
    MainCorner.Name = "MainCorner"
    MainCorner.Parent = Main

    MainHeader.Name = "MainHeader"
    MainHeader.Parent = Main
    MainHeader.BackgroundColor3 = themeList.Header
    Objects[MainHeader] = "BackgroundColor3"
    MainHeader.Size = UDim2.new(0, 525, 0, 29)
    headerCover.CornerRadius = UDim.new(0, 4)
    headerCover.Name = "headerCover"
    headerCover.Parent = MainHeader

    coverup.Name = "coverup"
    coverup.Parent = MainHeader
    coverup.BackgroundColor3 = themeList.Header
    Objects[coverup] = "BackgroundColor3"
    coverup.BorderSizePixel = 0
    coverup.Position = UDim2.new(0, 0, 0.758620679, 0)
    coverup.Size = UDim2.new(0, 525, 0, 7)

    title.Name = "title"
    title.Parent = MainHeader
    title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    title.BackgroundTransparency = 1.000
    title.BorderSizePixel = 0
    title.Position = UDim2.new(0.0171428565, 0, 0.344827592, 0)
    title.Size = UDim2.new(0, 204, 0, 8)
    title.Font = Enum.Font.Garamond
    title.RichText = true
    title.Text = kavName
    title.TextColor3 = Color3.fromRGB(245, 245, 245)
    title.TextSize = 16.000
    title.TextXAlignment = Enum.TextXAlignment.Left

    close.Name = "close"
    close.Parent = MainHeader
    close.BackgroundTransparency = 1.000
    close.Position = UDim2.new(0.949999988, 0, 0.137999997, 0)
    close.Size = UDim2.new(0, 21, 0, 21)
    close.ZIndex = 2
    close.Image = "rbxassetid://3926305904"
    close.ImageRectOffset = Vector2.new(284, 4)
    close.ImageRectSize = Vector2.new(24, 24)
    close.MouseButton1Click:Connect(function()
        game.TweenService:Create(close, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            ImageTransparency = 1
        }):Play()
        wait()
        game.TweenService:Create(Main, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = UDim2.new(0,0,0,0),
			Position = UDim2.new(0, Main.AbsolutePosition.X + (Main.AbsoluteSize.X / 2), 0, Main.AbsolutePosition.Y + (Main.AbsoluteSize.Y / 2))
		}):Play()
        wait(1)
        ScreenGui:Destroy()
    end)

    MainSide.Name = "MainSide"
    MainSide.Parent = Main
    MainSide.BackgroundColor3 = themeList.Header
    Objects[MainSide] = "Header"
    MainSide.Position = UDim2.new(-7.4505806e-09, 0, 0.0911949649, 0)
    MainSide.Size = UDim2.new(0, 149, 0, 289)

    sideCorner.CornerRadius = UDim.new(0, 4)
    sideCorner.Name = "sideCorner"
    sideCorner.Parent = MainSide

    coverup_2.Name = "coverup"
    coverup_2.Parent = MainSide
    coverup_2.BackgroundColor3 = themeList.Header
    Objects[coverup_2] = "Header"
    coverup_2.BorderSizePixel = 0
    coverup_2.Position = UDim2.new(0.949939311, 0, 0, 0)
    coverup_2.Size = UDim2.new(0, 7, 0, 289)

    tabFrames.Name = "tabFrames"
    tabFrames.Parent = MainSide
    tabFrames.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    tabFrames.BackgroundTransparency = 1.000
    tabFrames.Position = UDim2.new(0.0438990258, 0, -0.00066378375, 0)
    tabFrames.Size = UDim2.new(0, 135, 0, 283)

    tabListing.Name = "tabListing"
    tabListing.Parent = tabFrames
    tabListing.SortOrder = Enum.SortOrder.LayoutOrder

    pages.Name = "pages"
    pages.Parent = Main
    pages.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    pages.BackgroundTransparency = 1.000
    pages.BorderSizePixel = 0
    pages.Position = UDim2.new(0.299047589, 0, 0.122641519, 0)
    pages.Size = UDim2.new(0, 360, 0, 269)

    Pages.Name = "Pages"
    Pages.Parent = pages

    infoContainer.Name = "infoContainer"
    infoContainer.Parent = Main
    infoContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    infoContainer.BackgroundTransparency = 1.000
    infoContainer.BorderColor3 = Color3.fromRGB(27, 42, 53)
    infoContainer.ClipsDescendants = true
    infoContainer.Position = UDim2.new(0.299047619, 0, 0.874213815, 0)
    infoContainer.Size = UDim2.new(0, 368, 0, 33)

    
    coroutine.wrap(function()
        while wait() do
            Main.BackgroundColor3 = themeList.Background
            MainHeader.BackgroundColor3 = themeList.Header
            MainSide.BackgroundColor3 = themeList.Header
            coverup_2.BackgroundColor3 = themeList.Header
            coverup.BackgroundColor3 = themeList.Header
        end
    end)()

    function Kavo:ChangeColor(prope,color)
        if prope == "Background" then
            themeList.Background = color
        elseif prope == "SchemeColor" then
            themeList.SchemeColor = color
        elseif prope == "Header" then
            themeList.Header = color
        elseif prope == "TextColor" then
            themeList.TextColor = color
        elseif prope == "ElementColor" then
            themeList.ElementColor = color
        end
    end
    local Tabs = {}

    local first = true

    function Tabs:NewTab(tabName)
        tabName = tabName or "Tab"
        local tabButton = Instance.new("TextButton")
        local UICorner = Instance.new("UICorner")
        local page = Instance.new("ScrollingFrame")
        local pageListing = Instance.new("UIListLayout")

        local function UpdateSize()
            local cS = pageListing.AbsoluteContentSize

            game.TweenService:Create(page, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                CanvasSize = UDim2.new(0,cS.X,0,cS.Y)
            }):Play()
        end

        page.Name = "Page"
        page.Parent = Pages
        page.Active = true
        page.BackgroundColor3 = themeList.Background
        page.BorderSizePixel = 0
        page.Position = UDim2.new(0, 0, -0.00371747208, 0)
        page.Size = UDim2.new(1, 0, 1, 0)
        page.ScrollBarThickness = 5
        page.Visible = false
        page.ScrollBarImageColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 16, themeList.SchemeColor.g * 255 - 15, themeList.SchemeColor.b * 255 - 28)

        pageListing.Name = "pageListing"
        pageListing.Parent = page
        pageListing.SortOrder = Enum.SortOrder.LayoutOrder
        pageListing.Padding = UDim.new(0, 5)

        tabButton.Name = tabName.."TabButton"
        tabButton.Parent = tabFrames
        tabButton.BackgroundColor3 = themeList.SchemeColor
        Objects[tabButton] = "SchemeColor"
        tabButton.Size = UDim2.new(0, 135, 0, 28)
        tabButton.AutoButtonColor = false
        tabButton.Font = Enum.Font.Gotham
        tabButton.Text = tabName
        tabButton.TextColor3 = themeList.TextColor
        Objects[tabButton] = "TextColor3"
        tabButton.TextSize = 14.000
        tabButton.BackgroundTransparency = 1

        if first then
            first = false
            page.Visible = true
            tabButton.BackgroundTransparency = 0
            UpdateSize()
        else
            page.Visible = false
            tabButton.BackgroundTransparency = 1
        end

        UICorner.CornerRadius = UDim.new(0, 5)
        UICorner.Parent = tabButton
        table.insert(Tabs, tabName)

        UpdateSize()
        page.ChildAdded:Connect(UpdateSize)
        page.ChildRemoved:Connect(UpdateSize)

        tabButton.MouseButton1Click:Connect(function()
            UpdateSize()
            for i,v in next, Pages:GetChildren() do
                v.Visible = false
            end
            page.Visible = true
            for i,v in next, tabFrames:GetChildren() do
                if v:IsA("TextButton") then
                    if themeList.SchemeColor == Color3.fromRGB(255,255,255) then
                        Utility:TweenObject(v, {TextColor3 = Color3.fromRGB(255,255,255)}, 0.2)
                    end 
                    if themeList.SchemeColor == Color3.fromRGB(0,0,0) then
                        Utility:TweenObject(v, {TextColor3 = Color3.fromRGB(0,0,0)}, 0.2)
                    end 
                    Utility:TweenObject(v, {BackgroundTransparency = 1}, 0.2)
                end
            end
            if themeList.SchemeColor == Color3.fromRGB(255,255,255) then
                Utility:TweenObject(tabButton, {TextColor3 = Color3.fromRGB(0,0,0)}, 0.2)
            end 
            if themeList.SchemeColor == Color3.fromRGB(0,0,0) then
                Utility:TweenObject(tabButton, {TextColor3 = Color3.fromRGB(255,255,255)}, 0.2)
            end 
            Utility:TweenObject(tabButton, {BackgroundTransparency = 0}, 0.2)
        end)
        local Sections = {}
        local focusing = false
        local viewDe = false

        coroutine.wrap(function()
            while wait() do
                page.BackgroundColor3 = themeList.Background
                page.ScrollBarImageColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 16, themeList.SchemeColor.g * 255 - 15, themeList.SchemeColor.b * 255 - 28)
                tabButton.TextColor3 = themeList.TextColor
                tabButton.BackgroundColor3 = themeList.SchemeColor
            end
        end)()
    
        function Sections:NewSection(secName, hidden)
            secName = secName or "Section"
            local sectionFunctions = {}
            local modules = {}
	    hidden = hidden or false
            local sectionFrame = Instance.new("Frame")
            local sectionlistoknvm = Instance.new("UIListLayout")
            local sectionHead = Instance.new("Frame")
            local sHeadCorner = Instance.new("UICorner")
            local sectionName = Instance.new("TextLabel")
            local sectionInners = Instance.new("Frame")
            local sectionElListing = Instance.new("UIListLayout")
			
	    if hidden then
		sectionHead.Visible = false
	    else
		sectionHead.Visible = true
	    end

            sectionFrame.Name = "sectionFrame"
            sectionFrame.Parent = page
            sectionFrame.BackgroundColor3 = themeList.Background--36, 37, 43
            sectionFrame.BorderSizePixel = 0
            
            sectionlistoknvm.Name = "sectionlistoknvm"
            sectionlistoknvm.Parent = sectionFrame
            sectionlistoknvm.SortOrder = Enum.SortOrder.LayoutOrder
            sectionlistoknvm.Padding = UDim.new(0, 5)

            for i,v in pairs(sectionInners:GetChildren()) do
                while wait() do
                    if v:IsA("Frame") or v:IsA("TextButton") then
                        function size(pro)
                            if pro == "Size" then
                                UpdateSize()
                                updateSectionFrame()
                            end
                        end
                        v.Changed:Connect(size)
                    end
                end
            end
            sectionHead.Name = "sectionHead"
            sectionHead.Parent = sectionFrame
            sectionHead.BackgroundColor3 = themeList.SchemeColor
            Objects[sectionHead] = "BackgroundColor3"
            sectionHead.Size = UDim2.new(0, 352, 0, 33)

            sHeadCorner.CornerRadius = UDim.new(0, 4)
            sHeadCorner.Name = "sHeadCorner"
            sHeadCorner.Parent = sectionHead

            sectionName.Name = "sectionName"
            sectionName.Parent = sectionHead
            sectionName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            sectionName.BackgroundTransparency = 1.000
            sectionName.BorderColor3 = Color3.fromRGB(27, 42, 53)
            sectionName.Position = UDim2.new(0.0198863633, 0, 0, 0)
            sectionName.Size = UDim2.new(0.980113626, 0, 1, 0)
            sectionName.Font = Enum.Font.Gotham
            sectionName.Text = secName
            sectionName.RichText = true
            sectionName.TextColor3 = themeList.TextColor
            Objects[sectionName] = "TextColor3"
            sectionName.TextSize = 14.000
            sectionName.TextXAlignment = Enum.TextXAlignment.Left
            if themeList.SchemeColor == Color3.fromRGB(255,255,255) then
                Utility:TweenObject(sectionName, {TextColor3 = Color3.fromRGB(0,0,0)}, 0.2)
            end 
            if themeList.SchemeColor == Color3.fromRGB(0,0,0) then
                Utility:TweenObject(sectionName, {TextColor3 = Color3.fromRGB(255,255,255)}, 0.2)
            end 
               
            sectionInners.Name = "sectionInners"
            sectionInners.Parent = sectionFrame
            sectionInners.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            sectionInners.BackgroundTransparency = 1.000
            sectionInners.Position = UDim2.new(0, 0, 0.190751448, 0)

            sectionElListing.Name = "sectionElListing"
            sectionElListing.Parent = sectionInners
            sectionElListing.SortOrder = Enum.SortOrder.LayoutOrder
            sectionElListing.Padding = UDim.new(0, 3)

            
        coroutine.wrap(function()
            while wait() do
                sectionFrame.BackgroundColor3 = themeList.Background
                sectionHead.BackgroundColor3 = themeList.SchemeColor
                tabButton.TextColor3 = themeList.TextColor
                tabButton.BackgroundColor3 = themeList.SchemeColor
                sectionName.TextColor3 = themeList.TextColor
            end
        end)()

            local function updateSectionFrame()
                local innerSc = sectionElListing.AbsoluteContentSize
                sectionInners.Size = UDim2.new(1, 0, 0, innerSc.Y)
                local frameSc = sectionlistoknvm.AbsoluteContentSize
                sectionFrame.Size = UDim2.new(0, 352, 0, frameSc.Y)
            end
                updateSectionFrame()
                UpdateSize()
            local Elements = {}
            function Elements:NewButton(bname,tipINf, callback)
                showLogo = showLogo or true
                local ButtonFunction = {}
                tipINf = tipINf or "Tip: Clicking this nothing will happen!"
                bname = bname or "Click Me!"
                callback = callback or function() end

                local buttonElement = Instance.new("TextButton")
                local UICorner = Instance.new("UICorner")
                local btnInfo = Instance.new("TextLabel")
                local viewInfo = Instance.new("ImageButton")
                local touch = Instance.new("ImageLabel")
                local Sample = Instance.new("ImageLabel")

                table.insert(modules, bname)

                buttonElement.Name = bname
                buttonElement.Parent = sectionInners
                buttonElement.BackgroundColor3 = themeList.ElementColor
                buttonElement.ClipsDescendants = true
                buttonElement.Size = UDim2.new(0, 352, 0, 33)
                buttonElement.AutoButtonColor = false
                buttonElement.Font = Enum.Font.SourceSans
                buttonElement.Text = ""
                buttonElement.TextColor3 = Color3.fromRGB(0, 0, 0)
                buttonElement.TextSize = 14.000
                Objects[buttonElement] = "BackgroundColor3"

                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = buttonElement

                viewInfo.Name = "viewInfo"
                viewInfo.Parent = buttonElement
                viewInfo.BackgroundTransparency = 1.000
                viewInfo.LayoutOrder = 9
                viewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
                viewInfo.Size = UDim2.new(0, 23, 0, 23)
                viewInfo.ZIndex = 2
                viewInfo.Image = "rbxassetid://3926305904"
                viewInfo.ImageColor3 = themeList.SchemeColor
                Objects[viewInfo] = "ImageColor3"
                viewInfo.ImageRectOffset = Vector2.new(764, 764)
                viewInfo.ImageRectSize = Vector2.new(36, 36)

                Sample.Name = "Sample"
                Sample.Parent = buttonElement
                Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Sample.BackgroundTransparency = 1.000
                Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
                Sample.ImageColor3 = themeList.SchemeColor
                Objects[Sample] = "ImageColor3"
                Sample.ImageTransparency = 0.600

                local moreInfo = Instance.new("TextLabel")
                local UICorner = Instance.new("UICorner")

                moreInfo.Name = "TipMore"
                moreInfo.Parent = infoContainer
                moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
                moreInfo.Position = UDim2.new(0, 0, 2, 0)
                moreInfo.Size = UDim2.new(0, 353, 0, 33)
                moreInfo.ZIndex = 9
                moreInfo.Font = Enum.Font.GothamSemibold
                moreInfo.Text = "  "..tipINf
                moreInfo.RichText = true
                moreInfo.TextColor3 = themeList.TextColor
                Objects[moreInfo] = "TextColor3"
                moreInfo.TextSize = 14.000
                moreInfo.TextXAlignment = Enum.TextXAlignment.Left
                Objects[moreInfo] = "BackgroundColor3"

                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = moreInfo

                touch.Name = "touch"
                touch.Parent = buttonElement
                touch.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                touch.BackgroundTransparency = 1.000
                touch.BorderColor3 = Color3.fromRGB(27, 42, 53)
                touch.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
                touch.Size = UDim2.new(0, 21, 0, 21)
                touch.Image = "rbxassetid://3926305904"
                touch.ImageColor3 = themeList.SchemeColor
                Objects[touch] = "SchemeColor"
                touch.ImageRectOffset = Vector2.new(84, 204)
                touch.ImageRectSize = Vector2.new(36, 36)
                touch.ImageTransparency = 0

                btnInfo.Name = "btnInfo"
                btnInfo.Parent = buttonElement
                btnInfo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                btnInfo.BackgroundTransparency = 1.000
                btnInfo.Position = UDim2.new(0.096704483, 0, 0.272727281, 0)
                btnInfo.Size = UDim2.new(0, 314, 0, 14)
                btnInfo.Font = Enum.Font.GothamSemibold
                btnInfo.Text = bname
                btnInfo.RichText = true
                btnInfo.TextColor3 = themeList.TextColor
                Objects[btnInfo] = "TextColor3"
                btnInfo.TextSize = 14.000
                btnInfo.TextXAlignment = Enum.TextXAlignment.Left

                if themeList.SchemeColor == Color3.fromRGB(255,255,255) then
                    Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(0,0,0)}, 0.2)
                end 
                if themeList.SchemeColor == Color3.fromRGB(0,0,0) then
                    Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(255,255,255)}, 0.2)
                end 

                updateSectionFrame()
                                UpdateSize()

                local ms = game.Players.LocalPlayer:GetMouse()

                local btn = buttonElement
                local sample = Sample

                btn.MouseButton1Click:Connect(function()
                    if not focusing then
                        callback()
                        local c = sample:Clone()
                        c.Parent = btn
                        local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
                        c.Position = UDim2.new(0, x, 0, y)
                        local len, size = 0.35, nil
                        if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
                            size = (btn.AbsoluteSize.X * 1.5)
                        else
                            size = (btn.AbsoluteSize.Y * 1.5)
                        end
                        c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
                        for i = 1, 10 do
                            c.ImageTransparency = c.ImageTransparency + 0.05
                            wait(len / 12)
                        end
                        c:Destroy()
                    else
                        for i,v in next, infoContainer:GetChildren() do
                            Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
                            focusing = false
                        end
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                    end
                end)
                local hovering = false
                btn.MouseEnter:Connect(function()
                    if not focusing then
                        game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10)
                        }):Play()
                        hovering = true
                    end
                end)
                btn.MouseLeave:Connect(function()
                    if not focusing then 
                        game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            BackgroundColor3 = themeList.ElementColor
                        }):Play()
                        hovering = false
                    end
                end)
                viewInfo.MouseButton1Click:Connect(function()
                    if not viewDe then
                        viewDe = true
                        focusing = true
                        for i,v in next, infoContainer:GetChildren() do
                            if v ~= moreInfo then
                                Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
                            end
                        end
                        Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,0,0)}, 0.2)
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 0.5}, 0.2)
                        Utility:TweenObject(btn, {BackgroundColor3 = themeList.ElementColor}, 0.2)
                        wait(1.5)
                        focusing = false
                        Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,2,0)}, 0.2)
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                        wait(0)
                        viewDe = false
                    end
                end)
                coroutine.wrap(function()
                    while wait() do
                        if not hovering then
                            buttonElement.BackgroundColor3 = themeList.ElementColor
                        end
                        viewInfo.ImageColor3 = themeList.SchemeColor
                        Sample.ImageColor3 = themeList.SchemeColor
                        moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
                        moreInfo.TextColor3 = themeList.TextColor
                        touch.ImageColor3 = themeList.SchemeColor
                        btnInfo.TextColor3 = themeList.TextColor
                    end
                end)()
                
                function ButtonFunction:UpdateButton(newTitle)
                    btnInfo.Text = newTitle
                end
                return ButtonFunction
            end

            function Elements:NewTextBox(tname, tTip, callback)
                tname = tname or "Textbox"
                tTip = tTip or "Gets a value of Textbox"
                callback = callback or function() end
                local textboxElement = Instance.new("TextButton")
                local UICorner = Instance.new("UICorner")
                local viewInfo = Instance.new("ImageButton")
                local write = Instance.new("ImageLabel")
                local TextBox = Instance.new("TextBox")
                local UICorner_2 = Instance.new("UICorner")
                local togName = Instance.new("TextLabel")

                textboxElement.Name = "textboxElement"
                textboxElement.Parent = sectionInners
                textboxElement.BackgroundColor3 = themeList.ElementColor
                textboxElement.ClipsDescendants = true
                textboxElement.Size = UDim2.new(0, 352, 0, 33)
                textboxElement.AutoButtonColor = false
                textboxElement.Font = Enum.Font.SourceSans
                textboxElement.Text = ""
                textboxElement.TextColor3 = Color3.fromRGB(0, 0, 0)
                textboxElement.TextSize = 14.000

                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = textboxElement

                viewInfo.Name = "viewInfo"
                viewInfo.Parent = textboxElement
                viewInfo.BackgroundTransparency = 1.000
                viewInfo.LayoutOrder = 9
                viewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
                viewInfo.Size = UDim2.new(0, 23, 0, 23)
                viewInfo.ZIndex = 2
                viewInfo.Image = "rbxassetid://3926305904"
                viewInfo.ImageColor3 = themeList.SchemeColor
                viewInfo.ImageRectOffset = Vector2.new(764, 764)
                viewInfo.ImageRectSize = Vector2.new(36, 36)

                write.Name = "write"
                write.Parent = textboxElement
                write.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                write.BackgroundTransparency = 1.000
                write.BorderColor3 = Color3.fromRGB(27, 42, 53)
                write.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
                write.Size = UDim2.new(0, 21, 0, 21)
                write.Image = "rbxassetid://3926305904"
                write.ImageColor3 = themeList.SchemeColor
                write.ImageRectOffset = Vector2.new(324, 604)
                write.ImageRectSize = Vector2.new(36, 36)

                TextBox.Parent = textboxElement
                TextBox.BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 - 6, themeList.ElementColor.g * 255 - 6, themeList.ElementColor.b * 255 - 7)
                TextBox.BorderSizePixel = 0
                TextBox.ClipsDescendants = true
                TextBox.Position = UDim2.new(0.488749921, 0, 0.212121218, 0)
                TextBox.Size = UDim2.new(0, 150, 0, 18)
                TextBox.ZIndex = 99
                TextBox.ClearTextOnFocus = false
                TextBox.Font = Enum.Font.Gotham
                TextBox.PlaceholderColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 19, themeList.SchemeColor.g * 255 - 26, themeList.SchemeColor.b * 255 - 35)
                TextBox.PlaceholderText = "Type here!"
                TextBox.Text = ""
                TextBox.TextColor3 = themeList.SchemeColor
                TextBox.TextSize = 12.000

                UICorner_2.CornerRadius = UDim.new(0, 4)
                UICorner_2.Parent = TextBox

                togName.Name = "togName"
                togName.Parent = textboxElement
                togName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                togName.BackgroundTransparency = 1.000
                togName.Position = UDim2.new(0.096704483, 0, 0.272727281, 0)
                togName.Size = UDim2.new(0, 138, 0, 14)
                togName.Font = Enum.Font.GothamSemibold
                togName.Text = tname
                togName.RichText = true
                togName.TextColor3 = themeList.TextColor
                togName.TextSize = 14.000
                togName.TextXAlignment = Enum.TextXAlignment.Left

                local moreInfo = Instance.new("TextLabel")
                local UICorner = Instance.new("UICorner")

                moreInfo.Name = "TipMore"
                moreInfo.Parent = infoContainer
                moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
                moreInfo.Position = UDim2.new(0, 0, 2, 0)
                moreInfo.Size = UDim2.new(0, 353, 0, 33)
                moreInfo.ZIndex = 9
                moreInfo.Font = Enum.Font.GothamSemibold
                moreInfo.RichText = true
                moreInfo.Text = "  "..tTip
                moreInfo.TextColor3 = Color3.fromRGB(255, 255, 255)
                moreInfo.TextSize = 14.000
                moreInfo.TextXAlignment = Enum.TextXAlignment.Left

                if themeList.SchemeColor == Color3.fromRGB(255,255,255) then
                    Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(0,0,0)}, 0.2)
                end 
                if themeList.SchemeColor == Color3.fromRGB(0,0,0) then
                    Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(255,255,255)}, 0.2)
                end 

                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = moreInfo


                updateSectionFrame()
                                UpdateSize()
            
                local btn = textboxElement
                local infBtn = viewInfo

                btn.MouseButton1Click:Connect(function()
                    if focusing then
                        for i,v in next, infoContainer:GetChildren() do
                            Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
                            focusing = false
                        end
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                    end
                end)
                local hovering = false
                btn.MouseEnter:Connect(function()
                    if not focusing then
                        game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10)
                        }):Play()
                        hovering = true
                    end 
                end)

                btn.MouseLeave:Connect(function()
                    if not focusing then
                        game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            BackgroundColor3 = themeList.ElementColor
                        }):Play()
                        hovering = false
                    end
                end)

                TextBox.FocusLost:Connect(function(EnterPressed)
                    if focusing then
                        for i,v in next, infoContainer:GetChildren() do
                            Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
                            focusing = false
                        end
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                    end
                    if not EnterPressed then 
                        return
                    else
                        callback(TextBox.Text)
                        wait(0.18)
                        TextBox.Text = ""  
                    end
                end)

                viewInfo.MouseButton1Click:Connect(function()
                    if not viewDe then
                        viewDe = true
                        focusing = true
                        for i,v in next, infoContainer:GetChildren() do
                            if v ~= moreInfo then
                                Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
                            end
                        end
                        Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,0,0)}, 0.2)
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 0.5}, 0.2)
                        Utility:TweenObject(btn, {BackgroundColor3 = themeList.ElementColor}, 0.2)
                        wait(1.5)
                        focusing = false
                        Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,2,0)}, 0.2)
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                        wait(0)
                        viewDe = false
                    end
                end)
                coroutine.wrap(function()
                    while wait() do
                        if not hovering then
                            textboxElement.BackgroundColor3 = themeList.ElementColor
                        end
                        TextBox.BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 - 6, themeList.ElementColor.g * 255 - 6, themeList.ElementColor.b * 255 - 7)
                        viewInfo.ImageColor3 = themeList.SchemeColor
                        moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
                        moreInfo.TextColor3 = themeList.TextColor
                        write.ImageColor3 = themeList.SchemeColor
                        togName.TextColor3 = themeList.TextColor
                        TextBox.PlaceholderColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 19, themeList.SchemeColor.g * 255 - 26, themeList.SchemeColor.b * 255 - 35)
                        TextBox.TextColor3 = themeList.SchemeColor
                    end
                end)()
            end 

                function Elements:NewToggle(tname, nTip, callback)
                    local TogFunction = {}
                    tname = tname or "Toggle"
                    nTip = nTip or "Prints Current Toggle State"
                    callback = callback or function() end
                    local toggled = false
                    table.insert(SettingsT, tname)

                    local toggleElement = Instance.new("TextButton")
                    local UICorner = Instance.new("UICorner")
                    local toggleDisabled = Instance.new("ImageLabel")
                    local toggleEnabled = Instance.new("ImageLabel")
                    local togName = Instance.new("TextLabel")
                    local viewInfo = Instance.new("ImageButton")
                    local Sample = Instance.new("ImageLabel")

                    toggleElement.Name = "toggleElement"
                    toggleElement.Parent = sectionInners
                    toggleElement.BackgroundColor3 = themeList.ElementColor
                    toggleElement.ClipsDescendants = true
                    toggleElement.Size = UDim2.new(0, 352, 0, 33)
                    toggleElement.AutoButtonColor = false
                    toggleElement.Font = Enum.Font.SourceSans
                    toggleElement.Text = ""
                    toggleElement.TextColor3 = Color3.fromRGB(0, 0, 0)
                    toggleElement.TextSize = 14.000

                    UICorner.CornerRadius = UDim.new(0, 4)
                    UICorner.Parent = toggleElement

                    toggleDisabled.Name = "toggleDisabled"
                    toggleDisabled.Parent = toggleElement
                    toggleDisabled.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    toggleDisabled.BackgroundTransparency = 1.000
                    toggleDisabled.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
                    toggleDisabled.Size = UDim2.new(0, 21, 0, 21)
                    toggleDisabled.Image = "rbxassetid://3926309567"
                    toggleDisabled.ImageColor3 = themeList.SchemeColor
                    toggleDisabled.ImageRectOffset = Vector2.new(628, 420)
                    toggleDisabled.ImageRectSize = Vector2.new(48, 48)

                    toggleEnabled.Name = "toggleEnabled"
                    toggleEnabled.Parent = toggleElement
                    toggleEnabled.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    toggleEnabled.BackgroundTransparency = 1.000
                    toggleEnabled.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
                    toggleEnabled.Size = UDim2.new(0, 21, 0, 21)
                    toggleEnabled.Image = "rbxassetid://3926309567"
                    toggleEnabled.ImageColor3 = themeList.SchemeColor
                    toggleEnabled.ImageRectOffset = Vector2.new(784, 420)
                    toggleEnabled.ImageRectSize = Vector2.new(48, 48)
                    toggleEnabled.ImageTransparency = 1.000

                    togName.Name = "togName"
                    togName.Parent = toggleElement
                    togName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    togName.BackgroundTransparency = 1.000
                    togName.Position = UDim2.new(0.096704483, 0, 0.272727281, 0)
                    togName.Size = UDim2.new(0, 288, 0, 14)
                    togName.Font = Enum.Font.GothamSemibold
                    togName.Text = tname
                    togName.RichText = true
                    togName.TextColor3 = themeList.TextColor
                    togName.TextSize = 14.000
                    togName.TextXAlignment = Enum.TextXAlignment.Left

                    viewInfo.Name = "viewInfo"
                    viewInfo.Parent = toggleElement
                    viewInfo.BackgroundTransparency = 1.000
                    viewInfo.LayoutOrder = 9
                    viewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
                    viewInfo.Size = UDim2.new(0, 23, 0, 23)
                    viewInfo.ZIndex = 2
                    viewInfo.Image = "rbxassetid://3926305904"
                    viewInfo.ImageColor3 = themeList.SchemeColor
                    viewInfo.ImageRectOffset = Vector2.new(764, 764)
                    viewInfo.ImageRectSize = Vector2.new(36, 36)

                    Sample.Name = "Sample"
                    Sample.Parent = toggleElement
                    Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Sample.BackgroundTransparency = 1.000
                    Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
                    Sample.ImageColor3 = themeList.SchemeColor
                    Sample.ImageTransparency = 0.600

                    local moreInfo = Instance.new("TextLabel")
                    local UICorner = Instance.new("UICorner")
    
                    moreInfo.Name = "TipMore"
                    moreInfo.Parent = infoContainer
                    moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
                    moreInfo.Position = UDim2.new(0, 0, 2, 0)
                    moreInfo.Size = UDim2.new(0, 353, 0, 33)
                    moreInfo.ZIndex = 9
                    moreInfo.Font = Enum.Font.GothamSemibold
                    moreInfo.RichText = true
                    moreInfo.Text = "  "..nTip
                    moreInfo.TextColor3 = themeList.TextColor
                    moreInfo.TextSize = 14.000
                    moreInfo.TextXAlignment = Enum.TextXAlignment.Left
    
                    UICorner.CornerRadius = UDim.new(0, 4)
                    UICorner.Parent = moreInfo

                    local ms = game.Players.LocalPlayer:GetMouse()

                    if themeList.SchemeColor == Color3.fromRGB(255,255,255) then
                        Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(0,0,0)}, 0.2)
                    end 
                    if themeList.SchemeColor == Color3.fromRGB(0,0,0) then
                        Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(255,255,255)}, 0.2)
                    end 

                    local btn = toggleElement
                    local sample = Sample
                    local img = toggleEnabled
                    local infBtn = viewInfo

                                    updateSectionFrame()
                UpdateSize()

                    btn.MouseButton1Click:Connect(function()
                        if not focusing then
                            if toggled == false then
                                game.TweenService:Create(img, TweenInfo.new(0.11, Enum.EasingStyle.Linear,Enum.EasingDirection.In), {
                                    ImageTransparency = 0
                                }):Play()
                                local c = sample:Clone()
                                c.Parent = btn
                                local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
                                c.Position = UDim2.new(0, x, 0, y)
                                local len, size = 0.35, nil
                                if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
                                    size = (btn.AbsoluteSize.X * 1.5)
                                else
                                    size = (btn.AbsoluteSize.Y * 1.5)
                                end
                                c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
                                for i = 1, 10 do
                                    c.ImageTransparency = c.ImageTransparency + 0.05
                                    wait(len / 12)
                                end
                                c:Destroy()
                            else
                                game.TweenService:Create(img, TweenInfo.new(0.11, Enum.EasingStyle.Linear,Enum.EasingDirection.In), {
                                    ImageTransparency = 1
                                }):Play()
                                local c = sample:Clone()
                                c.Parent = btn
                                local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
                                c.Position = UDim2.new(0, x, 0, y)
                                local len, size = 0.35, nil
                                if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
                                    size = (btn.AbsoluteSize.X * 1.5)
                                else
                                    size = (btn.AbsoluteSize.Y * 1.5)
                                end
                                c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
                                for i = 1, 10 do
                                    c.ImageTransparency = c.ImageTransparency + 0.05
                                    wait(len / 12)
                                end
                                c:Destroy()
                            end
                            toggled = not toggled
                            pcall(callback, toggled)
                        else
                            for i,v in next, infoContainer:GetChildren() do
                                Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
                                focusing = false
                            end
                            Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                        end
                    end)
                    local hovering = false
                    btn.MouseEnter:Connect(function()
                        if not focusing then
                            game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                                BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10)
                            }):Play()
                            hovering = true
                        end 
                    end)
                    btn.MouseLeave:Connect(function()
                        if not focusing then
                            game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                                BackgroundColor3 = themeList.ElementColor
                            }):Play()
                            hovering = false
                        end
                    end)

                    coroutine.wrap(function()
                        while wait() do
                            if not hovering then
                                toggleElement.BackgroundColor3 = themeList.ElementColor
                            end
                            toggleDisabled.ImageColor3 = themeList.SchemeColor
                            toggleEnabled.ImageColor3 = themeList.SchemeColor
                            togName.TextColor3 = themeList.TextColor
                            viewInfo.ImageColor3 = themeList.SchemeColor
                            Sample.ImageColor3 = themeList.SchemeColor
                            moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
                            moreInfo.TextColor3 = themeList.TextColor
                        end
                    end)()
                    viewInfo.MouseButton1Click:Connect(function()
                        if not viewDe then
                            viewDe = true
                            focusing = true
                            for i,v in next, infoContainer:GetChildren() do
                                if v ~= moreInfo then
                                    Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
                                end
                            end
                            Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,0,0)}, 0.2)
                            Utility:TweenObject(blurFrame, {BackgroundTransparency = 0.5}, 0.2)
                            Utility:TweenObject(btn, {BackgroundColor3 = themeList.ElementColor}, 0.2)
                            wait(1.5)
                            focusing = false
                            Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,2,0)}, 0.2)
                            Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                            wait(0)
                            viewDe = false
                        end
                    end)
                    function TogFunction:UpdateToggle(newText, isTogOn)
                        isTogOn = isTogOn or toggle
                        if newText ~= nil then 
                            togName.Text = newText
                        end
                        if isTogOn then
                            toggled = true
                            game.TweenService:Create(img, TweenInfo.new(0.11, Enum.EasingStyle.Linear,Enum.EasingDirection.In), {
                                ImageTransparency = 0
                            }):Play()
                            pcall(callback, toggled)
                        else
                            toggled = false
                            game.TweenService:Create(img, TweenInfo.new(0.11, Enum.EasingStyle.Linear,Enum.EasingDirection.In), {
                                ImageTransparency = 1
                            }):Play()
                            pcall(callback, toggled)
                        end
                    end
                    return TogFunction
            end

            function Elements:NewSlider(slidInf, slidTip, maxvalue, minvalue, callback)
                slidInf = slidInf or "Slider"
                slidTip = slidTip or "Slider tip here"
                maxvalue = maxvalue or 500
                minvalue = minvalue or 16
                startVal = startVal or 0
                callback = callback or function() end

                local sliderElement = Instance.new("TextButton")
                local UICorner = Instance.new("UICorner")
                local togName = Instance.new("TextLabel")
                local viewInfo = Instance.new("ImageButton")
                local sliderBtn = Instance.new("TextButton")
                local UICorner_2 = Instance.new("UICorner")
                local UIListLayout = Instance.new("UIListLayout")
                local sliderDrag = Instance.new("Frame")
                local UICorner_3 = Instance.new("UICorner")
                local write = Instance.new("ImageLabel")
                local val = Instance.new("TextLabel")

                sliderElement.Name = "sliderElement"
                sliderElement.Parent = sectionInners
                sliderElement.BackgroundColor3 = themeList.ElementColor
                sliderElement.ClipsDescendants = true
                sliderElement.Size = UDim2.new(0, 352, 0, 33)
                sliderElement.AutoButtonColor = false
                sliderElement.Font = Enum.Font.SourceSans
                sliderElement.Text = ""
                sliderElement.TextColor3 = Color3.fromRGB(0, 0, 0)
                sliderElement.TextSize = 14.000

                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = sliderElement

                togName.Name = "togName"
                togName.Parent = sliderElement
                togName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                togName.BackgroundTransparency = 1.000
                togName.Position = UDim2.new(0.096704483, 0, 0.272727281, 0)
                togName.Size = UDim2.new(0, 138, 0, 14)
                togName.Font = Enum.Font.GothamSemibold
                togName.Text = slidInf
                togName.RichText = true
                togName.TextColor3 = themeList.TextColor
                togName.TextSize = 14.000
                togName.TextXAlignment = Enum.TextXAlignment.Left

                viewInfo.Name = "viewInfo"
                viewInfo.Parent = sliderElement
                viewInfo.BackgroundTransparency = 1.000
                viewInfo.LayoutOrder = 9
                viewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
                viewInfo.Size = UDim2.new(0, 23, 0, 23)
                viewInfo.ZIndex = 2
                viewInfo.Image = "rbxassetid://3926305904"
                viewInfo.ImageColor3 = themeList.SchemeColor
                viewInfo.ImageRectOffset = Vector2.new(764, 764)
                viewInfo.ImageRectSize = Vector2.new(36, 36)

                sliderBtn.Name = "sliderBtn"
                sliderBtn.Parent = sliderElement
                sliderBtn.BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 5, themeList.ElementColor.g * 255 + 5, themeList.ElementColor.b * 255  + 5)
                sliderBtn.BorderSizePixel = 0
                sliderBtn.Position = UDim2.new(0.488749951, 0, 0.393939406, 0)
                sliderBtn.Size = UDim2.new(0, 149, 0, 6)
                sliderBtn.AutoButtonColor = false
                sliderBtn.Font = Enum.Font.SourceSans
                sliderBtn.Text = ""
                sliderBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
                sliderBtn.TextSize = 14.000

                UICorner_2.Parent = sliderBtn

                UIListLayout.Parent = sliderBtn
                UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center

                sliderDrag.Name = "sliderDrag"
                sliderDrag.Parent = sliderBtn
                sliderDrag.BackgroundColor3 = themeList.SchemeColor
                sliderDrag.BorderColor3 = Color3.fromRGB(74, 99, 135)
                sliderDrag.BorderSizePixel = 0
                sliderDrag.Size = UDim2.new(-0.671140969, 100,1,0)

                UICorner_3.Parent = sliderDrag

                write.Name = "write"
                write.Parent = sliderElement
                write.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                write.BackgroundTransparency = 1.000
                write.BorderColor3 = Color3.fromRGB(27, 42, 53)
                write.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
                write.Size = UDim2.new(0, 21, 0, 21)
                write.Image = "rbxassetid://3926307971"
                write.ImageColor3 = themeList.SchemeColor
                write.ImageRectOffset = Vector2.new(404, 164)
                write.ImageRectSize = Vector2.new(36, 36)

                val.Name = "val"
                val.Parent = sliderElement
                val.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                val.BackgroundTransparency = 1.000
                val.Position = UDim2.new(0.352386296, 0, 0.272727281, 0)
                val.Size = UDim2.new(0, 41, 0, 14)
                val.Font = Enum.Font.GothamSemibold
                val.Text = minvalue
                val.TextColor3 = themeList.TextColor
                val.TextSize = 14.000
                val.TextTransparency = 1.000
                val.TextXAlignment = Enum.TextXAlignment.Right

                local moreInfo = Instance.new("TextLabel")
                local UICorner = Instance.new("UICorner")

                moreInfo.Name = "TipMore"
                moreInfo.Parent = infoContainer
                moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
                moreInfo.Position = UDim2.new(0, 0, 2, 0)
                moreInfo.Size = UDim2.new(0, 353, 0, 33)
                moreInfo.ZIndex = 9
                moreInfo.Font = Enum.Font.GothamSemibold
                moreInfo.Text = "  "..slidTip
                moreInfo.TextColor3 = themeList.TextColor
                moreInfo.TextSize = 14.000
                moreInfo.RichText = true
                moreInfo.TextXAlignment = Enum.TextXAlignment.Left

                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = moreInfo

                if themeList.SchemeColor == Color3.fromRGB(255,255,255) then
                    Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(0,0,0)}, 0.2)
                end 
                if themeList.SchemeColor == Color3.fromRGB(0,0,0) then
                    Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(255,255,255)}, 0.2)
                end 


                                updateSectionFrame()
                UpdateSize()
                local mouse = game:GetService("Players").LocalPlayer:GetMouse();

                local ms = game.Players.LocalPlayer:GetMouse()
                local uis = game:GetService("UserInputService")
                local btn = sliderElement
                local infBtn = viewInfo
                local hovering = false
                btn.MouseEnter:Connect(function()
                    if not focusing then
                        game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10)
                        }):Play()
                        hovering = true
                    end 
                end)
                btn.MouseLeave:Connect(function()
                    if not focusing then
                        game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            BackgroundColor3 = themeList.ElementColor
                        }):Play()
                        hovering = false
                    end
                end)        

                coroutine.wrap(function()
                    while wait() do
                        if not hovering then
                            sliderElement.BackgroundColor3 = themeList.ElementColor
                        end
                        moreInfo.TextColor3 = themeList.TextColor
                        moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
                        val.TextColor3 = themeList.TextColor
                        write.ImageColor3 = themeList.SchemeColor
                        togName.TextColor3 = themeList.TextColor
                        viewInfo.ImageColor3 = themeList.SchemeColor
                        sliderBtn.BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 5, themeList.ElementColor.g * 255 + 5, themeList.ElementColor.b * 255  + 5)
                        sliderDrag.BackgroundColor3 = themeList.SchemeColor
                    end
                end)()

                local Value
                sliderBtn.MouseButton1Down:Connect(function()
                    if not focusing then
                        game.TweenService:Create(val, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            TextTransparency = 0
                        }):Play()
                        Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 149) * sliderDrag.AbsoluteSize.X) + tonumber(minvalue)) or 0
                        pcall(function()
                            callback(Value)
                        end)
                        sliderDrag:TweenSize(UDim2.new(0, math.clamp(mouse.X - sliderDrag.AbsolutePosition.X, 0, 149), 0, 6), "InOut", "Linear", 0.05, true)
                        moveconnection = mouse.Move:Connect(function()
                            val.Text = Value
                            Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 149) * sliderDrag.AbsoluteSize.X) + tonumber(minvalue))
                            pcall(function()
                                callback(Value)
                            end)
                            sliderDrag:TweenSize(UDim2.new(0, math.clamp(mouse.X - sliderDrag.AbsolutePosition.X, 0, 149), 0, 6), "InOut", "Linear", 0.05, true)
                        end)
                        releaseconnection = uis.InputEnded:Connect(function(Mouse)
                            if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
                                Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 149) * sliderDrag.AbsoluteSize.X) + tonumber(minvalue))
                                pcall(function()
                                    callback(Value)
                                end)
                                val.Text = Value
                                game.TweenService:Create(val, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                                    TextTransparency = 1
                                }):Play()
                                sliderDrag:TweenSize(UDim2.new(0, math.clamp(mouse.X - sliderDrag.AbsolutePosition.X, 0, 149), 0, 6), "InOut", "Linear", 0.05, true)
                                moveconnection:Disconnect()
                                releaseconnection:Disconnect()
                            end
                        end)
                    else
                        for i,v in next, infoContainer:GetChildren() do
                            Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
                            focusing = false
                        end
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                    end
                end)
                viewInfo.MouseButton1Click:Connect(function()
                    if not viewDe then
                        viewDe = true
                        focusing = true
                        for i,v in next, infoContainer:GetChildren() do
                            if v ~= moreInfo then
                                Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
                            end
                        end
                        Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,0,0)}, 0.2)
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 0.5}, 0.2)
                        Utility:TweenObject(btn, {BackgroundColor3 = themeList.ElementColor}, 0.2)
                        wait(1.5)
                        focusing = false
                        Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,2,0)}, 0.2)
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                        wait(0)
                        viewDe = false
                    end
                end)        
            end

            function Elements:NewDropdown(dropname, dropinf, list, callback)
                local DropFunction = {}
                dropname = dropname or "Dropdown"
                list = list or {}
                dropinf = dropinf or "Dropdown info"
                callback = callback or function() end   

                local opened = false
                local DropYSize = 33


                local dropFrame = Instance.new("Frame")
                local dropOpen = Instance.new("TextButton")
                local listImg = Instance.new("ImageLabel")
                local itemTextbox = Instance.new("TextLabel")
                local viewInfo = Instance.new("ImageButton")
                local UICorner = Instance.new("UICorner")
                local UIListLayout = Instance.new("UIListLayout")
                local Sample = Instance.new("ImageLabel")

                local ms = game.Players.LocalPlayer:GetMouse()
                Sample.Name = "Sample"
                Sample.Parent = dropOpen
                Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Sample.BackgroundTransparency = 1.000
                Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
                Sample.ImageColor3 = themeList.SchemeColor
                Sample.ImageTransparency = 0.600
                
                dropFrame.Name = "dropFrame"
                dropFrame.Parent = sectionInners
                dropFrame.BackgroundColor3 = themeList.Background
                dropFrame.BorderSizePixel = 0
                dropFrame.Position = UDim2.new(0, 0, 1.23571432, 0)
                dropFrame.Size = UDim2.new(0, 352, 0, 33)
                dropFrame.ClipsDescendants = true
                local sample = Sample
                local btn = dropOpen
                dropOpen.Name = "dropOpen"
                dropOpen.Parent = dropFrame
                dropOpen.BackgroundColor3 = themeList.ElementColor
                dropOpen.Size = UDim2.new(0, 352, 0, 33)
                dropOpen.AutoButtonColor = false
                dropOpen.Font = Enum.Font.SourceSans
                dropOpen.Text = ""
                dropOpen.TextColor3 = Color3.fromRGB(0, 0, 0)
                dropOpen.TextSize = 14.000
                dropOpen.ClipsDescendants = true
                dropOpen.MouseButton1Click:Connect(function()
                    if not focusing then
                        if opened then
                            opened = false
                            dropFrame:TweenSize(UDim2.new(0, 352, 0, 33), "InOut", "Linear", 0.08)
                            wait(0.1)
                            updateSectionFrame()
                            UpdateSize()
                            local c = sample:Clone()
                            c.Parent = btn
                            local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
                            c.Position = UDim2.new(0, x, 0, y)
                            local len, size = 0.35, nil
                            if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
                                size = (btn.AbsoluteSize.X * 1.5)
                            else
                                size = (btn.AbsoluteSize.Y * 1.5)
                            end
                            c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
                            for i = 1, 10 do
                                c.ImageTransparency = c.ImageTransparency + 0.05
                                wait(len / 12)
                            end
                            c:Destroy()
                        else
                            opened = true
                            dropFrame:TweenSize(UDim2.new(0, 352, 0, UIListLayout.AbsoluteContentSize.Y), "InOut", "Linear", 0.08, true)
                            wait(0.1)
                            updateSectionFrame()
                            UpdateSize()
                            local c = sample:Clone()
                            c.Parent = btn
                            local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
                            c.Position = UDim2.new(0, x, 0, y)
                            local len, size = 0.35, nil
                            if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
                                size = (btn.AbsoluteSize.X * 1.5)
                            else
                                size = (btn.AbsoluteSize.Y * 1.5)
                            end
                            c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
                            for i = 1, 10 do
                                c.ImageTransparency = c.ImageTransparency + 0.05
                                wait(len / 12)
                            end
                            c:Destroy()
                        end
                    else
                        for i,v in next, infoContainer:GetChildren() do
                            Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
                            focusing = false
                        end
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                    end
                end)

                listImg.Name = "listImg"
                listImg.Parent = dropOpen
                listImg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                listImg.BackgroundTransparency = 1.000
                listImg.BorderColor3 = Color3.fromRGB(27, 42, 53)
                listImg.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
                listImg.Size = UDim2.new(0, 21, 0, 21)
                listImg.Image = "rbxassetid://3926305904"
                listImg.ImageColor3 = themeList.SchemeColor
                listImg.ImageRectOffset = Vector2.new(644, 364)
                listImg.ImageRectSize = Vector2.new(36, 36)

                itemTextbox.Name = "itemTextbox"
                itemTextbox.Parent = dropOpen
                itemTextbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                itemTextbox.BackgroundTransparency = 1.000
                itemTextbox.Position = UDim2.new(0.0970000029, 0, 0.273000002, 0)
                itemTextbox.Size = UDim2.new(0, 138, 0, 14)
                itemTextbox.Font = Enum.Font.GothamSemibold
                itemTextbox.Text = dropname
                itemTextbox.RichText = true
                itemTextbox.TextColor3 = themeList.TextColor
                itemTextbox.TextSize = 14.000
                itemTextbox.TextXAlignment = Enum.TextXAlignment.Left

                viewInfo.Name = "viewInfo"
                viewInfo.Parent = dropOpen
                viewInfo.BackgroundTransparency = 1.000
                viewInfo.LayoutOrder = 9
                viewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
                viewInfo.Size = UDim2.new(0, 23, 0, 23)
                viewInfo.ZIndex = 2
                viewInfo.Image = "rbxassetid://3926305904"
                viewInfo.ImageColor3 = themeList.SchemeColor
                viewInfo.ImageRectOffset = Vector2.new(764, 764)
                viewInfo.ImageRectSize = Vector2.new(36, 36)

                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = dropOpen

                local Sample = Instance.new("ImageLabel")

                Sample.Name = "Sample"
                Sample.Parent = dropOpen
                Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Sample.BackgroundTransparency = 1.000
                Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
                Sample.ImageColor3 = themeList.SchemeColor
                Sample.ImageTransparency = 0.600

                UIListLayout.Parent = dropFrame
                UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout.Padding = UDim.new(0, 3)

                updateSectionFrame() 
                UpdateSize()

                local ms = game.Players.LocalPlayer:GetMouse()
                local uis = game:GetService("UserInputService")
                local infBtn = viewInfo

                local moreInfo = Instance.new("TextLabel")
                local UICorner = Instance.new("UICorner")

                moreInfo.Name = "TipMore"
                moreInfo.Parent = infoContainer
                moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
                moreInfo.Position = UDim2.new(0, 0, 2, 0)
                moreInfo.Size = UDim2.new(0, 353, 0, 33)
                moreInfo.ZIndex = 9
                moreInfo.RichText = true
                moreInfo.Font = Enum.Font.GothamSemibold
                moreInfo.Text = "  "..dropinf
                moreInfo.TextColor3 = themeList.TextColor
                moreInfo.TextSize = 14.000
                moreInfo.TextXAlignment = Enum.TextXAlignment.Left

                local hovering = false
                btn.MouseEnter:Connect(function()
                    if not focusing then
                        game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10)
                        }):Play()
                        hovering = true
                    end 
                end)
                btn.MouseLeave:Connect(function()
                    if not focusing then
                        game.TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            BackgroundColor3 = themeList.ElementColor
                        }):Play()
                        hovering = false
                    end
                end)        
                coroutine.wrap(function()
                    while wait() do
                        if not hovering then
                            dropOpen.BackgroundColor3 = themeList.ElementColor
                        end
                        Sample.ImageColor3 = themeList.SchemeColor
                        dropFrame.BackgroundColor3 = themeList.Background
                        listImg.ImageColor3 = themeList.SchemeColor
                        itemTextbox.TextColor3 = themeList.TextColor
                        viewInfo.ImageColor3 = themeList.SchemeColor
                        moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
                        moreInfo.TextColor3 = themeList.TextColor
                    end
                end)()
                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = moreInfo

                if themeList.SchemeColor == Color3.fromRGB(255,255,255) then
                    Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(0,0,0)}, 0.2)
                end 
                if themeList.SchemeColor == Color3.fromRGB(0,0,0) then
                    Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(255,255,255)}, 0.2)
                end 

                viewInfo.MouseButton1Click:Connect(function()
                    if not viewDe then
                        viewDe = true
                        focusing = true
                        for i,v in next, infoContainer:GetChildren() do
                            if v ~= moreInfo then
                                Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
                            end
                        end
                        Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,0,0)}, 0.2)
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 0.5}, 0.2)
                        Utility:TweenObject(btn, {BackgroundColor3 = themeList.ElementColor}, 0.2)
                        wait(1.5)
                        focusing = false
                        Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,2,0)}, 0.2)
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                        wait(0)
                        viewDe = false
                    end
                end)     

                for i,v in next, list do
                    local optionSelect = Instance.new("TextButton")
                    local UICorner_2 = Instance.new("UICorner")
                    local Sample1 = Instance.new("ImageLabel")

                    local ms = game.Players.LocalPlayer:GetMouse()
                    Sample1.Name = "Sample1"
                    Sample1.Parent = optionSelect
                    Sample1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Sample1.BackgroundTransparency = 1.000
                    Sample1.Image = "http://www.roblox.com/asset/?id=4560909609"
                    Sample1.ImageColor3 = themeList.SchemeColor
                    Sample1.ImageTransparency = 0.600

                    local sample1 = Sample1
                    DropYSize = DropYSize + 33
                    optionSelect.Name = "optionSelect"
                    optionSelect.Parent = dropFrame
                    optionSelect.BackgroundColor3 = themeList.ElementColor
                    optionSelect.Position = UDim2.new(0, 0, 0.235294119, 0)
                    optionSelect.Size = UDim2.new(0, 352, 0, 33)
                    optionSelect.AutoButtonColor = false
                    optionSelect.Font = Enum.Font.GothamSemibold
                    optionSelect.Text = "  "..v
                    optionSelect.TextColor3 = Color3.fromRGB(themeList.TextColor.r * 255 - 6, themeList.TextColor.g * 255 - 6, themeList.TextColor.b * 255 - 6)
                    optionSelect.TextSize = 14.000
                    optionSelect.TextXAlignment = Enum.TextXAlignment.Left
                    optionSelect.ClipsDescendants = true
                    optionSelect.MouseButton1Click:Connect(function()
                        if not focusing then
                            opened = false
                            callback(v)
                            itemTextbox.Text = v
                            dropFrame:TweenSize(UDim2.new(0, 352, 0, 33), 'InOut', 'Linear', 0.08)
                            wait(0.1)
                            updateSectionFrame()
                            UpdateSize()
                            local c = sample1:Clone()
                            c.Parent = optionSelect
                            local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
                            c.Position = UDim2.new(0, x, 0, y)
                            local len, size = 0.35, nil
                            if optionSelect.AbsoluteSize.X >= optionSelect.AbsoluteSize.Y then
                                size = (optionSelect.AbsoluteSize.X * 1.5)
                            else
                                size = (optionSelect.AbsoluteSize.Y * 1.5)
                            end
                            c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
                            for i = 1, 10 do
                                c.ImageTransparency = c.ImageTransparency + 0.05
                                wait(len / 12)
                            end
                            c:Destroy()         
                        else
                            for i,v in next, infoContainer:GetChildren() do
                                Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
                                focusing = false
                            end
                            Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                        end
                    end)
    
                    UICorner_2.CornerRadius = UDim.new(0, 4)
                    UICorner_2.Parent = optionSelect

                    local oHover = false
                    optionSelect.MouseEnter:Connect(function()
                        if not focusing then
                            game.TweenService:Create(optionSelect, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                                BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10)
                            }):Play()
                            oHover = true
                        end 
                    end)
                    optionSelect.MouseLeave:Connect(function()
                        if not focusing then
                            game.TweenService:Create(optionSelect, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                                BackgroundColor3 = themeList.ElementColor
                            }):Play()
                            oHover = false
                        end
                    end)   
                    coroutine.wrap(function()
                        while wait() do
                            if not oHover then
                                optionSelect.BackgroundColor3 = themeList.ElementColor
                            end
                            optionSelect.TextColor3 = Color3.fromRGB(themeList.TextColor.r * 255 - 6, themeList.TextColor.g * 255 - 6, themeList.TextColor.b * 255 - 6)
                            Sample1.ImageColor3 = themeList.SchemeColor
                        end
                    end)()
                end

                function DropFunction:Refresh(newList)
                    newList = newList or {}
                    for i,v in next, dropFrame:GetChildren() do
                        if v.Name == "optionSelect" then
                            v:Destroy()
                        end
                    end
                    for i,v in next, newList do
                        local optionSelect = Instance.new("TextButton")
                        local UICorner_2 = Instance.new("UICorner")
                        local Sample11 = Instance.new("ImageLabel")
                        local ms = game.Players.LocalPlayer:GetMouse()
                        Sample11.Name = "Sample11"
                        Sample11.Parent = optionSelect
                        Sample11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        Sample11.BackgroundTransparency = 1.000
                        Sample11.Image = "http://www.roblox.com/asset/?id=4560909609"
                        Sample11.ImageColor3 = themeList.SchemeColor
                        Sample11.ImageTransparency = 0.600
    
                        local sample11 = Sample11
                        DropYSize = DropYSize + 33
                        optionSelect.Name = "optionSelect"
                        optionSelect.Parent = dropFrame
                        optionSelect.BackgroundColor3 = themeList.ElementColor
                        optionSelect.Position = UDim2.new(0, 0, 0.235294119, 0)
                        optionSelect.Size = UDim2.new(0, 352, 0, 33)
                        optionSelect.AutoButtonColor = false
                        optionSelect.Font = Enum.Font.GothamSemibold
                        optionSelect.Text = "  "..v
                        optionSelect.TextColor3 = Color3.fromRGB(themeList.TextColor.r * 255 - 6, themeList.TextColor.g * 255 - 6, themeList.TextColor.b * 255 - 6)
                        optionSelect.TextSize = 14.000
                        optionSelect.TextXAlignment = Enum.TextXAlignment.Left
                        optionSelect.ClipsDescendants = true
                        UICorner_2.CornerRadius = UDim.new(0, 4)
                        UICorner_2.Parent = optionSelect
                        optionSelect.MouseButton1Click:Connect(function()
                            if not focusing then
                                opened = false
                                callback(v)
                                itemTextbox.Text = v
                                dropFrame:TweenSize(UDim2.new(0, 352, 0, 33), 'InOut', 'Linear', 0.08)
                                wait(0.1)
                                updateSectionFrame()
                                UpdateSize()
                                local c = sample11:Clone()
                                c.Parent = optionSelect
                                local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
                                c.Position = UDim2.new(0, x, 0, y)
                                local len, size = 0.35, nil
                                if optionSelect.AbsoluteSize.X >= optionSelect.AbsoluteSize.Y then
                                    size = (optionSelect.AbsoluteSize.X * 1.5)
                                else
                                    size = (optionSelect.AbsoluteSize.Y * 1.5)
                                end
                                c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
                                for i = 1, 10 do
                                    c.ImageTransparency = c.ImageTransparency + 0.05
                                    wait(len / 12)
                                end
                                c:Destroy()         
                            else
                                for i,v in next, infoContainer:GetChildren() do
                                    Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
                                    focusing = false
                                end
                                Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                            end
                        end)
                                        updateSectionFrame()
                UpdateSize()
                        local hov = false
                        optionSelect.MouseEnter:Connect(function()
                            if not focusing then
                                game.TweenService:Create(optionSelect, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                                    BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10)
                                }):Play()
                                hov = true
                            end 
                        end)
                        optionSelect.MouseLeave:Connect(function()
                            if not focusing then
                                game.TweenService:Create(optionSelect, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                                    BackgroundColor3 = themeList.ElementColor
                                }):Play()
                                hov = false
                            end
                        end)   
                        coroutine.wrap(function()
                            while wait() do
                                if not oHover then
                                    optionSelect.BackgroundColor3 = themeList.ElementColor
                                end
                                optionSelect.TextColor3 = Color3.fromRGB(themeList.TextColor.r * 255 - 6, themeList.TextColor.g * 255 - 6, themeList.TextColor.b * 255 - 6)
                                Sample11.ImageColor3 = themeList.SchemeColor
                            end
                        end)()
                    end
                    if opened then 
                        dropFrame:TweenSize(UDim2.new(0, 352, 0, UIListLayout.AbsoluteContentSize.Y), "InOut", "Linear", 0.08, true)
                        wait(0.1)
                        updateSectionFrame()
                        UpdateSize()
                    else
                        dropFrame:TweenSize(UDim2.new(0, 352, 0, 33), "InOut", "Linear", 0.08)
                        wait(0.1)
                        updateSectionFrame()
                        UpdateSize()
                    end
                end
                return DropFunction
            end
            function Elements:NewKeybind(keytext, keyinf, first, callback)
                keytext = keytext or "KeybindText"
                keyinf = keyinf or "KebindInfo"
                callback = callback or function() end
                local oldKey = first.Name
                local keybindElement = Instance.new("TextButton")
                local UICorner = Instance.new("UICorner")
                local togName = Instance.new("TextLabel")
                local viewInfo = Instance.new("ImageButton")
                local touch = Instance.new("ImageLabel")
                local Sample = Instance.new("ImageLabel")
                local togName_2 = Instance.new("TextLabel")

                local ms = game.Players.LocalPlayer:GetMouse()
                local uis = game:GetService("UserInputService")
                local infBtn = viewInfo

                local moreInfo = Instance.new("TextLabel")
                local UICorner1 = Instance.new("UICorner")

                local sample = Sample

                keybindElement.Name = "keybindElement"
                keybindElement.Parent = sectionInners
                keybindElement.BackgroundColor3 = themeList.ElementColor
                keybindElement.ClipsDescendants = true
                keybindElement.Size = UDim2.new(0, 352, 0, 33)
                keybindElement.AutoButtonColor = false
                keybindElement.Font = Enum.Font.SourceSans
                keybindElement.Text = ""
                keybindElement.TextColor3 = Color3.fromRGB(0, 0, 0)
                keybindElement.TextSize = 14.000
                keybindElement.MouseButton1Click:connect(function(e) 
                    if not focusing then
                        togName_2.Text = ". . ."
                        local a, b = game:GetService('UserInputService').InputBegan:wait();
                        if a.KeyCode.Name ~= "Unknown" then
                            togName_2.Text = a.KeyCode.Name
                            oldKey = a.KeyCode.Name;
                        end
                        local c = sample:Clone()
                        c.Parent = keybindElement
                        local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
                        c.Position = UDim2.new(0, x, 0, y)
                        local len, size = 0.35, nil
                        if keybindElement.AbsoluteSize.X >= keybindElement.AbsoluteSize.Y then
                            size = (keybindElement.AbsoluteSize.X * 1.5)
                        else
                            size = (keybindElement.AbsoluteSize.Y * 1.5)
                        end
                        c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
                        for i = 1, 10 do
                        c.ImageTransparency = c.ImageTransparency + 0.05
                            wait(len / 12)
                        end
                    else
                        for i,v in next, infoContainer:GetChildren() do
                            Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
                            focusing = false
                        end
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                    end
                end)
        
                game:GetService("UserInputService").InputBegan:connect(function(current, ok) 
                    if not ok then 
                        if current.KeyCode.Name == oldKey then 
                            callback()
                        end
                    end
                end)

                moreInfo.Name = "TipMore"
                moreInfo.Parent = infoContainer
                moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
                moreInfo.Position = UDim2.new(0, 0, 2, 0)
                moreInfo.Size = UDim2.new(0, 353, 0, 33)
                moreInfo.ZIndex = 9
                moreInfo.RichText = true
                moreInfo.Font = Enum.Font.GothamSemibold
                moreInfo.Text = "  "..keyinf
                moreInfo.TextColor3 = themeList.TextColor
                moreInfo.TextSize = 14.000
                moreInfo.TextXAlignment = Enum.TextXAlignment.Left

                Sample.Name = "Sample"
                Sample.Parent = keybindElement
                Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Sample.BackgroundTransparency = 1.000
                Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
                Sample.ImageColor3 = themeList.SchemeColor
                Sample.ImageTransparency = 0.600

                
                togName.Name = "togName"
                togName.Parent = keybindElement
                togName.BackgroundColor3 = themeList.TextColor
                togName.BackgroundTransparency = 1.000
                togName.Position = UDim2.new(0.096704483, 0, 0.272727281, 0)
                togName.Size = UDim2.new(0, 222, 0, 14)
                togName.Font = Enum.Font.GothamSemibold
                togName.Text = keytext
                togName.RichText = true
                togName.TextColor3 = themeList.TextColor
                togName.TextSize = 14.000
                togName.TextXAlignment = Enum.TextXAlignment.Left

                viewInfo.Name = "viewInfo"
                viewInfo.Parent = keybindElement
                viewInfo.BackgroundTransparency = 1.000
                viewInfo.LayoutOrder = 9
                viewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
                viewInfo.Size = UDim2.new(0, 23, 0, 23)
                viewInfo.ZIndex = 2
                viewInfo.Image = "rbxassetid://3926305904"
                viewInfo.ImageColor3 = themeList.SchemeColor
                viewInfo.ImageRectOffset = Vector2.new(764, 764)
                viewInfo.ImageRectSize = Vector2.new(36, 36)
                viewInfo.MouseButton1Click:Connect(function()
                    if not viewDe then
                        viewDe = true
                        focusing = true
                        for i,v in next, infoContainer:GetChildren() do
                            if v ~= moreInfo then
                                Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
                            end
                        end
                        Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,0,0)}, 0.2)
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 0.5}, 0.2)
                        Utility:TweenObject(keybindElement, {BackgroundColor3 = themeList.ElementColor}, 0.2)
                        wait(1.5)
                        focusing = false
                        Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,2,0)}, 0.2)
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                        wait(0)
                        viewDe = false
                    end
                end)  
                                updateSectionFrame()
                UpdateSize()
                local oHover = false
                keybindElement.MouseEnter:Connect(function()
                    if not focusing then
                        game.TweenService:Create(keybindElement, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10)
                        }):Play()
                        oHover = true
                    end 
                end)
                keybindElement.MouseLeave:Connect(function()
                    if not focusing then
                        game.TweenService:Create(keybindElement, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            BackgroundColor3 = themeList.ElementColor
                        }):Play()
                        oHover = false
                    end
                end)        

                UICorner1.CornerRadius = UDim.new(0, 4)
                UICorner1.Parent = moreInfo

                if themeList.SchemeColor == Color3.fromRGB(255,255,255) then
                    Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(0,0,0)}, 0.2)
                end 
                if themeList.SchemeColor == Color3.fromRGB(0,0,0) then
                    Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(255,255,255)}, 0.2)
                end 

                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = keybindElement

                touch.Name = "touch"
                touch.Parent = keybindElement
                touch.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                touch.BackgroundTransparency = 1.000
                touch.BorderColor3 = Color3.fromRGB(27, 42, 53)
                touch.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
                touch.Size = UDim2.new(0, 21, 0, 21)
                touch.Image = "rbxassetid://3926305904"
                touch.ImageColor3 = themeList.SchemeColor
                touch.ImageRectOffset = Vector2.new(364, 284)
                touch.ImageRectSize = Vector2.new(36, 36)

                togName_2.Name = "togName"
                togName_2.Parent = keybindElement
                togName_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                togName_2.BackgroundTransparency = 1.000
                togName_2.Position = UDim2.new(0.727386296, 0, 0.272727281, 0)
                togName_2.Size = UDim2.new(0, 70, 0, 14)
                togName_2.Font = Enum.Font.GothamSemibold
                togName_2.Text = oldKey
                togName_2.TextColor3 = themeList.SchemeColor
                togName_2.TextSize = 14.000
                togName_2.TextXAlignment = Enum.TextXAlignment.Right   

                coroutine.wrap(function()
                    while wait() do
                        if not oHover then
                            keybindElement.BackgroundColor3 = themeList.ElementColor
                        end
                        togName_2.TextColor3 = themeList.SchemeColor
                        touch.ImageColor3 = themeList.SchemeColor
                        viewInfo.ImageColor3 = themeList.SchemeColor
                        togName.BackgroundColor3 = themeList.TextColor
                        togName.TextColor3 = themeList.TextColor
                        Sample.ImageColor3 = themeList.SchemeColor
                        moreInfo.TextColor3 = themeList.TextColor
                        moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)

                    end
                end)()
            end

            function Elements:NewColorPicker(colText, colInf, defcolor, callback)
                colText = colText or "ColorPicker"
                callback = callback or function() end
                defcolor = defcolor or Color3.fromRGB(1,1,1)
                local h, s, v = Color3.toHSV(defcolor)
                local ms = game.Players.LocalPlayer:GetMouse()
                local colorOpened = false
                local colorElement = Instance.new("TextButton")
                local UICorner = Instance.new("UICorner")
                local colorHeader = Instance.new("Frame")
                local UICorner_2 = Instance.new("UICorner")
                local touch = Instance.new("ImageLabel")
                local togName = Instance.new("TextLabel")
                local viewInfo = Instance.new("ImageButton")
                local colorCurrent = Instance.new("Frame")
                local UICorner_3 = Instance.new("UICorner")
                local UIListLayout = Instance.new("UIListLayout")
                local colorInners = Instance.new("Frame")
                local UICorner_4 = Instance.new("UICorner")
                local rgb = Instance.new("ImageButton")
                local UICorner_5 = Instance.new("UICorner")
                local rbgcircle = Instance.new("ImageLabel")
                local darkness = Instance.new("ImageButton")
                local UICorner_6 = Instance.new("UICorner")
                local darkcircle = Instance.new("ImageLabel")
                local toggleDisabled = Instance.new("ImageLabel")
                local toggleEnabled = Instance.new("ImageLabel")
                local onrainbow = Instance.new("TextButton")
                local togName_2 = Instance.new("TextLabel")

                --Properties:
                local Sample = Instance.new("ImageLabel")
                Sample.Name = "Sample"
                Sample.Parent = colorHeader
                Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Sample.BackgroundTransparency = 1.000
                Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
                Sample.ImageColor3 = themeList.SchemeColor
                Sample.ImageTransparency = 0.600

                local btn = colorHeader
                local sample = Sample

                colorElement.Name = "colorElement"
                colorElement.Parent = sectionInners
                colorElement.BackgroundColor3 = themeList.ElementColor
                colorElement.BackgroundTransparency = 1.000
                colorElement.ClipsDescendants = true
                colorElement.Position = UDim2.new(0, 0, 0.566834569, 0)
                colorElement.Size = UDim2.new(0, 352, 0, 33)
                colorElement.AutoButtonColor = false
                colorElement.Font = Enum.Font.SourceSans
                colorElement.Text = ""
                colorElement.TextColor3 = Color3.fromRGB(0, 0, 0)
                colorElement.TextSize = 14.000
                colorElement.MouseButton1Click:Connect(function()
                    if not focusing then
                        if colorOpened then
                            colorOpened = false
                            colorElement:TweenSize(UDim2.new(0, 352, 0, 33), "InOut", "Linear", 0.08)
                            wait(0.1)
                            updateSectionFrame()
                            UpdateSize()
                            local c = sample:Clone()
                            c.Parent = btn
                            local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
                            c.Position = UDim2.new(0, x, 0, y)
                            local len, size = 0.35, nil
                            if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
                                size = (btn.AbsoluteSize.X * 1.5)
                            else
                                size = (btn.AbsoluteSize.Y * 1.5)
                            end
                            c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
                            for i = 1, 10 do
                                c.ImageTransparency = c.ImageTransparency + 0.05
                                wait(len / 12)
                            end
                            c:Destroy()
                        else
                            colorOpened = true
                            colorElement:TweenSize(UDim2.new(0, 352, 0, 141), "InOut", "Linear", 0.08, true)
                            wait(0.1)
                            updateSectionFrame()
                            UpdateSize()
                            local c = sample:Clone()
                            c.Parent = btn
                            local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
                            c.Position = UDim2.new(0, x, 0, y)
                            local len, size = 0.35, nil
                            if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
                                size = (btn.AbsoluteSize.X * 1.5)
                            else
                                size = (btn.AbsoluteSize.Y * 1.5)
                            end
                            c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
                            for i = 1, 10 do
                                c.ImageTransparency = c.ImageTransparency + 0.05
                                wait(len / 12)
                            end
                            c:Destroy()
                        end
                    else
                        for i,v in next, infoContainer:GetChildren() do
                            Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
                            focusing = false
                        end
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                    end
                end)
                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = colorElement

                colorHeader.Name = "colorHeader"
                colorHeader.Parent = colorElement
                colorHeader.BackgroundColor3 = themeList.ElementColor
                colorHeader.Size = UDim2.new(0, 352, 0, 33)
                colorHeader.ClipsDescendants = true

                UICorner_2.CornerRadius = UDim.new(0, 4)
                UICorner_2.Parent = colorHeader
                
                touch.Name = "touch"
                touch.Parent = colorHeader
                touch.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                touch.BackgroundTransparency = 1.000
                touch.BorderColor3 = Color3.fromRGB(27, 42, 53)
                touch.Position = UDim2.new(0.0199999996, 0, 0.180000007, 0)
                touch.Size = UDim2.new(0, 21, 0, 21)
                touch.Image = "rbxassetid://3926305904"
                touch.ImageColor3 = themeList.SchemeColor
                touch.ImageRectOffset = Vector2.new(44, 964)
                touch.ImageRectSize = Vector2.new(36, 36)

                togName.Name = "togName"
                togName.Parent = colorHeader
                togName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                togName.BackgroundTransparency = 1.000
                togName.Position = UDim2.new(0.096704483, 0, 0.272727281, 0)
                togName.Size = UDim2.new(0, 288, 0, 14)
                togName.Font = Enum.Font.GothamSemibold
                togName.Text = colText
                togName.TextColor3 = themeList.TextColor
                togName.TextSize = 14.000
                togName.RichText = true
                togName.TextXAlignment = Enum.TextXAlignment.Left

                local moreInfo = Instance.new("TextLabel")
                local UICorner = Instance.new("UICorner")

                moreInfo.Name = "TipMore"
                moreInfo.Parent = infoContainer
                moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
                moreInfo.Position = UDim2.new(0, 0, 2, 0)
                moreInfo.Size = UDim2.new(0, 353, 0, 33)
                moreInfo.ZIndex = 9
                moreInfo.Font = Enum.Font.GothamSemibold
                moreInfo.Text = "  "..colInf
                moreInfo.TextColor3 = themeList.TextColor
                moreInfo.TextSize = 14.000
                moreInfo.RichText = true
                moreInfo.TextXAlignment = Enum.TextXAlignment.Left

                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = moreInfo

                viewInfo.Name = "viewInfo"
                viewInfo.Parent = colorHeader
                viewInfo.BackgroundTransparency = 1.000
                viewInfo.LayoutOrder = 9
                viewInfo.Position = UDim2.new(0.930000007, 0, 0.151999995, 0)
                viewInfo.Size = UDim2.new(0, 23, 0, 23)
                viewInfo.ZIndex = 2
                viewInfo.Image = "rbxassetid://3926305904"
                viewInfo.ImageColor3 = themeList.SchemeColor
                viewInfo.ImageRectOffset = Vector2.new(764, 764)
                viewInfo.ImageRectSize = Vector2.new(36, 36)
                viewInfo.MouseButton1Click:Connect(function()
                    if not viewDe then
                        viewDe = true
                        focusing = true
                        for i,v in next, infoContainer:GetChildren() do
                            if v ~= moreInfo then
                                Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
                            end
                        end
                        Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,0,0)}, 0.2)
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 0.5}, 0.2)
                        Utility:TweenObject(colorElement, {BackgroundColor3 = themeList.ElementColor}, 0.2)
                        wait(1.5)
                        focusing = false
                        Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,2,0)}, 0.2)
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                        wait(0)
                        viewDe = false
                    end
                end)   

                colorCurrent.Name = "colorCurrent"
                colorCurrent.Parent = colorHeader
                colorCurrent.BackgroundColor3 = defcolor
                colorCurrent.Position = UDim2.new(0.792613626, 0, 0.212121218, 0)
                colorCurrent.Size = UDim2.new(0, 42, 0, 18)

                UICorner_3.CornerRadius = UDim.new(0, 4)
                UICorner_3.Parent = colorCurrent

                UIListLayout.Parent = colorElement
                UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout.Padding = UDim.new(0, 3)

                colorInners.Name = "colorInners"
                colorInners.Parent = colorElement
                colorInners.BackgroundColor3 = themeList.ElementColor
                colorInners.Position = UDim2.new(0, 0, 0.255319148, 0)
                colorInners.Size = UDim2.new(0, 352, 0, 105)

                UICorner_4.CornerRadius = UDim.new(0, 4)
                UICorner_4.Parent = colorInners

                rgb.Name = "rgb"
                rgb.Parent = colorInners
                rgb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                rgb.BackgroundTransparency = 1.000
                rgb.Position = UDim2.new(0.0198863633, 0, 0.0476190485, 0)
                rgb.Size = UDim2.new(0, 211, 0, 93)
                rgb.Image = "http://www.roblox.com/asset/?id=6523286724"

                UICorner_5.CornerRadius = UDim.new(0, 4)
                UICorner_5.Parent = rgb

                rbgcircle.Name = "rbgcircle"
                rbgcircle.Parent = rgb
                rbgcircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                rbgcircle.BackgroundTransparency = 1.000
                rbgcircle.Size = UDim2.new(0, 14, 0, 14)
                rbgcircle.Image = "rbxassetid://3926309567"
                rbgcircle.ImageColor3 = Color3.fromRGB(0, 0, 0)
                rbgcircle.ImageRectOffset = Vector2.new(628, 420)
                rbgcircle.ImageRectSize = Vector2.new(48, 48)

                darkness.Name = "darkness"
                darkness.Parent = colorInners
                darkness.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                darkness.BackgroundTransparency = 1.000
                darkness.Position = UDim2.new(0.636363626, 0, 0.0476190485, 0)
                darkness.Size = UDim2.new(0, 18, 0, 93)
                darkness.Image = "http://www.roblox.com/asset/?id=6523291212"

                UICorner_6.CornerRadius = UDim.new(0, 4)
                UICorner_6.Parent = darkness

                darkcircle.Name = "darkcircle"
                darkcircle.Parent = darkness
                darkcircle.AnchorPoint = Vector2.new(0.5, 0)
                darkcircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                darkcircle.BackgroundTransparency = 1.000
                darkcircle.Size = UDim2.new(0, 14, 0, 14)
                darkcircle.Image = "rbxassetid://3926309567"
                darkcircle.ImageColor3 = Color3.fromRGB(0, 0, 0)
                darkcircle.ImageRectOffset = Vector2.new(628, 420)
                darkcircle.ImageRectSize = Vector2.new(48, 48)

                toggleDisabled.Name = "toggleDisabled"
                toggleDisabled.Parent = colorInners
                toggleDisabled.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                toggleDisabled.BackgroundTransparency = 1.000
                toggleDisabled.Position = UDim2.new(0.704659104, 0, 0.0657142699, 0)
                toggleDisabled.Size = UDim2.new(0, 21, 0, 21)
                toggleDisabled.Image = "rbxassetid://3926309567"
                toggleDisabled.ImageColor3 = themeList.SchemeColor
                toggleDisabled.ImageRectOffset = Vector2.new(628, 420)
                toggleDisabled.ImageRectSize = Vector2.new(48, 48)

                toggleEnabled.Name = "toggleEnabled"
                toggleEnabled.Parent = colorInners
                toggleEnabled.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                toggleEnabled.BackgroundTransparency = 1.000
                toggleEnabled.Position = UDim2.new(0.704999983, 0, 0.0659999996, 0)
                toggleEnabled.Size = UDim2.new(0, 21, 0, 21)
                toggleEnabled.Image = "rbxassetid://3926309567"
                toggleEnabled.ImageColor3 = themeList.SchemeColor
                toggleEnabled.ImageRectOffset = Vector2.new(784, 420)
                toggleEnabled.ImageRectSize = Vector2.new(48, 48)
                toggleEnabled.ImageTransparency = 1.000

                onrainbow.Name = "onrainbow"
                onrainbow.Parent = toggleEnabled
                onrainbow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                onrainbow.BackgroundTransparency = 1.000
                onrainbow.Position = UDim2.new(2.90643607e-06, 0, 0, 0)
                onrainbow.Size = UDim2.new(1, 0, 1, 0)
                onrainbow.Font = Enum.Font.SourceSans
                onrainbow.Text = ""
                onrainbow.TextColor3 = Color3.fromRGB(0, 0, 0)
                onrainbow.TextSize = 14.000

                togName_2.Name = "togName"
                togName_2.Parent = colorInners
                togName_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                togName_2.BackgroundTransparency = 1.000
                togName_2.Position = UDim2.new(0.779999971, 0, 0.100000001, 0)
                togName_2.Size = UDim2.new(0, 278, 0, 14)
                togName_2.Font = Enum.Font.GothamSemibold
                togName_2.Text = "Rainbow"
                togName_2.TextColor3 = themeList.TextColor
                togName_2.TextSize = 14.000
                togName_2.TextXAlignment = Enum.TextXAlignment.Left

                if themeList.SchemeColor == Color3.fromRGB(255,255,255) then
                    Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(0,0,0)}, 0.2)
                end 
                if themeList.SchemeColor == Color3.fromRGB(0,0,0) then
                    Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(255,255,255)}, 0.2)
                end 
                local hovering = false

                colorElement.MouseEnter:Connect(function()
                    if not focusing then
                        game.TweenService:Create(colorElement, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10)
                        }):Play()
                        hovering = true
                    end 
                end)
                colorElement.MouseLeave:Connect(function()
                    if not focusing then
                        game.TweenService:Create(colorElement, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            BackgroundColor3 = themeList.ElementColor
                        }):Play()
                        hovering = false
                    end
                end)        

                if themeList.SchemeColor == Color3.fromRGB(255,255,255) then
                    Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(0,0,0)}, 0.2)
                end 
                if themeList.SchemeColor == Color3.fromRGB(0,0,0) then
                    Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(255,255,255)}, 0.2)
                end 
                coroutine.wrap(function()
                    while wait() do
                        if not hovering then
                            colorElement.BackgroundColor3 = themeList.ElementColor
                        end
                        touch.ImageColor3 = themeList.SchemeColor
                        colorHeader.BackgroundColor3 = themeList.ElementColor
                        togName.TextColor3 = themeList.TextColor
                        moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
                        moreInfo.TextColor3 = themeList.TextColor
                        viewInfo.ImageColor3 = themeList.SchemeColor
                        colorInners.BackgroundColor3 = themeList.ElementColor
                        toggleDisabled.ImageColor3 = themeList.SchemeColor
                        toggleEnabled.ImageColor3 = themeList.SchemeColor
                        togName_2.TextColor3 = themeList.TextColor
                        Sample.ImageColor3 = themeList.SchemeColor
                    end
                end)()
                updateSectionFrame()
                UpdateSize()
                local plr = game.Players.LocalPlayer
                local mouse = plr:GetMouse()
                local uis = game:GetService('UserInputService')
                local rs = game:GetService("RunService")
                local colorpicker = false
                local darknesss = false
                local dark = false
                local rgb = rgb    
                local dark = darkness    
                local cursor = rbgcircle
                local cursor2 = darkcircle
                local color = {1,1,1}
                local rainbow = false
                local rainbowconnection
                local counter = 0
                --
                local function zigzag(X) return math.acos(math.cos(X*math.pi))/math.pi end
                counter = 0
                local function mouseLocation()
                    return plr:GetMouse()
                end
                local function cp()
                    if colorpicker then
                        local ml = mouseLocation()
                        local x,y = ml.X - rgb.AbsolutePosition.X,ml.Y - rgb.AbsolutePosition.Y
                        local maxX,maxY = rgb.AbsoluteSize.X,rgb.AbsoluteSize.Y
                        if x<0 then x=0 end
                        if x>maxX then x=maxX end
                        if y<0 then y=0 end
                        if y>maxY then y=maxY end
                        x = x/maxX
                        y = y/maxY
                        local cx = cursor.AbsoluteSize.X/2
                        local cy = cursor.AbsoluteSize.Y/2
                        cursor.Position = UDim2.new(x,-cx,y,-cy)
                        color = {1-x,1-y,color[3]}
                        local realcolor = Color3.fromHSV(color[1],color[2],color[3])
                        colorCurrent.BackgroundColor3 = realcolor
                        callback(realcolor)
                    end
                    if darknesss then
                        local ml = mouseLocation()
                        local y = ml.Y - dark.AbsolutePosition.Y
                        local maxY = dark.AbsoluteSize.Y
                        if y<0 then y=0 end
                        if y>maxY then y=maxY end
                        y = y/maxY
                        local cy = cursor2.AbsoluteSize.Y/2
                        cursor2.Position = UDim2.new(0.5,0,y,-cy)
                        cursor2.ImageColor3 = Color3.fromHSV(0,0,y)
                        color = {color[1],color[2],1-y}
                        local realcolor = Color3.fromHSV(color[1],color[2],color[3])
                        colorCurrent.BackgroundColor3 = realcolor
                        callback(realcolor)
                    end
                end

                local function setcolor(tbl)
                    local cx = cursor.AbsoluteSize.X/2
                    local cy = cursor.AbsoluteSize.Y/2
                    color = {tbl[1],tbl[2],tbl[3]}
                    cursor.Position = UDim2.new(color[1],-cx,color[2]-1,-cy)
                    cursor2.Position = UDim2.new(0.5,0,color[3]-1,-cy)
                    local realcolor = Color3.fromHSV(color[1],color[2],color[3])
                    colorCurrent.BackgroundColor3 = realcolor
                end
                local function setrgbcolor(tbl)
                    local cx = cursor.AbsoluteSize.X/2
                    local cy = cursor.AbsoluteSize.Y/2
                    color = {tbl[1],tbl[2],color[3]}
                    cursor.Position = UDim2.new(color[1],-cx,color[2]-1,-cy)
                    local realcolor = Color3.fromHSV(color[1],color[2],color[3])
                    colorCurrent.BackgroundColor3 = realcolor
                    callback(realcolor)
                end
                local function togglerainbow()
                    if rainbow then
                        game.TweenService:Create(toggleEnabled, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                            ImageTransparency = 1
                        }):Play()
                        rainbow = false
                        rainbowconnection:Disconnect()
                    else
                        game.TweenService:Create(toggleEnabled, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                            ImageTransparency = 0
                        }):Play()
                        rainbow = true
                        rainbowconnection = rs.RenderStepped:Connect(function()
                            setrgbcolor({zigzag(counter),1,1})
                            counter = counter + 0.01
                        end)
                    end
                end

                onrainbow.MouseButton1Click:Connect(togglerainbow)
                --
                mouse.Move:connect(cp)
                rgb.MouseButton1Down:connect(function()colorpicker=true end)
                dark.MouseButton1Down:connect(function()darknesss=true end)
                uis.InputEnded:Connect(function(input)
                    if input.UserInputType.Name == 'MouseButton1' then
                        if darknesss then darknesss = false end
                        if colorpicker then colorpicker = false end
                    end
                end)
                setcolor({h,s,v})
            end
            
            function Elements:NewLabel(title)
            	local labelFunctions = {}
            	local label = Instance.new("TextLabel")
            	local UICorner = Instance.new("UICorner")
            	label.Name = "label"
            	label.Parent = sectionInners
            	label.BackgroundColor3 = themeList.SchemeColor
            	label.BorderSizePixel = 0
				label.ClipsDescendants = true
            	label.Text = title
           		label.Size = UDim2.new(0, 352, 0, 33)
	            label.Font = Enum.Font.Gotham
	            label.Text = "  "..title
	            label.RichText = true
	            label.TextColor3 = themeList.TextColor
	            Objects[label] = "TextColor3"
	            label.TextSize = 14.000
	            label.TextXAlignment = Enum.TextXAlignment.Left
	            
	           	UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = label
            	
	            if themeList.SchemeColor == Color3.fromRGB(255,255,255) then
	                Utility:TweenObject(label, {TextColor3 = Color3.fromRGB(0,0,0)}, 0.2)
	            end 
	            if themeList.SchemeColor == Color3.fromRGB(0,0,0) then
	                Utility:TweenObject(label, {TextColor3 = Color3.fromRGB(255,255,255)}, 0.2)
	            end 

		        coroutine.wrap(function()
		            while wait() do
		                label.BackgroundColor3 = themeList.SchemeColor
		                label.TextColor3 = themeList.TextColor
		            end
		        end)()
                updateSectionFrame()
                UpdateSize()
                function labelFunctions:UpdateLabel(newText)
                	if label.Text ~= "  "..newText then
                		label.Text = "  "..newText
                	end
                end	
                return labelFunctions
            end	
            return Elements
        end
        return Sections
    end  
    return Tabs
end



local Player = game.Players.LocalPlayer

-- Function to create the Notification with two buttons
local function GuiNotify(title, text, button1, button2)
    -- Check if notification already exists, remove it
    local existingNotif = game.CoreGui:FindFirstChild("NotificationFrame")
    if existingNotif then
        existingNotif:Destroy()
    end

    -- Create the main ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "NotificationGui"
    screenGui.Parent = game.CoreGui

    -- Main Notification Frame
    local notifFrame = Instance.new("Frame")
    notifFrame.Name = "NotificationFrame"
    notifFrame.Parent = screenGui
    notifFrame.BackgroundColor3 = Color3.fromRGB(59, 59, 59)
    notifFrame.BorderSizePixel = 0
    notifFrame.Position = UDim2.new(0.5, 9, 0.5, -50) -- Centering the frame
    notifFrame.Size = UDim2.new(0, 500, 0, 250)
    notifFrame.AnchorPoint = Vector2.new(0.5, 0.5) -- Set anchor to center

    -- Add a UICorner to the notification frame for rounded corners
    local notifCorner = Instance.new("UICorner")
    notifCorner.CornerRadius = UDim.new(0, 8)
    notifCorner.Parent = notifFrame

    -- Title Label (Bold)
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Parent = notifFrame
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.new(0, 0, 0, 15)
    titleLabel.Size = UDim2.new(1, 0, 0, 24)  -- Title size changed to 24
    titleLabel.Font = Enum.Font.GothamBold  -- Bold Font
    titleLabel.Text = title
    titleLabel.TextSize = 24
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextStrokeTransparency = 0.5
    titleLabel.TextXAlignment = Enum.TextXAlignment.Center
    titleLabel.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

    -- Create a white frame under the title
    local whiteFrame = Instance.new("Frame")
    whiteFrame.Parent = notifFrame
    whiteFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    whiteFrame.BackgroundTransparency = 0
    whiteFrame.Position = UDim2.new(0, 25, 0, 45) -- Position right below the title
    whiteFrame.Size = UDim2.new(0, 450, 0, 2)  -- Small white frame with size 450x2
    local whiteFrameCorner = Instance.new("UICorner")
    whiteFrameCorner.CornerRadius = UDim.new(0, 0) -- No rounded corners
    whiteFrameCorner.Parent = whiteFrame

    -- Text Label for the body of the notification
    local textLabel = Instance.new("TextLabel")
    textLabel.Parent = notifFrame
    textLabel.BackgroundTransparency = 1
    textLabel.Position = UDim2.new(0, 35, 0, 55)  -- Positioned at {0, 35}, {0, 55}
    textLabel.Size = UDim2.new(0, 425, 0, 130)  -- Adjusted size to {0, 425}, {0, 130}
    textLabel.Font = Enum.Font.Gotham
    textLabel.Text = text
    textLabel.TextSize = 16
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextStrokeTransparency = 0.5
    textLabel.TextWrapped = true
    textLabel.TextScaled = true
    textLabel.TextXAlignment = Enum.TextXAlignment.Center

    -- Container for action buttons
    local buttonContainer = Instance.new("Frame")
    buttonContainer.Parent = notifFrame
    buttonContainer.BackgroundTransparency = 1
    buttonContainer.Position = UDim2.new(0, 25, 1, -65)  -- Position for buttons
    buttonContainer.Size = UDim2.new(0, 450, 0, 50)

    -- Function to create a button
    local function createButton(buttonName, buttonText, position)
        local button = Instance.new("TextButton")
        button.Name = buttonName
        button.Parent = buttonContainer
        button.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- White background
        button.Size = UDim2.new(0.5, -10, 1, -10)
        button.Position = position
        button.Text = buttonText
        button.Font = Enum.Font.Gotham -- Changed to non-bold font (Gotham)
        button.TextColor3 = Color3.fromRGB(0, 0, 0) -- Black text
        button.TextSize = 16
        button.TextStrokeTransparency = 1
        button.BorderSizePixel = 0
        button.AutoButtonColor = true

        -- Adding rounded corners to the button
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 12)
        corner.Parent = button

        -- Button click event handling
        button.MouseButton1Click:Connect(function()
            notifFrame:Destroy() -- Close the notification
            if buttonText == "Leave" then
                game.Players.LocalPlayer:Kick("[CRIM-HOOK]: You have been kicked via notification request.") -- Leave the game
            end
            if buttonText == "Retry" then
                print("Retrying...")
            end
        end)
    end

    -- If both buttons are provided
    if button1 ~= "none" and button2 ~= "none" then
        createButton("Button1", string.upper(button1), UDim2.new(0, 10, 0, 10))
        createButton("Button2", string.upper(button2), UDim2.new(0.5, 10, 0, 10))
    elseif button1 ~= "none" then
        -- If only one button, center it in the container
        createButton("Button1", string.upper(button1), UDim2.new(0.5, -115, 0, 10))
    elseif button2 ~= "none" then
        createButton("Button2", string.upper(button2), UDim2.new(0.5, -115, 0, 10))
    end
end

-- Test the notification
--GuiNotify("CrimHook Notification", "Your account has not been authorized to access CrimHook. If this was a mistake, please contact the owner via ticket creation located in our Discord server.", "Confirm", "Leave")




--// END OF UI LIBRARY CREATION--
local Library = Kavo

local Window = Library.CreateLib(" ( ͡° ͜ʖ ͡°) CrimHook [v.1.0.0]", "Synapse")

local Tab = Window:NewTab("Main")
local Tab2 = Window:NewTab("Combat")
local Tab3 = Window:NewTab("Visuals")
local Tab4 = Window:NewTab("Config")
local Tab5 = Window:NewTab("LegitBot")
local Tab6 = Window:NewTab("Teleports")

local Section = Tab:NewSection("CrimHook Main Functions")
local Section2 = Tab2:NewSection("CrimHook Combat Functions")
local Section3 = Tab3:NewSection("CrimHook Visual Functions")
local Section4 = Tab4:NewSection("CrimHook Configurations")
local Section5 = Tab5:NewSection('CrimHook Legit Features')
local SectionT = Tab6:NewSection("CrimHook Teleport Functions")

local function Notify(text)
        game:GetService("StarterGui"):SetCore("SendNotification", { Title = "[CRIM-HOOK]"; Text = text; Duration = 3; })
    end

GuiNotify("CrimHook Activated", "Welcome to CrimHook. Your account has been sucessfully authorized to use CrimHook!", "Continue", "none")
task.wait(2)
Notify("CrimHook is currently loading, please wait for functions to appear.")
task.wait(5)


SectionT:NewLabel("CrimHook Teleports currently work with out the need for bypasses.")
--// REPEATED FUNCTIONS LOGIC--
-- inf yield bang works player tp any distancce
-- inf yield has anti-fling that works
local rs = game:GetService("RunService")

--// CHAT SPY LOGIC --
 --[[loadstring(game:HttpGet("https://raw.githubusercontent.com/edgeiy/infiniteyield/master/source"))()
      enabled = _G.chatspyxx
      
        --if true will check your messages too
        spyOnMyself = true
        --if true will chat the logs publicly (fun, risky)
        public = _G.AnnounceChatSpy
        --if true will use /me to stand out
        publicItalics = true
        --customize private logs
        privateProperties = {
            Color = Color3.fromRGB(255, 170, 5),
            Font = Enum.Font.SourceSansBold,
            TextSize = 18
        }
        --////////////////////////////////////////////////////////////////
        local StarterGui = game:GetService("StarterGui")
        local Players = game:GetService("Players")
        local player = Players.LocalPlayer
        local saymsg =
            game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild(
            "SayMessageRequest"
        )
        local getmsg =
            game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild(
            "OnMessageDoneFiltering"
        )
        local instance = (_G.chatSpyInstance or 0) + 1
        _G.chatSpyInstance = instance

        local function onChatted(p, msg)
            if _G.chatSpyInstance == instance then
                if p == player and msg:lower():sub(1, 4) == "/enableChatSpy" then
                    enabled = not enabled
                    wait(0.3)
                    privateProperties.Text = "[CrimHook Chat Spy" .. (enabled and "En" or "Dis") .. "abled]"
                    StarterGui:SetCore("ChatMakeSystemMessage", privateProperties)
                elseif enabled and (spyOnMyself == true or p ~= player) then
                    msg = msg:gsub("[

]", ""):gsub("	", " "):gsub("[ ]+", " ")
                    local hidden = true
                    local conn =
                        getmsg.OnClientEvent:Connect(
                        function(packet, channel)
                            if
                                packet.SpeakerUserId == p.UserId and
                                    packet.Message == msg:sub(#msg - #packet.Message + 1) and
                                    (channel == "All" or
                                        (channel == "Team" and public == false and
                                            Players[packet.FromSpeaker].Team == player.Team))
                             then
                                hidden = false
                            end
                        end
                    )
                    wait(1)
                    conn:Disconnect()
                    if hidden and enabled then
                        if public then
                            saymsg:FireServer(
                                (publicItalics and "/me " or "") .. "[CrimHook] [" .. p.Name .. "]: " .. msg,
                                "All"
                            )
                        else
                            privateProperties.Text = "[CrimHook] [" .. p.Name .. "]: " .. msg
                            StarterGui:SetCore("ChatMakeSystemMessage", privateProperties)
                        end
                    end
                end
            end
        end

        for _, p in ipairs(Players:GetPlayers()) do
            p.Chatted:Connect(
                function(msg)
                    onChatted(p, msg)
                end
            )
        end
        Players.PlayerAdded:Connect(
            function(p)
                p.Chatted:Connect(
                    function(msg)
                        onChatted(p, msg)
                    end
                )
            end
        )
        privateProperties.Text = "[CrimHook Chat Spy " .. (enabled and "En" or "Dis") .. "abled}"
        StarterGui:SetCore("ChatMakeSystemMessage", privateProperties)
        local chatFrame = player.PlayerGui.Chat.Frame
        chatFrame.ChatChannelParentFrame.Visible = true
        chatFrame.ChatBarParentFrame.Position =
            chatFrame.ChatChannelParentFrame.Position + UDim2.new(UDim.new(), chatFrame.ChatChannelParentFrame.Size.Y)
]]
--// END CHAT SPY LOGIC --

--// ANTI AIM LOGIC INITIALSETUP--
local player = game.Players.LocalPlayer
local Animer = Instance.new("Animation")
Animer.AnimationId = "rbxassetid://215384594"
local track
_G.isAntiAim = false

local function setupAntiAim()
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")

    -- Load the animation for the new humanoid
    track = humanoid:LoadAnimation(Animer)

    -- If Anti-Aim is already active, play the animation
    if _G.isAntiAim then
        track:Play(3, 1, 1e7)
    end
end

-- Set up initially
setupAntiAim()

-- Handle respawn/reinitialization
player.CharacterAdded:Connect(function()
    task.wait(0.5) -- Add a small delay to ensure objects are ready
    setupAntiAim()
end)

--// END ANTI AIM LOGIC INITIALSETUP --



_G.SpeedToggled = false
_G.SpeedValue = 16
_G.JumpToggled = true
_G.JumpValue = 25
_G.InfPepperToggled = false
_G.InfInvSlotsToggled = false
_G.NoRunStaminaReductionToggled = false
_G.UnbreakableLimbsToggled = false
_G.NoGrabbedToggled = false
_G.NoRagdollToggled = false
_G.NoDownedToggled = false
local RunService = game:GetService("RunService")
local Self = game.Players.LocalPlayer

task.spawn(function(NoAnims)
	local NoAnimsConnection = RunService.PreRender:Connect(function()
		local Character = Self.Character
		if (Character and Character ~= nil) then
			local Humanoid = Character:FindFirstChildOfClass("Humanoid")
			if (Humanoid and Humanoid ~= nil) then
				if _G.NoAnimsToggled == true then
					for _, track in ipairs(Humanoid:GetPlayingAnimationTracks()) do
						track:Stop()
					end
				end
			end
		end
	end)
end)

task.spawn(function(NoDowned)
	local NoDownedConnection = RunService.PreRender:Connect(function()
		if _G.NoDownedToggled == true then
			local CharStats = game:GetService("ReplicatedStorage"):FindFirstChild("CharStats")
			if (CharStats and CharStats ~= nil) then
				local MyStats = CharStats:FindFirstChild(Self.Name)
				if (MyStats and MyStats ~= nil) then
					local DownedStat = MyStats:FindFirstChild("Downed")
					if (DownedStat and DownedStat ~= nil) then
						DownedStat.Value = false
					end
				end
			end
		end
	end)
end)

task.spawn(function(NoRagdoll)
	local NoRagdollConnection = RunService.PreRender:Connect(function()
		if _G.NoRagdollToggled == true then
			local CharStats = game:GetService("ReplicatedStorage"):FindFirstChild("CharStats")
			if (CharStats and CharStats ~= nil) then
				local MyStats = CharStats:FindFirstChild(Self.Name)
				if (MyStats and MyStats ~= nil) then
					local RagdollStat = MyStats:FindFirstChild("RagdollTime")
					if (RagdollStat and RagdollStat ~= nil) then
						local RagdollStat1 = RagdollStat:FindFirstChild("RagdollSwitch")
						if (RagdollStat1 and RagdollStat1 ~= nil) then
							RagdollStat1.Value = false
						end
						local RagdollStat2 = RagdollStat:FindFirstChild("SRagdolled")
						if (RagdollStat2 and RagdollStat2 ~= nil) then
							RagdollStat2.Value = false
						end
					end
				end
			end
		end
	end)
end)

task.spawn(function(NoGrabbed)
	local NoGrabbedConnection = RunService.PreRender:Connect(function()
		if _G.NoGrabbedTogled == true then
			local CharStats = game:GetService("ReplicatedStorage"):FindFirstChild("CharStats")
			if (CharStats and CharStats ~= nil) then
				local MyStats = CharStats:FindFirstChild(Self.Name)
				if (MyStats and MyStats ~= nil) then
					local DownedStat = MyStats:FindFirstChild("Grabbed")
					if (DownedStat and DownedStat ~= nil) then
						DownedStat.Value = false
					end
				end
			end
		end
	end)
end)

task.spawn(function(UnbreakableLimbs)
	local UnbreakableLimbsConnection = RunService.PreRender:Connect(function()
		if _G.UnbreakableLimbsToggled == true then
			local CharStats = game:GetService("ReplicatedStorage"):FindFirstChild("CharStats")
			if (CharStats and CharStats ~= nil) then
				local MyStats = CharStats:FindFirstChild(Self.Name)
				if (MyStats and MyStats ~= nil) then
					local DownedStat = MyStats:FindFirstChild("HealthValues")
					if (DownedStat and DownedStat ~= nil) then
						for i,v in pairs(DownedStat:GetDescendants()) do
							if v.Name == "Broken" or v.Name == "Destroyed" then
								v.Value = false
							elseif v.Name == "Head" or v.Name == "Right Arm" or v.Name == "Left Arm" or v.Name == "Right Leg" or v.Name == "Left Leg" then
								v.MaxValue = math.huge
								v.MinValue = math.huge
								v.Value = math.huge
							end
						end
					end
				end
			end
		end
	end)
end)

task.spawn(function(InfPepper)
	local InfPepperConnection = RunService.PreRender:Connect(function()
		if _G.InfPepperToggled == true then
			local Character = Self.Character
			if (Character and Character ~= nil) then
				local Pepperspray = Character:FindFirstChild("Pepper-spray")
				if (Pepperspray and Pepperspray ~= nil) then
					local Ammo = Pepperspray:FindFirstChild("Ammo")
					if (Ammo and Ammo ~= nil) then
						Ammo.MaxValue = math.huge
						Ammo.MinValue = math.huge
						Ammo.Value = math.huge
					end
				end
			end
		end
	end)
end)

task.spawn(function(InfInvSlots)
	local InfInvSlotsConnection = RunService.PreRender:Connect(function()
		if _G.InfInvSlotsToggled == true then
			local CharStats = game:GetService("ReplicatedStorage"):FindFirstChild("CharStats")
			if (CharStats and CharStats ~= nil) then
				local MyStats = CharStats:FindFirstChild(Self.Name)
				if (MyStats and MyStats ~= nil) then
					local DownedStat = MyStats:FindFirstChild("InventorySlots")
					if (DownedStat and DownedStat ~= nil) then
						DownedStat.MaxValue = math.huge
						DownedStat.MinValue = 0
						DownedStat.Value = 1
					end
				end
			end
		end
	end)
end)

task.spawn(function(Speed)
	local SpeedConnection = game:GetService("RunService").PreRender:Connect(function()
		local Character = game.Players.LocalPlayer.Character
		if (Character and Character ~= nil) then
			local Humanoid = Character:FindFirstChildOfClass("Humanoid")
			if (Humanoid and Humanoid ~= nil) then
				if _G.SpeedToggled == true then
					local PrimaryPart = Character:FindFirstChild("HumanoidRootPart")
					if (PrimaryPart and PrimaryPart ~= nil) then
						if (Humanoid.MoveDirection.Magnitude > 0) then
							PrimaryPart.Velocity = Vector3.new(Humanoid.MoveDirection.X * _G.SpeedValue, PrimaryPart.Velocity.Y, Humanoid.MoveDirection.Z * _G.SpeedValue)
						end
					end
				end
			end
		end
	end)
end)



task.spawn(function(Jump)
	local JumpConnection = game:GetService("UserInputService").JumpRequest:Connect(function()
		local Character = game.Players.LocalPlayer.Character
		if (Character and Character ~= nil) then
			local Humanoid = Character:FindFirstChildOfClass("Humanoid")
			if (Humanoid and Humanoid ~= nil) then
				if _G.JumpToggled == true then
					local PrimaryPart = Character:FindFirstChild("HumanoidRootPart")
					if (PrimaryPart and PrimaryPart ~= nil) then
						PrimaryPart.Velocity = Vector3.new(PrimaryPart.Velocity.X, _G.JumpValue, PrimaryPart.Velocity.Z)
					end
				end
			end
		end
	end)
end)

task.spawn(function(NoDowned)
	local NoDownedConnection = RunService.PreRender:Connect(function()
		if _G.NoDownedToggled == true then
			local CharStats = game:GetService("ReplicatedStorage"):FindFirstChild("CharStats")
			if (CharStats and CharStats ~= nil) then
				local MyStats = CharStats:FindFirstChild(Self.Name)
				if (MyStats and MyStats ~= nil) then
					local DownedStat = MyStats:FindFirstChild("Downed")
					if (DownedStat and DownedStat ~= nil) then
						DownedStat.Value = false
					end
				end
			end
		end
	end)
end)
















Section:NewLabel("CrimHook is unfinished. Bugs may occur.")

Section:NewButton("Refresh Character", "Refreshes the character the normal way.", function()
     local args1 = {
         [1] = true
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PlayerReset"):FireServer(unpack(args1))
        task.wait(2.1)
        local args = {
            [1] = "KMG4R904"
        }

        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("DeathRespawn"):InvokeServer(unpack(args))
end)

Section2:NewButton("Anti-Headshot", "[RISKY]: Repositions the head to an ideal combat position.", function()
     local plr = game.Players.LocalPlayer
    local char = plr.Character
    local NeckMotor = char.Torso:FindFirstChild("Neck")
    local BallSocket = char.HumanoidRootPart.CTs.RGCT_Neck

    NeckMotor.Enabled = false
    BallSocket.TwistLowerAngle = 170
    BallSocket.TwistUpperAngle = 155
    char.Head.CollisionGroup = nil
    char.Head.Visible = false
    char.Head.face:Destroy()
    char.Head.HeadCollider:Destroy()
end)

Section2:NewButton("Enable WallBang", "Allows weapons to ignore walls [LIMITED TO <50 STUDS]", function()
    Notify("Wallbang has been enabled, Max Penetration: 3")
    game:service[[Workspace]]:FindFirstChild('Map'):FindFirstChild('Parts'):FindFirstChild('M_Parts').Parent = game:service[[Workspace]]:FindFirstChild('Characters')
end)

--// BEGIN KILL AURA LOGIC --
_G.isFlinging = false

function getRoot(char)
	local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
	return rootPart
end

function nofling()
	_G.isFlinging = false
end


function yesfling()
	nofling()
    local humanoid = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
    if humanoid then
        humanoid.Died:Connect(function()
            nofling()
        end)
    end

    --execCmd("noclip")
    _G.isFlinging = true
    repeat game:GetService("RunService").Heartbeat:Wait()
        local character = game.Players.LocalPlayer.Character
        local root = character.HumanoidRootPart or character.Torso
        local vel, movel = nil, 0.1

        while not (character and character.Parent and root and root.Parent) do
            game:GetService("RunService").Heartbeat:Wait()
            character = game.Players.LocalPlayer.Character
            root = character.HumanoidRootPart or character.Torso
        end

        vel = root.Velocity
        root.Velocity = vel * 10000 + Vector3.new(0, 75000, 0)

        game:GetService("RunService").RenderStepped:Wait()
        if character and character.Parent and root and root.Parent then
            root.Velocity = vel
        end

        game:GetService("RunService").Stepped:Wait()
        if character and character.Parent and root and root.Parent then
            root.Velocity = vel + Vector3.new(0, movel, 0)
            movel = movel * -1
        end
    until _G.isFlinging == false	
end

--// END KILL AURA LOGIC --
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:FindFirstChildWhichIsA("Humanoid")
local rootPart = character:FindFirstChild("HumanoidRootPart")

local swimming = false
local oldgrav = workspace.Gravity
local swimbeat = nil
local gravReset = nil

-- Function to update character references on respawn
local function onCharacterAdded(newCharacter)
    character = newCharacter
    humanoid = newCharacter:WaitForChild("Humanoid") -- Wait for Humanoid to be fully loaded
    rootPart = newCharacter:WaitForChild("HumanoidRootPart") -- Ensure rootPart is loaded
    
    -- Reinitialize swimming logic if it's active
    if swimming then
        startSwim()
    end
end

player.CharacterAdded:Connect(onCharacterAdded) -- Listen for respawns

-- Function to start swimming (fly)
function startSwim()
    if swimming then return end
    
    swimming = true
    oldgrav = workspace.Gravity
    workspace.Gravity = 1

    local function swimDied()
        stopSwim()
    end

    gravReset = humanoid.Died:Connect(swimDied)

    -- Disable humanoid states for swimming
    local enums = Enum.HumanoidStateType:GetEnumItems()
    table.remove(enums, table.find(enums, Enum.HumanoidStateType.None))

    for _, v in pairs(enums) do
        humanoid:SetStateEnabled(v, false)
    end
    
    humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
    
    -- Disable certain parts of the torso for swimming effect
    if character:FindFirstChild("Torso") then
        character.Torso["Left Hip"].Enabled = false
        character.Torso["Right Hip"].Enabled = false
        character.Torso["Left Shoulder"].Enabled = false
        character.Torso["Right Shoulder"].Enabled = false
    end
    
    -- Apply friction torque settings if HumanoidRootPart exists
    if character:FindFirstChild("HumanoidRootPart") then
        local CTs = character.HumanoidRootPart:FindFirstChild("CTs")
        if CTs then
            CTs["RGCT_Left Hip"].MaxFrictionTorque = 25
            CTs["RGCT_Right Hip"].MaxFrictionTorque = 25
            CTs["RGCT_Left Shoulder"].MaxFrictionTorque = 25
            CTs["RGCT_Right Shoulder"].MaxFrictionTorque = 25
            CTs["RGCT_RootJoint"].MaxFrictionTorque = 252
        end
    end

    -- Handle swimming movement
    swimbeat = RunService.Heartbeat:Connect(function()
        pcall(function()
            if character and rootPart then
                local moveDirection = humanoid.MoveDirection
                rootPart.Velocity = (moveDirection ~= Vector3.new() or UserInputService:IsKeyDown(Enum.KeyCode.Space)) 
                    and rootPart.Velocity 
                    or Vector3.new() -- Prevents character from falling
            end
        end)
    end)
end

-- Function to stop swimming (fly)
function stopSwim()
    if not swimming then return end
    
    swimming = false
    workspace.Gravity = oldgrav

    if gravReset then
        gravReset:Disconnect()
        gravReset = nil
    end

    if swimbeat then
        swimbeat:Disconnect()
        swimbeat = nil
    end

    -- Reset torso and joints
    if character:FindFirstChild("Torso") then
        character.Torso["Left Hip"].Enabled = true
        character.Torso["Right Hip"].Enabled = true
        character.Torso["Left Shoulder"].Enabled = true
        character.Torso["Right Shoulder"].Enabled = true
    end
    
    -- Reset friction torque settings
    if character:FindFirstChild("HumanoidRootPart") then
        local CTs = character.HumanoidRootPart:FindFirstChild("CTs")
        if CTs then
            CTs["RGCT_Left Hip"].MaxFrictionTorque = 0
            CTs["RGCT_Right Hip"].MaxFrictionTorque = 0
            CTs["RGCT_Left Shoulder"].MaxFrictionTorque = 0
            CTs["RGCT_Right Shoulder"].MaxFrictionTorque = 0
            CTs["RGCT_RootJoint"].MaxFrictionTorque = 0
        end
    end

    -- Re-enable humanoid states
    local enums = Enum.HumanoidStateType:GetEnumItems()
    table.remove(enums, table.find(enums, Enum.HumanoidStateType.None))

    for _, v in pairs(enums) do
        humanoid:SetStateEnabled(v, true)
    end
end

-- Toggle swim functionality
Section:NewToggle("Toggle Fly", "[RISKY]: Allows the character to fly", function(state)
    if state then
        startSwim()
    else
        stopSwim()
    end
end)




Section2:NewToggle("Toggle Kill Aura", "[RISKY]: Kills any player that touches you", function(state)
     if state == true then
		yesfling()
        Notify("Kill aura enabled. Movement cheats except bypasses will not work.")
	else
	nofling()
	end	
end)

Section3:NewToggle("Toggle Textured Viewmodel", "Modifies the viewmodel material", function(state)
     local viewmodel = workspace.Camera.ViewModel
     if state == true then
        -- Apply the chosen color to both arms
        viewmodel["Right Arm"].Material = Enum.Material.ForceField
        viewmodel["Left Arm"].Material = Enum.Material.ForceField
    else
       viewmodel["Right Arm"].Material = Enum.Material.SmoothPlastic
        viewmodel["Left Arm"].Material = Enum.Material.SmoothPlastic
    end
end)

Section3:NewColorPicker("Edit Viewmodel Color", "Changes viewmodel colors", Color3.fromRGB(255,255,255), function(color)
    -- Accessing the Right Arm and Left Arm in the custom viewmodel system
    local viewmodel = workspace.Camera.ViewModel
    if viewmodel and viewmodel:FindFirstChild("Right Arm") and viewmodel:FindFirstChild("Left Arm") then
        -- Apply the chosen color to both arms
        viewmodel["Right Arm"].Color = color
        viewmodel["Left Arm"].Color = color
    else
        warn("CrimHook -->> Viewmodel Dependencies Not Found. (EDIT VIEWMODEL COLOR) Function has failed.")
    end
end)


_G.preventStaminaUngain = false

Section:NewToggle("Toggle Infinite Sprint", "[Warning: Breaks run animation]: Disables the sprinting stamina reduction", function(state)
    _G.preventStaminaUngain = state
end)

_G.isKEEE = false

Section2:NewToggle("Toggle Melee Bot v2", "[RISKY]: Upgraded version of Melee Rage Bot with 99% hit accuruacy and less glitching", function(state)
    local Player = game.Players.LocalPlayer
    local UIS = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")
    local Camera = workspace.CurrentCamera

    local Character = Player.Character
    if not Character then return end

    local Torso = Character:FindFirstChild("UpperTorso") or Character:FindFirstChild("Torso")
    if not Torso then return end

    local LeftArm = Character:FindFirstChild("Left Arm") or Character:FindFirstChild("LeftUpperArm")
    local RightArm = Character:FindFirstChild("Right Arm") or Character:FindFirstChild("RightUpperArm")

    if not LeftArm or not RightArm then return end

    local LeftMotor = Torso:FindFirstChild("Left Shoulder") or Torso:FindFirstChild("LeftShoulder")
    local RightMotor = Torso:FindFirstChild("Right Shoulder") or Torso:FindFirstChild("RightShoulder")

    if not LeftMotor or not RightMotor then return end

    -- Get all DmgPoint attachments in both arms
    local LeftDmgPoints = {}
    local RightDmgPoints = {}
    
    for _, attachment in pairs(LeftArm:GetChildren()) do
        if attachment.Name == "DmgPoint" then
            table.insert(LeftDmgPoints, attachment)
        end
    end

    for _, attachment in pairs(RightArm:GetChildren()) do
        if attachment.Name == "DmgPoint" then
            table.insert(RightDmgPoints, attachment)
        end
    end

    -- Store original positions of all dmgpoints
    local LeftDmgOriginal = {}
    local RightDmgOriginal = {}

    for _, dmgPoint in pairs(LeftDmgPoints) do
        table.insert(LeftDmgOriginal, dmgPoint.Position)
    end

    for _, dmgPoint in pairs(RightDmgPoints) do
        table.insert(RightDmgOriginal, dmgPoint.Position)
    end

    local LockingOn = false
    local DistanceThreshold = 100
    local CurrentTarget = nil

    local function GetNearestToMouse()
        local Closest, ClosestDistance = nil, math.huge
        local MousePosition = UIS:GetMouseLocation()

        for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
            if otherPlayer ~= Player and otherPlayer.Character then
                local Target = otherPlayer.Character
                local Head = Target:FindFirstChild("Head")

                if Head then
                    local CharacterDistance = (Character.HumanoidRootPart.Position - Head.Position).Magnitude
                    if CharacterDistance <= DistanceThreshold then
                        local ScreenPoint, OnScreen = Camera:WorldToScreenPoint(Head.Position)
                        if OnScreen then
                            local MouseDistance = (Vector2.new(ScreenPoint.X, ScreenPoint.Y) - MousePosition).Magnitude
                            if MouseDistance < ClosestDistance then
                                Closest, ClosestDistance = Target, MouseDistance
                            end
                        end
                    end
                end
            end
        end
        return Closest
    end

    local function StartTracking(Target)
        if not Target then return end
        LockingOn = true

        -- Disable Motors so arms move freely
        LeftMotor.Enabled = false
        RightMotor.Enabled = false

        task.spawn(function()
            while LockingOn and _G.isKEEE and Target do
                if Character and Target:FindFirstChild("Head") then
                    local Head = Target.Head

                    -- Keep arms attached to the target's head
                    LeftArm.CFrame = Head.CFrame * CFrame.new(-1.5, 0, 0)
                    RightArm.CFrame = Head.CFrame * CFrame.new(1.5, 0, 0)

                    -- Move all dmgpoint attachments to match the arms
                    for i, dmgPoint in pairs(LeftDmgPoints) do
                        dmgPoint.Position = LeftArm.Position + (dmgPoint.Position - LeftArm.Position)
                    end

                    for i, dmgPoint in pairs(RightDmgPoints) do
                        dmgPoint.Position = RightArm.Position + (dmgPoint.Position - RightArm.Position)
                    end
                else
                    LockingOn = false
                end
                RunService.Heartbeat:Wait()
            end
        end)
    end

    local function StopTracking()
        LockingOn = false
        CurrentTarget = nil

        -- Restore Motor6Ds
        LeftMotor.Enabled = true
        RightMotor.Enabled = true

        -- Restore dmgpoint attachments to their original positions
        for i, dmgPoint in pairs(LeftDmgPoints) do
            dmgPoint.Position = LeftDmgOriginal[i]
        end

        for i, dmgPoint in pairs(RightDmgPoints) do
            dmgPoint.Position = RightDmgOriginal[i]
        end
    end

    UIS.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.V and _G.isKEEE then
            if LockingOn then
                StopTracking()
            else
                CurrentTarget = GetNearestToMouse()
                if CurrentTarget then
                    StartTracking(CurrentTarget)
                end
            end
        end
    end)

    local function ToggleOn()
        _G.isKEEE = true
    end

    local function ToggleOff()
        _G.isKEEE = false
        StopTracking()
    end

    if state == true then
        ToggleOn()
        Notify("Melee Bot v2 is Active. Toggle using [V]")
    else
        ToggleOff()
    end
end)


_G.isMeleeBot = false

--[[Section2:NewToggle("Toggle [OLD] Melee Rage Bot", "[RISKY]: Toggled using V. Flys towards the nearest player to the mouse and locks on.", function(state)
    local Player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

-- Variables
 -- Controlled via GUI toggle
local LockingOn = false -- Tracks if currently locked onto a target
local Speed = 60 -- Walkspeed equivalent
local DistanceThreshold = 100 -- Maximum distance from the player to consider targets
local PositionOffset = Vector3.new(0, 0, 2.35) -- Offset for backing up while above the target
local CurrentTarget -- Stores the currently locked target

-- Functions
local function GetNearestToMouse()
    local Closest, ClosestDistance = nil, math.huge
    local MousePosition = UIS:GetMouseLocation()

    for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
        if otherPlayer ~= Player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local Character = Player.Character
            local Target = otherPlayer.Character
            local TargetPart = Target:FindFirstChild("HumanoidRootPart")

            if Character and TargetPart then
                local CharacterDistance = (Character.HumanoidRootPart.Position - TargetPart.Position).Magnitude
                if CharacterDistance <= DistanceThreshold then
                    local ScreenPoint, OnScreen = Camera:WorldToScreenPoint(TargetPart.Position)
                    if OnScreen then
                        local MouseDistance = (Vector2.new(ScreenPoint.X, ScreenPoint.Y) - MousePosition).Magnitude
                        if MouseDistance < ClosestDistance then
                            Closest, ClosestDistance = Target, MouseDistance
                        end
                    end
                end
            end
        end
    end
    return Closest
end

local function StartTracking(Target)
    LockingOn = true
    task.spawn(function()
        while LockingOn and _G.isMeleeBot and Target do
            local Character = Player.Character
            if Character and Character:FindFirstChild("HumanoidRootPart") and Target:FindFirstChild("HumanoidRootPart") then
                local TargetPart = Target.HumanoidRootPart
                local TargetPosition = TargetPart.Position + TargetPart.CFrame:VectorToWorldSpace(PositionOffset)
                local Direction = (TargetPosition - Character.HumanoidRootPart.Position).Unit

                -- Set Velocity
                Character.HumanoidRootPart.Velocity = Direction * Speed

                -- Aim Downward at Target
                Character.HumanoidRootPart.CFrame = CFrame.new(Character.HumanoidRootPart.Position, TargetPart.Position) *
                                                     CFrame.Angles(math.rad(-30), 0, 0)
            else
                LockingOn = false -- Stop tracking if target or character becomes invalid
            end
            RunService.Heartbeat:Wait()
        end
    end)
end

local function StopTracking()
    LockingOn = false
    CurrentTarget = nil
    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        -- Stop movement
        Player.Character.HumanoidRootPart.Velocity = Vector3.zero
    end
end

-- Toggle Functions for GUI


-- Input Handling for Locking
UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    if input.KeyCode == Enum.KeyCode.V and _G.isMeleeBot then
        if LockingOn then
            StopTracking()
        else
            CurrentTarget = GetNearestToMouse()
            if CurrentTarget then
                StartTracking(CurrentTarget)
            end
        end
    end
end)


local function ToggleOn()
    _G.isMeleeBot = true
end

local function ToggleOff()
    _G.isMeleeBot = false
    StopTracking()
end

if state == true then
	ToggleOn()
else
ToggleOff()
end
end)]]

Section2:NewButton("Enable Aimbot", "[Y]: Enables standard camera aimbot (FIRST PERSON ONLY)", function()
     getgenv().AimPart = "Head" -- For R15 Games: {UpperTorso, LowerTorso, HumanoidRootPart, Head} | For R6 Games: {Head, Torso, HumanoidRootPart}
        getgenv().AimlockToggleKey = "Y" -- Toggles Aimbot On/Off
        getgenv().AimRadius = 50 -- How far away from someones character you want to lock on at
        getgenv().ThirdPerson = false -- Locking onto someone in your Third Person POV
        getgenv().FirstPerson = true -- Locking onto someone in your First Person POV
        getgenv().TeamCheck = false -- Check if Target is on your Team (True means it wont lock onto your teamates, false is vice versa) (Set it to false if there are no teams)
        getgenv().PredictMovement = true -- Predicts if they are moving in fast velocity (like jumping) so the aimbot will go a bit faster to match their speed
        getgenv().PredictionVelocity = 15 -- The speed of the PredictMovement feature


--[[
getgenv().AimPart = "HumanoidRootPart" -- For R15 Games: {UpperTorso, LowerTorso, HumanoidRootPart, Head} | For R6 Games: {Head, Torso, HumanoidRootPart}
getgenv().AimlockToggleKey = "Y" -- Toggles Aimbot On/Off 
getgenv().AimRadius = 50 -- How far away from someones character you want to lock on at
getgenv().ThirdPerson = false -- Locking onto someone in your Third Person POV
getgenv().FirstPerson = true -- Locking onto someone in your First Person POV
getgenv().TeamCheck = false -- Check if Target is on your Team (True means it wont lock onto your teamates, false is vice versa) (Set it to false if there are no teams)
getgenv().PredictMovement = true -- Predicts if they are moving in fast velocity (like jumping) so the aimbot will go a bit faster to match their speed 
getgenv().PredictionVelocity = 10 -- The speed of the PredictMovement feature 
]]--

local Players, Uis, RService, SGui = game:GetService"Players", game:GetService"UserInputService", game:GetService"RunService", game:GetService"StarterGui";
local Client, Mouse, Camera, CF, RNew, Vec3, Vec2 = Players.LocalPlayer, Players.LocalPlayer:GetMouse(), workspace.CurrentCamera, CFrame.new, Ray.new, Vector3.new, Vector2.new;
local Aimlock, MousePressed, CanNotify = true, false, false;
local AimlockTarget;
getgenv().CrimHookAimbot = true

getgenv().SeparateNotify = function(title, text, icon, time) 
    SGui:SetCore("SendNotification",{
        Title = title;
        Text = text;
        Duration = time;
    })
end

getgenv().Notify = function(title, text, icon, time)
    if CanNotify == true then 
        if not time or not type(time) == "number" then time = 3 end
        SGui:SetCore("SendNotification",{
            Title = title;
            Text = text;
            Duration = time;
        }) 
    end
end

getgenv().WorldToViewportPoint = function(P)
    return Camera:WorldToViewportPoint(P)
end

getgenv().WorldToScreenPoint = function(P)
    return Camera.WorldToScreenPoint(Camera, P)
end

getgenv().GetObscuringObjects = function(T)
    if T and T:FindFirstChild(getgenv().AimPart) and Client and Client.Character:FindFirstChild("Head") then 
        local RayPos = workspace:FindPartOnRay(RNew(
            T[getgenv().AimPart].Position, Client.Character.Head.Position)
        )
        if RayPos then return RayPos:IsDescendantOf(T) end
    end
end

getgenv().GetNearestTarget = function()
    -- Credits to whoever made this, i didnt make it, and my own mouse2plr function kinda sucks
    local players = {}
    local PLAYER_HOLD  = {}
    local DISTANCES = {}
    for i, v in pairs(Players:GetPlayers()) do
        if v ~= Client then
            table.insert(players, v)
        end
    end
    for i, v in pairs(players) do
        if v.Character ~= nil then
            local AIM = v.Character:FindFirstChild("Head")
            if getgenv().TeamCheck == true and v.Team ~= Client.Team then
                local DISTANCE = (v.Character:FindFirstChild("Head").Position - game.Workspace.CurrentCamera.CFrame.p).magnitude
                local RAY = Ray.new(game.Workspace.CurrentCamera.CFrame.p, (Mouse.Hit.p - game.Workspace.CurrentCamera.CFrame.p).unit * DISTANCE)
                local HIT,POS = game.Workspace:FindPartOnRay(RAY, game.Workspace)
                local DIFF = math.floor((POS - AIM.Position).magnitude)
                PLAYER_HOLD[v.Name .. i] = {}
                PLAYER_HOLD[v.Name .. i].dist= DISTANCE
                PLAYER_HOLD[v.Name .. i].plr = v
                PLAYER_HOLD[v.Name .. i].diff = DIFF
                table.insert(DISTANCES, DIFF)
            elseif getgenv().TeamCheck == false and v.Team == Client.Team then 
                local DISTANCE = (v.Character:FindFirstChild("Head").Position - game.Workspace.CurrentCamera.CFrame.p).magnitude
                local RAY = Ray.new(game.Workspace.CurrentCamera.CFrame.p, (Mouse.Hit.p - game.Workspace.CurrentCamera.CFrame.p).unit * DISTANCE)
                local HIT,POS = game.Workspace:FindPartOnRay(RAY, game.Workspace)
                local DIFF = math.floor((POS - AIM.Position).magnitude)
                PLAYER_HOLD[v.Name .. i] = {}
                PLAYER_HOLD[v.Name .. i].dist= DISTANCE
                PLAYER_HOLD[v.Name .. i].plr = v
                PLAYER_HOLD[v.Name .. i].diff = DIFF
                table.insert(DISTANCES, DIFF)
            end
        end
    end
    
    if unpack(DISTANCES) == nil then
        return nil
    end
    
    local L_DISTANCE = math.floor(math.min(unpack(DISTANCES)))
    if L_DISTANCE > getgenv().AimRadius then
        return nil
    end
    
    for i, v in pairs(PLAYER_HOLD) do
        if v.diff == L_DISTANCE then
            return v.plr
        end
    end
    return nil
end

--[[getgenv().CheckTeamsChildren = function()
    if workspace and workspace:FindFirstChild"Teams" then 
        if getgenv().TeamCheck == true then
            if #workspace.Teams:GetChildren() == 0 then 
                getgenv().TeamCheck = false 
                SeparateNotify("CrimHook", "checking teams set to: "..tostring(getgenv().TeamCheck).." because there are no teams!", "", 3)
            end
        end
    end
end
CheckTeamsChildren()
]]--

--[[getgenv().GetNearestTarget = function()
    local T;
    for _, p in next, Players:GetPlayers() do 
        if p ~= Client then 
            if p.Character and p.Character:FindFirstChild(getgenv().AimPart) then 
                if getgenv().TeamCheck == true and p.Team ~= Client.Team then 
                    local Pos, ScreenCheck = WorldToScreenPoint(p.Character[getgenv().AimPart].Position)
                    Pos = Vec2(Pos.X, Pos.Y)
                    local MPos = Vec2(Mouse.X, Mouse.Y) -- Credits to CriShoux for this
                    local Distance = (Pos - MPos).Magnitude;
                    if Distance < getgenv().AimRadius then 
                        T = p 
                    end
                elseif getgenv().TeamCheck == false and p.Team == Client.Team then 
                    local Pos, ScreenCheck = WorldToScreenPoint(p.Character[getgenv().AimPart].Position)
                    Pos = Vec2(Pos.X, Pos.Y)
                    local MPos = Vec2(Mouse.X, Mouse.Y) -- Credits to CriShoux for this
                    local Distance = (Pos - MPos).Magnitude;
                    if Distance < getgenv().AimRadius then 
                        T = p 
                    end
                end
            end
        end
    end
    if T then 
        return T
    end
end]]--

Uis.InputBegan:Connect(function(Key)
    if not (Uis:GetFocusedTextBox()) then 
        if Key.UserInputType == Enum.UserInputType.MouseButton2 then 
            pcall(function()
                if MousePressed ~= true then MousePressed = true end 
                local Target;Target = GetNearestTarget()
                if Target ~= nil then 
                    AimlockTarget = Target
                    Notify("CrimHook", "is currently locking: "..tostring(AimlockTarget), "", 3)
                end
            end)
        end
        if Key.KeyCode == Enum.KeyCode[AimlockToggleKey] then 
            Aimlock = not Aimlock
            Notify("CrimHook", "Aimbot set to: "..tostring(Aimlock), "", 3)
        end
    end
end)
Uis.InputEnded:Connect(function(Key)
    if not (Uis:GetFocusedTextBox()) then 
        if Key.UserInputType == Enum.UserInputType.MouseButton2 then 
            if AimlockTarget ~= nil then AimlockTarget = nil end
            if MousePressed ~= false then 
                MousePressed = false 
            end
        end
    end
end)

RService.RenderStepped:Connect(function()
    if getgenv().FirstPerson == true and getgenv().ThirdPerson == false then 
        if (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude <= 1 then 
            CanNotify = true 
        else 
            CanNotify = false 
        end
    elseif getgenv().ThirdPerson == true and getgenv().FirstPerson == false then 
        if (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude > 1 then 
            CanNotify = true 
        else 
            CanNotify = false 
        end
    end
    if Aimlock == true and MousePressed == true then 
        if AimlockTarget and AimlockTarget.Character and AimlockTarget.Character:FindFirstChild(getgenv().AimPart) then 
            if getgenv().FirstPerson == true then
                if CanNotify == true then
                    if getgenv().PredictMovement == true then 
                        Camera.CFrame = CF(Camera.CFrame.p, AimlockTarget.Character[getgenv().AimPart].Position + AimlockTarget.Character[getgenv().AimPart].Velocity/PredictionVelocity)
                    elseif getgenv().PredictMovement == false then 
                        Camera.CFrame = CF(Camera.CFrame.p, AimlockTarget.Character[getgenv().AimPart].Position)
                    end
                end
            elseif getgenv().ThirdPerson == true then 
                if CanNotify == true then
                    if getgenv().PredictMovement == true then 
                        Camera.CFrame = CF(Camera.CFrame.p, AimlockTarget.Character[getgenv().AimPart].Position + AimlockTarget.Character[getgenv().AimPart].Velocity/PredictionVelocity)
                    elseif getgenv().PredictMovement == false then 
                        Camera.CFrame = CF(Camera.CFrame.p, AimlockTarget.Character[getgenv().AimPart].Position)
                    end
                end 
            end
        end
    end
end)
end)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local triggerBotEnabled = false
local rightMouseHeld = false

-- Function to check if a target is a valid enemy
local function isValidTarget(target)
    if target and target.Parent then
        local character = target.Parent
        local player = Players:GetPlayerFromCharacter(character)
        if player and player ~= LocalPlayer then
            return (character:FindFirstChild("Humanoid") and character:FindFirstChild("Head"))
        end
    end
    return false
end

-- Function to enable/disable trigger bot
local function toggleTriggerBot(state)
    triggerBotEnabled = state
    if state then
        print("Trigger Bot Enabled")
    else
        print("Trigger Bot Disabled")
    end
end

-- Listen for right mouse button hold
UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        rightMouseHeld = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        rightMouseHeld = false
    end
end)

-- Main trigger bot loop
RunService.RenderStepped:Connect(function()
    if triggerBotEnabled and rightMouseHeld then
        local target = Mouse.Target
        if isValidTarget(target) then
            local distance = (LocalPlayer.Character.Head.Position - target.Position).Magnitude
            if distance <= 250 then
                -- Simulate left mouse click
                mouse1click()
            end
        end
    end
end)

Section2:NewToggle("Toggle Trigger Bot", "Auto shoots/triggers mouse", function(state)
    toggleTriggerBot(state)
    Notify("Trigger Bot is Active. Must holding ADS to use.")
end)


Section5:NewButton("Enable Legit Aimbot", "[Y]: Enables legit aimbot", function()
    getgenv().AimPart = "Head" -- Changeable target
    getgenv().AimlockToggleKey = "Y"
    getgenv().AimRadius = 100 
    getgenv().FirstPerson = true
    getgenv().ThirdPerson = false
    getgenv().TeamCheck = false
    getgenv().PredictMovement = true
    getgenv().PredictionVelocity = 15
    getgenv().AimSmoothness = 0.2 -- 0 = instant, higher = slower aim speed
    getgenv().JitterAmount = 0.3 -- Small random offsets to mimic human aim
    
    local Players = game:GetService("Players")
    local Uis = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")
    local Camera = workspace.CurrentCamera
    local LocalPlayer = Players.LocalPlayer
    local Mouse = LocalPlayer:GetMouse()
    
    local Aimlock = false
    local AimlockTarget
    local MousePressed = false
    
    local function Notify(title, text)
        game:GetService("StarterGui"):SetCore("SendNotification", { Title = title; Text = text; Duration = 3; })
    end

    local function GetNearestTarget()
        local closest = nil
        local shortestDist = getgenv().AimRadius
        
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild(getgenv().AimPart) then
                if getgenv().TeamCheck and player.Team == LocalPlayer.Team then continue end
                
                local targetPart = player.Character[getgenv().AimPart]
                local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                local distance = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(screenPos.X, screenPos.Y)).Magnitude
                
                if onScreen and distance < shortestDist then
                    closest = player
                    shortestDist = distance
                end
            end
        end
        
        return closest
    end

    Uis.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton2 then
            MousePressed = true
            AimlockTarget = GetNearestTarget()
            if AimlockTarget then
                Notify("Aimbot", "Locking onto: " .. AimlockTarget.Name)
            end
        end
        if input.KeyCode == Enum.KeyCode[getgenv().AimlockToggleKey] then
            Aimlock = not Aimlock
            Notify("Aimbot", "Aimbot set to: " .. tostring(Aimlock))
        end
    end)

    Uis.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton2 then
            MousePressed = false
            AimlockTarget = nil
        end
    end)

    RunService.RenderStepped:Connect(function()
        if Aimlock and MousePressed and AimlockTarget and AimlockTarget.Character and AimlockTarget.Character:FindFirstChild(getgenv().AimPart) then
            local targetPart = AimlockTarget.Character[getgenv().AimPart]
            
            -- Predict movement
            local aimPos = targetPart.Position
            if getgenv().PredictMovement then
                aimPos = aimPos + targetPart.Velocity / getgenv().PredictionVelocity
            end

            -- Add slight jitter for realism
            aimPos = aimPos + Vector3.new(
                math.random() * getgenv().JitterAmount - getgenv().JitterAmount / 2,
                math.random() * getgenv().JitterAmount - getgenv().JitterAmount / 2,
                math.random() * getgenv().JitterAmount - getgenv().JitterAmount / 2
            )

            -- Smoothly move camera towards target
            local newCFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, aimPos), getgenv().AimSmoothness)
            Camera.CFrame = newCFrame
        end
    end)
end)


SectionT:NewButton("Give Teleport Tool", "[RISKY]: Gives a tool that teleports to where the mouse clicks [LIMITED TO 50+ STUDS]", function()
       mouse = game.Players.LocalPlayer:GetMouse()
	    tool = Instance.new("Tool")
	    tool.RequiresHandle = false
	    tool.Name = "Teleport"
	    tool.Activated:connect(function()
	    local pos = mouse.Hit+Vector3.new(0,2.5,0)
	    pos = CFrame.new(pos.X,pos.Y,pos.Z)
		 local A_1 = "__--r"
        local A_2 = Vector3.new(1555.178057461977005, 80000.45867919921875, 1654.940984725952148)
        local A_3 = CFrame.new(4622.77637, 1474.090881, 7744.0441208, 3566.999935508, 2456.06157474e-08, -0.0113573903, 9.29981692e-09, 1, -1.15918411e-07, 0.0113573903, 1.15805307e-07, 0.999935508)
        game:GetService("ReplicatedStorage").Events["__DFfDD"]:FireServer(A_1, A_2, A_3)
		wait(.1)
	    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
	    end)
	    tool.Parent = game.Players.LocalPlayer.Backpack
end)

Section:NewButton("Enable Auto Lockpick", "Automatically picks any activated lockpick menus.", function()
    function checkLockpick(...)
    local frames = { ... };
    for i,v in pairs(frames) do
        v.Parent.UIScale.Scale = 10
        if (v.AbsolutePosition.Y >= 450 and v.AbsolutePosition.Y <= 550) then
            mouse1click(); task.wait(0.1); mouse1release();
        end
    end
end

while true do task.wait()
    local pgui = game.Players.LocalPlayer:WaitForChild"PlayerGui"
    local lpgui = pgui:FindFirstChild'LockpickGUI';

    if (lpgui) then

        local B1 = lpgui.MF.LP_Frame.Frames.B1.Bar.Selection;
        local B2 = lpgui.MF.LP_Frame.Frames.B2.Bar.Selection;
        local B3 = lpgui.MF.LP_Frame.Frames.B3.Bar.Selection;

        checkLockpick(B1, B2, B3);
    end
end
end)

Section2:NewSlider("Modify Finish Speed", "[RISKY]: Modifies the speed a melee finish is done", 25, 0.5, function(s)
     local repStorage = game:GetService("ReplicatedStorage")
    local valuesFolder = repStorage:FindFirstChild("Values")
    local FinishSpeedMult = valuesFolder:FindFirstChild("FinishSpeedMulti")

    FinishSpeedMult.Value = s
end)








local Noclipping = nil
local RunService = game:GetService("RunService")
Section:NewToggle("Toggle Noclip", "[RISKY]: Disables player collisions on walls. (Disables ground collisions when downed.)", function(state)
   local speaker = game.Players.LocalPlayer
  	if state == true then
	Clip = false
	wait(0.1)
	local function NoclipLoop()
	if Clip == false and speaker.Character ~= nil then
		for _, child in pairs(speaker.Character:GetDescendants()) do
			if child:IsA("BasePart") and child.CanCollide == true and child.Name ~= floatName then
				child.CanCollide = false
			end
		end
	end
end
	Noclipping = RunService.Stepped:Connect(NoclipLoop)
	else

	if Noclipping then
	Noclipping:Disconnect()
	end
	Clip = true
	end

end)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local dropdownOptions = {}

-- Function to get a player's root part
local function getRoot(character)
    return character and character:FindFirstChild("HumanoidRootPart")
end

-- Function to teleport to a player for 3 seconds
local function teleportToPlayer(targetPlayer)
    if LocalPlayer.Character and targetPlayer.Character then
        local targetRoot = getRoot(targetPlayer.Character)
        local localRoot = getRoot(LocalPlayer.Character)

        if targetRoot and localRoot then
            -- Start teleport loop
            local connection
            connection = game:GetService("RunService").Heartbeat:Connect(function()
                if not targetPlayer.Character or not getRoot(targetPlayer.Character) then
                    connection:Disconnect()
                else
                    localRoot.CFrame = getRoot(targetPlayer.Character).CFrame
                end
            end)

            -- Stop teleporting after 3 seconds
            task.wait(3)
            connection:Disconnect()
        end
    end
end

-- Function to update the dropdown options
local function updateDropdown()
    dropdownOptions = {}
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            table.insert(dropdownOptions, player.Name)
        end
    end

    -- Update existing dropdown instead of creating a new one
    if teleportDropdown then
        teleportDropdown:Refresh(dropdownOptions)
    else
        teleportDropdown = SectionT:NewDropdown("Teleport to Player", "Select a player to teleport to", dropdownOptions, function(selectedPlayerName)
            local targetPlayer = Players:FindFirstChild(selectedPlayerName)
            if targetPlayer then
                Notify("Attempted teleport to: "..targetPlayer.Name.." in progress.")
                teleportToPlayer(targetPlayer)
            end
        end)
    end
end

-- Update dropdown when players join/leave
Players.PlayerAdded:Connect(updateDropdown)
Players.PlayerRemoving:Connect(updateDropdown)
updateDropdown() -- Initial update


local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local charStats = ReplicatedStorage:FindFirstChild("CharStats")

if not charStats then
    warn("CharStats folder not found in ReplicatedStorage!")
    return
end

local function getRootPart()
    local character = LocalPlayer.Character
    return character and character:FindFirstChild("HumanoidRootPart")
end

local originalPosition = nil
local isUnderground = false
local toggleEnabled = false -- Manual toggle

-- Function to check the downed state and toggle effect
local function checkDowned()
    if not toggleEnabled then return end -- Toggle must be enabled

    local downedValue = charStats:FindFirstChild(LocalPlayer.Name) and charStats[LocalPlayer.Name]:FindFirstChild("Downed")

    if downedValue and downedValue.Value then
        if not isUnderground then
            local root = getRootPart()
            if root then
                originalPosition = root.CFrame
                root.Anchored = true
                root.CFrame = root.CFrame * CFrame.new(0, -6, 0) -- Move underground
               -- isUnderground = true
            end
        end
    else
        if isUnderground then
            local root = getRootPart()
            if root then
                root.CFrame = originalPosition or root.CFrame -- Restore position
                root.Anchored = false
                isUnderground = false
            end
        end
    end
end

-- Function to toggle on/off
local function toggleDownedEffect()
    toggleEnabled = not toggleEnabled
    if not toggleEnabled and isUnderground then
        -- If toggled off while underground, restore position
        local root = getRootPart()
        if root then
            root.CFrame = originalPosition or root.CFrame
            root.Anchored = false
            isUnderground = false
        end
    end
    Notify("Anti-Downed Toggle is", toggleEnabled and "Active" or "Inactive")
end

-- Connect to heartbeat for checking downed status
RunService.Heartbeat:Connect(checkDowned)

-- UI Button Example
Section:NewToggle("Anti-Downed", "Prevents you from being downed", function(state)
    toggleDownedEffect()
end)



Section:NewToggle("Toggle Anti-Fling/Kill Aura", "Enables/Disables anti-fling/aura protection", function(state)
    if state then
        if antifling then
            antifling:Disconnect()
            antifling = nil
        end
        Notify("Anti-Fling/Kill Aura is Active. This feature may cause severe lag on lower end computers.")
        antifling = game:GetService("RunService").Stepped:Connect(function()
            for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                if player ~= game.Players.LocalPlayer and player.Character then
                    for _, v in pairs(player.Character:GetDescendants()) do
                        if v:IsA("BasePart") then
                            v.CanCollide = false
                        end
                    end
                end
            end
        end)
    else
        if antifling then
            antifling:Disconnect()
            antifling = nil
        end
    end
end)

local tpwalkSpeed = 10 -- Default speed

Section:NewSlider("Bypass Walk Speed", "Adjust the bypass walk speed", 50, 1, function(s)
    tpwalkSpeed = s
end)

Section:NewToggle("Toggle Bypass Walk", "Walkspeed that allows kill aura, etc.", function(state)
    if state then
        Notify("Toggle Bypass Walk is Active. Best suited for Kill Aura usage.")
        tpwalking = true
        local speaker = game.Players.LocalPlayer
        local chr = speaker.Character
        local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")

        task.spawn(function()
            while tpwalking and chr and hum and hum.Parent do
                local delta = game:GetService("RunService").Heartbeat:Wait()
                if hum.MoveDirection.Magnitude > 0 then
                    chr:TranslateBy(hum.MoveDirection * delta * tpwalkSpeed)
                end
            end
        end)
    else
        tpwalking = false
    end
end)


Section:NewToggle("Toggle Walkspeed", "Allows scripted changes in movement speed", function(state)
    _G.SpeedToggled = state
end)

Section:NewSlider("Walkspeed Modifier", "Determines the movement speed changes", 85, 10, function(s)
    _G.SpeedValue = s
end)

Section:NewToggle("Toggle JumpPower", "Allows scripted changes in jumping height", function(state)
    _G.JumpToggled = state
end)

Section:NewSlider("JumpPower Modifier", "Determines the jumping height changes", 125, 10, function(s)
    _G.JumpValue = s
end)

Section:NewToggle("Toggle Door Collisions", "Toggles whether doors in the map are able collidable.", function(state)
    if state then
    local doorsFolder = game.Workspace:WaitForChild("Map"):WaitForChild("Doors")
for _, door in ipairs(doorsFolder:GetChildren()) do
    if door:IsA("Model") then
        for _, part in ipairs(door:GetDescendants()) do
            if part:IsA("BasePart") and part.Name == "DoorBase" then
                part.CanCollide = false
            end
        end
    end
end
    elseif not state then
local doorsFolder = game.Workspace:WaitForChild("Map"):WaitForChild("Doors")

for _, door in ipairs(doorsFolder:GetChildren()) do
    if door:IsA("Model") then
        for _, part in ipairs(door:GetDescendants()) do
            if part:IsA("BasePart") and part.Name == "DoorBase" then
                part.CanCollide = true
            end
        end
    end
end
    end
end)
Section:NewToggle("Toggle Barbed Wire Collisions", "Toggles whether barbed wire in the map are able damage.", function(state)
    if state then
   local partsFolder = game.Workspace:WaitForChild("Filter"):WaitForChild("Parts"):WaitForChild("F_Parts"):WaitForChild("6VMBJD")

for _, part in ipairs(partsFolder:GetChildren()) do
    if part:IsA("MeshPart") then
        part.CanTouch = false
        part.Color = Color3.new(255, 0, 0)
    end
end
    elseif not state then
  local partsFolder = game.Workspace:WaitForChild("Filter"):WaitForChild("Parts"):WaitForChild("F_Parts"):WaitForChild("6VMBJD")

for _, part in ipairs(partsFolder:GetChildren()) do
    if part:IsA("MeshPart") then
        part.CanTouch = true
        part.Color = Color3.new(91, 93, 105)
    end
end
    end
end)

Section3:NewToggle("Toggle Remove Allowance UI", "Toggles the visibility of the UI", function(state)
    local RS = game:GetService("ReplicatedStorage")
    local Folder = RS:FindFirstChild("Values")
    
    Folder:FindFirstChild("UI_RemoveAllowance").Value = state
end)
Section3:NewToggle("Toggle Remove Bank UI", "Toggles the visibility of the UI", function(state)
    local RS = game:GetService("ReplicatedStorage")
    local Folder = RS:FindFirstChild("Values")
    
    Folder:FindFirstChild("UI_RemoveBank").Value = state
end)
Section3:NewToggle("Toggle Remove Bounty UI", "Toggles the visibility of the UI", function(state)
    local RS = game:GetService("ReplicatedStorage")
    local Folder = RS:FindFirstChild("Values")
    
    Folder:FindFirstChild("UI_RemoveBounty").Value = state
end)
Section3:NewToggle("Toggle Remove Cash UI", "Toggles the visibility of the UI", function(state)
    local RS = game:GetService("ReplicatedStorage")
    local Folder = RS:FindFirstChild("Values")
    
    Folder:FindFirstChild("UI_RemoveCash").Value = state
end)
Section3:NewToggle("Toggle Remove Cash Drop Button", "Toggles the visibility of the UI", function(state)
    local RS = game:GetService("ReplicatedStorage")
    local Folder = RS:FindFirstChild("Values")
    
    Folder:FindFirstChild("UI_RemoveCashDropButton").Value = state
end)
Section3:NewToggle("Toggle Remove Store Button", "Toggles the visibility of the UI", function(state)
    local RS = game:GetService("ReplicatedStorage")
    local Folder = RS:FindFirstChild("Values")
    
    Folder:FindFirstChild("UI_RemoveStoreButton").Value = state
end)
Section3:NewToggle("Toggle Free UGC Button", "Toggles the visibility of the UI", function(state)
    local RS = game:GetService("ReplicatedStorage")
    local Folder = RS:FindFirstChild("Values")
    
    Folder:FindFirstChild("UI_VisibleFreeUGC").Value = state
end)
Section3:NewToggle("Toggle Infection Points UI", "Toggles the visibility of the UI", function(state)
    local RS = game:GetService("ReplicatedStorage")
    local Folder = RS:FindFirstChild("Values")
    
    Folder:FindFirstChild("UI_VisiblePoints").Value = state
end)

Section3:NewToggle("Toggle Downed Status", "Toggles whether or not you're downed (Mainly Visual)", function(state)
    local RS = game:GetService("ReplicatedStorage")
    local Folder = RS:FindFirstChild("CharStats"):FindFirstChild(game.Players.LocalPlayer.Name)
    
    Folder.Downed.Value = state
end)













Section:NewToggle("Toggle Ragdoll Roofs", "Toggles whether inaccessable roof ragdoll zones actually work", function(state)
    if state then
   local partsFolder = game.Workspace:WaitForChild("Filter"):WaitForChild("Parts"):WaitForChild("F_Parts"):WaitForChild("6VMBJD")

for _, part in ipairs(partsFolder:GetChildren()) do
    if part.Name == "RG_Part" then
        part.CanTouch = false
        part.CanCollide = false
    end
end
    elseif not state then
  local partsFolder = game.Workspace:WaitForChild("Filter"):WaitForChild("Parts"):WaitForChild("F_Parts"):WaitForChild("6VMBJD")

for _, part in ipairs(partsFolder:GetChildren()) do
    if part.Name == "RG_Part" then
        part.CanTouch = true
        part.CanCollide = true
    end
end
    end
end)

Section2:NewToggle("Toggle Global Snowball Area", "Makes the entire map able to let you create snowballs from the ground (ONLY WINTER)", function(state)
        local snowFolder = game.Workspace:WaitForChild("Filter"):WaitForChild("Snow"):GetChildren()[65]
local originalSizes = {}


for _, part in ipairs(snowFolder:GetChildren()) do
    if part:IsA("BasePart") and part.Name == "SNOWPART" then
        originalSizes[part] = part.Size
    end
end

local function toggleSnowSize()
    state = not state
    for part, originalSize in pairs(originalSizes) do
        if state then
            part.Size = Vector3.new(999, originalSize.Y, originalSize.Z)
            part.Transparency = 1
        else
            part.Size = originalSize
            part.Transparency = 0
        end
    end
end

toggleSnowSize()

end)

Section:NewToggle("Toggle Anti-Aim", "[RISKY]: Creates nearly untrackable player movement.", function(state)
     if state then
            _G.isAntiAim = true
            if track then
                track:Play(3, 1, 1e7)
            end
        else
            _G.isAntiAim = false
            if track then
                track:Stop()
            end
        end

end)

Section:NewToggle("Toggle Unbreakable Limbs", "Makes all character joints impossible to break or injure", function(state)
        _G.UnbreakableLimbsToggled = state
end)

Section:NewToggle("Toggle Infinite Inventory", "[VISUAL EFFECT]: Visually removes the inventory slot limitations", function(state)
        _G.InfInvSlotsToggled = state
end)

Section:NewToggle("Toggle Anti-Ragdoll", "Makes the character immune to ragdoll effects", function(state)
        _G.NoRagdollToggled = state
end)

Section:NewToggle("Toggle Anti-Grabbed", "Makes the character impossible to grab when downed", function(state)
        _G.NoRagdollToggled = state
end)

Section2:NewToggle("Toggle Infinite PepperSpray", "Removes the pepper spray ammo degeneration", function(state)
        _G.InfPepperToggled = state
end)

Section:NewToggle("Toggle Anti-Downed", "Makes the character impossible to get downed", function(state)
        _G.NoDownedToggled = state
end)

Section3:NewButton("Remove Viewmodel Shirt", "Removes the shirt on the FirstPerson Viewmodel to allow customizations", function()
if game.Workspace.Camera.ViewModel then
		game.Workspace.Camera.ViewModel.Shirt:Destroy()
	end
end)

Section:NewToggle("Toggle NoLimbs", "Toggles whether your character has limbs", function(state)
    local character = game.Players.LocalPlayer.Character
    if state then
       character.Torso["Left Hip"].Enabled = false
    character.Torso["Right Hip"].Enabled = false
    character.Torso["Left Shoulder"].Enabled = false
    character.Torso["Right Shoulder"].Enabled = false
    character.HumanoidRootPart.CTs["RGCT_Left Hip"].Enabled = false
    character.HumanoidRootPart.CTs["RGCT_Right Hip"].Enabled = false
    character.HumanoidRootPart.CTs["RGCT_Left Shoulder"].Enabled = false
    character.HumanoidRootPart.CTs["RGCT_Right Shoulder"].Enabled = false
    character.HumanoidRootPart.CTs["RGCT_RootJoint"].Enabled = false
    else
      character.Torso["Left Hip"].Enabled = true
    character.Torso["Right Hip"].Enabled = true
    character.Torso["Left Shoulder"].Enabled = true
    character.Torso["Right Shoulder"].Enabled = true
    character.HumanoidRootPart.CTs["RGCT_Left Hip"].Enabled = true
    character.HumanoidRootPart.CTs["RGCT_Right Hip"].Enabled = true
    character.HumanoidRootPart.CTs["RGCT_Left Shoulder"].Enabled = true
    character.HumanoidRootPart.CTs["RGCT_Right Shoulder"].Enabled = true
    character.HumanoidRootPart.CTs["RGCT_RootJoint"].Enabled = true
    end
end)

Section:NewButton("Enable Ragdoll Toggle", "[T]: Ragdolls the character when pressed", function()
   Notify("Ragdoll Toggle is Active. Activate using [T]")
    local mouse = game.Players.LocalPlayer:GetMouse()
    mouse.KeyDown:Connect(function(k) 
        if k == "t" then

        local A_1 = "__--r"
        local A_2 = Vector3.new(1555.178057461977005, 80000.45867919921875, 1654.940984725952148)
        local A_3 = CFrame.new(4622.77637, 1474.090881, 7744.0441208, 3566.999935508, 2456.06157474e-08, -0.0113573903, 9.29981692e-09, 1, -1.15918411e-07, 0.0113573903, 1.15805307e-07, 0.999935508)
        game:GetService("ReplicatedStorage").Events["__DFfDD"]:FireServer(A_1, A_2, A_3)
    end
end)

end)

Section3:NewButton("Reset Movement Animations", "Resets movement animations back to the defaults.", function()
     local player = game.Players.LocalPlayer.Character

--idle
local idle1 = player.Animate.idle1.Animation1_1
local idle1_2 = player.Animate.idle1.Animation2_1
local idle2 = player.Animate.idle2.Animation1_2
local idle2_2 = player.Animate.idle2.Animation2_2
local idle3 = player.Animate.idle3.Animation1_3
local idle3_2 = player.Animate.idle3.Animation2_3

--walk
local walk1 = player.Animate.walk1.WalkAnim1
local walk2 = player.Animate.walk2.WalkAnim2
local walk3 = player.Animate.walk3.WalkAnim3

--run
local run1 = player.Animate.run1.RunAnim1
local run2 = player.Animate.run2.RunAnim2
local run3 = player.Animate.run3.RunAnim3

--zomb anims
local infectedidle = "rbxassetid://180435571"
local infectedwalk = "rbxassetid://14694480722"
local infectedrun = "rbxassetid://14694480293"

--brute anims
local bruterun = "rbxassetid://14694480293"

--zombie idle
idle1.AnimationId = infectedidle
idle1_2.AnimationId = infectedidle
idle2.AnimationId = infectedidle
idle2_2.AnimationId = infectedidle
idle3.AnimationId = infectedidle
idle3_2.AnimationId = infectedidle

--zombie walk
walk1.AnimationId = infectedwalk
walk2.AnimationId = infectedwalk
walk3.AnimationId = infectedwalk

--zombie run
--run1.AnimationId = infectedrun
--run2.AnimationId = infectedrun
--run3.AnimationId = infectedrun

--brute run
run1.AnimationId = bruterun
run2.AnimationId = bruterun
run3.AnimationId = bruterun

end)

local CarToggle = false
local RunService = game:GetService("RunService")

Section3:NewToggle("Toggle Fake Car", "Makes you look and move like a car", function(state) 
    local Character = game.Players.LocalPlayer.Character
    if not Character then return end

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    if not HumanoidRootPart or not Humanoid then return end

    local animator = Humanoid:FindFirstChildOfClass("Animator")
    if not animator then return end

    -- Store animations globally so they can be stopped properly
    if not _G.CarAnim1 then
        _G.CarAnim1 = Instance.new("Animation")
        _G.CarAnim1.AnimationId = "rbxassetid://179224234"
    end

    if not _G.CarAnim2 then
        _G.CarAnim2 = Instance.new("Animation")
        _G.CarAnim2.AnimationId = "rbxassetid://181526230"
    end

    if state then
        CarToggle = true
        --[[game:GetService("StarterGui"):SetCore("SendNotification", {
          Title = "CrimHook Framework",
          Text = "Fake Car Toggle Activated",
          Duration = 3, -- Time in seconds
        })]] 

        -- Load and play animations
        if not _G.CarTrack1 then
            _G.CarTrack1 = animator:LoadAnimation(_G.CarAnim1)
        end
        if not _G.CarTrack2 then
            _G.CarTrack2 = animator:LoadAnimation(_G.CarAnim2)
        end

        _G.CarTrack1:Play()
        _G.CarTrack2:Play()

        -- Make the character "slippery" with updated physical properties
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("Part") then
                part.CustomPhysicalProperties = PhysicalProperties.new(0.1, 0, 0, 0, 0) -- Adjust friction and bounciness
            end
        end

        -- Slippery movement effect
        local Connection
        Connection = RunService.Stepped:Connect(function()
            if not CarToggle then
                Connection:Disconnect()
                return
            end

            -- Reduce movement friction by applying velocity decay
           --[[ local velocity = HumanoidRootPart.Velocity
            HumanoidRootPart.Velocity = Vector3.new(velocity.X * 0.96, velocity.Y, velocity.Z * 0.96) -- Smoother sliding
        ]]
        end)


    else
        CarToggle = false

        -- Stop and destroy animation tracks properly
        if _G.CarTrack1 then
            _G.CarTrack1:Stop()
            _G.CarTrack1:Destroy()
            _G.CarTrack1 = nil
        end

        if _G.CarTrack2 then
            _G.CarTrack2:Stop()
            _G.CarTrack2:Destroy()
            _G.CarTrack2 = nil
        end

        -- Reset physical properties back to default for all parts
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("Part") then
                part.CustomPhysicalProperties = PhysicalProperties.new(1, 0.3, 0.5, 1, 1) -- Reset to default
            end
        end
    end
end)


Section3:NewButton("Enable Fake Infected", "[RISKY]: Turns your character into an infected zombie (Visual Only, No Perks)", function()
     local player = game.Players.LocalPlayer.Character

--idle
local idle1 = player.Animate.idle1.Animation1_1
local idle1_2 = player.Animate.idle1.Animation2_1
local idle2 = player.Animate.idle2.Animation1_2
local idle2_2 = player.Animate.idle2.Animation2_2
local idle3 = player.Animate.idle3.Animation1_3
local idle3_2 = player.Animate.idle3.Animation2_3

--walk
local walk1 = player.Animate.walk1.WalkAnim1
local walk2 = player.Animate.walk2.WalkAnim2
local walk3 = player.Animate.walk3.WalkAnim3

--run
local run1 = player.Animate.run1.RunAnim1
local run2 = player.Animate.run2.RunAnim2
local run3 = player.Animate.run3.RunAnim3

--zomb anims
local infectedidle = "rbxassetid://11467619014"
local infectedwalk = "rbxassetid://11467628939"
local infectedrun = "rbxassetid://4514293527"

--brute anims
local bruterun = "rbxassetid://11467630904"

--zombie idle
idle1.AnimationId = infectedidle
idle1_2.AnimationId = infectedidle
idle2.AnimationId = infectedidle
idle2_2.AnimationId = infectedidle
idle3.AnimationId = infectedidle
idle3_2.AnimationId = infectedidle

--zombie walk
walk1.AnimationId = infectedwalk
walk2.AnimationId = infectedwalk
walk3.AnimationId = infectedwalk

--zombie run
--run1.AnimationId = infectedrun
--run2.AnimationId = infectedrun
--run3.AnimationId = infectedrun

--brute run
run1.AnimationId = bruterun
run2.AnimationId = bruterun
run3.AnimationId = bruterun

end)

Section3:NewButton("Freeze Movement Animations", "Freezes all default movement animations but allows other animations", function()
     local player = game.Players.LocalPlayer.Character

--idle
local idle1 = player.Animate.idle1.Animation1_1
local idle1_2 = player.Animate.idle1.Animation2_1
local idle2 = player.Animate.idle2.Animation1_2
local idle2_2 = player.Animate.idle2.Animation2_2
local idle3 = player.Animate.idle3.Animation1_3
local idle3_2 = player.Animate.idle3.Animation2_3

--walk
local walk1 = player.Animate.walk1.WalkAnim1
local walk2 = player.Animate.walk2.WalkAnim2
local walk3 = player.Animate.walk3.WalkAnim3

--run
local run1 = player.Animate.run1.RunAnim1
local run2 = player.Animate.run2.RunAnim2
local run3 = player.Animate.run3.RunAnim3

--zomb anims
local infectedidle = "rbxassetid://13084367111"
local infectedwalk = "rbxassetid://13084367111"
local infectedrun = "rbxassetid://13084367111"

--brute anims
local bruterun = "rbxassetid://13084367111"

--zombie idle
idle1.AnimationId = infectedidle
idle1_2.AnimationId = infectedidle
idle2.AnimationId = infectedidle
idle2_2.AnimationId = infectedidle
idle3.AnimationId = infectedidle
idle3_2.AnimationId = infectedidle

--zombie walk
walk1.AnimationId = infectedwalk
walk2.AnimationId = infectedwalk
walk3.AnimationId = infectedwalk

--zombie run
--run1.AnimationId = infectedrun
--run2.AnimationId = infectedrun
--run3.AnimationId = infectedrun

--brute run
run1.AnimationId = bruterun
run2.AnimationId = bruterun
run3.AnimationId = bruterun

end)

Section3:NewToggle("Toggle Daytime", "Changes the time of day either from or to current time and full daylight", function(state)
     if state == true then
        local repStorage = game:GetService("ReplicatedStorage")
    local valuesFolder = repStorage:FindFirstChild("Values")

    local TimeState = valuesFolder:FindFirstChild("TimeState")
    TimeState.Value = 12
    TimeState.Enabled.Value = true
    elseif state == false then
       local repStorage = game:GetService("ReplicatedStorage")
    local valuesFolder = repStorage:FindFirstChild("Values")

    local TimeState = valuesFolder:FindFirstChild("TimeState")
    TimeState.Enabled.Value = false 
    end

end)

local Skyboxes = { 
    ["none"] = {
        SkyboxLf = "rbxassetid://252760980",
        SkyboxBk = "rbxassetid://252760981",
        SkyboxDn = "rbxassetid://252763035",
        SkyboxFt = "rbxassetid://252761439",
        SkyboxRt = "rbxassetid://252760986",
        SkyboxUp = "rbxassetid://252762652",
    },
    ["nebula"] = {
        SkyboxLf = "rbxassetid://159454286",
        SkyboxBk = "rbxassetid://159454299",
        SkyboxDn = "rbxassetid://159454296",
        SkyboxFt = "rbxassetid://159454293",
        SkyboxRt = "rbxassetid://159454300",
        SkyboxUp = "rbxassetid://159454288",
    },
    ["vaporwave"] = {
        SkyboxLf = "rbxassetid://1417494402",
        SkyboxBk = "rbxassetid://1417494030",
        SkyboxDn = "rbxassetid://1417494146",
        SkyboxFt = "rbxassetid://1417494253",
        SkyboxRt = "rbxassetid://1417494499",
        SkyboxUp = "rbxassetid://1417494643",
    },
    ["clouds"] = {
        SkyboxLf = "rbxassetid://570557620",
        SkyboxBk = "rbxassetid://570557514",
        SkyboxDn = "rbxassetid://570557775",
        SkyboxFt = "rbxassetid://570557559",
        SkyboxRt = "rbxassetid://570557672",
        SkyboxUp = "rbxassetid://570557727",
    },
    ["twilight"] = {
        SkyboxLf = "rbxassetid://264909758",
        SkyboxBk = "rbxassetid://264908339",
        SkyboxDn = "rbxassetid://264907909",
        SkyboxFt = "rbxassetid://264909420",
        SkyboxRt = "rbxassetid://264908886",
        SkyboxUp = "rbxassetid://264907379",
    },
}

Section3:NewDropdown("Modify Skybox", "Modifies the skybox to an option of choice", {"none", "nebula", "vaporwave", "clouds", "twilight"}, function(item)
local selectedSkybox = Skyboxes[item]
        if selectedSkybox then
            local lighting = game:GetService("Lighting")
            -- Clear existing skybox if any
            local existingSkybox = lighting:FindFirstChildOfClass("Sky")
            if existingSkybox then
                existingSkybox:Destroy()
            end

            -- Create a new Sky instance
            local skybox = Instance.new("Sky")
            skybox.Name = item .. "_Skybox"
            skybox.SkyboxLf = selectedSkybox.SkyboxLf
            skybox.SkyboxBk = selectedSkybox.SkyboxBk
            skybox.SkyboxDn = selectedSkybox.SkyboxDn
            skybox.SkyboxFt = selectedSkybox.SkyboxFt
            skybox.SkyboxRt = selectedSkybox.SkyboxRt
            skybox.SkyboxUp = selectedSkybox.SkyboxUp
            skybox.Parent = lighting
        end

end)
-- Toggle ESP using your script hub format
Section5:NewToggle("Toggle ESP [DISABLED]", "[LAG WARNING]: ESP IN BETA.", function(state)
  --local ESPLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/Exunys-ESP/main/src/ESP.lua"))()
    if state then
        Notify("This feature is currently disabled, or is not supported on your executor. ErrorCode: DSBLD")
        print("CrimHook: ESP CURRENTLY DISABLED DUE TO EXECUTOR ISSUES AND POTENTIAL LAG. PLEASE USE THIS FEATURE LATER.")
       -- ExunysDeveloperESP:Exit()
        --ExunysDeveloperESP.Load()
    else
    -- ExunysDeveloperESP:Exit()
    end
end)

Section3:NewToggle("Fake 2x XP", "[VISUAL EFFECT]: Makes the XP bar seem doubled", function(state)
    local repStorage = game:GetService("ReplicatedStorage")
    local valuesFolder = repStorage:FindFirstChild("PlayerbaseData2")
    local userMan = game.Players.LocalPlayer
    local plrData = valuesFolder:FindFirstChild(userMan.Name)
    local xpVal = plrData:FindFirstChild("DoubleXP")
    local permVal = xpVal:FindFirstChild("Perm")
    local timerVal = xpVal:FindFirstChild("Timer")

    xpVal.Value = state
    permVal.Value = state
    timerVal.Value = 17997.223 -- only value that works apparently

end)

Section3:NewButton("Enable Armory Gamepass", "Automatically unlocks all armory exclusive purchases for free", function()
          -- Define the main folder path
local mainFolder = game:GetService("ReplicatedStorage"):WaitForChild("Storage"):WaitForChild("ItemStats")

-- Define the items and their respective folders
local itemsToUpdate = {
    Guns = {"BFG-1", "FN-FAL", "FNP-45", "G-18", "M320-1", "M4A1-1", "MP7", "Magnum", "Super-Shorty", "UMP-45"},
    Melees = {"BBaton", "Machete"},
    Throwables = {"Stun-Grenade", "Incendiary-Grenade", "CS-Grenade"},
}

-- Define the values to update
local newValues = {
    Level = 1,
    TypeName = "CrimHook Pre-Unlocked",
}

-- Function to update the values
local function updateItemValues(folderName, itemName)
    local folder = mainFolder:FindFirstChild(folderName)
    if folder then
        local item = folder:FindFirstChild(itemName)
        if item then
            -- Check and update the "Level" value
            local levelValue = item:FindFirstChild("Level")
            if levelValue and levelValue:IsA("IntValue") then
                levelValue.Value = newValues.Level
            end

            -- Check and update the "TypeName" value
            local typeNameValue = item:FindFirstChild("TypeName")
            if typeNameValue and typeNameValue:IsA("StringValue") then
                typeNameValue.Value = newValues.TypeName
            end
        end
    end
end

-- Loop through the items and update their values
for folderName, itemList in pairs(itemsToUpdate) do
    for _, itemName in ipairs(itemList) do
        updateItemValues(folderName, itemName)
    end
end
end)

Section3:NewToggle("Toggle Chat Visibility", "Toggles the ability to see chat box messages in the top left", function(state)
   -- _G.chatspyxx = true
   Notify("This feature is currently disabled, or is not supported by your executor. ErrorCode: DSBLD")
end)
SectionT:NewButton("Teleport to Vibin", "Teleports you to a specific world position for 3 seconds", function()
    local targetCFrame = CFrame.new(Vector3.new(-4401.72168, 10.6533871, -399.988434, -0.999862373, 7.89069361e-07, 0.0165919233, 7.8891145e-07, 1, -1.60638045e-08, -0.0165919233, -2.97203462e-09, -0.999862373)) -- CHANGE THIS TO YOUR DESIRED POSITION

    if LocalPlayer.Character then
        local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            -- Start teleport loop
            local connection
            connection = RunService.Heartbeat:Connect(function()
                if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    connection:Disconnect()
                else
                    rootPart.CFrame = targetCFrame
                end
            end)

            -- Stop teleporting after 3 seconds
            task.wait(4)
            connection:Disconnect()
        end
    end
end)

SectionT:NewButton("Teleport to Cafe", "Teleports you to a specific world position for 3 seconds", function()
    local targetCFrame = CFrame.new(Vector3.new(-4634.18018, 6.05001259, -268.236969, -0.00103855843, 2.26462009e-11, 0.999999464, -1.251662e-09, 1, -2.39461385e-11, -0.999999464, -1.2516862e-09, -0.00103855843)) -- CHANGE THIS TO YOUR DESIRED POSITION

    if LocalPlayer.Character then
        local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            -- Start teleport loop
            local connection
            connection = RunService.Heartbeat:Connect(function()
                if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    connection:Disconnect()
                else
                    rootPart.CFrame = targetCFrame
                end
            end)

            -- Stop teleporting after 3 seconds
            task.wait(4)
            connection:Disconnect()
        end
    end
end)

SectionT:NewButton("Teleport to Armory", "Teleports you to a specific world position for 3 seconds", function()
    local targetCFrame = CFrame.new(Vector3.new(-4770.66064, 4.10010958, -411.626068, 0.985415459, -2.33432438e-08, -0.170165807, 2.24706209e-08, 1, -7.05399339e-09, 0.170165807, 3.12738302e-09, 0.985415459)) -- CHANGE THIS TO YOUR DESIRED POSITION

    if LocalPlayer.Character then
        local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            -- Start teleport loop
            local connection
            connection = RunService.Heartbeat:Connect(function()
                if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    connection:Disconnect()
                else
                    rootPart.CFrame = targetCFrame
                end
            end)

            -- Stop teleporting after 3 seconds
            task.wait(4)
            connection:Disconnect()
        end
    end
end)

SectionT:NewButton("Teleport to Thrift", "Teleports you to a specific world position for 3 seconds", function()
    local targetCFrame = CFrame.new(Vector3.new(-4645.10107, 59.4000473, -158.749405, -0.00126033998, -9.13031712e-08, 0.999999225, 6.30001162e-09, 1, 9.13111862e-08, -0.999999225, 6.41508979e-09, -0.00126033998)) -- CHANGE THIS TO YOUR DESIRED POSITION

    if LocalPlayer.Character then
        local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            -- Start teleport loop
            local connection
            connection = RunService.Heartbeat:Connect(function()
                if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    connection:Disconnect()
                else
                    rootPart.CFrame = targetCFrame
                end
            end)

            -- Stop teleporting after 3 seconds
            task.wait(4)
            connection:Disconnect()
        end
    end
end)

SectionT:NewButton("Teleport to Gas Station", "Teleports you to a specific world position for 3 seconds", function()
    local targetCFrame = CFrame.new(Vector3.new(-4430.54492, 4.02643299, 199.598038, 0.999929786, -6.53627985e-11, 0.0118481144, 2.81205753e-10, 1, -1.82158271e-08, -0.0118481144, 1.82178805e-08, 0.999929786)) -- CHANGE THIS TO YOUR DESIRED POSITION

    if LocalPlayer.Character then
        local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            -- Start teleport loop
            local connection
            connection = RunService.Heartbeat:Connect(function()
                if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    connection:Disconnect()
                else
                    rootPart.CFrame = targetCFrame
                end
            end)

            -- Stop teleporting after 3 seconds
            task.wait(4)
            connection:Disconnect()
        end
    end
end)

SectionT:NewButton("Teleport to Pizza Place", "Teleports you to a specific world position for 3 seconds", function()
    local targetCFrame = CFrame.new(Vector3.new(-4422.27686, 5.19999504, -147.936722, -0.999501109, 1.4515554e-10, -0.0315836444, 3.67340117e-11, 1, 3.43341799e-09, 0.0315836444, 3.43054474e-09, -0.999501109)) -- CHANGE THIS TO YOUR DESIRED POSITION

    if LocalPlayer.Character then
        local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            -- Start teleport loop
            local connection
            connection = RunService.Heartbeat:Connect(function()
                if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    connection:Disconnect()
                else
                    rootPart.CFrame = targetCFrame
                end
            end)

            -- Stop teleporting after 3 seconds
            task.wait(4)
            connection:Disconnect()
        end
    end
end)

SectionT:NewButton("Teleport to Armory 2", "Teleports you to a specific world position for 3 seconds", function()
    local targetCFrame = CFrame.new(Vector3.new(-4192.85205, 4.10010958, -186.230728, -0.0131855253, -1.17324859e-07, 0.999913096, 5.22687715e-09, 1, 1.17403985e-07, -0.999913096, 6.77445566e-09, -0.0131855253)) -- CHANGE THIS TO YOUR DESIRED POSITION

    if LocalPlayer.Character then
        local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            -- Start teleport loop
            local connection
            connection = RunService.Heartbeat:Connect(function()
                if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    connection:Disconnect()
                else
                    rootPart.CFrame = targetCFrame
                end
            end)

            -- Stop teleporting after 3 seconds
            task.wait(4)
            connection:Disconnect()
        end
    end
end)

SectionT:NewButton("Teleport to Workshop", "Teleports you to a specific world position for 3 seconds", function()
    local targetCFrame = CFrame.new(Vector3.new(-4264.18896, 7.36541653, -635.996399, 0.999991238, 3.55608409e-09, 0.00418508006, -3.23758464e-09, 1, -7.61103109e-08, -0.00418508006, 7.6096093e-08, 0.999991238)) -- CHANGE THIS TO YOUR DESIRED POSITION

    if LocalPlayer.Character then
        local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            -- Start teleport loop
            local connection
            connection = RunService.Heartbeat:Connect(function()
                if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    connection:Disconnect()
                else
                    rootPart.CFrame = targetCFrame
                end
            end)

            -- Stop teleporting after 3 seconds
            task.wait(4)
            connection:Disconnect()
        end
    end
end)

SectionT:NewButton("Teleport to Factory", "Teleports you to a specific world position for 3 seconds", function()
    local targetCFrame = CFrame.new(Vector3.new(-4403.01318, 5.60026264, -562.368347, 0.999476552, 2.8595716e-08, 0.0323515721, -3.10801909e-08, 1, 7.62932686e-08, -0.0323515721, -7.72588322e-08, 0.999476552)) -- CHANGE THIS TO YOUR DESIRED POSITION

    if LocalPlayer.Character then
        local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            -- Start teleport loop
            local connection
            connection = RunService.Heartbeat:Connect(function()
                if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    connection:Disconnect()
                else
                    rootPart.CFrame = targetCFrame
                end
            end)

            -- Stop teleporting after 3 seconds
            task.wait(4)
            connection:Disconnect()
        end
    end
end)

SectionT:NewButton("Teleport to Warehouse", "Teleports you to a specific world position for 3 seconds", function()
    local targetCFrame = CFrame.new(Vector3.new(-4627.23682, 6.70005417, -565.664246, -0.987851083, 6.87250923e-09, 0.155403405, 1.08346321e-09, 1, -3.73364344e-08, -0.155403405, -3.67144644e-08, -0.987851083)) -- CHANGE THIS TO YOUR DESIRED POSITION

    if LocalPlayer.Character then
        local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            -- Start teleport loop
            local connection
            connection = RunService.Heartbeat:Connect(function()
                if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    connection:Disconnect()
                else
                    rootPart.CFrame = targetCFrame
                end
            end)

            -- Stop teleporting after 3 seconds
            task.wait(4)
            connection:Disconnect()
        end
    end
end)

SectionT:NewButton("Teleport to Subway", "Teleports you to a specific world position for 3 seconds", function()
    local targetCFrame = CFrame.new(Vector3.new(-4702.08789, -32.2998962, -694.54657, -0.00791770592, -7.43546593e-08, 0.999968648, 1.8548495e-09, 1, 7.43716768e-08, -0.999968648, 2.4436444e-09, -0.00791770592)) -- CHANGE THIS TO YOUR DESIRED POSITION

    if LocalPlayer.Character then
        local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            -- Start teleport loop
            local connection
            connection = RunService.Heartbeat:Connect(function()
                if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    connection:Disconnect()
                else
                    rootPart.CFrame = targetCFrame
                end
            end)

            -- Stop teleporting after 3 seconds
            task.wait(4)
            connection:Disconnect()
        end
    end
end)

SectionT:NewButton("Teleport to Tower", "Teleports you to a specific world position for 3 seconds", function()
    local targetCFrame = CFrame.new(Vector3.new(-4472.5752, 149.4496, -808.06488, 0.999363244, 2.59653437e-08, 0.0356801935, -2.37550299e-08, 1, -6.2371825e-08, -0.0356801935, 6.14845206e-08, 0.999363244)) -- CHANGE THIS TO YOUR DESIRED POSITION

    if LocalPlayer.Character then
        local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            -- Start teleport loop
            local connection
            connection = RunService.Heartbeat:Connect(function()
                if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    connection:Disconnect()
                else
                    rootPart.CFrame = targetCFrame
                end
            end)

            -- Stop teleporting after 3 seconds
            task.wait(4)
            connection:Disconnect()
        end
    end
end)

SectionT:NewButton("Teleport to Motel", "Teleports you to a specific world position for 3 seconds", function()
    local targetCFrame = CFrame.new(Vector3.new(-4641.69482, 3.29673815, -903.941406, 0.0963173434, -6.2303414e-08, 0.995350659, -7.29805283e-09, 1, 6.33006465e-08, -0.995350659, -1.33610722e-08, 0.0963173434)) -- CHANGE THIS TO YOUR DESIRED POSITION

    if LocalPlayer.Character then
        local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            -- Start teleport loop
            local connection
            connection = RunService.Heartbeat:Connect(function()
                if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    connection:Disconnect()
                else
                    rootPart.CFrame = targetCFrame
                end
            end)

            -- Stop teleporting after 3 seconds
            task.wait(4)
            connection:Disconnect()
        end
    end
end)

SectionT:NewButton("Teleport to Safety Roof", "Teleports you to a specific world position for 3 seconds", function()
    local targetCFrame = CFrame.new(Vector3.new(-4646.0708, 25.8000221, -269.240723, 0.0268308334, 1.05069603e-07, -0.999639988, 1.84008941e-09, 1, 1.05156829e-07, 0.999639988, -4.66087213e-09, 0.0268308334)) -- CHANGE THIS TO YOUR DESIRED POSITION

    if LocalPlayer.Character then
        local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            -- Start teleport loop
            local connection
            connection = RunService.Heartbeat:Connect(function()
                if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    connection:Disconnect()
                else
                    rootPart.CFrame = targetCFrame
                end
            end)

            -- Stop teleporting after 3 seconds
            task.wait(4)
            connection:Disconnect()
        end
    end
end)
-- LocalScript
local notificationService = game:GetService("StarterGui")

-- Function to send a notification
local function sendNotification(title, message, duration)
    notificationService:SetCore("SendNotification", {
        Title = title,
        Text = message,
        Duration = duration or 5, -- Default duration is 5 seconds
    })
end

-- Example usage
sendNotification("Please Join RIPs!", "gg/NUsSGtr5P3", 5)











--[[
Section:NewButton("ButtonText", "ButtonInfo", function()
    print("Clicked")
end)

Section:NewToggle("ToggleText", "ToggleInfo", function(state)
    if state then
        print("Toggle On")
    else
        print("Toggle Off")
    end
end)

Section:NewSlider("SliderText", "SliderInfo", 500, 0, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

Section:NewDropdown("DropdownText", "DropdownInf", {"Option 1", "Option 2", "Option 3"}, function(currentOption)
    print(currentOption)
end)






character.Torso["Left Hip"].Enabled = false
    character.Torso["Right Hip"].Enabled = false
    character.Torso["Left Shoulder"].Enabled = false
    character.Torso["Right Shoulder"].Enabled = false
    character.HumanoidRootPart.CTs["RGCT_Left Hip"].Enabled = false
    character.HumanoidRootPart.CTs["RGCT_Right Hip"].Enabled = false
    character.HumanoidRootPart.CTs["RGCT_Left Shoulder"].Enabled = false
    character.HumanoidRootPart.CTs["RGCT_Right Shoulder"].Enabled = false
    character.HumanoidRootPart.CTs["RGCT_RootJoint"].Enabled = false

    character.Torso["Left Hip"].Enabled = true
    character.Torso["Right Hip"].Enabled = true
    character.Torso["Left Shoulder"].Enabled = true
    character.Torso["Right Shoulder"].Enabled = true
    character.HumanoidRootPart.CTs["RGCT_Left Hip"].Enabled = true
    character.HumanoidRootPart.CTs["RGCT_Right Hip"].Enabled = true
    character.HumanoidRootPart.CTs["RGCT_Left Shoulder"].Enabled = true
    character.HumanoidRootPart.CTs["RGCT_Right Shoulder"].Enabled = true
    character.HumanoidRootPart.CTs["RGCT_RootJoint"].Enabled = true
   


]]
