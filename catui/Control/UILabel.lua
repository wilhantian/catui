--[[
The MIT License (MIT)

Copyright (c) 2016 WilhanTian  田伟汉

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]--

-------------------------------------
-- UILabel
-- @usage
-- local label = UILabel:new("font/visat.ttf", "Hello World！", 24)
-- label:setAnchor(0, 0)
-- label:setSize(100, 100)
-- label:setAutoSize(false)
-------------------------------------
local UILabel = UIControl:extend("UILabel", {
    text = "",
    size = 12,
    font = nil,
    fontName = nil,
    drawable = nil,
    color = {0, 0, 0, 255},
    lineHeight = 1,
    autoSize = true
})

-------------------------------------
-- construct
-------------------------------------
function UILabel:init(fontName, text, size)
    UIControl.init(self)

    self.size = size
    self.text = text

    self:setClip(true)

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

-------------------------------------
-- (callback)
-- draw self
-------------------------------------
function UILabel:onDraw()
    local box = self:getBoundingBox()

    local rb, gb, bb, ab = love.graphics.getColor()
    local color = self.color
    love.graphics.setColor(color[1], color[2], color[3], color[4])
    love.graphics.draw(self.drawable, box:getX(), box:getY())
    love.graphics.setColor(rb, gb, bb, ab)
end

-------------------------------------
-- set text
-- @string text
-------------------------------------
function UILabel:setText(text)
    self.text = text
    self.drawable:set(self.text)

    self:textTest()
end

-------------------------------------
-- get text
-- @treturn string text
-------------------------------------
function UILabel:getText()
    return self.text
end

-------------------------------------
-- set font
-- @string fontName file path
-------------------------------------
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

-------------------------------------
-- get font
-- @treturn font love2d font
-------------------------------------
function UILabel:getFont()
    return self.font
end

-------------------------------------
-- get font name
-- @treturn string font name
-------------------------------------
function UILabel:getFontName()
    return self.fontName
end

-------------------------------------
-- set font size
-- @number size
-------------------------------------
function UILabel:setFontSize(size)
    self.size = size
    self.font = love.graphics.newFont(self.fontName, size)
    self.drawable:setFont(self.font)

    self:textTest()
end

-------------------------------------
-- get font size
-- @treturn number font size
-------------------------------------
function UILabel:getFontSize()
    return self.size
end

-------------------------------------
-- set font color
-- @tab color {r, g, b, a}
-------------------------------------
function UILabel:setFontColor(color)
    self.color = color
end

-------------------------------------
-- get font color
-- @treturn tab font color
-------------------------------------
function UILabel:getFontColor()
    return self.color
end

-------------------------------------
-- set line height
-- @number lineHeight line height
-------------------------------------
function UILabel:setLineHeight(lineHeight)
    self.lineHeight = lineHeight
    self.font:setLineHeight(self.lineHeight)
end

-------------------------------------
-- get line height
-- @treturn number line height
-------------------------------------
function UILabel:getLineHeight()
    return self.lineHeight
end

-------------------------------------
-- set is auto size
-- @bool autoSize is auto size
-------------------------------------
function UILabel:setAutoSize(autoSize)
    self.autoSize = autoSize
    self:textTest()
end

-------------------------------------
-- get is auto size
-- @treturn bool is auto size
-------------------------------------
function UILabel:isAutoSize()
    return self.autoSize
end

-------------------------------------
-- test text
-------------------------------------
function UILabel:textTest()
    if self.autoSize then -- 自动大小
        self:setSize(self.drawable:getWidth(), self.drawable:getHeight())
    else
        local _, t = self.font:getWrap(self.text, self:getWidth())
        local text = ""
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

-------------------------------------
-- get drawable
-- @return drawable
-------------------------------------
function UILabel:getDrawable()
    return self.drawable
end

-------------------------------------
-- get a wrap array
-- @treturn tab wrap string array
-------------------------------------
function UILabel:getWrap()
    if self.autoSize then
        return {self.text}
    else
        local _, t = self.font:getWrap(self.text, self:getWidth())
        return t
    end
end

-------------------------------------
-- measure text width
-- @treturn number width
-------------------------------------
function UILabel:measureWidth(text)
    return self.font:getWidth(text)
end

return UILabel
