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
-- UIRoot
-- ui root control
-------------------------------------
local UIRoot = UIControl:extend("UIRoot", {
    coreContainer,
    popupContainer,
    optionContainer,
    tipContainer,
})

-------------------------------------
-- construct
-------------------------------------
function UIRoot:init()
    UIControl.init(self)

    local width = love.graphics.getWidth()
    local height = love.graphics.getHeight()

    self:setSize(width, height)

    self.coreContainer = UIControl:new()
    self.coreContainer:setSize(width, height)
    self:addChild(self.coreContainer, 1)

    self.popupContainer = UIControl:new()
    self.popupContainer:setSize(width, height)
    self:addChild(self.popupContainer, 2)

    self.optionContainer = UIControl:new()
    self.optionContainer:setSize(width, height)
    self:addChild(self.optionContainer, 3)

    self.tipContainer = UIControl:new()
    self.tipContainer:setSize(width, height)
    self:addChild(self.tipContainer, 4)
end

---------------------------------------
-- love2d resize window callback
---------------------------------------
function UIRoot:resize(w, h)
    self:setSize(w, h)
	
	self.coreContainer:setSize(w, h)
	
	self.popupContainer:setSize(w, h)
	
	self.optionContainer:setSize(w, h)
	
	self.tipContainer:setSize(w, h)
end

return UIRoot
