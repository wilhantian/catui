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
-- UIImage
-- @usage
-- local img = UIImage:new("img/gem.png")
-------------------------------------
local UIImage = UIControl:extend("UIImage", {
    drawable = nil
})

-------------------------------------
-- construct
-------------------------------------
function UIImage:init(fileName)
    UIControl.init(self)

    self:setImage(fileName)
    self:resetSize()

    self.events:on(UI_DRAW, self.onDraw, self)
end

-------------------------------------
-- (callback)
-- draw self
-------------------------------------
function UIImage:onDraw()
    local box = self:getBoundingBox()
    local x, y = box:getX(), box:getY()
    local w, h = box:getWidth(), box:getHeight()
    love.graphics.draw(self.drawable, x, y)
end

-------------------------------------
-- set a image
-- @string fileName file path
-------------------------------------
function UIImage:setImage(fileName)
    if fileName then
        self.drawable = love.graphics.newImage(fileName)
    end
end

-------------------------------------
-- reset size
-------------------------------------
function UIImage:resetSize()
    if self.drawable then
        self:setWidth(self.drawable:getWidth())
        self:setHeight(self.drawable:getHeight())
    else
        self:setWidth(0)
        self:setHeight(0)
    end
end

return UIImage
