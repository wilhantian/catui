local UILabel = UIControl:extend("UILabel", {
    size = 12,
    drawable = nil,
    text = "",
    color = {0, 0, 0, 255}
})

--- 构造
function UILabel:init(text, size, fontFile)
    UIControl.init(self)

    self:setClip(true)

    self.events:on(UI_DRAW, self.onDraw, self)
    self.events:on(UI_CLICK, function()
        self:setText("A")
    end, self)

    self.text = text
    self.size = size

    local font = nil
    if fontFile then
        font = love.graphics.newFont(fontFile, size)
    else
        font = love.graphics.getFont()
    end
    self.drawable = love.graphics.newText(font, text)

    self:resetSize()
end

--- 绘制
function UILabel:onDraw()
    local box = self:getBoundingBox()
    local x, y = box:getPos()
    local color = self.color

    local br, bg, bb, ba = love.graphics.getColor()
    love.graphics.setColor(color[1], color[2], color[3], color[4])
    love.graphics.draw(self.drawable, x, y)
    love.graphics.setColor(br, bg, bb, ba)
end

--- TODO 设置字体 传入文件名或字体实例
function UILabel:setFont(fileName)
    local font = love.graphics.newFont(fontFile, self.size)
    self.drawable:setFont(font)
    self:resetSize()
end

--- 获取字体
function UILabel:getFont()
    return self.drawable:getFont()
end

--- 设置文字
function UILabel:setText(text)
    self.text = text
    self.drawable:set(text)
    self:resetSize()
end

--- 获取文字
function UILabel:getText()
    return self.text
end

--- 设置文字大小
function UILabel:setSize(size)
    self.size = size
    self.drawable:getFont():setWidth(size)
    self.drawable:getFont():setHeight(size)
    self:resetSize()
end

--- 获取文字大小
function UILabel:getSize()
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
