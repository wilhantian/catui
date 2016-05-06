local UIManager = class("UIManager", {
    hoverCtrl = nil,
    focusCtrl = nil,
    rootCtrl = nil,
})

---------------------------------------
-- 构造
---------------------------------------
function UIManager:init()
end

---------------------------------------
-- UI更新
---------------------------------------
function UIManager:doUpdate(dt)
    if self.rootCtrl then
        self.rootCtrl:doUpdate(dt)
    end
end

---------------------------------------
-- 渲染
---------------------------------------
function UIManager:doDraw(dt)
    if self.rootCtrl then
        self.rootCtrl:doDraw(dt)
    end
end

---------------------------------------
-- 鼠标移动
---------------------------------------
function UIManager:mouseMove(x, y, dx, dy)
    if not rootCtrl then
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
