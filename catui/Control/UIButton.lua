local UIButton = UIControl:extend("UIButton", {
    isHoved = false,
    isPressed = false
})

function UIButton:init()
    UIControl.init(self)

    self.events:on(UI_DRAW, self.onDraw, self)
    self.events:on(UI_MOUSE_ENTER, self.onMouseEnter, self)
    self.events:on(UI_MOUSE_LEAVE, self.onMouseLevel, self)
    self.events:on(UI_MOUSE_DOWN, self.onMouseDown, self)
    self.events:on(UI_MOUSE_UP, self.onMouseUp, self)
end

function UIButton:onDraw()
    if self.isPressed then
        local x, y = self:localToGlobal()
        love.graphics.setLineWidth(2)
        love.graphics.setColor(COLOR_MAIN.r, COLOR_MAIN.g, COLOR_MAIN.b, 255)
        love.graphics.rectangle("fill", x, y, self.width, self.height)
    elseif self.isHoved then
        local x, y = self:localToGlobal()
        love.graphics.setLineWidth(2)
        love.graphics.setColor(COLOR_SUB.r, COLOR_SUB.g, COLOR_SUB.b, 255)
        love.graphics.rectangle("fill", x, y, self.width, self.height)
    else
        local x, y = self:localToGlobal()
        love.graphics.setLineWidth(2)
        love.graphics.setColor(COLOR_ADOM.r, COLOR_ADOM.g, COLOR_ADOM.b, 255)
        love.graphics.rectangle("fill", x, y, self.width, self.height)
    end
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
