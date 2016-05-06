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

    -- 自定义参数
    tag = nil,
    userData = nil,
})

---------------------------------------
-- 构造
---------------------------------------
function UIControl:init()
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
end

---------------------------------------
-- 系统更新 由UIManager调用
---------------------------------------
function UIControl:doUpdate(dt)
    self:update(dt)
    for i,v in ipairs(self.children) do
        v:update(dt)
    end
end

---------------------------------------
-- 渲染
---------------------------------------
function UIControl:draw()
end

---------------------------------------
-- 系统渲染 由UIManager调用
---------------------------------------
function UIControl:doDraw()
    self:draw(dt)
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
        if childCtrl then
            return childCtrl
        end
    end

    return self
end

---------------------------------------
-- 局部坐标转全局坐标
---------------------------------------
function UIControl:localToGlobal(x, y)
    local bx, by = 0, 0
    if self.parent then
        bx, by = self.parent:localToGlobal(x, y)
    end
    return bx + self.x, by + self.y
end

---------------------------------------
-- 全局坐标转局部坐标
---------------------------------------
function UIControl:globalToLocal(x, y)
  local bx, by = 0, 0
  if self.parent then
      bx, by = self.parent:globalToLocal(x, y)
  end
  return bx - self.x, by - self.y
end

---------------------------------------
-- 添加一个子控件
---------------------------------------
function UIControl:addChild(child, depth)
    child.parent = self
    table.insert(self.children, child, depth)
end

---------------------------------------
-- 移除一个子控件
---------------------------------------
function UIControl:removeChild(child)
    for i,v in ipairs(self.children) do
        if self.children == child then
            table.remove(self.children, i)
            break
        end
    end
end

---------------------------------------
-- 鼠标进入
---------------------------------------
function UIControl:mouseEnter()
end

---------------------------------------
-- 鼠标离开
---------------------------------------
function UIControl:mouseLeave()
end

---------------------------------------
-- 鼠标移动
-- x, y 为世界坐标
---------------------------------------
function UIControl:mouseMove(x, y, dx, dy)
end

---------------------------------------
-- 鼠标按下
-- x, y 为世界坐标
---------------------------------------
function UIControl:mouseDown()
end

---------------------------------------
-- 鼠标抬起
-- x, y 为世界坐标
---------------------------------------
function UIControl:mouseUp()
end

---------------------------------------
-- 设置焦点
---------------------------------------
function UIControl:setFocus()
    UIManager:getInstance():setFocus(self)
end

---------------------------------------
-- 控件获得焦点
---------------------------------------
function UIControl:focus()
end

---------------------------------------
-- 控件失去焦点
---------------------------------------
function UIControl:unFocus()
end

return UIControl
