local UIManager = class("UIManager", {
    hoverCtrl = nil,
    focusCtrl = nil,
    holdCtrl = nil,
    rootCtrl = nil,
})

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

    -- 派发焦点控件的移动事件
    if self.focusCtrl then
        self.focusCtrl:mouseMove(x, y, dx, dy)
    end

    local hitCtrl = self.rootCtrl:hitTest(x, y)

    -- 尝试探测鼠标进入与离开事件
    if hitCtrl ~= self.hoverCtrl then
        if self.hoverCtrl then
            self.hoverCtrl:mouseLeave()
        end

        self.hoverCtrl = hitCtrl

        if hitCtrl then
            hitCtrl:mouseEnter()
        end
    end

    -- 派发悬浮控件的移动事件
    if self.hoverCtrl then
        self.hoverCtrl:mouseMove(x, y, dx, dy)
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
        self.focusCtrl:unFocus()
    end

    self.focusCtrl = ctrl

    if self.focusCtrl then
        self.focusCtrl:focus()
    end
end

return UIManager
