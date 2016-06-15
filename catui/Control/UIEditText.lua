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
-- UIEditText
-- @usage
-- local editText = UIEditText:new()
-- editText:setSize(120, 50)
-- editText:setText("input")
-------------------------------------
local UIEditText = UIControl:extend("UIEditText", {
    backgroundColor = nil,
    focusStrokeColor = nil,
    unfocusStrokeColor = nil,
    cursorColor = nil,
    stroke = 1,

    focus = false,
    label = nil,
    moreLine = false,
    showCursor = false,
    showCursorDt = 0
})

-------------------------------------
-- construct
-------------------------------------
function UIEditText:init(fontName, text, size)
    UIControl.init(self)
    self:setClip(false)
    self:setEnabled(true)

    self:initTheme()

    self.label = UILabel:new(fontName, text, size)
    self:addChild(self.label)

    self.events:on(UI_UPDATE, self.onUpdate, self)
    self.events:on(UI_DRAW, self.onDraw, self)
    self.events:on(UI_KEY_DOWN, self.onKeyDown, self)
    self.events:on(UI_TEXT_INPUT, self.textInput, self)
    self.events:on(UI_MOUSE_ENTER, self.onMouseEnter, self)
    self.events:on(UI_MOUSE_LEAVE, self.onMouseLeave, self)
    self.events:on(UI_FOCUS, self.onFocus, self)
    self.events:on(UI_UN_FOCUS, self.onUnFocus, self)
end

-------------------------------------
-- init Theme Style
-- @tab _theme
-------------------------------------
function UIEditText:initTheme(_theme)
    local theme = theme or _theme
    self.backgroundColor = theme.editText.backgroundColor
    self.focusStrokeColor = theme.editText.focusStrokeColor
    self.unfocusStrokeColor = theme.editText.unfocusStrokeColor
    self.cursorColor = theme.editText.cursorColor
    self.stroke = theme.editText.stroke
end

-------------------------------------
-- (callback)
-- update
-------------------------------------
function UIEditText:onUpdate(dt)
    if self.focus then
        self.showCursorDt = self.showCursorDt + dt
        if self.showCursorDt > 0.5 then
            self.showCursor = not self.showCursor
            self.showCursorDt = 0
        end
    end
end

-------------------------------------
-- (callback)
-- draw self
-------------------------------------
function UIEditText:onDraw()
    local box = self:getBoundingBox()
    local x, y = box.left, box.top
    local w, h = box:getWidth(), box:getHeight()
    local r, g, b, a = love.graphics.getColor()

    -- 背景
    local color = self.backgroundColor
    love.graphics.setColor(color[1], color[2], color[3], color[4])
    love.graphics.rectangle("fill", x, y, w, h)

    -- 描边
    if self.focus then
        color = self.focusStrokeColor
    else
        color = self.unfocusStrokeColor
    end
    local lineWidth = love.graphics.getLineWidth()
    love.graphics.setLineWidth(self.stroke)
    love.graphics.setColor(color[1], color[2], color[3], color[4])
    love.graphics.rectangle("line", x, y, w, h)
    love.graphics.getLineWidth(lineWidth)

    love.graphics.setColor(r, g, b, a)

    self:drawCursor()
end

-------------------------------------
-- (override)
-------------------------------------
function UIEditText:setSize(width, height)
    UIControl.setSize(self, width, height)
    self.label:setSize(width, height)
end

-------------------------------------
-- (override)
-------------------------------------
function UIEditText:setWidth(width)
    UIControl.setWidth(self, width)
    self.label:setWidth(width)
end

-------------------------------------
-- (override)
-------------------------------------
function UIEditText:setHeight(height)
    UIControl.setHeight(self, height)
    self.label:setHeight(height)
end

-------------------------------------
-- (callback)
-- on key down
-------------------------------------
function UIEditText:onKeyDown(key, scancode, isrepeat)
    if key == "backspace" then
        local text = self.label:getText()
        local byteoffset = utf8.offset(text, -1)

        if byteoffset then
            text = string.sub(text, 1, byteoffset - 1)
            self.label:setText(text)
            self.events:dispatch(UI_TEXT_CHANGE, self.label:getText())
        end
    end

    self.showCursorDt = 0
    self.showCursor = true
end

-------------------------------------
-- (callback)
-- on text input
-------------------------------------
function UIEditText:textInput(text)
    self.label:setText(self.label:getText() .. text)
    self.events:dispatch(UI_TEXT_CHANGE, self.label:getText())
end

-------------------------------------
-- (callback)
-- on mouse enter
-------------------------------------
function UIEditText:onMouseEnter()
    if love.mouse.getSystemCursor("ibeam") then
        love.mouse.setCursor(love.mouse.getSystemCursor("ibeam"))
    end
end

-------------------------------------
-- (callback)
-- on mouse leave
-------------------------------------
function UIEditText:onMouseLeave()
    love.mouse.setCursor()
end

-------------------------------------
-- (callback)
-- on focus
-------------------------------------
function UIEditText:onFocus()
    self.focus = true
    self.showCursor = true

    local box = self:getBoundingBox()
    local x, y = box.left, box.top
    local w, h = box:getWidth(), box:getHeight()
    love.keyboard.setTextInput(true, x, y, w, h )
end

-------------------------------------
-- (callback)
-- on unfocus
-------------------------------------
function UIEditText:onUnFocus()
    self.focus = false
    self.showCursor = false

    love.keyboard.setTextInput(false, 0, 0, 0, 0)
end

-------------------------------------
-- set text
-- @string text
-------------------------------------
function UIEditText:setText(text)
    self.label:setText(text)
end

-------------------------------------
-- get text
-- @treturn string text
-------------------------------------
function UIEditText:getText()
    return self.label
end

-------------------------------------
-- draw cursor
-------------------------------------
function UIEditText:drawCursor()
    if not self.showCursor then
        return
    end

    local wraps = self.label:getWrap()
    local length = #wraps == 0 and 1 or #wraps
    local width = self.label:measureWidth(wraps[#wraps] or "")
    local maxX = self.label:getBoundingBox():getX() + width + 1
    local maxY = self.label:getBoundingBox():getY() + self.label:getFont():getHeight() * length

    local r, g, b, a = love.graphics.getColor()
    local color = self.cursorColor
    love.graphics.setColor(color[1], color[2], color[3], color[4])
    love.graphics.setLineWidth(2)
    love.graphics.line(maxX, maxY, maxX, maxY - self.label:getFont():getHeight())
    love.graphics.setColor(r, g, b, a)
end

-------------------------------------
-- set more line input type
-- @bool moreLine
-------------------------------------
function UIEditText:setMoreLine(moreLine)
    self.moreLine = moreLine
    self.label:setAutoSize(not moreLine)
end

-------------------------------------
-- get more line input type
-- @treturn bool is more line
-------------------------------------
function UIEditText:getMoreLine(moreLine)
    return self.moreLine
end

-------------------------------------
-- set font color
-- @tab color
-------------------------------------
function UIEditText:setFontColor(color)
    self.label:setFontColor(color)
end

-------------------------------------
-- get font color
-- @treturn tab font color
-------------------------------------
function UIEditText:getFontColor()
    return self.label:getFontColor()
end

return UIEditText
