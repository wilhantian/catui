local UIControl = class("UIControl", {
    x = 0,
    y = 0,
    width = 0,
    height = 0,
    depth = 0,
    children = {},
    parent = nil,
})

function UIControl:init()
end

function UIControl:update(dt)
end

function UIControl:draw()
end

function UIControl:hitTest()
end

function UIControl:localToGlobal()
end

function UIControl:globalToLocal()
end

function UIControl:mouseEnter()
end

function UIControl:mouseLeave()
end

function UIControl:mouseMove()
end

function UIControl:mouseDown()
end

function UIControl:mouseUp()
end

function UIControl:setFocus()
end

return UIControl
