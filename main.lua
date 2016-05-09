class = require "catui.libs.30log"
tween = require "catui.libs.tween"

require "catui.Core.UIDefine"

UIEvent = require "catui.Core.UIEvent"
UIControl = require "catui.Core.UIControl"
UIManager = require "catui.Core.UIManager"
UIButton = require "catui.Control.UIButton"

function love.load(arg)
    mgr = UIManager:getInstance()

    childA = UIButton:new()
    childA:set({x=50, y=50, width=50, height=50})
    mgr.rootCtrl:addChild(childA)
    --------------------------------------
    childA.events:on(UI_FOCUS, function()
        print("AAA", UI_FOCUS)
    end)
    --------------------------------------
    childA.events:on(UI_UN_FOCUS, function()
        print("AAA", UI_UN_FOCUS)
    end)
    --------------------------------------
    childA.events:on(UI_MOUSE_MOVE, function(x, y, dx, dy)
        print("AAA", UI_MOUSE_MOVE, x, y)
    end)
    --------------------------------------
    childA.events:on(UI_DB_CLICK, function(ctrl, x, y)
        print("AAA", UI_DB_CLICK, love.timer.getTime())
        t = tween.new(2, childA, {y=500}, "outBounce")
    end)
    --------------------------------------

end

function love.update(dt)
    mgr:update(dt)
    if t then t:update(dt) end
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
