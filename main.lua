require "catui"

function love.load(arg)
    love.graphics.setBackgroundColor(35, 42, 50, 255)

    mgr = UIManager:getInstance()

    local content = UIContent:new()
    content:setPos(10, 20)
    content:setSize(150, 150)
    content:setContentSize(450, 450)
    mgr.rootCtrl.coreContainer:addChild(content)

    childA = UIButton:new()
    childA:setPos(10, 10)
    childA:setText("登陆")
    childA:setIcon("img/icon_haha.png", "left")
    childA:setAnchor(0, 0)
    content:addChild(childA)

    local img = UIImage:new("img/gem.png")
    img:setSize(150, 150)
    img:setPos(150, 150)
    childA:addChild(img)

    local label = UILabel:new("font/visat.ttf", "Hello World!你好世界！", 24)
    label:setAnchor(0, 0)
    label:setSize(100, 1000)
    label:setAutoSize(false)
    img:addChild(label)

    local checkBox = UICheckBox:new()
    checkBox:setPos(200, 60)
    content:addChild(checkBox)

    local progressBar = UIProgressBar:new()
    progressBar:setPos(100, 100)
    progressBar:setSize(100, 10)
    progressBar:setValue(40)
    content:addChild(progressBar)

    local editText = UIEditText:new()
    editText:setPos(100, 120)
    editText:setSize(120, 50)
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
    mgr:whellMove(x, y)
end

function love.textinput(text)
    mgr:textInput(text)
end
