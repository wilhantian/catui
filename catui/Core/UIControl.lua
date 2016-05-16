local UIControl = class("UIControl", {
    x = 0,
    y = 0,
    width = 0,
    height = 0,
    depth = 0,
    children = {},
    parent = nil,
    visible = true,
    enabled = false,
    childrenEnabled = true,
    events = nil,
})

---------------------------------------
-- 构造
---------------------------------------
function UIControl:init()
    self.events = UIEvent:new()
end

---------------------------------------
-- 设置属性
---------------------------------------
function UIControl:set(attrs)
    for k,v in pairs(attrs) do
        self[k] = v
    end
end

---------------------------------------
-- 更新
---------------------------------------
function UIControl:update(dt)
    self.events:dispatch(UI_UPDATE, dt)
    for i,v in ipairs(self.children) do
        v:update(dt)
    end
end

---------------------------------------
-- 渲染
---------------------------------------
function UIControl:draw()
    if not self.visible then
        return
    end

    self.events:dispatch(UI_DRAW)
    for i,v in ipairs(self.children) do
        v:draw(dt)
    end
end

---------------------------------------
-- 检测坐标
---------------------------------------
function UIControl:hitTest(x, y)
    local globalX, globalY = self:globalToLocal(x, y)

    if globalX < 0 or globalY < 0 or globalX >= self.width or globalY >= self.height or not self.visible then
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

---------------------------------------
-- 局部坐标转全局坐标
---------------------------------------
function UIControl:localToGlobal(x, y)
    x = (x or 0) + self.x
    y = (y or 0) + self.y

    if self.parent then
        x, y = self.parent:localToGlobal(x, y)
    end
    return x, y
end

---------------------------------------
-- 全局坐标转局部坐标
---------------------------------------
function UIControl:globalToLocal(x, y)
    x = (x or 0) - self.x
    y = (y or 0) - self.y

    if self.parent then
        x, y = self.parent:globalToLocal(x, y)
    end
    return x, y
end

---------------------------------------
-- 添加一个子控件
---------------------------------------
function UIControl:addChild(child, depth)
    child.parent = self
    child.depth = depth
    table.insert(self.children, child)
    self:sortChildren()
end

---------------------------------------
-- 移除一个子控件
---------------------------------------
function UIControl:removeChild(child)
    for i,v in ipairs(self.children) do
        if v == child then
            table.remove(self.children, i)
            break
        end
    end
end

---------------------------------------
-- 对子控件排序
---------------------------------------
function UIControl:sortChildren()
    table.sort(self.children, function(a, b)
        return a.depth > b.depth
    end)
end

---------------------------------------
-- 设置焦点
---------------------------------------
function UIControl:setFocus()
    UIManager:getInstance():setFocus(self)
end

---------------------------------------
-- 设置坐标
---------------------------------------
function UIControl:setPos(x, y)
    self.x = x
    self.y = y
end

---------------------------------------
-- 获取坐标
---------------------------------------
function UIControl:getPos()
    return self.x, self.y
end

---------------------------------------
-- 设置宽度
---------------------------------------
function UIControl:setWidth(width)
    self.width = width
end

---------------------------------------
-- 设置高度
---------------------------------------
function UIControl:setHeight(height)
    self.height = height
end

---------------------------------------
-- 设置深度
---------------------------------------
function UIControl:setDepth(depth)
    self.depth = depth
    if self.parent then
        self.parent:sortChildren()
    end
end

return UIControl
