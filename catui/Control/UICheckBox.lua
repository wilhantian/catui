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
-- UICheckBox
-- @usage
-- local checkBox = UICheckBox:new()
-------------------------------------
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

-------------------------------------
-- construct
-------------------------------------
function UICheckBox:init()
    UIControl.init(self)
    self:initTheme()
    self:setEnabled(true)

    self.events:on(UI_DRAW, self.onDraw, self)
    self.events:on(UI_MOUSE_ENTER, self.onMouseEnter, self)
    self.events:on(UI_MOUSE_LEAVE, self.onMouseLeave, self)
    self.events:on(UI_MOUSE_DOWN, self.onMouseDown, self)
    self.events:on(UI_MOUSE_UP, self.onMouseUp, self)
    self.events:on(UI_CLICK, self.onClick, self)
end

-------------------------------------
-- init Theme Style
-- @tab _theme
-------------------------------------
function UICheckBox:initTheme(_theme)
    local theme = theme or _theme
    self.upColor = theme.checkBox.upColor
    self.downColor = theme.checkBox.downColor
    self.hoverColor = theme.checkBox.hoverColor
    self.disableColor = theme.checkBox.disableColor
    self.size = theme.checkBox.size

    self:setSize(self.size, self.size)
end

-------------------------------------
-- (callback)
-- draw self
-------------------------------------
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
    if self.selected then
        love.graphics.rectangle("fill", x, y, self.size, self.size)
    else
        love.graphics.rectangle("line", x, y, self.size, self.size)
    end
    love.graphics.setColor(r, g, b, a)
end

-------------------------------------
-- (callback)
-- on mouse enter
-------------------------------------
function UICheckBox:onMouseEnter()
    self.isHoved = true
end

-------------------------------------
-- (callback)
-- on mouse leave
-------------------------------------
function UICheckBox:onMouseLeave()
    self.isHoved = false
end

-------------------------------------
-- (callback)
-- on mouse down
-------------------------------------
function UICheckBox:onMouseDown(x, y)
    self.isPressed = true
end

-------------------------------------
-- (callback)
-- on mouse up
-------------------------------------
function UICheckBox:onMouseUp(x, y)
    self.isPressed = false
end

-------------------------------------
-- (callback)
-- on click
-------------------------------------
function UICheckBox:onClick()
    self:setSelected(not self.selected)
    self.events:dispatch(UI_ON_SELECT, self.selected)
end

-------------------------------------
-- set selected
-- @bool selected
-------------------------------------
function UICheckBox:setSelected(selected)
    self.selected = selected
end

-------------------------------------
-- is selected
-- @treturn bool is selected
-------------------------------------
function UICheckBox:isSelected()
    return self.selected
end

return UICheckBox
