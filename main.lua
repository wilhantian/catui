require "catui"

function love.load(arg)
    love.graphics.setBackgroundColor(35/255, 42/255, 50/255, 1)

    mgr = UIManager:getInstance()

    local content = UIContent:new()
    content:setPos(20, 20)
    content:setSize(300, 450)
    content:setContentSize(500, 500)
    mgr.rootCtrl.coreContainer:addChild(content)


    local buttonA = UIButton:new()
    buttonA:setPos(10, 10)
    buttonA:setText("A")
    buttonA:setIcon("img/icon_haha.png")
    buttonA:setAnchor(0, 0)
    content:addChild(buttonA)

    local buttonB = UIButton:new()
    buttonB:setPos(60, 20)
    buttonB:setText("B")
    buttonB:setIcon("img/icon_haha.png")
    buttonB:setAnchor(0, 0)
    content:addChild(buttonB)

    local buttonC = UIButton:new()
    buttonC:setPos(110, 30)
    buttonC:setText("C")
    buttonC:setIcon("img/icon_haha.png")
    buttonC:setIconDir("right")
    buttonC:setAnchor(0, 0)
    content:addChild(buttonC)


    local img = UIImage:new("img/gem.png")
    img:setPos(0, 50)
    buttonA:addChild(img)


    local label = UILabel:new("font/visat.ttf", "Hello World!", 24)
    label:setAnchor(0, 0.5)
    label:setAutoSize(false)
    label:setPos(100, 150/2)
    label:setFontColor({1, 1, 0, 1})
    img:addChild(label)


    local checkBoxA = UICheckBox:new()
    checkBoxA:setPos(20, 160)
    content:addChild(checkBoxA)

    local checkBoxB = UICheckBox:new()
    checkBoxB:setPos(50, 160)
    content:addChild(checkBoxB)

    local checkBoxC = UICheckBox:new()
    checkBoxC:setPos(80, 160)
    content:addChild(checkBoxC)


    local progressBarA = UIProgressBar:new()
    progressBarA:setPos(20, 200)
    progressBarA:setSize(100, 10)
    progressBarA:setValue(0)
    content:addChild(progressBarA)

    local progressBarB = UIProgressBar:new()
    progressBarB:setPos(20, 220)
    progressBarB:setSize(100, 10)
    progressBarB:setValue(50)
    content:addChild(progressBarB)

    local progressBarC = UIProgressBar:new()
    progressBarC:setPos(20, 240)
    progressBarC:setSize(100, 10)
    progressBarC:setValue(100)
    content:addChild(progressBarC)


    local editText = UIEditText:new()
    editText:setPos(20, 270)
    editText:setSize(120, 20)
    editText:setText("你好!")
    content:addChild(editText)
end

function love.update(dt)
    mgr:update(dt)
end

function love.draw()
    mgr:draw()
end

function love.mousemoved(x, y, dx, dy)
    mgr:mouseMove(x, y, dx, dy)
end

function love.mousepressed(x, y, button, isTouch)
    mgr:mouseDown(x, y, button, isTouch)
end

function love.mousereleased(x, y, button, isTouch)
    mgr:mouseUp(x, y, button, isTouch)
end

function love.keypressed(key, scancode, isrepeat)
    mgr:keyDown(key, scancode, isrepeat)
end

function love.keyreleased(key)
    mgr:keyUp(key)
end

function love.wheelmoved(x, y)
    mgr:wheelMove(x, y)
end

function love.textinput(text)
    mgr:textInput(text)
end
