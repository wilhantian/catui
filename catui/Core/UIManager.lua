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

local function dispatch(ctrl, name, ...)
    ctrl.events:dispatch(name, ...)
end

---------------------------------------
-- UIManager
---------------------------------------
local UIManager = class("UIManager", {
    rootCtrl = nil,
    hoverCtrl = nil,
    focusCtrl = nil,
    holdCtrl = nil,

    lastClickCtrl = nil,
    lastClickTime = love.timer.getTime()
})

---------------------------------------
-- get a UIManager instance
-- @return UIManager
---------------------------------------
function UIManager:getInstance()
    if not UIManager.instance then
        UIManager.instance = UIManager:new()
    end
    return UIManager.instance
end

-------------------------------------
-- construct
-------------------------------------
function UIManager:init()
    -- TODO 此处由用户设置
    self.rootCtrl = self:createRootCtrl()
end

-------------------------------------
-- create root control
-- @return UIControl
-------------------------------------
function UIManager:createRootCtrl()
    local ctrl = UIRoot:new()
    self.rootCtrl = ctrl
    return ctrl
end

---------------------------------------
-- get root control
---------------------------------------
function UIManager:getRootCtrl()
    return self.rootCtrl
end

---------------------------------------
-- love2d update callback
-- @number dt
---------------------------------------
function UIManager:update(dt)
    if self.rootCtrl then
        self.rootCtrl:update(dt)
    end
end

---------------------------------------
-- love2d draw callback
---------------------------------------
function UIManager:draw()
    if self.rootCtrl then
        self.rootCtrl:draw()
    end
end

---------------------------------------
-- love2d mouse move callback
---------------------------------------
function UIManager:mouseMove(x, y, dx, dy)
    if not self.rootCtrl then
        return
    end

    local hitCtrl = self.rootCtrl:hitTest(x, y)
    if hitCtrl ~= self.hoverCtrl then
        if self.hoverCtrl then
            dispatch(self.hoverCtrl, UI_MOUSE_LEAVE)
        end

        self.hoverCtrl = hitCtrl

        if hitCtrl then
            dispatch(hitCtrl, UI_MOUSE_ENTER)
        end
    end

    if self.holdCtrl then
        dispatch(self.holdCtrl, UI_MOUSE_MOVE, x, y, dx, dy)
    else
        if self.hoverCtrl then
            dispatch(self.hoverCtrl, UI_MOUSE_MOVE, x, y, dx, dy)
        end
    end
end

---------------------------------------
-- love2d mouse down callback
---------------------------------------
function UIManager:mouseDown(x, y, button, isTouch)
    if not self.rootCtrl then
        return
    end

    local hitCtrl = self.rootCtrl:hitTest(x, y)
    if hitCtrl then
        dispatch(hitCtrl, UI_MOUSE_DOWN, x, y, button, isTouch)
        self.holdCtrl = hitCtrl
    end

    self:setFocus(hitCtrl)
end

---------------------------------------
-- love2d mouse up callback
---------------------------------------
function UIManager:mouseUp(x, y, button, isTouch)
    if self.holdCtrl then
        -- 派发抬起
        dispatch(self.holdCtrl, UI_MOUSE_UP, x, y, button, isTouch)

        -- 点击事件验证
        if self.rootCtrl then
            local hitCtrl = self.rootCtrl:hitTest(x, y)
            if hitCtrl == self.holdCtrl then
                -- 检测是否双击
                if self.lastClickCtrl and self.lastClickCtrl == self.holdCtrl and (love.timer.getTime() - self.lastClickTime) <= 0.4 then
                    -- 派发双击事件
                    dispatch(self.holdCtrl, UI_DB_CLICK, self.holdCtrl, x, y)

                    self.lastClickCtrl = nil
                    self.lastClickTime = 0
                else
                    -- 派发点击事件
                    dispatch(self.holdCtrl, UI_CLICK, self.holdCtrl, x, y)

                    self.lastClickCtrl = self.holdCtrl
                    self.lastClickTime = love.timer.getTime()
                end
            end
        end

        self.holdCtrl = nil
    end
end

---------------------------------------
-- love2d whell move callback
---------------------------------------
function UIManager:whellMove(x, y)
    local hitCtrl = self.rootCtrl:hitTest(love.mouse.getX(), love.mouse.getY())
    while hitCtrl do
        self:mouseMove(love.mouse.getX(), love.mouse.getY(), 0, 0)
        if hitCtrl.events:dispatch(UI_WHELL_MOVE, x, y) then
            return
        end
        hitCtrl = hitCtrl:getParent()
    end
end

---------------------------------------
-- love2d key down callback
---------------------------------------
function UIManager:keyDown(key, scancode, isrepeat)
    if self.focusCtrl then
        dispatch(self.focusCtrl, UI_KEY_DOWN, key, scancode, isrepeat)
    end
end

---------------------------------------
-- love2d key up callback
---------------------------------------
function UIManager:keyUp(key)
    if self.focusCtrl then
        dispatch(self.focusCtrl, UI_KEY_UP, key)
    end
end

---------------------------------------
-- love2d text input callback
---------------------------------------
function UIManager:textInput(text)
    if self.focusCtrl then
        dispatch(self.focusCtrl, UI_TEXT_INPUT, text)
    end
end

---------------------------------------
-- set focus control
-- @param control
---------------------------------------
function UIManager:setFocus(ctrl)
    if self.focusCtrl == ctrl then
        return
    end

    if self.focusCtrl then
        dispatch(self.focusCtrl, UI_UN_FOCUS)
    end

    self.focusCtrl = ctrl

    if self.focusCtrl then
        dispatch(self.focusCtrl, UI_FOCUS)
    end
end

return UIManager
