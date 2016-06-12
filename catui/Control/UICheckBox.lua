local UICheckBox = UIControl:extend("UICheckBox", {
    upColor = nil,
    downColor = nil,
    hoverColor = nil,
    disableColor = nil,
    size = 14,

    isHoved = false,
    isPressed = false,
    selected = false,
})

function UICheckBox:init()
    UIControl.init(self)
    self:initTheme()
    self:setEnabled(true)

    self.events:on(UI_DRAW, self.onDraw, self)
    self.events:on(UI_MOUSE_ENTER, self.onMouseEnter, self)
    self.events:on(UI_MOUSE_LEAVE, self.onMouseLevel, self)
    self.events:on(UI_MOUSE_DOWN, self.onMouseDown, self)
    self.events:on(UI_MOUSE_UP, self.onMouseUp, self)
    self.events:on(UI_CLICK, self.onClick, self)
end

--- 初始化主题
function UICheckBox:initTheme(_theme)
    local theme = theme or _theme
    self.upColor = theme.checkBox.upColor
    self.downColor = theme.checkBox.downColor
    self.hoverColor = theme.checkBox.hoverColor
    self.disableColor = theme.checkBox.disableColor
    self.size = theme.checkBox.size

    self:setSize(self.size, self.size)
end

--- 绘制
function UICheckBox:onDraw()
    local box = self:getBoundingBox()
    local x, y = box.left, box.top
    local w, h = box:getWidth(), box:getHeight()

    local r, g, b, a = love.graphics.getColor()
    local color = nil

    -- 本身
    if self.isPressed then color = self.downColor
    elseif self.isHoved then color = self.hoverColor
    elseif self.enabled then color = self.upColor
    else color = self.disableColor end

    love.graphics.setColor(color[1], color[2], color[3], color[4])
    love.graphics.setLineWidth(1)
    love.graphics.rectangle("line", x, y, self.size, self.size)
    if self.selected then
        love.graphics.line(x, y, x+self.size, y+self.size, x+self.size, y, x, y+self.size)
    end
    love.graphics.setColor(r, g, b, a)
end

--- 鼠标进入
function UICheckBox:onMouseEnter()
    self.isHoved = true
end

--- 鼠标离开
function UICheckBox:onMouseLevel()
    self.isHoved = false
end

--- 鼠标按下
function UICheckBox:onMouseDown(x, y)
    self.isPressed = true
end

--- 鼠标抬起
function UICheckBox:onMouseUp(x, y)
    self.isPressed = false
end

--- 点击
function UICheckBox:onClick()
    self:setSelected(not self.selected)
    self.events:dispatch(UI_ON_SELECT, self.selected)
end

--- 设置选中
function UICheckBox:setSelected(selected)
    self.selected = selected
end

--- 获取选中状态
function UICheckBox:isSelected()
    return self.selected
end

return UICheckBox
