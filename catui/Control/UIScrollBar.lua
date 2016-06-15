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
-- UIScrollBar
-- @usage
-- local bar = UIScrollBar:new()
-- bar:setSize(100, 20)
-- bar:setDir("vertical")
-------------------------------------
local UIScrollBar = UIControl:extend("UIScrollBar", {
    upColor = nil,
    downColor = nil,
    hoverColor = nil,
    backgroundColor = nil,

    dir = "vertical", --horizontal
    ratio = 3, --bar占多少比例
    bar = nil,
    barDown = false,
    barPosRatio = 0,
})

-------------------------------------
-- construct
-------------------------------------
function UIScrollBar:init()
    UIControl.init(self)

    self.bar = UIButton:new()
    self.bar.events:on(UI_MOUSE_DOWN, self.onBarDown, self)
    self.bar.events:on(UI_MOUSE_MOVE, self.onBarMove, self)
    self.bar.events:on(UI_MOUSE_UP, self.onBarUp, self)
    self:addChild(self.bar)

    self:initTheme()

    self:setEnabled(true)
    self.events:on(UI_DRAW, self.onDraw, self)
    self.events:on(UI_MOUSE_DOWN, self.onBgDown, self)
end

-------------------------------------
-- (callback)
-- draw self
-------------------------------------
function UIScrollBar:onDraw()
    local box = self:getBoundingBox()
    local x, y = box.left, box.top
    local w, h = box:getWidth(), box:getHeight()

    local r, g, b, a = love.graphics.getColor()
    local color = self.backgroundColor
    love.graphics.setColor(color[1], color[2], color[3], color[4])
    love.graphics.rectangle("fill", x, y, w, h)
    love.graphics.setColor(r, g, b, a)
end

-------------------------------------
-- init Theme Style
-- @tab _theme
-------------------------------------
function UIScrollBar:initTheme(_theme)
    local theme = theme or _theme
    self.upColor = theme.scrollBar.upColor
    self.downColor = theme.scrollBar.downColor
    self.hoverColor = theme.scrollBar.hoverColor
    self.backgroundColor = theme.scrollBar.backgroundColor

    self.bar:setStroke(0)
    self.bar:setUpColor(self.upColor)
    self.bar:setDownColor(self.downColor)
    self.bar:setHoverColor(self.hoverColor)
end

-------------------------------------
-- set bar scroll direction
-- @string dir "vertical" or "horizontal", default is vertical
-------------------------------------
function UIScrollBar:setDir(dir)
    self.dir = dir
    self:reset()
end

-------------------------------------
-- get bar scroll direction
-- @treturn string direction
-------------------------------------
function UIScrollBar:getDir()
    return self.dir
end

-------------------------------------
-- (callback)
-- on bar down
-------------------------------------
function UIScrollBar:onBarDown(x, y)
    self.barDown = true
end

-------------------------------------
-- (callback)
-- on bar move
-------------------------------------
function UIScrollBar:onBarMove(x, y, dx, dy)
    if not self.barDown then return end

    local bar = self.bar

    if self.dir == "vertical" then
        local after = bar:getY() + dy
        if after < 0 then
            after = 0
        elseif after + bar:getHeight() > self:getHeight() then
            after = self:getHeight() - bar:getHeight()
        end
        self.barPosRatio = after / (self:getHeight() - bar:getHeight())
    else
        local after = bar:getX() + dx
        if after < 0 then
            after = 0
        elseif after + bar:getWidth() > self:getWidth() then
            after = self:getWidth() - bar:getWidth()
        end
        self.barPosRatio = after / (self:getWidth() - bar:getWidth())
    end

    self:setBarPos(self.barPosRatio)
end

-------------------------------------
-- (callback)
-- on bar up
-------------------------------------
function UIScrollBar:onBarUp(x, y)
    self.barDown = false
end

-------------------------------------
-- (callback)
-- on bar down
-------------------------------------
function UIScrollBar:onBgDown(x, y)
    x, y = self:globalToLocal(x, y)

    if self.dir == "vertical" then
        self:setBarPos(y / self:getHeight())
    else
        self:setBarPos(x / self:getWidth())
    end
end

-------------------------------------
-- (override)
-------------------------------------
function UIScrollBar:setSize(width, height)
    UIControl.setSize(self, width, height)
    self:reset()
end

-------------------------------------
-- (override)
-------------------------------------
function UIScrollBar:setWidth(width)
    UIControl.setWidth(self, width)
    self:reset()
end

-------------------------------------
-- (override)
-------------------------------------
function UIScrollBar:setHeight(height)
    UIControl.setHeight(self, height)
    self:reset()
end

-------------------------------------
-- set bar up color
-- @tab color
-------------------------------------
function UIScrollBar:setUpColor(color)
    self.upColor = color
end

-------------------------------------
-- set bar down color
-- @tab color
-------------------------------------
function UIScrollBar:setDownColor(color)
    self.downColor = color
end

-------------------------------------
-- set bar hover color
-- @tab color
-------------------------------------
function UIScrollBar:setHoverColor(color)
    self.hoverColor = color
end

-------------------------------------
-- set bar position with ratio
-- @number ratio value: 0-1
-------------------------------------
function UIScrollBar:setRatio(ratio)
    self.ratio = ratio < 1 and 1 or ratio
    self:reset()
end

-------------------------------------
-- reset contorl
-------------------------------------
function UIScrollBar:reset()
    local ratio = self.ratio
    if self.dir == "vertical" then
        self.bar:setWidth(self:getWidth())
        self.bar:setHeight(self:getHeight() / ratio)
    else
        self.bar:setWidth(self:getWidth() / ratio)
        self.bar:setHeight(self:getHeight())
    end
    self:setBarPos(self.barPosRatio)
end

-------------------------------------
-- set bar position with ratio
-- @number ratio
-------------------------------------
function UIScrollBar:setBarPos(ratio)
    if ratio < 0 then ratio = 0 end
    if ratio > 1 then ratio = 1 end

    self.barPosRatio = ratio
    if self.dir == "vertical" then
        self.bar:setX(0)
        self.bar:setY((self:getHeight() - self.bar:getHeight()) * ratio)
    else
        self.bar:setX((self:getWidth() - self.bar:getWidth()) * ratio)
        self.bar:setY(0)
    end

    self.events:dispatch(UI_ON_SCROLL, ratio)
end

-------------------------------------
-- get bar position with ratio
-- @treturn number ratio
-------------------------------------
function UIScrollBar:getBarPos()
    return self.barPosRatio
end

return UIScrollBar
