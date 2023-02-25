local Library = {}
    
function Library.Init()
    local lp = game:GetService("Players").LocalPlayer
    local mouse = lp:GetMouse()

    local isMin = false
    local isExit = false
    local toggleKey

    local function bindUiFunctionEvent(callBack, uiEvent)
        local events = {}
        for _,event in pairs(uiEvent) do
            table.insert(events,
                event:Connect(function(...)
                    pcall(callBack, event, ...)
                end)
            )
        end
        return events
    end

    local function inList(list, value)
        for _,v in pairs(list) do
            if v == value then
                return true
            end
        end
    
        return false
    end

    local MainUI = Instance.new("ScreenGui")
    local Main = Instance.new("Frame")
    local Main_UiCorner = Instance.new("UICorner")
    local TitleText = Instance.new("TextLabel")
    local Title = Instance.new("Frame")
    local Title_UiCorner = Instance.new("UICorner")
    local Side = Instance.new("Frame")
    local Side_UiCorner = Instance.new("UICorner")
    local Side_UiListLayout = Instance.new("UIListLayout")
    local RealSide = Instance.new("ScrollingFrame")
    local Exit = Instance.new("ImageButton")
    local Leaf = Instance.new("ImageButton")
    local Min = Instance.new("ImageButton")
    local BGFIX = Instance.new("Frame")

    local UiToggle = Instance.new("TextButton")
    local UiToggle_UiCorner = Instance.new("UICorner")

    local TweenService = game:GetService("TweenService")
    local UIS = game:GetService('UserInputService')
    local frame = Title
    local dragToggle = nil
    local dragSpeed = 0.25
    local dragStart = nil
    local startPos = nil

    local function updateInput(input)
        local delta = input.Position - dragStart
        local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)

        Title:SetAttribute("rPosition", position)
        game:GetService('TweenService'):Create(frame, TweenInfo.new(dragSpeed), {Position = position}):Play()
    end

    frame.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            dragToggle = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragToggle = false
                end
            end)
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            if dragToggle then
                updateInput(input)
            end
        end
    end)

    MainUI.Name = "MainUI"
    MainUI.Parent = game:GetService("CoreGui")

    Main.Name = "Main"
    Main.Parent = Title
    Main.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.316987693, 0, 0.633637547, 0)
    Main.Size = UDim2.new(0, 375, 0, 336)
    Main.ClipsDescendants = true

    Main_UiCorner.CornerRadius = UDim.new(0, 5)
    Main_UiCorner.Name = "Main_UiCorner"
    Main_UiCorner.Parent = Main

    Title.Name = "Title"
    Title.Parent = MainUI
    Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Title.BorderSizePixel = 0
    Title.Position = UDim2.new(0.35, 0, 0.325, 0)
    Title.Size = UDim2.new(0, 549, 0, 29)
    Title.ZIndex = 3
    Title:SetAttribute("rPosition", Title.Position)

    Exit.Name = "Exit"
    Exit.Parent = Title
    Exit.BackgroundTransparency = 1.000
    Exit.Position = UDim2.new(0.0160000008, 0, 0.150000006, 0)
    Exit.Size = UDim2.new(0, 20, 0, 20)
    Exit.ZIndex = 4
    Exit.Image = "rbxassetid://3926307971"
    Exit.ImageColor3 = Color3.fromRGB(255, 67, 70)
    Exit.ImageRectOffset = Vector2.new(644, 44)
    Exit.ImageRectSize = Vector2.new(36, 36)

    Leaf.Name = "Leaf"
    Leaf.Parent = Title
    Leaf.BackgroundTransparency = 1.000
    Leaf.LayoutOrder = 5
    Leaf.Position = UDim2.new(0.0270000007, 0, 0.133000001, 0)
    Leaf.Rotation = -35.000
    Leaf.Size = UDim2.new(0, 12, 0, 6)
    Leaf.ZIndex = 5
    Leaf.Image = "rbxassetid://3926305904"
    Leaf.ImageColor3 = Color3.fromRGB(4, 255, 0)
    Leaf.ImageRectOffset = Vector2.new(124, 124)
    Leaf.ImageRectSize = Vector2.new(36, 36)

    UiToggle.Name = "UiToggle"
    UiToggle.Parent = MainUI
    UiToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    UiToggle.Position = UDim2.new(2.992, 0, 0.45, 0)
    UiToggle.Size = UDim2.new(0, 10, 0, 151)
    UiToggle.AutoButtonColor = false
    UiToggle.Font = Enum.Font.SourceSans
    UiToggle.Text = ""
    UiToggle.TextColor3 = Color3.fromRGB(0, 0, 0)
    UiToggle.TextSize = 14.000
    UiToggle.Visible = true
    UiToggle:SetAttribute("rPosition", UiToggle.Position)

    UiToggle_UiCorner.Name = "UiToggle_UiCorner"
    UiToggle_UiCorner.Parent = UiToggle

    bindUiFunctionEvent(function()
        coroutine.wrap(function()
            isMin = false

            local tP = UiToggle:GetAttribute("rPosition")
            UiToggle:SetAttribute("rPosition", UDim2.new(tP.X.Scale + 2, tP.X.Offset, tP.Y.Scale, tP.Y.Offset))
            TweenService:Create(UiToggle, TweenInfo.new(0.3), { Position = UDim2.new(tP.X.Scale + 2, tP.X.Offset, tP.Y.Scale, tP.Y.Offset) }):Play()

            local nP = Title:GetAttribute("rPosition")
            Title:SetAttribute("rPosition", UDim2.new(nP.X.Scale - 2, nP.X.Offset, nP.Y.Scale, nP.Y.Offset))
            TweenService:Create(Title, TweenInfo.new(0.75), { Position = UDim2.new(nP.X.Scale - 2, nP.X.Offset, nP.Y.Scale, nP.Y.Offset) }):Play()

            wait(0.75)
        end)()
    end, { UiToggle.MouseButton1Down })


    local exitButtonIn = nil
    bindUiFunctionEvent(function(event)
        exitButtonIn = event
        Exit.ImageColor3 = Color3.fromRGB(200, 67, 70)
        Leaf.ImageColor3 = Color3.fromRGB(4, 200, 0)
    end, { Exit.MouseEnter, Leaf.MouseEnter })

    bindUiFunctionEvent(function(event)
        if exitButtonIn ~= event then
            Exit.ImageColor3 = Color3.fromRGB(255, 67, 70)
            Leaf.ImageColor3 = Color3.fromRGB(4, 255, 0)
        end
    end, { Exit.MouseLeave, Leaf.MouseLeave })

    bindUiFunctionEvent(function()
        MainUI:Destroy()
        isExit = true
    end, { Exit.MouseButton1Down, Leaf.MouseButton1Down })

    Min.Name = "Min"
    Min.Parent = Title
    Min.BackgroundTransparency = 1.000
    Min.Position = UDim2.new(0.0599999987, 0, 0.155000001, 0)
    Min.Size = UDim2.new(0, 20, 0, 20)
    Min.ZIndex = 4
    Min.Image = "rbxassetid://3926307971"
    Min.ImageColor3 = Color3.fromRGB(255, 200, 0)
    Min.ImageRectOffset = Vector2.new(644, 44)
    Min.ImageRectSize = Vector2.new(36, 36)

    bindUiFunctionEvent(function()
        Min.ImageColor3 = Color3.fromRGB(225, 200, 0)
    end, { Min.MouseEnter })

    bindUiFunctionEvent(function()
        Min.ImageColor3 = Color3.fromRGB(255, 200, 0)
    end, { Min.MouseLeave })

    local oldScreenPosition = Title:GetAttribute("rPosition")
    bindUiFunctionEvent(function()
        coroutine.wrap(function()
            isMin = true
            oldScreenPosition = Title:GetAttribute("rPosition")

            local onP = Title.Position
            local nP = Title:GetAttribute("rPosition")
            Title:SetAttribute("rPosition", UDim2.new(nP.X.Scale + 2, onP.X.Offset, onP.Y.Scale, onP.Y.Offset))
            TweenService:Create(Title, TweenInfo.new(0.75), { Position = UDim2.new(nP.X.Scale + 2, 0, 0.325, 0) }):Play()

            local otP = UiToggle.Position
            local tP = UiToggle:GetAttribute("rPosition")
            UiToggle:SetAttribute("rPosition", UDim2.new(tP.X.Scale - 2, otP.X.Offset, otP.Y.Scale, otP.Y.Offset))
            TweenService:Create(UiToggle, TweenInfo.new(0.3), { Position = UDim2.new(tP.X.Scale - 2, otP.X.Offset, otP.Y.Scale, otP.Y.Offset) }):Play()
        end)()
    end, { Min.MouseButton1Down })

    UIS.InputBegan:Connect(function(input, gpe)
        if not isExit and gpe == false and toggleKey ~= nil then
            if input.KeyCode == toggleKey then
                if isMin then
                    local otP = UiToggle.Position
                    local tP = UiToggle:GetAttribute("rPosition")
                    UiToggle:SetAttribute("rPosition", UDim2.new(tP.X.Scale + 2, otP.X.Offset, otP.Y.Scale, otP.Y.Offset))
                    TweenService:Create(UiToggle, TweenInfo.new(0.3), { Position = UDim2.new(tP.X.Scale + 2, otP.X.Offset, otP.Y.Scale, otP.Y.Offset) }):Play()

                    Title:SetAttribute("rPosition", oldScreenPosition)
                    TweenService:Create(Title, TweenInfo.new(0.75), { Position = oldScreenPosition }):Play()
                else
                    oldScreenPosition = Title:GetAttribute("rPosition")

                    local onP = Title.Position
                    local nP = Title:GetAttribute("rPosition")
                    Title:SetAttribute("rPosition", UDim2.new(nP.X.Scale + 2, onP.X.Offset, onP.Y.Scale, onP.Y.Offset))
                    TweenService:Create(Title, TweenInfo.new(0.75), { Position = UDim2.new(nP.X.Scale + 2, 0, 0.325, 0) }):Play()

                    local otP = UiToggle.Position
                    local tP = UiToggle:GetAttribute("rPosition")
                    UiToggle:SetAttribute("rPosition", UDim2.new(tP.X.Scale - 2, otP.X.Offset, otP.Y.Scale, otP.Y.Offset))
                    TweenService:Create(UiToggle, TweenInfo.new(0.3), { Position = UDim2.new(tP.X.Scale - 2, otP.X.Offset, otP.Y.Scale, otP.Y.Offset) }):Play()
                end

                isMin = not isMin
            end
        end
    end)

    BGFIX.Name = "BGFIX"
    BGFIX.Parent = Title
    BGFIX.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    BGFIX.BorderSizePixel = 0
    BGFIX.Position = UDim2.new(0.296951264, 0, 0.955149651, 0)
    BGFIX.Size = UDim2.new(0, 358, 0, 326)

    TitleText.Name = "TitleText"
    TitleText.Parent = Title
    TitleText.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    TitleText.BackgroundTransparency = 1.000
    TitleText.BorderColor3 = Color3.fromRGB(27, 42, 53)
    TitleText.Position = UDim2.new(0.102003641, 0, 0, 0)
    TitleText.Size = UDim2.new(0, 493, 0, 29)
    TitleText.ZIndex = 4
    TitleText.Font = Enum.Font.SourceSansItalic
    TitleText.Text = ""
    TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleText.TextSize = 15.000

    Title_UiCorner.CornerRadius = UDim.new(0, 4)
    Title_UiCorner.Name = "Title_UiCorner"
    Title_UiCorner.Parent = Title

    Side.Name = "Side"
    Side.Parent = Title
    Side.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Side.BackgroundTransparency = 0.200
    Side.BorderSizePixel = 0
    Side.Position = UDim2.new(-5.62369823e-05, 0, 0.62068969, 0)
    Side.Size = UDim2.new(0, 174, 0, 336)
    Side.ZIndex = 0

    Side_UiCorner.CornerRadius = UDim.new(0, 5)
    Side_UiCorner.Name = "Side_UiCorner"
    Side_UiCorner.Parent = Side

    RealSide.Name = "RealSide"
    RealSide.Parent = Side
    RealSide.Active = true
    RealSide.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    RealSide.BackgroundTransparency = 1.000
    RealSide.BorderSizePixel = 0
    RealSide.Position = UDim2.new(0.0574712642, 0, 0.0595238097, 0)
    RealSide.Size = UDim2.new(0, 145, 0, 306)
    RealSide.CanvasSize = UDim2.new(0, 0, 0, 0)
    RealSide.ScrollBarThickness = 3

    Side_UiListLayout.Name = "Side_UiListLayout"
    Side_UiListLayout.Parent = RealSide
    Side_UiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    Side_UiListLayout.Padding = UDim.new(0, 3)

    local bigCategorys = {}

    function bigCategorys:SetTitle(_titleText)
        TitleText.Text = tostring(_titleText)
    end

    function bigCategorys:SetUiToggleKey(_key)
        toggleKey = _key
    end

    local miniCategoryButtons = {}
    local nowContanerYPosition = 16 -- 1 contaner plus 334

    function UpdateSideSize()
        local Size = -3

        for i,v in pairs(RealSide:GetChildren()) do
            if v:IsA("TextButton") then
                Size = Size + v.Size.Y.Offset + 3
            end
        end

        TweenService:Create(RealSide, TweenInfo.new(0.1), { CanvasSize = UDim2.new(0, 0, 0, math.max(Size, 0)) }):Play()
    end

    function bigCategorys:CreateBigCategory(_bigCategoryName, _IconImageId)
        local BigCategory = Instance.new("TextButton")
        local BigCategory_Text = Instance.new("TextButton")
        local BigCategory_Icon = Instance.new("ImageButton")
        local BigCategory_Arrow = Instance.new("ImageButton")
        local BigCategoryContaner = Instance.new("Frame")

        BigCategory.Name = "BigCategory"
        BigCategory.Parent = RealSide
        BigCategory.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        BigCategory.BackgroundTransparency = 1.000
        BigCategory.BorderSizePixel = 0
        BigCategory.ClipsDescendants = true
        BigCategory.Size = UDim2.new(0, 142, 0, 30)
        BigCategory.AutoButtonColor = false
        BigCategory.Font = Enum.Font.SourceSans
        BigCategory.Text = ""
        BigCategory.TextColor3 = Color3.fromRGB(0, 0, 0)
        BigCategory.TextSize = 14.000

        BigCategory_Text.Name = "BigCategory_Text"
        BigCategory_Text.Parent = BigCategory
        BigCategory_Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        BigCategory_Text.BackgroundTransparency = 1.000
        BigCategory_Text.BorderSizePixel = 0
        BigCategory_Text.Position = UDim2.new(0.330985904, 0, 0, 0)
        BigCategory_Text.Size = UDim2.new(0, 75, 0, 30)
        BigCategory_Text.AutoButtonColor = false
        BigCategory_Text.Font = Enum.Font.Nunito
        BigCategory_Text.Text = " "..tostring(_bigCategoryName)
        BigCategory_Text.TextColor3 = Color3.fromRGB(170, 170, 170)
        BigCategory_Text.TextSize = 18.000
        BigCategory_Text.TextXAlignment = Enum.TextXAlignment.Left

        if _IconImageId ~= nil then
            BigCategory_Icon.Name = "BigCategory_Icon"
            BigCategory_Icon.Parent = BigCategory
            BigCategory_Icon.BackgroundTransparency = 1.000
            BigCategory_Icon.LayoutOrder = 14
            BigCategory_Icon.Position = UDim2.new(0, 27, 0, 5)
            BigCategory_Icon.Size = UDim2.new(0, 20, 0, 20)
            BigCategory_Icon.ZIndex = 2
            BigCategory_Icon.Image = "rbxassetid://3926305904"
            BigCategory_Icon.ImageRectOffset = Vector2.new(924, 684)
            BigCategory_Icon.ImageRectSize = Vector2.new(36, 36)
        end

        BigCategory_Arrow.Name = "BigCategory_Arrow"
        BigCategory_Arrow.Parent = BigCategory
        BigCategory_Arrow.BackgroundTransparency = 1.000
        BigCategory_Arrow.LayoutOrder = 11
        BigCategory_Arrow.Position = UDim2.new(0, 0, 0, 2)
        BigCategory_Arrow.Size = UDim2.new(0, 25, 0, 25)
        BigCategory_Arrow.ZIndex = 2
        BigCategory_Arrow.Image = "rbxassetid://3926305904"
        BigCategory_Arrow.ImageColor3 = Color3.fromRGB(170, 170, 170)
        BigCategory_Arrow.ImageRectOffset = Vector2.new(924, 884)
        BigCategory_Arrow.ImageRectSize = Vector2.new(36, 36)

        BigCategoryContaner.Name = "BigCategoryContaner"
        BigCategoryContaner.Parent = BigCategory
        BigCategoryContaner.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        BigCategoryContaner.BackgroundTransparency = 1.000
        BigCategoryContaner.BorderSizePixel = 0
        BigCategoryContaner.Position = UDim2.new(0, 26, 0, 30)
        BigCategoryContaner.Size = UDim2.new(0, 113, 0, 0)
        BigCategoryContaner.AutomaticSize = Enum.AutomaticSize.Y

        local isOpend = false
        bindUiFunctionEvent(function()
            isOpend = not isOpend

            if isOpend then
                --== Color ==--
                TweenService:Create(BigCategory_Text, TweenInfo.new(0.25), { TextColor3 = Color3.fromRGB(255, 255, 255) }):Play()
                TweenService:Create(BigCategory_Arrow, TweenInfo.new(0.25), { ImageColor3 = Color3.fromRGB(255, 255, 255) }):Play()
                if _IconImageId ~= nil then
                    TweenService:Create(BigCategory_Icon, TweenInfo.new(0.25), { ImageColor3 = Color3.fromRGB(255, 255, 255) }):Play()
                end

                --== Rotation ==--
                TweenService:Create(BigCategory_Arrow, TweenInfo.new(0.25), { Rotation = 90 }):Play()

                --== Size ==--
                if #BigCategoryContaner:GetChildren() > 0 then
                    TweenService:Create(BigCategory, TweenInfo.new(0.25), { Size = UDim2.new(0, 142, 0, 30 + 8 + BigCategoryContaner.Size.Y.Offset) }):Play()
                end
            else
                --== Color ==--
                TweenService:Create(BigCategory_Text, TweenInfo.new(0.25), { TextColor3 = Color3.fromRGB(170, 170, 170) }):Play()
                TweenService:Create(BigCategory_Arrow, TweenInfo.new(0.25), { ImageColor3 = Color3.fromRGB(170, 170, 170) }):Play()
                if _IconImageId ~= nil then
                    TweenService:Create(BigCategory_Icon, TweenInfo.new(0.25), { ImageColor3 = Color3.fromRGB(170, 170, 170) }):Play()
                end

                --== Rotation ==--
                TweenService:Create(BigCategory_Arrow, TweenInfo.new(0.25), { Rotation = 0 }):Play()

                --== Size ==--
                TweenService:Create(BigCategory, TweenInfo.new(0.25), { Size = UDim2.new(0, 142, 0, 30) }):Play()
            end

            for i = 1, 250 do
                UpdateSideSize()
                wait(0.001)
            end
        end, { BigCategory_Arrow.MouseButton1Down })
        
        local selectedMini
        local miniCategorys = {}
        local nowMiniYPosition = 0

        function miniCategorys:CreateMiniCategory(_miniCategoryName)
            local dSV = BigCategoryContaner.Size
            BigCategoryContaner.Size = UDim2.new(dSV.X.Scale, dSV.X.Offset, dSV.Y.Scale, dSV.Y.Offset + 20)

            local MiniCategory = Instance.new("TextButton") -- y pading 4
            local Contaner_UiList = Instance.new("UIListLayout")
            local Contaner = Instance.new("ScrollingFrame")

            Contaner.Name = "Contaner"
            Contaner.Parent = Main
            Contaner.Active = true
            Contaner.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Contaner.BackgroundTransparency = 1.000
            Contaner.BorderSizePixel = 0
            Contaner.Position = UDim2.new(0, -1, 0, nowContanerYPosition)
            Contaner.Size = UDim2.new(0, 369, 0, 311)
            Contaner.ZIndex = 2
            Contaner.ClipsDescendants = true
            Contaner.CanvasSize = UDim2.new(0, 0, 0, 0)
            Contaner.ScrollBarThickness = 5
            Contaner:SetAttribute("rPosition", Contaner.Position)

            nowContanerYPosition = nowContanerYPosition + 334

            Contaner_UiList.Name = "Contaner_UiList"
            Contaner_UiList.Parent = Contaner
            Contaner_UiList.SortOrder = Enum.SortOrder.LayoutOrder
            Contaner_UiList.Padding = UDim.new(0, 0)

            MiniCategory.Name = "MiniCategory"
            MiniCategory.Parent = BigCategoryContaner
            MiniCategory.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            MiniCategory.BackgroundTransparency = 1.000
            MiniCategory.BorderSizePixel = 0
            MiniCategory.Position = UDim2.new(0.0707964599, 0, 0, nowMiniYPosition)
            MiniCategory.Size = UDim2.new(0, 104, 0, 20)
            MiniCategory.AutoButtonColor = false
            MiniCategory.Font = Enum.Font.GothamSemibold
            MiniCategory.Text = _miniCategoryName
            MiniCategory.TextColor3 = Color3.fromRGB(170, 170, 170)
            MiniCategory.TextSize = 13.000
            MiniCategory.TextXAlignment = Enum.TextXAlignment.Left
            if Contaner:GetAttribute("rPosition") == UDim2.new(0, -1, 0, 16) then
                MiniCategory.TextColor3 = Color3.fromRGB(255, 255, 255)
            end

            table.insert(miniCategoryButtons, MiniCategory)

            nowMiniYPosition = nowMiniYPosition + 20

            bindUiFunctionEvent(function()
                coroutine.wrap(function()
                    for _,mincat in pairs(miniCategoryButtons) do
                        TweenService:Create(mincat, TweenInfo.new(0.25), { TextColor3 = Color3.fromRGB(170, 170, 170) }):Play()
                    end
                    TweenService:Create(MiniCategory, TweenInfo.new(0.25), { TextColor3 = Color3.fromRGB(255, 255, 255) }):Play()
                end)()

                local oldPos = Contaner:GetAttribute("rPosition")
                local plusPos = 16 - oldPos.Y.Offset
                Contaner:SetAttribute("rPosition", UDim2.new(oldPos.X.Scale, oldPos.X.Offset, oldPos.Y.Scale, oldPos.Y.Offset + plusPos))
                TweenService:Create(Contaner, TweenInfo.new(0.25), { Position = Contaner:GetAttribute("rPosition") }):Play()

                for i,v in pairs(Main:GetChildren()) do
                    if v ~= Contaner and v.Name == "Contaner" then
                        oldPos = v:GetAttribute("rPosition")
                        v:SetAttribute("rPosition", UDim2.new(oldPos.X.Scale, oldPos.X.Offset, oldPos.Y.Scale, oldPos.Y.Offset + plusPos))
                        TweenService:Create(v, TweenInfo.new(0.25), { Position = v:GetAttribute("rPosition") }):Play()
                    end
                end
            end, { MiniCategory.MouseButton1Down })

            local contanerItems = {}

            local function getDistance(a, b)
                return math.sqrt(((b.X - a.X) ^ 2) + ((b.Y - a.X) ^ 2))
            end

            function contanerItems:UpdateSize()
                local size = 0
                for i,v in pairs(Contaner:GetChildren()) do
                    if v:IsA("Frame") then
                        size = size + v.Size.Y.Offset
                    end
                end
                if size > 4 then
                    size = size - 4
                end

                Contaner.CanvasSize = UDim2.new(0, 0, 0, size)
            end

            function contanerItems:GetContaner()
                return Contaner
            end

            local function UpdateSize()
                local size = 0
                for i,v in pairs(Contaner:GetChildren()) do
                    if v:IsA("Frame") then
                        size = size + v.Size.Y.Offset
                    end
                end
                if size > 4 then
                    size = size - 4
                end

                Contaner.CanvasSize = UDim2.new(0, 0, 0, size)
            end

            function contanerItems:CreateButton(_buttonName, _buttonCallback)
                local ButtonFrame = Instance.new("Frame")
                local Button = Instance.new("TextButton")
                local Button_UiCorner = Instance.new("UICorner")

                ButtonFrame.Name = "ButtonFrame"
                ButtonFrame.Parent = Contaner
                ButtonFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ButtonFrame.BackgroundTransparency = 1.000
                ButtonFrame.Size = UDim2.new(0, 363, 0, 34)
                ButtonFrame.ZIndex = 3

                Button.Name = "Button"
                Button.Parent = ButtonFrame
                Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                Button.ClipsDescendants = true
                Button.Size = UDim2.new(0, 365, 0, 30)
                Button.ZIndex = 3
                Button.AutoButtonColor = false
                Button.Text = _buttonName
                Button.Font = Enum.Font.GothamSemibold
                Button.TextColor3 = Color3.fromRGB(215, 215, 215)
                Button.TextSize = 12.000

                Button_UiCorner.CornerRadius = UDim.new(0, 5)
                Button_UiCorner.Name = "Button_UiCorner"
                Button_UiCorner.Parent = Button

                bindUiFunctionEvent(function()
                    TweenService:Create(Button, TweenInfo.new(0.1), { TextColor3 = Color3.fromRGB(255, 255, 255) }):Play()
                end, { Button.MouseEnter })

                bindUiFunctionEvent(function()
                    TweenService:Create(Button, TweenInfo.new(0.1), { TextColor3 = Color3.fromRGB(215, 215, 215) }):Play()
                end, { Button.MouseLeave })

                local function buttonClickEvent(event)
                    event = event or {}
                    
                    if inList({ Button.MouseButton1Down }, event) then
                        coroutine.wrap(function()
                            local mouseAbsolutePosition = Vector2.new(mouse.X, mouse.Y)
                            local mouseRelativePosition = mouseAbsolutePosition - Button.AbsolutePosition

                            local Button_RippleCircle = Instance.new("ImageLabel")

                            Button_RippleCircle.Name = "Ripple"
                            Button_RippleCircle.AnchorPoint = Vector2.new(0.5, 0.5)
                            Button_RippleCircle.Parent = Button
                            Button_RippleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            Button_RippleCircle.BackgroundTransparency = 1.000
                            Button_RippleCircle.BorderSizePixel = 0
                            Button_RippleCircle.ZIndex = 5
                            Button_RippleCircle.Image = "http://www.roblox.com/asset/?id=4560909609"
                            Button_RippleCircle.ImageTransparency = 0.8
                            Button_RippleCircle.Position = UDim2.new(0, mouseRelativePosition.X, 0, mouseRelativePosition.Y)

                            local tl = getDistance(mouseRelativePosition, Vector2.new(0, 0))
                            local tr = getDistance(mouseRelativePosition, Vector2.new(Button.AbsoluteSize.X, 0))
                            local br = getDistance(mouseRelativePosition, Button.AbsoluteSize)
                            local bl = getDistance(mouseRelativePosition, Vector2.new(0, Button.AbsoluteSize.Y))

                            local size = math.max(tl, tr, br, bl) * 2

                            local speed = 0.5

                            TweenService:Create(
                                Button_RippleCircle,
                                TweenInfo.new( speed ),
                                { Size = UDim2.new(0, size, 0, size) }
                            ):Play()

                            TweenService:Create(
                                Button_RippleCircle,
                                TweenInfo.new( speed ),
                                { ImageTransparency = 1 }
                            ):Play()

                            wait(speed)
                            Button_RippleCircle:Destroy()
                        end)()
                    end

                    pcall(_buttonCallback)
                end

                bindUiFunctionEvent(buttonClickEvent, { Button.MouseButton1Down })

                UpdateSize()
                
                local buttonFunctions = {}
                function buttonFunctions:GetUI()
                    return ButtonFrame
                end

                return buttonFunctions, buttonClickEvent
            end

            function contanerItems:CreateToggle(_toggleName, _toggleCallback)
                local isEnabled = false

                local ToggleFrame = Instance.new("Frame")
                local Toggle = Instance.new("TextButton")
                local Toggle_UiCorner = Instance.new("UICorner")
                local ToggleSwitch = Instance.new("TextButton")
                local ToggleSwitch_UiCorner = Instance.new("UICorner")
                local ToggleSwitch_Circle = Instance.new("TextButton")
                local ToggleSwitch_Circle_UiCorner = Instance.new("UICorner")

                ToggleFrame.Name = "ToggleFrame"
                ToggleFrame.Parent = Contaner
                ToggleFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToggleFrame.BackgroundTransparency = 1.000
                ToggleFrame.Size = UDim2.new(0, 363, 0, 34)
                ToggleFrame.ZIndex = 3

                Toggle.Name = "Toggle"
                Toggle.Parent = ToggleFrame
                Toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                Toggle.ClipsDescendants = true
                Toggle.Size = UDim2.new(0, 365, 0, 30)
                Toggle.ZIndex = 3
                Toggle.AutoButtonColor = false
                Toggle.Font = Enum.Font.GothamSemibold
                Toggle.Text = _toggleName
                Toggle.TextColor3 = Color3.fromRGB(215, 215, 215)
                Toggle.TextSize = 12.000

                Toggle_UiCorner.CornerRadius = UDim.new(0, 5)
                Toggle_UiCorner.Name = "Toggle_UiCorner"
                Toggle_UiCorner.Parent = Toggle

                ToggleSwitch.Name = "ToggleSwitch"
                ToggleSwitch.Parent = Toggle
                ToggleSwitch.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                ToggleSwitch.Position = UDim2.new(0.85753423, 0, 0.172413796, 0)
                ToggleSwitch.Size = UDim2.new(0, 45, 0, 19)
                ToggleSwitch.ZIndex = 6
                ToggleSwitch.AutoButtonColor = false
                ToggleSwitch.Font = Enum.Font.SourceSans
                ToggleSwitch.Text = ""
                ToggleSwitch.TextColor3 = Color3.fromRGB(0, 0, 0)
                ToggleSwitch.TextSize = 14.000

                ToggleSwitch_UiCorner.CornerRadius = UDim.new(0, 7)
                ToggleSwitch_UiCorner.Name = "ToggleSwitch_UiCorner"
                ToggleSwitch_UiCorner.Parent = ToggleSwitch

                ToggleSwitch_Circle.Name = "ToggleSwitch_Circle"
                ToggleSwitch_Circle.Parent = ToggleSwitch
                ToggleSwitch_Circle.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
                ToggleSwitch_Circle.BorderColor3 = Color3.fromRGB(87, 135, 170)
                ToggleSwitch_Circle.Position = UDim2.new(0, 5, 0, 1)
                ToggleSwitch_Circle.Size = UDim2.new(0, 16, 0, 16)
                ToggleSwitch_Circle.ZIndex = 7
                ToggleSwitch_Circle.AutoButtonColor = false
                ToggleSwitch_Circle.Font = Enum.Font.SourceSans
                ToggleSwitch_Circle.Text = ""
                ToggleSwitch_Circle.TextColor3 = Color3.fromRGB(170, 170, 170)
                ToggleSwitch_Circle.TextSize = 14.000

                ToggleSwitch_Circle_UiCorner.CornerRadius = UDim.new(0, 5)
                ToggleSwitch_Circle_UiCorner.Name = "ToggleSwitch_Circle_UiCorner"
                ToggleSwitch_Circle_UiCorner.Parent = ToggleSwitch_Circle

                bindUiFunctionEvent(function()
                    TweenService:Create(Toggle, TweenInfo.new(0.1), { TextColor3 = Color3.fromRGB(255, 255, 255) }):Play()
                end, { Toggle.MouseEnter })

                bindUiFunctionEvent(function()
                    TweenService:Create(Toggle, TweenInfo.new(0.1), { TextColor3 = Color3.fromRGB(215, 215, 215) }):Play()
                end, { Toggle.MouseLeave })

                local function ToggleClickEvent(event)
                    event = event or {}
                    isEnabled = not isEnabled

                    if isEnabled then
                        TweenService:Create(ToggleSwitch_Circle, TweenInfo.new(0.1), { Position = UDim2.new(0, 25, 0, 1) }):Play()
                        TweenService:Create(ToggleSwitch_Circle, TweenInfo.new(0.1), { BackgroundColor3 = Color3.fromRGB(255, 255, 255) }):Play()
                    else
                        TweenService:Create(ToggleSwitch_Circle, TweenInfo.new(0.1), { Position = UDim2.new(0, 5, 0, 1) }):Play()
                        TweenService:Create(ToggleSwitch_Circle, TweenInfo.new(0.1), { BackgroundColor3 = Color3.fromRGB(120, 120, 120) }):Play()
                    end

                    if inList({ Toggle.MouseButton1Down, ToggleSwitch.MouseButton1Down, ToggleSwitch_Circle.MouseButton1Down }, event) then
                        coroutine.wrap(function()
                            local mouseAbsolutePosition = Vector2.new(mouse.X, mouse.Y)
                            local mouseRelativePosition = mouseAbsolutePosition - Toggle.AbsolutePosition
    
                            local Toggle_RippleCircle = Instance.new("ImageLabel")
    
                            Toggle_RippleCircle.Name = "Ripple"
                            Toggle_RippleCircle.AnchorPoint = Vector2.new(0.5, 0.5)
                            Toggle_RippleCircle.Parent = Toggle
                            Toggle_RippleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            Toggle_RippleCircle.BackgroundTransparency = 1.000
                            Toggle_RippleCircle.BorderSizePixel = 0
                            Toggle_RippleCircle.ZIndex = 5
                            Toggle_RippleCircle.Image = "http://www.roblox.com/asset/?id=4560909609"
                            Toggle_RippleCircle.ImageTransparency = 0.8
                            Toggle_RippleCircle.Position = UDim2.new(0, mouseRelativePosition.X, 0, mouseRelativePosition.Y)
    
                            local tl = getDistance(mouseRelativePosition, Vector2.new(0, 0))
                            local tr = getDistance(mouseRelativePosition, Vector2.new(Toggle.AbsoluteSize.X, 0))
                            local br = getDistance(mouseRelativePosition, Toggle.AbsoluteSize)
                            local bl = getDistance(mouseRelativePosition, Vector2.new(0, Toggle.AbsoluteSize.Y))
    
                            local size = math.max(tl, tr, br, bl) * 2
    
                            local speed = 0.5
    
                            TweenService:Create(
                                Toggle_RippleCircle,
                                TweenInfo.new( speed ),
                                { Size = UDim2.new(0, size, 0, size) }
                            ):Play()
    
                            TweenService:Create(
                                Toggle_RippleCircle,
                                TweenInfo.new( speed ),
                                { ImageTransparency = 1 }
                            ):Play()
    
                            wait(speed)
                            Toggle_RippleCircle:Destroy()
                        end)()
                    end

                    pcall(_toggleCallback, isEnabled)
                end

                bindUiFunctionEvent(ToggleClickEvent, { Toggle.MouseButton1Down, ToggleSwitch.MouseButton1Down, ToggleSwitch_Circle.MouseButton1Down })
                
                UpdateSize()

                local toggleFunctions = {}
                function toggleFunctions:GetUI()
                    return ToggleFrame
                end
                function toggleFunctions:GetStatus()
                    return isEnabled
                end
                function toggleFunctions:SetStatus(Args)
                    isEnabled = Args

                    if isEnabled then
                        TweenService:Create(ToggleSwitch_Circle, TweenInfo.new(0.1), { Position = UDim2.new(0, 25, 0, 1) }):Play()
                        TweenService:Create(ToggleSwitch_Circle, TweenInfo.new(0.1), { BackgroundColor3 = Color3.fromRGB(255, 255, 255) }):Play()
                    else
                        TweenService:Create(ToggleSwitch_Circle, TweenInfo.new(0.1), { Position = UDim2.new(0, 5, 0, 1) }):Play()
                        TweenService:Create(ToggleSwitch_Circle, TweenInfo.new(0.1), { BackgroundColor3 = Color3.fromRGB(120, 120, 120) }):Play()
                    end
                end
                return toggleFunctions, ToggleClickEvent
            end

            function contanerItems:CreateTextbox(_TextboxTitle, _TextboxCallback, _TextboxLiveCallback)
                _TextboxLiveCallback = _TextboxLiveCallback or function () end

                local TextBoxFrame = Instance.new("Frame")
                local TextBox_Background = Instance.new("Frame")
                local TextBox = Instance.new("TextBox")
                local TextBox_RippleCircle = Instance.new("ImageLabel")
                local TextBox_UiCorner = Instance.new("UICorner")
                local TextBox_Title = Instance.new("TextButton")

                TextBoxFrame.Name = "TextBoxFrame"
                TextBoxFrame.Parent = Contaner
                TextBoxFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextBoxFrame.BackgroundTransparency = 1.000
                TextBoxFrame.Size = UDim2.new(0, 363, 0, 44)
                TextBoxFrame.ZIndex = 3

                TextBox_Background.Name = "TextBox_Background"
                TextBox_Background.Parent = TextBoxFrame
                TextBox_Background.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                TextBox_Background.BorderSizePixel = 0
                TextBox_Background.Size = UDim2.new(0, 365, 0, 40)
                TextBox_Background.ZIndex = 3

                TextBox.Parent = TextBox_Background
                TextBox.AnchorPoint = Vector2.new(0, 1)
                TextBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                TextBox.BackgroundTransparency = 1.000
                TextBox.BorderSizePixel = 0
                TextBox.Position = UDim2.new(0, 23, 0, 40)
                TextBox.Size = UDim2.new(0, 345, 0, 27)
                TextBox.ZIndex = 5
                TextBox.ClearTextOnFocus = false
                TextBox.Font = Enum.Font.SourceSans
                TextBox.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
                TextBox.Text = "Text"
                TextBox.TextColor3 = Color3.fromRGB(190, 190, 190)
                TextBox.TextSize = 14.000
                TextBox.TextWrapped = true
                TextBox.TextXAlignment = Enum.TextXAlignment.Left

                TextBox_RippleCircle.Name = "TextBox_RippleCircle"
                TextBox_RippleCircle.Parent = TextBox_Background
                TextBox_RippleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextBox_RippleCircle.BackgroundTransparency = 1.000
                TextBox_RippleCircle.BorderSizePixel = 0
                TextBox_RippleCircle.ZIndex = 5
                TextBox_RippleCircle.Image = "http://www.roblox.com/asset/?id=4560909609"
                TextBox_RippleCircle.ImageTransparency = 0.300

                TextBox_UiCorner.CornerRadius = UDim.new(0, 5)
                TextBox_UiCorner.Name = "TextBox_UiCorner"
                TextBox_UiCorner.Parent = TextBox_Background

                TextBox_Title.Name = "TextBox_Title"
                TextBox_Title.Parent = TextBox_Background
                TextBox_Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextBox_Title.BackgroundTransparency = 1.000
                TextBox_Title.Position = UDim2.new(0, 15, 0, 4)
                TextBox_Title.Size = UDim2.new(0, 347, 0, 20)
                TextBox_Title.ZIndex = 4
                TextBox_Title.AutoButtonColor = false
                TextBox_Title.Font = Enum.Font.GothamSemibold
                TextBox_Title.Text = _TextboxTitle
                TextBox_Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextBox_Title.TextSize = 13.000
                TextBox_Title.TextXAlignment = Enum.TextXAlignment.Left

                local nowTyping = false
                bindUiFunctionEvent(function()
                    if not nowTyping then
                        TweenService:Create(TextBox, TweenInfo.new(0.2), { TextColor3 = Color3.fromRGB(230, 230, 230) }):Play()
                    end
                end, { TextBox.MouseEnter })

                bindUiFunctionEvent(function()
                    if not nowTyping then
                        TweenService:Create(TextBox, TweenInfo.new(0.15), { TextColor3 = Color3.fromRGB(190, 190, 190) }):Play()
                    end
                end, { TextBox.MouseLeave })

                bindUiFunctionEvent(function()
                    nowTyping = true
                    TweenService:Create(TextBox, TweenInfo.new(0.15), { TextColor3 = Color3.fromRGB(230, 230, 230) }):Play()
                    TweenService:Create(TextBox_Title, TweenInfo.new(0.125), { TextTransparency = 1 }):Play()
                    TweenService:Create(TextBox, TweenInfo.new(0.15), { Size = UDim2.new(0, 345, 0, 40) }):Play()
                    TweenService:Create(TextBox, TweenInfo.new(0.15), { TextSize = 17 }):Play()
                end, { TextBox.Focused })

                bindUiFunctionEvent(function()
                    nowTyping = false
                    TweenService:Create(TextBox, TweenInfo.new(0.15), { TextColor3 = Color3.fromRGB(190, 190, 190) }):Play()
                    TweenService:Create(TextBox, TweenInfo.new(0.15), { Size = UDim2.new(0, 345, 0, 27) }):Play()
                    TweenService:Create(TextBox, TweenInfo.new(0.15), { TextSize = 14 }):Play()
                    TweenService:Create(TextBox_Title, TweenInfo.new(0.25), { TextTransparency = 0 }):Play()

                    pcall(_TextboxCallback, TextBox.Text)
                end, { TextBox.FocusLost })

                bindUiFunctionEvent(function(event, property)
                    if property == "Text" then
                        pcall(_TextboxLiveCallback)
                    end
                end, { TextBox.Changed })

                UpdateSize()

                local textboxFunctions = {}
                function textboxFunctions:GetUI()
                    return TextBoxFrame
                end
                return textboxFunctions
            end

            function contanerItems:CreateDropdown(_DropdownName, _DropdownMultiSelect, _DropdownCallback)
                _DropdownCallback = _DropdownCallback or nil

                local dropdownIsOpend = false

                local DropdownFrame = Instance.new("Frame")
                local Dropdown_Background = Instance.new("Frame")
                local Dropdown = Instance.new("TextButton")
                local Dropdown_UiCorner = Instance.new("UICorner")
                local Dropdown_Arrow = Instance.new("ImageButton")
                local Dropdown_Background_UiCorner = Instance.new("UICorner")
                local Dropdown_Contaner = Instance.new("ScrollingFrame")
                local Dropdown_Contaner_UiList = Instance.new("UIListLayout")

                DropdownFrame.Name = "DropdownFrame"
                DropdownFrame.Parent = Contaner
                DropdownFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownFrame.BackgroundTransparency = 1.000
                DropdownFrame.Size = UDim2.new(0, 363, 0, 34)
                DropdownFrame.ZIndex = 3

                Dropdown_Background.Name = "Dropdown_Background"
                Dropdown_Background.Parent = DropdownFrame
                Dropdown_Background.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
                Dropdown_Background.BorderSizePixel = 0
                Dropdown_Background.Size = UDim2.new(0, 365, 0, 30)
                Dropdown_Background.ZIndex = 2
                Dropdown_Background.ClipsDescendants = true

                Dropdown.Name = "Dropdown"
                Dropdown.Parent = Dropdown_Background
                Dropdown.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                Dropdown.ClipsDescendants = true
                Dropdown.Size = UDim2.new(0, 365, 0, 30)
                Dropdown.ZIndex = 3
                Dropdown.AutoButtonColor = false
                Dropdown.Font = Enum.Font.SourceSans
                Dropdown.Text = _DropdownName
                Dropdown.TextColor3 = Color3.fromRGB(190, 190, 190)
                Dropdown.TextSize = 14.000

                Dropdown_UiCorner.CornerRadius = UDim.new(0, 5)
                Dropdown_UiCorner.Name = "Dropdown_UiCorner"
                Dropdown_UiCorner.Parent = Dropdown

                Dropdown_Arrow.Name = "Dropdown_Arrow"
                Dropdown_Arrow.Parent = Dropdown
                Dropdown_Arrow.BackgroundTransparency = 1.000
                Dropdown_Arrow.Position = UDim2.new(0, 336, 0, 3)
                Dropdown_Arrow.Rotation = 0
                Dropdown_Arrow.Size = UDim2.new(0, 25, 0, 25)
                Dropdown_Arrow.ZIndex = 4
                Dropdown_Arrow.Image = "rbxassetid://3926305904"
                Dropdown_Arrow.ImageColor3 = Color3.fromRGB(190, 190, 190)
                Dropdown_Arrow.ImageRectOffset = Vector2.new(124, 924)
                Dropdown_Arrow.ImageRectSize = Vector2.new(36, 36)

                Dropdown_Background_UiCorner.Name = "Dropdown_UiCorner"
                Dropdown_Background_UiCorner.Parent = Dropdown_Background
                Dropdown_Background_UiCorner.CornerRadius = UDim.new(0, 5)

                Dropdown_Contaner.Name = "Dropdown_Contaner"
                Dropdown_Contaner.Parent = Dropdown_Background
                Dropdown_Contaner.Active = true
                Dropdown_Contaner.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Dropdown_Contaner.BackgroundTransparency = 1.000
                Dropdown_Contaner.BorderSizePixel = 0
                Dropdown_Contaner.Position = UDim2.new(0, 7, 0, 37)
                Dropdown_Contaner.Size = UDim2.new(0, 354, 0, 103)
                Dropdown_Contaner.ZIndex = 4
                Dropdown_Contaner.ScrollBarThickness = 4
                Dropdown_Contaner.CanvasSize = UDim2.new(0, 0, 0, 0)
                Dropdown_Contaner.ClipsDescendants = true

                Dropdown_Contaner_UiList.Name = "Dropdown_Contaner_UiList"
                Dropdown_Contaner_UiList.Parent = Dropdown_Contaner
                Dropdown_Contaner_UiList.SortOrder = Enum.SortOrder.LayoutOrder
                Dropdown_Contaner_UiList.Padding = UDim.new(0, 5)

                local Dropdown_Contaner_Size = 0

                local function dropdownUpdateSize()
                    local size = 0
                    for i,v in pairs(Dropdown_Contaner:GetChildren()) do
                        if v:IsA("TextButton") then
                            size = size + v.Size.Y.Offset + 5
                        end
                    end
                    if size > 5 then
                        size = size - 5
                    end

                    if size > 146 then
                        Dropdown_Contaner.CanvasSize = UDim2.new(0, 0, 0, size)

                        for i,v in pairs(Dropdown_Contaner:GetChildren()) do
                            if v:IsA("TextButton") then
                                local vos = v.Size -- v oldSize
                                v.Size = UDim2.new(vos.X.Scale, 341, vos.Y.Scale, math.clamp(vos.Y.Offset, 0, 120))
                            end
                        end
                    else
                        local os = Dropdown_Contaner.Size -- oldsize

                        local Dropdown_Contaner_Size_Clone = (function() return Dropdown_Contaner_Size end)()
                        if Dropdown_Contaner_Size_Clone >= 5 then
                            Dropdown_Contaner_Size_Clone = Dropdown_Contaner_Size_Clone - 5
                        end
                        Dropdown_Contaner.Size = UDim2.new(os.X.Scale, os.X.Offset, os.Y.Scale, Dropdown_Contaner_Size_Clone)

                        for i,v in pairs(Dropdown_Contaner:GetChildren()) do
                            if v:IsA("TextButton") then
                                local vos = v.Size -- v oldSize
                                v.Size = UDim2.new(vos.X.Scale, 351, vos.Y.Scale, vos.Y.Offset)
                            end
                        end
                    end
                end

                local function getDropdownContSize()
                    local Dropdown_Contaner_Size_Clone = (function() return Dropdown_Contaner_Size end)()
                    if Dropdown_Contaner_Size_Clone >= 5 then
                        Dropdown_Contaner_Size_Clone = Dropdown_Contaner_Size_Clone - 5
                    end
                    return Dropdown_Contaner_Size_Clone
                end

                bindUiFunctionEvent(function()
                    if not dropdownIsOpend then
                        TweenService:Create(Dropdown, TweenInfo.new(0.2), { TextColor3 = Color3.fromRGB(230, 230, 230) }):Play()
                        TweenService:Create(Dropdown_Arrow, TweenInfo.new(0.2), { ImageColor3 = Color3.fromRGB(230, 230, 230) }):Play()
                    end
                end, { Dropdown.MouseEnter })

                bindUiFunctionEvent(function()
                    if not dropdownIsOpend then
                        TweenService:Create(Dropdown, TweenInfo.new(0.2), { TextColor3 = Color3.fromRGB(190, 190, 190) }):Play()
                        TweenService:Create(Dropdown_Arrow, TweenInfo.new(0.2), { ImageColor3 = Color3.fromRGB(190, 190, 190) }):Play()
                    end
                end, { Dropdown.MouseLeave })

                bindUiFunctionEvent(function()
                    dropdownIsOpend = not dropdownIsOpend

                    if dropdownIsOpend then
                        -- opening
                        TweenService:Create(Dropdown, TweenInfo.new(0.2), { TextColor3 = Color3.fromRGB(255, 255, 255) }):Play()
                        TweenService:Create(Dropdown_Arrow, TweenInfo.new(0.2), { ImageColor3 = Color3.fromRGB(255, 255, 255) }):Play()

                        TweenService:Create(DropdownFrame, TweenInfo.new(0.2), { Size = UDim2.new(0, 365, 0, getDropdownContSize() + 47) }):Play()
                        TweenService:Create(Dropdown_Background, TweenInfo.new(0.2), { Size = UDim2.new(0, 365, 0, math.clamp(getDropdownContSize() + 44, 0, 163)) }):Play()

                        TweenService:Create(Dropdown_Arrow, TweenInfo.new(0.2), { Rotation = -90 }):Play()
                    else
                        -- closing
                        TweenService:Create(Dropdown, TweenInfo.new(0.2), { TextColor3 = Color3.fromRGB(190, 190, 190) }):Play()
                        TweenService:Create(Dropdown_Arrow, TweenInfo.new(0.2), { ImageColor3 = Color3.fromRGB(190, 190, 190) }):Play()

                        TweenService:Create(DropdownFrame, TweenInfo.new(0.2), { Size = UDim2.new(0, 365, 0, 34) }):Play()
                        TweenService:Create(Dropdown_Background, TweenInfo.new(0.2), { Size = UDim2.new(0, 365, 0, 30) }):Play()

                        TweenService:Create(Dropdown_Arrow, TweenInfo.new(0.2), { Rotation = 0 }):Play()
                    end

                    coroutine.wrap(function()
                        for i = 1, 230 do
                            UpdateSize()
                            wait(0.001)
                        end
                        dropdownUpdateSize()
                    end)()
                end, { Dropdown_Arrow.MouseButton1Down, Dropdown.MouseButton1Down })

                local dropdownContanerItem = {}
                function dropdownContanerItem:CreateButton(_ButtonName, _ButtonCallback)
                    _ButtonCallback = _ButtonCallback or nil
                    Dropdown_Contaner_Size = math.clamp(Dropdown_Contaner_Size + 25 + 5, 0, 103)

                    local Dropdown_Button = Instance.new("TextButton")
                    local Dropdown_Button_UiCorner = Instance.new("UICorner")
                    local Dropdown_Button_Text = Instance.new("TextButton")

                    Dropdown_Button.Name = _ButtonName
                    Dropdown_Button.Parent = Dropdown_Contaner
                    Dropdown_Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    Dropdown_Button.ClipsDescendants = true
                    Dropdown_Button.Position = UDim2.new(0, 0, 2.96287169e-07, 0)
                    Dropdown_Button.Size = UDim2.new(0, 341, 0, 25)
                    Dropdown_Button.ZIndex = 3
                    Dropdown_Button.AutoButtonColor = false
                    Dropdown_Button.Font = Enum.Font.SourceSans
                    Dropdown_Button.Text = ""
                    Dropdown_Button.TextColor3 = Color3.fromRGB(225, 225, 225)
                    Dropdown_Button.TextSize = 14.000
                    Dropdown_Button:SetAttribute("Enabled", false)

                    Dropdown_Button_UiCorner.CornerRadius = UDim.new(0, 3)
                    Dropdown_Button_UiCorner.Name = "Dropdown_Button_UiCorner"
                    Dropdown_Button_UiCorner.Parent = Dropdown_Button

                    Dropdown_Button_Text.Name = "Dropdown_Button_Text"
                    Dropdown_Button_Text.Parent = Dropdown_Button
                    Dropdown_Button_Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Dropdown_Button_Text.BackgroundTransparency = 1.000
                    Dropdown_Button_Text.Position = UDim2.new(0.0287222452, 0, 0, 0)
                    Dropdown_Button_Text.Size = UDim2.new(0, 342, 0, 25)
                    Dropdown_Button_Text.ZIndex = 4
                    Dropdown_Button_Text.Text = _ButtonName
                    Dropdown_Button_Text.Font = Enum.Font.Nunito
                    Dropdown_Button_Text.TextColor3 = Color3.fromRGB(190, 190, 190)
                    Dropdown_Button_Text.TextSize = 16.000
                    Dropdown_Button_Text.TextXAlignment = Enum.TextXAlignment.Left

                    bindUiFunctionEvent(function()
                        if Dropdown_Button:GetAttribute("Enabled") == false then
                            TweenService:Create(Dropdown_Button_Text, TweenInfo.new(0.2), { TextColor3 = Color3.fromRGB(210, 210, 210) }):Play()
                        end
                    end, { Dropdown_Button.MouseEnter })

                    bindUiFunctionEvent(function()
                        if Dropdown_Button:GetAttribute("Enabled") == false then
                            TweenService:Create(Dropdown_Button_Text, TweenInfo.new(0.2), { TextColor3 = Color3.fromRGB(190, 190, 190) }):Play()
                        end
                    end, { Dropdown_Button.MouseLeave })

                    bindUiFunctionEvent(function()
                        if _DropdownMultiSelect then
                            if Dropdown_Button:GetAttribute("Enabled") then
                                Dropdown_Button:SetAttribute("Enabled", false)
                                TweenService:Create(Dropdown_Button_Text, TweenInfo.new(0.2), { TextColor3 = Color3.fromRGB(190, 190, 190) }):Play()
                            else
                                Dropdown_Button:SetAttribute("Enabled", true)
                                TweenService:Create(Dropdown_Button_Text, TweenInfo.new(0.2), { TextColor3 = Color3.fromRGB(255, 255, 255) }):Play()
                            end
                        else
                            Dropdown_Button:SetAttribute("Enabled", true)

                            for _,ui in pairs(Dropdown_Contaner:GetChildren()) do
                                if ui:IsA("TextButton") and ui ~= Dropdown_Button then
                                    ui:SetAttribute("Enabled", false)
                                    TweenService:Create(ui, TweenInfo.new(0.2), { TextColor3 = Color3.fromRGB(190, 190, 190) }):Play()
                                end
                            end
                        end

                        local returnTable = {}
                        for _,ui in pairs(Dropdown_Contaner:GetChildren()) do
                            if ui:IsA("TextButton") then
                                returnTable[ui.Name] = ui:GetAttribute("Enabled")
                            end
                        end

                        if _DropdownCallback ~= nil then
                            pcall(_DropdownCallback, returnTable)
                        end

                        if _ButtonCallback ~= nil then
                            pcall(_ButtonCallback, returnTable)
                        end
                    end, { Dropdown_Button.MouseButton1Down, Dropdown_Button_Text.MouseButton1Down })

                    dropdownUpdateSize()

                    local dropdownInButtonFunctions = {}
                    function dropdownInButtonFunctions:Destroy()
                        Dropdown_Button:Destroy()
                        dropdownUpdateSize()
                    end
                    return dropdownInButtonFunctions
                end

                function dropdownContanerItem:GetUI()
                    return DropdownFrame
                end

                return dropdownContanerItem
            end

            function contanerItems:CreateSlider(_SliderName, _SliderSetting, _SliderCallback)
                local SliderFrame = Instance.new("Frame")
                local Slider_Background = Instance.new("Frame")
                local Slider_UiCorner = Instance.new("UICorner")
                local Slider_Title = Instance.new("TextButton")
                local SliderBar_Background = Instance.new("TextButton")
                local Slider_Background_UiCorner = Instance.new("UICorner")
                local SliderBar = Instance.new("TextButton")
                local SliderBar_UiCorner = Instance.new("UICorner")
                local SliderBar_Circle = Instance.new("ImageButton")
                local Slider_Value = Instance.new("TextBox")
                local Slider_Value_UiCorner = Instance.new("UICorner")

                SliderFrame.Name = "SliderFrame"
                SliderFrame.Parent = Contaner
                SliderFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderFrame.BackgroundTransparency = 1.000
                SliderFrame.Size = UDim2.new(0, 363, 0, 44)
                SliderFrame.ZIndex = 3

                Slider_Background.Name = "Slider_Background"
                Slider_Background.Parent = SliderFrame
                Slider_Background.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                Slider_Background.BorderSizePixel = 0
                Slider_Background.Size = UDim2.new(0, 365, 0, 40)
                Slider_Background.ZIndex = 3

                Slider_UiCorner.CornerRadius = UDim.new(0, 5)
                Slider_UiCorner.Name = "Slider_UiCorner"
                Slider_UiCorner.Parent = Slider_Background

                Slider_Title.Name = "Slider_Title"
                Slider_Title.Parent = Slider_Background
                Slider_Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Slider_Title.BackgroundTransparency = 1.000
                Slider_Title.Position = UDim2.new(0, 15, 0, 4)
                Slider_Title.Size = UDim2.new(0, 292, 0, 20)
                Slider_Title.ZIndex = 4
                Slider_Title.AutoButtonColor = false
                Slider_Title.Font = Enum.Font.GothamSemibold
                Slider_Title.Text = _SliderName
                Slider_Title.TextColor3 = Color3.fromRGB(215, 215, 215)
                Slider_Title.TextSize = 13.000
                Slider_Title.TextXAlignment = Enum.TextXAlignment.Left

                SliderBar_Background.Name = "Slider_Background"
                SliderBar_Background.Parent = Slider_Background
                SliderBar_Background.AnchorPoint = Vector2.new(0, 0.5)
                SliderBar_Background.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                SliderBar_Background.Position = UDim2.new(0.065, 0, 0.699999988, 0)
                SliderBar_Background.Size = UDim2.new(0, 315, 0, 5)
                SliderBar_Background.ZIndex = 4
                SliderBar_Background.AutoButtonColor = false
                SliderBar_Background.Font = Enum.Font.SourceSans
                SliderBar_Background.Text = ""
                SliderBar_Background.TextColor3 = Color3.fromRGB(0, 0, 0)
                SliderBar_Background.TextSize = 14.000

                Slider_Background_UiCorner.CornerRadius = UDim.new(0, 10)
                Slider_Background_UiCorner.Name = "Slider_Background_UiCorner"
                Slider_Background_UiCorner.Parent = SliderBar_Background

                SliderBar.Name = "SliderBar"
                SliderBar.Parent = SliderBar_Background
                SliderBar.AnchorPoint = Vector2.new(0, 0.5)
                SliderBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderBar.Position = UDim2.new(0, 0, 0, 2)
                SliderBar.Size = UDim2.new(0, 0, 0, 5) -- 234
                SliderBar.ZIndex = 4
                SliderBar.AutoButtonColor = false
                SliderBar.Font = Enum.Font.SourceSans
                SliderBar.Text = ""
                SliderBar.TextColor3 = Color3.fromRGB(0, 0, 0)
                SliderBar.TextSize = 14.000

                SliderBar_UiCorner.CornerRadius = UDim.new(0, 10)
                SliderBar_UiCorner.Name = "SliderBar_UiCorner"
                SliderBar_UiCorner.Parent = SliderBar

                SliderBar_Circle.Name = "SliderBar_Circle"
                SliderBar_Circle.Parent = SliderBar
                SliderBar_Circle.AnchorPoint = Vector2.new(0.5, 0.5)
                SliderBar_Circle.BackgroundTransparency = 1.000
                SliderBar_Circle.Position = UDim2.new(0.995, 0, 0.45, 0) -- 2
                SliderBar_Circle.Size = UDim2.new(0, 0, 0, 0)
                SliderBar_Circle.ZIndex = 5
                SliderBar_Circle.Image = "rbxassetid://3926307971"
                SliderBar_Circle.ImageRectOffset = Vector2.new(644, 44)
                SliderBar_Circle.ImageRectSize = Vector2.new(36, 36)

                Slider_Value.Name = "Slider_Value"
                Slider_Value.Parent = Slider_Background
                Slider_Value.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                Slider_Value.BackgroundTransparency = 1.000
                Slider_Value.Position = UDim2.new(0.85799998, 0, 0.075000003, 0)
                Slider_Value.Size = UDim2.new(0, 44, 0, 18)
                Slider_Value.ZIndex = 5
                Slider_Value.ClearTextOnFocus = false
                Slider_Value.Font = Enum.Font.SourceSans
                Slider_Value.Text = tostring(_SliderSetting.Min)
                Slider_Value.TextColor3 = Color3.fromRGB(255, 255, 255)
                Slider_Value.TextSize = 13.000

                Slider_Value_UiCorner.CornerRadius = UDim.new(0, 3)
                Slider_Value_UiCorner.Name = "Slider_Value_UiCorner"
                Slider_Value_UiCorner.Parent = Slider_Value

                bindUiFunctionEvent(function()
                    TweenService:Create(Slider_Title, TweenInfo.new(0.1), { TextColor3 = Color3.fromRGB(255, 255, 255) }):Play()
                end, { Slider_Background.MouseEnter })

                bindUiFunctionEvent(function()
                    TweenService:Create(Slider_Title, TweenInfo.new(0.1), { TextColor3 = Color3.fromRGB(215, 215, 215) }):Play()
                end, { Slider_Background.MouseLeave})

                bindUiFunctionEvent(function()
                    Slider_Value.Text = tostring(math.clamp(tonumber(Slider_Value.Text), _SliderSetting.Min, _SliderSetting.Max))

                    local size = math.floor((SliderBar_Background.Size.X.Offset / (_SliderSetting.Max - _SliderSetting.Min)) * math.clamp(tonumber(Slider_Value.Text), _SliderSetting.Min, _SliderSetting.Max) + _SliderSetting.Min)

                    if size <= 2 then
                        size = 0
                    end
                    TweenService:Create(SliderBar, TweenInfo.new(0.2), { Size = UDim2.new(0, size, 0, 5) }):Play()
                end, { Slider_Value.FocusLost })

                bindUiFunctionEvent(function()
                    TweenService:Create(SliderBar_Circle, TweenInfo.new(0.2), { Size = UDim2.new(0, 11, 0, 11) }):Play()

                    function setValue()
                        local x = math.clamp(mouse.X - SliderBar_Background.AbsolutePosition.X, 0, SliderBar_Background.Size.X.Offset)

                        local value = math.floor(((_SliderSetting.Max - _SliderSetting.Min) / SliderBar_Background.Size.X.Offset) * x + _SliderSetting.Min)
                        Slider_Value.Text = tostring(value)

                        TweenService:Create(SliderBar, TweenInfo.new(0.1), { Size = UDim2.new(0, x, 0, 5) }):Play()

                        pcall(_SliderCallback, value)
                    end

                    setValue()
                    mouseMoveConnection = mouse.Move:Connect(setValue)

                    releaseConnection = game:GetService("UserInputService").InputEnded:Connect(function(input, gameProcessedEvent)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            mouseMoveConnection:Disconnect()
                            releaseConnection:Disconnect()

                            TweenService:Create(SliderBar_Circle, TweenInfo.new(0.2), { Size = UDim2.new(0, 0, 0, 0) }):Play()
                        end
                    end)
                end, { SliderBar_Background.MouseButton1Down, SliderBar.MouseButton1Down, SliderBar_Circle.MouseButton1Down })

                local sliderFunctions = {}
                function sliderFunctions:GetUI()
                    return SliderFrame
                end
                return sliderFunctions
            end

            function contanerItems:CreateBind(_BindName, _BindSetting, _BasicKey, _BindCallback, _KeyBindCallback)
                _BasicKey = _BasicKey or nil
                _KeyBindCallback = _KeyBindCallback or function () end

                _BindSetting["BindKeyNameColor"] = _BindSetting["BindKeyNameColor"] or Color3.fromRGB(0, 255, 200)
                _BindSetting["BindingMessage"] = _BindSetting["BindingMessage"] or "Press Key"

                local BindFrame = Instance.new("Frame")
                local Bind = Instance.new("TextButton")
                local Bind_UiCorner = Instance.new("UICorner")
                local Bind_Text = Instance.new("TextButton")
                local Bind_Button_Name = Instance.new("TextButton")

                BindFrame.Name = "BindFrame"
                BindFrame.Parent = Contaner
                BindFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                BindFrame.BackgroundTransparency = 1.000
                BindFrame.Size = UDim2.new(0, 363, 0, 34)
                BindFrame.ZIndex = 3

                Bind.Name = "Bind"
                Bind.Parent = BindFrame
                Bind.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                Bind.ClipsDescendants = true
                Bind.Size = UDim2.new(0, 365, 0, 30)
                Bind.ZIndex = 3
                Bind.AutoButtonColor = false
                Bind.Font = Enum.Font.SourceSans
                Bind.Text = ""
                Bind.TextColor3 = Color3.fromRGB(255, 255, 255)
                Bind.TextSize = 14.000

                Bind_UiCorner.CornerRadius = UDim.new(0, 5)
                Bind_UiCorner.Name = "Bind_UiCorner"
                Bind_UiCorner.Parent = Bind

                Bind_Text.Name = "Bind_Text"
                Bind_Text.Parent = Bind
                Bind_Text.BackgroundColor3 = Color3.fromRGB(215, 215, 215)
                Bind_Text.BackgroundTransparency = 1.000
                Bind_Text.ClipsDescendants = true
                Bind_Text.Position = UDim2.new(0, 15, 0, -1)
                Bind_Text.Size = UDim2.new(0, 253, 0, 30)
                Bind_Text.ZIndex = 4
                Bind_Text.AutoButtonColor = false
                Bind_Text.Font = Enum.Font.GothamSemibold
                Bind_Text.Text = _BindName
                Bind_Text.TextColor3 = Color3.fromRGB(215, 215, 215)
                Bind_Text.TextSize = 12.000
                Bind_Text.TextXAlignment = Enum.TextXAlignment.Left

                Bind_Button_Name.Name = "Bind_Button_Name"
                Bind_Button_Name.Parent = Bind
                Bind_Button_Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Bind_Button_Name.BackgroundTransparency = 1.000
                Bind_Button_Name.ClipsDescendants = true
                Bind_Button_Name.Position = UDim2.new(0, 268, 0, 0)
                Bind_Button_Name.Size = UDim2.new(0, 88, 0, 30)
                Bind_Button_Name.ZIndex = 4
                Bind_Button_Name.Font = Enum.Font.GothamSemibold
                Bind_Button_Name.TextColor3 = _BindSetting.BindKeyNameColor
                Bind_Button_Name.TextSize = 13.000
                Bind_Button_Name.TextXAlignment = Enum.TextXAlignment.Right

                if _BasicKey == nil then
                    Bind_Button_Name.Text = ""
                else
                    Bind_Button_Name.Text = _BasicKey.Name
                end

                local uis = game:GetService("UserInputService")

                local bindKey = _BasicKey
                local Connection

                if bindKey ~= nil then
                    Connection = uis.InputBegan:Connect(function(input, gameProcessedEvent)
                        if not gameProcessedEvent and not isExit then
                            if input.KeyCode == bindKey and input.KeyCode ~= Enum.KeyCode.Unknown then
                                pcall(_BindCallback)
                            end
                        end
                    end)
                end

                local input_ing = false
                bindUiFunctionEvent(function()                    
                    coroutine.wrap(function()
                        local mouseAbsolutePosition = Vector2.new(mouse.X, mouse.Y)
                        local mouseRelativePosition = mouseAbsolutePosition - Bind.AbsolutePosition

                        local Bind_RippleCircle = Instance.new("ImageLabel")

                        Bind_RippleCircle.Name = "Ripple"
                        Bind_RippleCircle.AnchorPoint = Vector2.new(0.5, 0.5)
                        Bind_RippleCircle.Parent = Bind
                        Bind_RippleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        Bind_RippleCircle.BackgroundTransparency = 1.000
                        Bind_RippleCircle.BorderSizePixel = 0
                        Bind_RippleCircle.ZIndex = 10
                        Bind_RippleCircle.Image = "http://www.roblox.com/asset/?id=4560909609"
                        Bind_RippleCircle.ImageTransparency = 0.8
                        Bind_RippleCircle.Position = UDim2.new(0, mouseRelativePosition.X, 0, mouseRelativePosition.Y)

                        -- local function getDistance(a, b)
                        --     return math.sqrt(((b.X - a.X) ^ 2) + ((b.Y - a.X) ^ 2))
                        -- end

                        local tl = getDistance(mouseRelativePosition, Vector2.new(0, 0))
                        local tr = getDistance(mouseRelativePosition, Vector2.new(Bind.AbsoluteSize.X, 0))
                        local br = getDistance(mouseRelativePosition, Bind.AbsoluteSize)
                        local bl = getDistance(mouseRelativePosition, Vector2.new(0, Bind.AbsoluteSize.Y))

                        local size = math.max(tl, tr, br, bl) * 2

                        local speed = 0.5


                        TweenService:Create(Bind_RippleCircle, TweenInfo.new( speed ), { Size = UDim2.new(0, size, 0, size) }):Play()
                        TweenService:Create(Bind_RippleCircle, TweenInfo.new( speed ), { ImageTransparency = 1 }):Play()
                        wait(speed)

                        Bind_RippleCircle:Destroy()
                    end)()

                    if not input_ing then
                        input_ing = true

                        TweenService:Create(Bind_Button_Name, TweenInfo.new(0.1), { TextTransparency = 1 }):Play()
                        TweenService:Create(Bind_Text, TweenInfo.new(0.1), { Position = UDim2.new(0, 15, 0, 35) }):Play()
                        wait(0.1)

                        Bind_Text.TextTransparency = 1
                        Bind_Text.Position = UDim2.new(0, 15, 0, -1)
                        Bind_Text.Text = _BindSetting.BindingMessage

                        TweenService:Create(Bind_Text, TweenInfo.new(0.2), { TextTransparency = 0 }):Play()

                        one = uis.InputBegan:Connect(function(input, gameProcessedEvent)
                            one:Disconnect()

                            if input.KeyCode ~= Enum.KeyCode.Unknown then
                                bindKey = input.KeyCode
                                pcall(_KeyBindCallback, bindKey)
                            end

                            TweenService:Create(Bind_Text, TweenInfo.new(0.2), { TextTransparency = 1 }):Play()
                            wait(0.2)

                            -- re
                            Bind_Text.Position = UDim2.new(0, 15, 0, 35)
                            Bind_Text.Text = _BindName

                            if input.KeyCode ~= Enum.KeyCode.Unknown then
                                if bindKey ~= nil and bindKey ~= Enum.KeyCode.Unknown then
                                    Bind_Button_Name.Text = bindKey.Name
                                else
                                    Bind_Button_Name.Text = ""
                                end
                            else
                                Bind_Button_Name.Text = ""
                            end

                            TweenService:Create(Bind_Button_Name, TweenInfo.new(0.1), { TextTransparency = 0 }):Play()
                            TweenService:Create(Bind_Text, TweenInfo.new(0.1), { TextTransparency = 0 }):Play()
                            TweenService:Create(Bind_Text, TweenInfo.new(0.1), { Position = UDim2.new(0, 15, 0, -1) }):Play()
                            wait(0.1)

                            input_ing = false
                        end)

                        if Connection ~= nil then
                            Connection:Disconnect()
                            Connection = nil
                        end

                        Connection = uis.InputBegan:Connect(function(input, gameProcessedEvent)
                            if not gameProcessedEvent and not isExit then
                                if input.KeyCode == bindKey and input.KeyCode ~= Enum.KeyCode.Unknown then
                                    pcall(_BindCallback)
                                end
                            end
                        end)
                    end
                end, { Bind.MouseButton1Down, Bind_Text.MouseButton1Down, Bind_Button_Name.MouseButton1Down })

                bindUiFunctionEvent(function()
                    TweenService:Create(Bind_Text, TweenInfo.new(0.1), { TextColor3 = Color3.fromRGB(255, 255, 255) }):Play()
                end, { Bind.MouseEnter })

                bindUiFunctionEvent(function()
                    TweenService:Create(Bind_Text, TweenInfo.new(0.1), { TextColor3 = Color3.fromRGB(215, 215, 215) }):Play()
                end, { Bind.MouseLeave })

                local bindFunctions = {}
                function bindFunctions:GetUI()
                    return BindFrame
                end
                return bindFunctions
            end

            return contanerItems
        end

        return miniCategorys
    end

    return bigCategorys
end

return Library
