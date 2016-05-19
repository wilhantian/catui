local UILabel = UIControl:extend("UILabel", {
    size = 12,
    drawable = nil,
    font = nil,
    text = "",
    color = {0, 0, 0, 255}
})

--- 构造
function UILabel:init(text, size, fontFile)
    UIControl.init(self)

    -- self:setClip(true)
    self.events:on(UI_DRAW, self.onDraw, self)

    self.size = size
    self.text = text

    self.font = love.graphics.newFont(fontFile, size)
    self.drawable = love.graphics.newText(self.font, text)

    self:resetSize()
end

--- 绘制
function UILabel:onDraw()
    local box = self:getBoundingBox()
    local x, y = box:getPos()
    local color = self.color

    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(color[1], color[2], color[3], color[4])
    love.graphics.draw(self.drawable, x, y)
    love.graphics.setColor(r, g, b, a)
end

--- 设置字体
function UILabel:setFont(fileName)
    self.font = love.graphics.newFont(fileName, self.size)
    self.drawable:setFont(self.font)
end

--- 获取字体
function UILabel:getFont()
    return self.drawable:getFont()
end

--- 设置文字
function UILabel:setText(text)
    self.text = text
    self.drawable:set(text)
end

--- 获取文字
function UILabel:getText()
    return self.text
end

--- 设置文字大小
function UILabel:setFontSize(size)
    self.size = size
    self.font = love.graphics.newFont("font/visat.ttf", size)
    self.drawable:setFont(self.font)
end

--- 获取文字大小
function UILabel:getFontSize()
    return self.size
end

--- 同步大小
function UILabel:resetSize()
    self:setWidth(self.drawable:getWidth())
    self:setHeight(self.drawable:getHeight())
end

--- 设置颜色
function UILabel:setColor(color)
    self.color = color
end

--- 获取颜色
function UILabel:getColor()
    return self.color
end

return UILabel
