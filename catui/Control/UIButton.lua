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
-- UIButton
-- @usage
-- local button = UIButton:new()
-------------------------------------
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

-------------------------------------
-- construct
-------------------------------------
function UIButton:init()
    UIControl.init(self)
    self:initTheme()
    self:setEnabled(true)

    self.events:on(UI_DRAW, self.onDraw, self)
    self.events:on(UI_MOUSE_ENTER, self.onMouseEnter, self)
    self.events:on(UI_MOUSE_LEAVE, self.onMouseLeave, self)
    self.events:on(UI_MOUSE_DOWN, self.onMouseDown, self)
    self.events:on(UI_MOUSE_UP, self.onMouseUp, self)
end

-------------------------------------
-- init Theme Style
-- @tab _theme
-------------------------------------
function UIButton:initTheme(_theme)
    local theme = theme or _theme
    self.width = theme.button.width
    self.height = theme.button.height
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

-------------------------------------
-- (callback)
-- draw self
-------------------------------------
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

-------------------------------------
-- (callback)
-- on mouse enter
-------------------------------------
function UIButton:onMouseEnter()
    self.isHoved = true
    if love.mouse.getSystemCursor("hand") then
        love.mouse.setCursor(love.mouse.getSystemCursor("hand"))
    end
end

-------------------------------------
-- (callback)
-- on mouse level
-------------------------------------
function UIButton:onMouseLeave()
    self.isHoved = false
    love.mouse.setCursor()
end

-------------------------------------
-- (callback)
-- on mouse down
-------------------------------------
function UIButton:onMouseDown(x, y)
    self.isPressed = true
end

-------------------------------------
-- (callback)
-- on mouse up
-------------------------------------
function UIButton:onMouseUp(x, y)
    self.isPressed = false
end

-------------------------------------
-- set icon image
-- @string icon image path
-------------------------------------
function UIButton:setIcon(icon)
    self.iconImg = love.graphics.newImage(icon)
end

-------------------------------------
-- set icon direction
-- @string dir "left" or "right", default is left
-------------------------------------
function UIButton:setIconDir(dir)
    self.iconDir = dir
end

-------------------------------------
-- set button label text
-- @string text
-------------------------------------
function UIButton:setText(text)
    self.text = text
    self.textDrawable:set(text)
end

-------------------------------------
-- set button up color
-- @tab color color = {r, g, b, a}
-------------------------------------
function UIButton:setUpColor(color)
    self.upColor = color
end

-------------------------------------
-- set button down color
-- @tab color color = {r, g, b, a}
-------------------------------------
function UIButton:setDownColor(color)
    self.downColor = color
end

-------------------------------------
-- set button hover color
-- @tab color color = {r, g, b, a}
-------------------------------------
function UIButton:setHoverColor(color)
    self.hoverColor = color
end

-------------------------------------
-- set button disable color
-- @tab color color = {r, g, b, a}
-------------------------------------
function UIButton:setDisableColor(color)
    self.disableColor = color
end

-------------------------------------
-- set button stroke width
-- @number stroke
-------------------------------------
function UIButton:setStroke(stroke)
    self.stroke = stroke
end

-------------------------------------
-- set button stroke color
-- @tab color color = {r, g, b, a}
-------------------------------------
function UIButton:setStrokeColor(color)
    self.strokeColor = color
end

return UIButton
