local UIButton = UIControl:extend("UIButton", {
    isHoved = false,
    isPressed = false,

    text = "",
    font = nil,
    fontColor = nil,
    textDrawable = nil,
    iconImg = nil,
    iconDir = "left",
    upColor = nil,
    downColor = nil,
    hoverColor = nil,
    disableColor = nil,
    strokeColor = nil,
    stroke = 1,
    iconAndTextSpace = 6
})

--- 构造
function UIButton:init()
    UIControl.init(self)
    self:initTheme()
    self:setEnabled(true)

    self.events:on(UI_DRAW, self.onDraw, self)
    self.events:on(UI_MOUSE_ENTER, self.onMouseEnter, self)
    self.events:on(UI_MOUSE_LEAVE, self.onMouseLevel, self)
    self.events:on(UI_MOUSE_DOWN, self.onMouseDown, self)
    self.events:on(UI_MOUSE_UP, self.onMouseUp, self)
end

--- 初始化主题
function UIButton:initTheme(_theme)
    local theme = theme or _theme
    self.upColor = theme.button.upColor
    self.downColor = theme.button.downColor
    self.hoverColor = theme.button.hoverColor
    self.disableColor = theme.button.disableColor
    self.strokeColor = theme.button.strokeColor
    self.stroke = theme.button.stroke
    self.font = love.graphics.newFont(theme.button.font, theme.button.fontSize)
    self.textDrawable = love.graphics.newText(self.font, self.text)
    self.fontColor = theme.button.fontColor
    self.iconDir = theme.button.iconDir
    self.iconAndTextSpace = theme.button.iconAndTextSpace
end

--- 绘制
function UIButton:onDraw()
    local box = self:getBoundingBox()
    local x, y = box.left, box.top
    local w, h = box:getWidth(), box:getHeight()

    local r, g, b, a = love.graphics.getColor()
    local color = nil

    -- 按钮本身
    if self.isPressed then color = self.downColor
    elseif self.isHoved then color = self.hoverColor
    elseif self.enabled then color = self.upColor
    else color = self.disableColor end

    love.graphics.setColor(color[1], color[2], color[3], color[4])
    love.graphics.rectangle("fill", x, y, w, h)

    -- 按钮描边
    if self.enabled then
        local oldLineWidth = love.graphics.getLineWidth()
        love.graphics.setLineWidth(self.stroke)
        love.graphics.setLineStyle("rough")
        color = self.strokeColor
        love.graphics.setColor(color[1], color[2], color[3], color[4])
        love.graphics.rectangle("line", x, y, w, h)
        love.graphics.setLineWidth(oldLineWidth)
    end

    -- 计算文字与图标位置
    local text = self.textDrawable
    local textWidth = text and text:getWidth() or 0
    local textHeight = text and text:getHeight() or 0
    local icon = self.iconImg
    local iconWidth = icon and icon:getWidth() or 0
    local iconHeight = icon and icon:getHeight() or 0

    local space = text and icon and self.iconAndTextSpace or 0
    local allWidth = space + textWidth + iconWidth

    local textX = 0
    local textY = (h - textHeight)/2 + y
    local iconX = 0
    local iconY = (h - iconHeight)/2 + y

    if self.iconDir == "left" then
        iconX = (w - allWidth)/2 + x
        textX = iconX + iconWidth + space
    else
        textX = (w - allWidth)/2 + x
        iconX = textX + textWidth + space
    end

    -- 文本
    if text then
        color = self.fontColor
        love.graphics.setColor(color[1], color[2], color[3], color[4])
        love.graphics.draw(text, textX, textY)
    end

    -- 图标
    if self.iconImg then
        love.graphics.draw(icon, iconX, iconY)
    end

    love.graphics.setColor(r, g, b, a)
end

--- 鼠标进入
function UIButton:onMouseEnter()
    self.isHoved = true
    love.mouse.setCursor(love.mouse.getSystemCursor("hand"))
end

--- 鼠标离开
function UIButton:onMouseLevel()
    self.isHoved = false
    love.mouse.setCursor()
end

--- 鼠标按下
function UIButton:onMouseDown(x, y)
    self.isPressed = true
end

--- 鼠标抬起
function UIButton:onMouseUp(x, y)
    self.isPressed = false
end

--- 设置Icon
function UIButton:setIcon(icon)
    self.iconImg = love.graphics.newImage(icon)
end

--- 设置Icon方向
function UIButton:setIconDir(dir)
    self.iconDir = dir
end

--- 设置文字
function UIButton:setText(text)
    self.text = text
    self.textDrawable:set(text)
end

--- 设置抬起颜色
function UIButton:setUpColor(color)
    self.upColor = color
end

--- 设置按下颜色
function UIButton:setDownColor(color)
    self.downColor = color
end

--- 设置悬浮颜色
function UIButton:setHoverColor(color)
    self.hoverColor = color
end

--- 设置禁用颜色
function UIButton:setDisableColor(color)
    self.disableColor = color
end

--- 设置描边
function UIButton:setStroke(stroke)
    self.stroke = stroke
end

--- 设置描边颜色
function UIButton:setStrokeColor(color)
    self.strokeColor = color
end

return UIButton
