class = require "catui.libs.30log"
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

function love.mousereleased(x, y, button, isTouch)
end

function love.keypressed(key, scancode, isrepeat)
end
