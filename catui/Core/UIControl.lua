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
-- UIControl
-- @usage
-- local control = UIControl:new()
--
-- -- enable control
-- control:setEnabled(true)
--
-- -- draw
-- control.events:on(UI_DRAW, function()
--     local box = self:getBoundingBox()
--     local x, y = box.left, box.top
--     local w, h = box:getWidth(), box:getHeight()
--     love.graphics.rectangle(x, y, w, h)
-- end, control)
--
-- -- on control click
-- control.events:on(UI_CLICK, function()
--     print("the control is click")
-- end)
-------------------------------------
local UIControl = class("UIControl", {
    x = 0,
    y = 0,
    anchorX = 0,
    anchorY = 0,
    width = 0,
    height = 0,
    depth = 0,
    children = {},
    parent = nil,
    visible = true,
    enabled = false,
    childrenEnabled = true,
    events = nil,
    clip = false,
    isNeedValidate = false,
    worldX = 0,
    worldY = 0,
    boundingBox = nil
})

-------------------------------------
-- construct
-------------------------------------
function UIControl:init()
    self.events = UIEvent:new()
    self.boundingBox = Rect:new()
end

-------------------------------------
-- love2d update callback
-- @number dt
-------------------------------------
function UIControl:update(dt)
    self:validate()
    self.events:dispatch(UI_UPDATE, dt)

    for i,v in ipairs(self.children) do
        v:update(dt)
    end
end

-------------------------------------
-- love2d draw callback
-------------------------------------
function UIControl:draw()
    if not self.visible then
        return
    end

    self:clipBegin()

    self.events:dispatch(UI_DRAW)

    for i,v in ipairs(self.children) do
        v:draw(dt)
    end

    self:clipEnd()
end

-------------------------------------
-- set control is enable clipping
-------------------------------------
function UIControl:setClip(isClip)
    self.clip = isClip
end

-------------------------------------
-- get control is enable clipping
-------------------------------------
function UIControl:isClip()
    return self.clip
end

-------------------------------------
-- clipping begin
-------------------------------------
function UIControl:clipBegin()
    if self.clip then
        local box = self:getBoundingBox()
		local x, y = box.left, box.top
        local w, h = box:getWidth(), box:getHeight()
        self.ox, self.oy, self.ow, self.oh = clipScissor(x, y, w, h)
	end
end

-------------------------------------
-- clipping end
-------------------------------------
function UIControl:clipEnd()
    if self.clip then
        love.graphics.setScissor(self.ox, self.oy, self.ow, self.oh)
	end
end

-------------------------------------
-- need validate layout
-------------------------------------
function UIControl:needValidate()
    self.isNeedValidate = true
end

-------------------------------------
-- validate layout
-------------------------------------
function UIControl:validate()
    if not self.isNeedValidate then
        return
    end

    local x, y = self:localToGlobal()
    local w = self.width * self.anchorX
    local h = self.height * self.anchorY
    self.worldX = x - w
    self.worldY = y - h

    local box = self.boundingBox
    box.left = self.worldX
    box.top = self.worldY
    box.right = self.worldX + self.width
    box.bottom = self.worldY + self.height

    for i,v in ipairs(self.children) do
        v:needValidate()
        v:validate()
    end

    self.isNeedValidate = false
end

-------------------------------------
-- set anchor point
-- @number x
-- @number y
-------------------------------------
function UIControl:setAnchor(x, y)
    self.anchorX = x
    self.anchorY = y
    self:needValidate()
end

-------------------------------------
-- get anchor point
-- @treturn number x
-- @treturn number y
-------------------------------------
function UIControl:getAnchor()
    return self.anchorX, self.anchorY
end

-------------------------------------
-- set anchor point x
-- @number x
-------------------------------------
function UIControl:setAnchorX(x)
    self.anchorX = x
    self:needValidate()
end

-------------------------------------
-- get anchor point x
-- @treturn number x
-------------------------------------
function UIControl:getAnchorX()
    return self.anchorX
end

-------------------------------------
-- set anchor point y
-- @number x
-------------------------------------
function UIControl:setAnchorY(y)
    self.anchorY = y
    self:needValidate()
end

-------------------------------------
-- get anchor point y
-- @number y
-------------------------------------
function UIControl:getAnchorY()
    return self.anchorY
end

-------------------------------------
-- set position
-- @number x
-- @number y
-------------------------------------
function UIControl:setPos(x, y)
    self.x = x
    self.y = y
    self:needValidate()
    self.events:dispatch(UI_MOVE)
end

-------------------------------------
-- get position
-- @treturn number x
-- @treturn number y
-------------------------------------
function UIControl:getPos()
    return self.x, self.y
end

-------------------------------------
-- set position x
-- @number x
-------------------------------------
function UIControl:setX(x)
    self.x = x
    self:needValidate()
end

-------------------------------------
-- get position x
-- @treturn number x
-------------------------------------
function UIControl:getX()
    return self.x
end

-------------------------------------
-- set position y
-- @number y
-------------------------------------
function UIControl:setY(y)
    self.y = y
    self:needValidate()
end

-------------------------------------
-- get position y
-- @treturn number y
-------------------------------------
function UIControl:getY()
    return self.y
end

-------------------------------------
-- set size
-- @number width
-- @number height
-------------------------------------
function UIControl:setSize(width, height)
    self.width = width
    self.height = height
    self:needValidate()
end

-------------------------------------
-- get size
-- @treturn number width
-- @treturn number height
-------------------------------------
function UIControl:getSize()
    return self.width, self.height
end

-------------------------------------
-- set width
-- @number width
-------------------------------------
function UIControl:setWidth(width)
    self.width = width
    self:needValidate()
end

-------------------------------------
-- get width
-- @treturn number width
-------------------------------------
function UIControl:getWidth()
    return self.width
end

-------------------------------------
-- set height
-- @number height
-------------------------------------
function UIControl:setHeight(height)
    self.height = height
    self:needValidate()
end

-------------------------------------
-- get height
-- @treturn number height
-------------------------------------
function UIControl:getHeight()
    return self.height
end

-------------------------------------
-- get bounding box
-- @treturn Rect bounding box
-------------------------------------
function UIControl:getBoundingBox()
    return self.boundingBox
end

-------------------------------------
-- set parent control
-- @param UIControl
-------------------------------------
function UIControl:setParent(parent)
    self.parent = parent
    self:needValidate()
end

-------------------------------------
-- get parent control
-- @treturn UIControl parent
-------------------------------------
function UIControl:getParent()
    return self.parent
end

-------------------------------------
-- set control enable status
-- @bool enabled
-------------------------------------
function UIControl:setEnabled(enabled)
    self.enabled = enabled
end

-------------------------------------
-- get control enable status
-- @treturn bool status
-------------------------------------
function UIControl:isEnabled()
    return self.enabled
end

-------------------------------------
-- set children control enable status
-- @bool enabled
-------------------------------------
function UIControl:setChildrenEnabled(enabled)
    self.childrenEnabled = enabled
end

-------------------------------------
-- get children control enable status
-- @treturn bool enabled
-------------------------------------
function UIControl:isChildrenEnabled()
    return self.childrenEnabled
end

-------------------------------------
-- hit test
-- @number x
-- @number y
-- @treturn UIControl
-------------------------------------
function UIControl:hitTest(x, y)
    local globalX, globalY = self:globalToLocal(x, y)

    if not self:getBoundingBox():contains(x, y) then
        return nil
    end

    if self.childrenEnabled then --如果子类开启
        for i,v in ipairs(self.children) do
            local ctrl = self.children[#self.children - i + 1]
            local hitCtrl = ctrl:hitTest(x, y)
            if hitCtrl then
                return hitCtrl
            end
        end
    end

    if self.enabled then
        return self
    else
        return nil
    end
end

-------------------------------------
-- local position to world position
-- @number x
-- @number y
-- @treturn number world x
-- @treturn number world y
-------------------------------------
function UIControl:localToGlobal(x, y)
    x = (x or 0) + self.x
    y = (y or 0) + self.y

    if self.parent then
        x, y = self.parent:localToGlobal(x, y)
    end
    return x, y
end

-------------------------------------
-- world position to local position
-- @number x
-- @number y
-- @treturn number local x
-- @treturn number local y
-------------------------------------
function UIControl:globalToLocal(x, y)
    x = (x or 0) - self.x
    y = (y or 0) - self.y

    if self.parent then
        x, y = self.parent:globalToLocal(x, y)
    end
    return x, y
end

-------------------------------------
-- set control depth
-- @number depth
-------------------------------------
function UIControl:setDepth(depth)
    self.depth = depth
    if self.parent then
        self.parent:sortChildren()
    end
end

-------------------------------------
-- get control depth
-- @treturn number depth
-------------------------------------
function UIControl:getDepth()
    return self.depth
end

-------------------------------------
-- add a child control
-- @param child
-- @number depth
-------------------------------------
function UIControl:addChild(child, depth)
    table.insert(self.children, child)
    child:setParent(self)
    if depth then
        child:setDepth(depth)
    end
    child.events:dispatch(UI_ON_ADD)
end

-------------------------------------
-- remove a child control
-- @param child
-------------------------------------
function UIControl:removeChild(child)
    for i,v in ipairs(self.children) do
        if v == child then
            table.remove(self.children, i)
            child.events:dispatch(UI_ON_REMOVE)
            break
        end
    end
end

-------------------------------------
-- sort children
-------------------------------------
function UIControl:sortChildren()
    table.sort(self.children, function(a, b)
        return a.depth < b.depth
    end)
end

-------------------------------------
-- get all child
-- @treturn tab child control table
-------------------------------------
function UIControl:getChildren()
    return self.children
end

-------------------------------------
-- set control is focus
-------------------------------------
function UIControl:setFocus()
    UIManager:getInstance():setFocus(self)
end

return UIControl
