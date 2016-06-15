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
-- UIContent
-- A scroll container, default with two scrollbar
-- @usage
-- local content = UIContent:new()
-- content:setSize(100, 100) -- set frame size
-- content:setContentSize(450, 450) -- set content size
-------------------------------------
local UIContent = UIControl:extend("UIContent", {
    backgroundColor = nil,
    barSize = 12,

    contentCtrl = nil,
    vBar = nil,
    hBar = nil
})

-------------------------------------
-- construct
-------------------------------------
function UIContent:init()
    UIControl.init(self)

    self:initTheme()

    self:setClip(true)
    self:setEnabled(true)
    self.events:on(UI_WHELL_MOVE, self.onWhellMove, self)
    self.events:on(UI_DRAW, self.onDraw, self)

    self.contentCtrl = UIControl:new()
    UIControl.addChild(self, self.contentCtrl)

    -- 垂直
    self.vBar = UIScrollBar:new()
    self.vBar:setDir("vertical")
    self.vBar.events:on(UI_ON_SCROLL, self.onVBarScroll, self)
    UIControl.addChild(self, self.vBar)

    -- 水平
    self.hBar = UIScrollBar:new()
    self.hBar:setDir("horizontal")
    self.hBar.events:on(UI_ON_SCROLL, self.onHBarScroll, self)
    UIControl.addChild(self, self.hBar)
end

-------------------------------------
-- init Theme Style
-- @tab _theme
-------------------------------------
function UIContent:initTheme(_theme)
    local theme = theme or _theme
    self.barSize = theme.content.barSize
    self.backgroundColor = theme.content.backgroundColor
end

-------------------------------------
-- (callback)
-- draw self
-------------------------------------
function UIContent:onDraw()
    local box = self:getBoundingBox()
    local r, g, b, a = love.graphics.getColor()
    local color = self.backgroundColor
    love.graphics.setColor(color[1], color[2], color[3], color[4])
    love.graphics.rectangle("fill", box:getX(), box:getY(), box:getWidth(), box:getHeight())
    love.graphics.setColor(r, g, b, a)
end

-------------------------------------
-- (callback)
-- on mouse whell move
-------------------------------------
function UIContent:onWhellMove(x, y)
    if x ~= 0 and self:getWidth() > self.contentCtrl:getWidth() then
        return false
    end

    if y ~= 0 and self:getHeight() > self.contentCtrl:getHeight() then
        return false
    end

    if x ~= 0 then
        local offsetR = x / self:getContentWidth() * 3
        self.hBar:setBarPos(self.hBar:getBarPos() - offsetR)
    end

    if y ~= 0 then
        local offsetR = y / self:getContentHeight() * 3
        self.vBar:setBarPos(self.vBar:getBarPos() - offsetR)
    end

    return true
end

-------------------------------------
-- (callback)
-- on vertical scroll
-------------------------------------
function UIContent:onVBarScroll(ratio)
    local offset = -ratio * self:getContentHeight()
    self.contentCtrl:setY(offset)
end

-------------------------------------
-- (callback)
-- on horizontal scroll
-------------------------------------
function UIContent:onHBarScroll(ratio)
    local offset = -ratio * self:getContentWidth()
    self.contentCtrl:setX(offset)
end

-------------------------------------
-- (override)
-------------------------------------
function UIContent:setSize(width, height)
    UIControl.setSize(self, width, height)
    self:resetBar()
end

-------------------------------------
-- (override)
-------------------------------------
function UIContent:setWidth(width)
    UIControl.setWidth(self, width)
    self:resetBar()
end

-------------------------------------
-- (override)
-------------------------------------
function UIContent:setHeight(height)
    UIControl.setHeight(self, height)
    self:resetBar()
end

-------------------------------------
-- get content control
-- @treturn UIControl content control
-------------------------------------
function UIContent:getContent()
    return self.contentCtrl
end

-------------------------------------
-- set content size
-- @number width
-- @number height
-------------------------------------
function UIContent:setContentSize(width, height)
    self.contentCtrl:setSize(width, height)
    self:resetBar()
end

-------------------------------------
-- get content size
-- @treturn number width
-- @treturn number height
-------------------------------------
function UIContent:getContentSize()
    return self.contentCtrl:getSize()
end

-------------------------------------
-- get content width
-- @treturn number width
-------------------------------------
function UIContent:getContentWidth()
    return self.contentCtrl:getWidth()
end

-------------------------------------
-- get content height
-- @treturn number height
-------------------------------------
function UIContent:getContentHeight()
    return self.contentCtrl:getHeight()
end

-------------------------------------
-- set content offset
-- @number x
-- @number y
-------------------------------------
function UIContent:setContentOffsetPos(x, y)
    self.contentCtrl:setPos(x, y)
    self:resetBar()
end

-------------------------------------
-- set content x offset
-- @number x
-------------------------------------
function UIContent:setContentOffsetX(x)
    self.contentCtrl:setX(x)
    self:resetBar()
end

-------------------------------------
-- set content y offset
-- @number y
-------------------------------------
function UIContent:setContentOffsetY(y)
    self.contentCtrl:setY(y)
    self:resetBar()
end

-------------------------------------
-- (override)
-------------------------------------
function UIContent:addChild(child, depth)
    self.contentCtrl:addChild(child, depth)
end

-------------------------------------
-- (override)
-------------------------------------
function UIContent:removeChild(child)
    self.contentCtrl:removeChild(child)
end

-------------------------------------
-- reset bar size & position
-------------------------------------
function UIControl:resetBar()
    self.vBar:setSize(self.barSize, self:getHeight() - self.barSize)
    self.vBar:setPos(self:getWidth() - self.barSize, 0)

    self.hBar:setSize(self:getWidth() - self.barSize, self.barSize)
    self.hBar:setPos(0, self:getHeight() - self.barSize)

    local cw, ch = self:getContentSize()
    self.vBar:setRatio(ch/self:getHeight())
    self.hBar:setRatio(cw/self:getWidth())
end

return UIContent
