class = require "catui.libs.30log"
tween = require "catui.libs.tween"

require "catui.Core.UIDefine"

point = require "catui.Utils.Utils"
Rect = require "catui.Core.Rect"
UIEvent = require "catui.Core.UIEvent"
UIControl = require "catui.Core.UIControl"
UIRoot = require "catui.Core.UIRoot"
UIManager = require "catui.Core.UIManager"
UIPanel = require "catui.Control.UIPanel"
UILabel = require "catui.Control.UILabel"
UIButton = require "catui.Control.UIButton"
UIImage = require "catui.Control.UIImage"

function love.load(arg)

    love.graphics.setBackgroundColor(255, 255, 255, 255)

    mgr = UIManager:getInstance()

    childA = UIButton:new("img/gem.png", "img/equip1.png", "img/equip2.png")
    childA:setPos(0, 0)
    -- childA:setSize(100, 50)
    childA:setAnchor(0, 0)
    mgr.rootCtrl.coreContainer:addChild(childA)

    local img = UIImage:new("img/gem.png")
    img:setSize(150, 150)
    img:setPos(150, 150)
    childA:addChild(img)

    local label = UILabel:new("AAAA\nHello World", 46)
    img:addChild(label)

    texture = love.graphics.newText(love.graphics.getFont(), "...")

    --------------------------------------
    childA.events:on(UI_FOCUS, function()
        texture = love.graphics.newText(love.graphics.getFont(), UI_FOCUS)
    end)
    --------------------------------------
    childA.events:on(UI_UN_FOCUS, function()
        texture = love.graphics.newText(love.graphics.getFont(), UI_UN_FOCUS)
    end)
    --------------------------------------
    childA.events:on(UI_MOUSE_MOVE, function(x, y, dx, dy)
        texture = love.graphics.newText(love.graphics.getFont(), UI_MOUSE_MOVE)
    end)
    --------------------------------------
    childA.events:on(UI_DB_CLICK, function(ctrl, x, y)
        texture = love.graphics.newText(love.graphics.getFont(), UI_DB_CLICK)
    end)
    --------------------------------------

    local panel = UIPanel:new()
    panel.x = 300
    panel.y = 300
    panel.width = 400
    panel.height = 350
    mgr.rootCtrl.coreContainer:addChild(panel)
end

function love.update(dt)
    mgr:update(dt)
end

function love.draw()
    mgr:draw()
    love.graphics.draw(texture, 100, 100)
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

function love.resize(w, h)
    mgr:resize(w, h)
end
