local UILabel = UIControl:extend("UILabel", {
    text = "",
    size = 12,
    font = nil,
    fontName = nil,
    drawable = nil,
    color = {0, 0, 0, 255},
    lineHeight = 1,
    autoSize = true,
})

--- 构造
function UILabel:init(fontName, text, size)
    UIControl.init(self)

    self.size = size
    self.text = text

    if fontName == nil or fontName == "" then
        self.fontName = "font/visat.ttf"
    else
        self.fontName = fontName
    end

    self.font = love.graphics.newFont(self.fontName, size)
    self.drawable = love.graphics.newText(self.font, text)
    self.font:setLineHeight(self.lineHeight)

    self:textTest()

    self.events:on(UI_DRAW, self.onDraw, self)
end

--- 绘制
function UILabel:onDraw()
    local box = self:getBoundingBox()

    local rb, gb, bb, ab = love.graphics.getColor()
    local color = self.color
    love.graphics.setColor(color[1], color[2], color[3], color[4])
    love.graphics.draw(self.drawable, box:getX(), box:getY())
    love.graphics.setColor(rb, gb, bb, ab)
end

--- 设置字符串
function UILabel:setText(text)
    self.text = text
    self.drawable:set(self.text)

    self:textTest()
end

--- 获取字符串
function UILabel:getText()
    return self.text
end

--- 设置字体
function UILabel:setFont(fontName)
    if fontName == nil or fontName == "" then
        self.fontName = "font/visat.ttf"
    else
        self.fontName = fontName
    end
    self.font = love.graphics.newFont(self.fontName, self.size)
    self.font:setLineHeight(self.lineHeight)
    self.drawable:setFont(self.font)

    self:textTest()
end

--- 获取字体
function UILabel:getFont()
    return self.font
end

--- 获取字体名
function UILabel:getFontName()
    return self.fontName
end

--- 设置字体大小
function UILabel:setFontSize(size)
    self.size = size
    self.font = love.graphics.newFont(self.fontName, size)
    self.drawable:setFont(self.font)

    self:textTest()
end

--- 获取字体大小
function UILabel:getFontSize()
    return self.size
end

--- 设置颜色
function UILabel:setFontColor(color)
    self.color = color
end

--- 获取颜色
function UILabel:getFontColor()
    return self.color
end

function UILabel:setLineHeight(lineHeight)
    self.lineHeight = lineHeight
    self.font:setLineHeight(self.lineHeight)
end

function UILabel:getLineHeight()
    return self.lineHeight
end

--- 设置是否自动适应字体大小
function UILabel:setAutoSize(autoSize)
    self.autoSize = autoSize
    self:textTest()
end

--- 是否自动适应字体大小
function UILabel:isAutoSize()
    return self.autoSize
end

--- 测试文本
function UILabel:textTest()
    if self.autoSize then -- 自动大小
        self:setSize(self.drawable:getWidth(), self.drawable:getHeight())
    else
        local _, t = self.font:getWrap(self.text, self:getWidth())
        local text = "";
        for i,v in ipairs(t) do
            if i == #t then
                text = text .. v
            else
                text = text .. v .. "\n"
            end
        end
        self.drawable:set(text)
    end
end

return UILabel
