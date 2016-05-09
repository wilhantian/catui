local UIControl = class("UIControl", {
    x = 0,
    y = 0,
    -- anchorX = 0,
    -- anchorY = 0,
    -- scaleX = 1,
    -- scaleY = 1,
    width = 0,
    height = 0,
    depth = 0,
    children = {},
    parent = nil,
    visible = true,
    enabled = true,
    childrenEnabled = true,
    events = nil,

    color = nil,
    stroke = 0,
    strokeColor = nil,
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
    local x, y = self:localToGlobal()
    local width, height = self.width, self.height

    love.graphics.push("all")
        -- 绘制描边
        local stroke = self.stroke
        local strokeColor = self.strokeColor
        if stroke > 0 and strokeColor then
            love.graphics.setLineWidth(stroke)
            love.graphics.setColor(strokeColor[1], strokeColor[2], strokeColor[3], strokeColor[4])
            love.graphics.rectangle("line", x, y, width, height)
        end
        -- 绘制底色
        local color = self.color
        if color then
            love.graphics.setColor(color[1], color[2], color[3], color[4])
            love.graphics.rectangle("fill", x, y, width, height)
        end
    love.graphics.pop()

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
    if globalX < 0 or globalY < 0 or globalX >= self.width or globalY >= self.height then
        return nil
    end

    for i,v in ipairs(self.children) do
        local ctrl = self.children[#self.children - i + 1]
        local hitCtrl = ctrl:hitTest(x, y)
        if hitCtrl then
            return hitCtrl
        end
    end

    return self
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
    table.insert(self.children, child)
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
-- 设置焦点
---------------------------------------
function UIControl:setFocus()
    UIManager:getInstance():setFocus(self)
end

return UIControl
