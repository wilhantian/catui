class = require "catui.libs.30log"

require "catui.Core.UIDefine"

UIEvent = require "catui.Core.UIEvent"
UIControl = require "catui.Core.UIControl"
UIManager = require "catui.Core.UIManager"

function love.load(arg)
    mgr = UIManager:new()

    childA = UIControl:new()
    childA.x = 50
    childA.y = 50
    childA.width = 50
    childA.height = 50
    mgr.rootCtrl:addChild(childA)
    --------------------------------------
    childA.events:on(UI_MOUSE_ENTER, function()
        print("AAA", UI_MOUSE_ENTER)
    end)
    --------------------------------------
    childA.events:on(UI_MOUSE_LEAVE, function()
        print("AAA", UI_MOUSE_LEAVE)
    end)
    --------------------------------------
    mgr.rootCtrl.events:on(UI_MOUSE_ENTER, function()
        print("RRR", UI_MOUSE_ENTER)
    end)
    --------------------------------------
    mgr.rootCtrl.events:on(UI_MOUSE_LEAVE, function()
        print("RRR", UI_MOUSE_LEAVE)
    end)
    --------------------------------------
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
