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
    cursorCoords = {x=0, y=1},
    rows = 0,
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
    self.events:on(UI_TEXT_CHANGE, self.onTextChange, self)
    if text ~= nil then
      self.events:dispatch(UI_TEXT_CHANGE, text)
    end
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
-- textchange
-------------------------------------
function UIEditText:onTextChange(text)
    self.rows = #csplit(text, '\n')
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

function UIEditText:getLineInfoAt(x, y)
    -- returns the wrap, line, and byteoffset
    -- of specified line
    local wraps = self.label:getWrap()
    local line = wraps[self.cursorCoords.y] or ""
    local byteoffset = utf8.offset(line, self.cursorCoords.x) or 0
    return wraps, line, byteoffset
end

function UIEditText:getLineInfo()
    return self:getLineInfoAt(self.cursorCoords.x, self.cursorCoords.y)
end

function UIEditText:wedgeLineAt(x, y, xo, yo)
    -- return line info + both parts of line
    -- split by the current position of cursor
    local wraps, line, byteoffset = self:getLineInfo(x, y)
    left = line:sub(1, byteoffset + xo)
    right = line:sub(byteoffset + yo, -1)
    return wraps, line, byteoffset, left, right
end

function UIEditText:wedgeLine(lo, ro)
    return self:wedgeLineAt(
      self.cursorCoords.x, self.cursorCoords.y, lo, ro
    )
end

function UIEditText:removeCharAt(x, y)
    local wraps, line, byteoffset, left, right =
      self:wedgeLineAt(x, y, -1, 1)
    table.remove(wraps, y)
    table.insert(wraps, y, left..right)
    self.label:setText(table.concat(wraps, '\n'))
    self.events:dispatch(UI_TEXT_CHANGE, self.label:getText())
    self:moveCursor(-1, 0)
end

function UIEditText:removeChar()
    self:removeCharAt(self.cursorCoords.x, self.cursorCoords.y)
end

function UIEditText:insertCharAt(char, x, y)
    local wraps, line, byteoffset, left, right =
      self:wedgeLineAt(x, y, 0, 1)
    local newLine = left..char..right
    if x == 0 then
      newLine = char..left..right
    end
    -- some future wrapping :)
    -- if char ~= '\f' and #newLine % 20 == 0 then
    --     print('inserting f')
    --     self:insertCharAt('\f', x+1, y)
    -- end
    table.remove(wraps, y)
    table.insert(wraps, y, newLine)
    self.label:setText(table.concat(wraps, '\n'))
    self.events:dispatch(UI_TEXT_CHANGE, self.label:getText())
    self:moveCursor(#char, 0)
end

function UIEditText:insertChar(char)
    self:insertCharAt(char, self.cursorCoords.x, self.cursorCoords.y)
end

function UIEditText:mergeLinesAt(x, y)
    -- merge the end of a previous line with the
    -- start of the next one
    local wraps, line, byteoffset = self:getLineInfoAt(x, y)
    local oldLine = wraps[y-1]
    local newLine = oldLine .. line
    table.insert(wraps, y, newLine)
    table.remove(wraps, y-1)
    table.remove(wraps, y)
    self.label:setText(table.concat(wraps, '\n'))
    self.events:dispatch(UI_TEXT_CHANGE, self.label:getText())
    self:moveCursor(#oldLine, -1)
end

function UIEditText:mergeLines()
    self:mergeLinesAt(self.cursorCoords.x, self.cursorCoords.y)
end

function UIEditText:newline()
    local wraps, line, byteoffset, left, right =
      self:wedgeLine(0, 1)
    if self.cursorCoords.x == 0 then
      right = left..right
      left = ""
    end
    table.remove(wraps, self.cursorCoords.y)
    table.insert(wraps, self.cursorCoords.y, left)
    table.insert(wraps, self.cursorCoords.y + 1, right)
    self.label:setText(table.concat(wraps, '\n'))
    self.events:dispatch(UI_TEXT_CHANGE, self.label:getText())
    self:moveCursor(-self.cursorCoords.x, 1)
end

function UIEditText:backspace()
    if self.cursorCoords.x > 0 then
        self:removeChar()
    elseif self.cursorCoords.y > 1 then
        self:mergeLines()
    end
end

-------------------------------------
-- (callback)
-- on key down
-------------------------------------
function UIEditText:onKeyDown(key, scancode, isrepeat)
    local wraps, line, byteoffset = self:getLineInfo()
    if key == "backspace" and byteoffset then
        self:backspace()
    elseif key == "return" then
        self:newline()
    elseif key == "tab" then
        self:insertChar('  ')
    elseif key == "up" then
        if self.cursorCoords.y > 1 then
            self:moveCursor(0, -1)
        end
    elseif key == "down" then
        if self.cursorCoords.y < self.rows then
            self:moveCursor(0, 1)
        end
    elseif key == "left" then
        if self.cursorCoords.x > 0 then
            self:moveCursor(-1, 0)
        elseif self.cursorCoords.y > 1 then
            self:moveCursor(#(wraps[self.cursorCoords.y-1] or {}), -1)
        end
    elseif key == "right" then
        if self.cursorCoords.x < #line then
            self:moveCursor(1, 0)
        elseif self.cursorCoords.y < self.rows then
            self:moveCursor(-self.cursorCoords.x, 1)
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
    self:insertChar(text)
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

function UIEditText:moveCursor(xo, yo)
    self.cursorCoords.y = self.cursorCoords.y + yo
    if xo == 0 then
      local wraps = self.label:getWrap()
      local width = #wraps[self.cursorCoords.y]
      if self.cursorCoords.x > width then
        self.cursorCoords.x = width
      end
    else
      self.cursorCoords.x = self.cursorCoords.x + xo
    end
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
    local chars = (wraps[self.cursorCoords.y] or ""):sub(
      1, self.cursorCoords.x
    )
    local width = self.label:measureWidth(chars)
    local maxX = self.label:getBoundingBox():getX()
    local maxY = self.label:getBoundingBox():getY()
    maxX = maxX + width + 1
    maxY = maxY + self.cursorCoords.y * self.label:getFont():getHeight()

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
