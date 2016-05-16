local UIButton = UIControl:extend("UIButton", {
    isHoved = false,
    isPressed = false,
    label = nil
})

function UIButton:init(drawable)
    UIControl.init(self)

    self.enabled = true
    self.drawable = drawable

    self.label = UILabel:new()
    self.label:setText("AAA")
    self:addChild(self.label)

    self.events:on(UI_DRAW, self.onDraw, self)
    self.events:on(UI_MOUSE_ENTER, self.onMouseEnter, self)
    self.events:on(UI_MOUSE_LEAVE, self.onMouseLevel, self)
    self.events:on(UI_MOUSE_DOWN, self.onMouseDown, self)
    self.events:on(UI_MOUSE_UP, self.onMouseUp, self)
end

function UIButton:onDraw()
    local x, y = self:localToGlobal()

    love.graphics.push("all")
    if self.isPressed then
        love.graphics.setColor(Color4(COLOR_BTN_DOWN))
        love.graphics.rectangle("fill", x, y, self.width, self.height)
    elseif self.isHoved then
        love.graphics.setColor(Color4(COLOR_BTN_HOVE))
        love.graphics.rectangle("fill", x, y, self.width, self.height)
    else
        love.graphics.setColor(Color4(COLOR_BTN))
        love.graphics.rectangle("fill", x, y, self.width, self.height)
    end

    love.graphics.pop()
end

function UIButton:onMouseEnter()
    self.isHoved = true
end

function UIButton:onMouseLevel()
    self.isHoved = false
end

function UIButton:onMouseDown(x, y)
    self.isPressed = true
end

function UIButton:onMouseUp(x, y)
    self.isPressed = false
end

return UIButton
