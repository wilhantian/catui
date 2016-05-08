---------------------------------------
-- 为控件派发消息
---------------------------------------
local function dispatch(ctrl, name, ...)
    ctrl.events:dispatch(name, ...)
end

---------------------------------------
-- UI管理器
---------------------------------------
local UIManager = class("UIManager", {
    hoverCtrl = nil,
    focusCtrl = nil,
    holdCtrl = nil,
    rootCtrl = nil,

    lastClickCtrl = nil,
    lastClickTime = love.timer.getTime()
})

---------------------------------------
-- 获取单利
---------------------------------------
function UIManager:getInstance()
    if not UIManager.instance then
        UIManager.instance = UIManager:new()
    end
    return UIManager.instance
end

---------------------------------------
-- 构造
---------------------------------------
function UIManager:init()
    local ctrl = UIControl:new()
    ctrl.x = 0
    ctrl.y = 0
    ctrl.width = love.graphics.getWidth()
    ctrl.height = love.graphics.getHeight()
    self.rootCtrl = ctrl
end

---------------------------------------
-- UI更新
---------------------------------------
function UIManager:update(dt)
    if self.rootCtrl then
        self.rootCtrl:update(dt)
    end
end

---------------------------------------
-- 渲染
---------------------------------------
function UIManager:draw(dt)
    if self.rootCtrl then
        self.rootCtrl:draw(dt)
    end
end

---------------------------------------
-- 鼠标移动
---------------------------------------
function UIManager:mouseMove(x, y, dx, dy)
    if not self.rootCtrl then
        return
    end

    -- 尝试探测鼠标进入与离开事件
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

    -- 派发锁定控件的移动事件
    if self.holdCtrl then
        dispatch(self.holdCtrl, UI_MOUSE_MOVE, x, y, dx, dy)
    else
        -- 派发悬浮控件的移动事件
        if self.hoverCtrl then
            dispatch(self.hoverCtrl, UI_MOUSE_MOVE, x, y, dx, dy)
        end
    end

end

---------------------------------------
-- 鼠标按下
---------------------------------------
function UIManager:mouseDown(x, y, button, isTouch)
    if not self.rootCtrl then
        return
    end

    -- 鼠标点击
    local hitCtrl = self.rootCtrl:hitTest(x, y)
    if hitCtrl then
        dispatch(hitCtrl, UI_MOUSE_DOWN, x, y, button, isTouch)
        self.holdCtrl = hitCtrl --设置按下控件
    end

    self:setFocus(hitCtrl)
end

---------------------------------------
-- 设置抬起
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
-- 设置焦点
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
