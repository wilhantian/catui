class = require "catui.libs.30log"
tween = require "catui.libs.tween"

require "catui.Core.UIDefine"

point = require "catui.Utils.Utils"
Rect = require "catui.Core.Rect"
UIEvent = require "catui.Core.UIEvent"
UIStencilManager = require "catui.Core.UIStencilManager"
UIControl = require "catui.Core.UIControl"
UIRoot = require "catui.Core.UIRoot"
UIManager = require "catui.Core.UIManager"
UIPanel = require "catui.Control.UIPanel"
UILabel = require "catui.Control.UILabel"
UIButton = require "catui.Control.UIButton"
UIImage = require "catui.Control.UIImage"
UIContent = require "catui.Control.UIContent"

function love.load(arg)
    love.graphics.setBackgroundColor(255, 255, 255, 255)

    mgr = UIManager:getInstance()

    local content = UIContent:new()
    content:setSize(150, 150)
    content:setContentSize(450, 450)
    mgr.rootCtrl.coreContainer:addChild(content)

    childA = UIButton:new("img/gem.png", "img/equip1.png", "img/equip2.png")
    childA:setPos(0, 0)
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

    --------------------------------------
    childA.events:on(UI_FOCUS, function()
        label:setText(label:getWidth() .. " " .. label:getHeight())
    end)
    --------------------------------------
    childA.events:on(UI_UN_FOCUS, function()
    end)
    --------------------------------------
    childA.events:on(UI_MOUSE_MOVE, function(x, y, dx, dy)
    end)
    --------------------------------------
    childA.events:on(UI_DB_CLICK, function(ctrl, x, y)
      label:setText("啊哈哈哈哈啊哈哈哈哈啊哈哈哈")
    end)
    --------------------------------------

    local panel = UIPanel:new()
    panel.x = 300
    panel.y = 300
    panel.width = 200
    panel.height = 80
    mgr.rootCtrl.coreContainer:addChild(panel)
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

function love.resize(w, h)
    mgr:resize(w, h)
end
