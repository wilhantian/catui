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
-- UIProgressBar
-- @usage
-- rogressBar = UIProgressBar:new()
-- progressBar:setSize(100, 10)
-- progressBar:setValue(40)
-------------------------------------
local UIProgressBar = UIControl:extend("UIProgressBar", {
    value = 0,
    minValue = 0,
    maxValue = 100,
    color = nil,
    backgroundColor = nil
})

-------------------------------------
-- construct
-------------------------------------
function UIProgressBar:init()
    UIControl.init(self)
    self:setEnabled(false)

    self:initTheme()

    self.events:on(UI_DRAW, self.onDraw, self)
end

-------------------------------------
-- init Theme Style
-- @tab _theme
-------------------------------------
function UIProgressBar:initTheme(_theme)
    local theme = theme or _theme
    self.color = theme.progressBar.color
    self.backgroundColor = theme.progressBar.backgroundColor
end

-------------------------------------
-- (callback)
-- draw self
-------------------------------------
function UIProgressBar:onDraw()
    local box = self:getBoundingBox()
    local r, g, b, a = love.graphics.getColor()

    -- 背景
    local color = self.backgroundColor
    love.graphics.setColor(color[1], color[2], color[3], color[4])
    love.graphics.rectangle("fill", box:getX(), box:getY(), box:getWidth(), box:getHeight())

    -- 高亮
    local barWidth = self.value / (self.maxValue-self.minValue) * box:getWidth()
    if barWidth < 0 then
        barWidth = 0
    elseif barWidth > box:getWidth() then
        barWidth = box:getWidth()
    end

    color = self.color
    love.graphics.setColor(color[1], color[2], color[3], color[4])
    love.graphics.rectangle("fill", box:getX(), box:getY(), barWidth, box:getHeight())

    love.graphics.setColor(r, g, b, a)
end

-------------------------------------
-- set value
-- @number value
-------------------------------------
function UIProgressBar:setValue(value)
    self.value = value
end

-------------------------------------
-- get value
-- @treturn number value
-------------------------------------
function UIProgressBar:getValue()
    return self.value
end

-------------------------------------
-- set min value
-- @number value
-------------------------------------
function UIProgressBar:setMinValue(minValue)
    self.minValue = minValue
end

-------------------------------------
-- get min value
-- @treturn number min value
-------------------------------------
function UIProgressBar:getMinValue()
    return self.minValue
end

-------------------------------------
-- set max value
-- @number value
-------------------------------------
function UIProgressBar:setMaxValue(maxValue)
    self.maxValue = maxValue
end

-------------------------------------
-- get max value
-- @treturn number max value
-------------------------------------
function UIProgressBar:getMaxValue()
    return self.maxValue
end

return UIProgressBar
