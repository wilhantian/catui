class = require "catui.libs.30log"
tween = require "catui.libs.tween"

require "catui.Core.UIDefine"

point = require "catui.Utils.Utils"
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

    local childA = UIButton:new()
    childA:set({x=50, y=50, width=50, height=50})
    mgr.rootCtrl.coreContainer:addChild(childA)

    local img = UIImage:new("img/gem.png")
    img.x = 150
    img.y = 150
    childA:addChild(img)

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
        t = tween.new(2, img, {y=460}, "outBounce")

        local x, y  = point.rotate(0, 1, 0, 10, 90)
        texture = love.graphics.newText(love.graphics.getFont(), "x=".. x .. " y=" .. y)
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
    if t then t:update(dt) end
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
