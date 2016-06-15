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
-- Rect
-- @usage
-- local rect = Rect:new(10, 10, 10, 10)
-------------------------------------
local Rect = class("Rect", {
    left = 0,
    top = 0,
    right = 0,
    bottom = 0
})

-------------------------------------
-- construct
-------------------------------------
function Rect:init(left, top, right, bottom)
    self.left = left or 0
    self.top = top or 0
    self.right = right or 0
    self.bottom = bottom or 0
end

-------------------------------------
-- contains
-- @number x
-- @number y
-- @treturn bool is contains
-------------------------------------
function Rect:contains(x, y)
    if x < self.left or x >= self.right or y < self.top or y >= self.bottom then
        return false
    end
    return true
end

-------------------------------------
-- get x and y position
-- @treturn number left
-- @treturn number top
-------------------------------------
function Rect:getPos()
    return self.left, self.top
end

-------------------------------------
-- get x position
-- @treturn number x
-------------------------------------
function Rect:getX()
    return self.left
end

-------------------------------------
-- get y position
-- @treturn number y
-------------------------------------
function Rect:getY()
    return self.top
end

-------------------------------------
-- get width and height
-- @treturn number width
-- @treturn number height
-------------------------------------
function Rect:getSize()
    local w = self.right - self.left
    local h = self.bottom - self.top
    return w, h
end

-------------------------------------
-- get width
-- @treturn number width
-------------------------------------
function Rect:getWidth()
    return self.right - self.left
end

-------------------------------------
-- get height
-- @treturn number height
-------------------------------------
function Rect:getHeight()
    return self.bottom - self.top
end

return Rect
