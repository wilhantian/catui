class = require "catui.libs.30log"

require "catui.Core.UIDefine"

UIEvent = require "catui.Core.UIEvent"
UIControl = require "catui.Core.UIControl"
UIManager = require "catui.Core.UIManager"

function love.load(arg)
    mgr = UIManager:getInstance()

    childA = UIControl:new()
    childA:set({x=50, y=50, width=50, height=50})
    mgr.rootCtrl:addChild(childA)
    --------------------------------------
    childA.events:on(UI_DRAW, function(self)
        local x, y = self:localToGlobal()
        love.graphics.setLineWidth(2)
        love.graphics.setColor(255, 0, 0, 255)
        love.graphics.rectangle("line", x, y, self.width, self.height)
    end, childA)
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
