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

--- 构造
function UIControl:init()
    self.events = UIEvent:new()
    self.boundingBox = Rect:new()
end

--- 更新
function UIControl:update(dt)
    self:validate()
    self.events:dispatch(UI_UPDATE, dt)

    for i,v in ipairs(self.children) do
        v:update(dt)
    end
end

--- 渲染
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

--- 设置裁剪
function UIControl:setClip(isClip)
    self.clip = isClip
end

--- 是否裁剪
function UIControl:isClip()
    return self.clip
end

--- 开始裁剪
function UIControl:clipBegin()
    if self.clip then
        local box = self:getBoundingBox()
		local x, y = box.left, box.top
        local w, h = box:getWidth(), box:getHeight()
	    -- local stencilfunc = function()
	    --     love.graphics.rectangle("fill", x, y, w, h)
	    -- end
	    -- love.graphics.stencil(stencilfunc, "replace", 1)
	    -- love.graphics.setStencilTest("greater", 0)
        UIStencilManager:getInstance():stencilBegin(x, y, w, h)
	end
end

--- 裁剪结束
function UIControl:clipEnd()
    if self.clip then
		-- love.graphics.setStencilTest()
        UIStencilManager:getInstance():stencilEnd()
	end
end

--- 需要验证布局
function UIControl:needValidate()
    self.isNeedValidate = true
end

--- 验证布局
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

--- 设置锚点
function UIControl:setAnchor(x, y)
    self.anchorX = x
    self.anchorY = y
    self:needValidate()
end

--- 获取锚点
function UIControl:getAnchor()
    return self.anchorX, self.anchorY
end

--- 设置X轴锚点
function UIControl:setAnchorX(x)
    self.anchorX = x
    self:needValidate()
end

--- 获取X轴锚点
function UIControl:getAnchorX()
    return self.anchorX
end

--- 设置Y轴锚点
function UIControl:setAnchorY(y)
    self.anchorY = y
    self:needValidate()
end

--- 获取Y轴锚点
function UIControl:getAnchorY()
    return self.anchorY
end

--- 设置坐标
function UIControl:setPos(x, y)
    self.x = x
    self.y = y
    self:needValidate()
    self.events:dispatch(UI_MOVE)
end

--- 获取坐标
function UIControl:getPos()
    return self.x, self.y
end

--- 设置X坐标
function UIControl:setX(x)
    self.x = x
    self:needValidate()
end

--- 获取X坐标
function UIControl:getX()
    return self.x
end

--- 设置Y坐标
function UIControl:setY(y)
    self.y = y
    self:needValidate()
end

--- 获取Y坐标
function UIControl:getY()
    return self.y
end

--- 设置大小
function UIControl:setSize(width, height)
    self.width = width
    self.height = height
    self:needValidate()
end

--- 获取大小
function UIControl:getSize()
    return self.width, self.height
end

--- 设置宽度
function UIControl:setWidth(width)
    self.width = width
    self:needValidate()
end

--- 获取宽度
function UIControl:getWidth()
    return self.width
end

--- 设置高度
function UIControl:setHeight(height)
    self.height = height
    self:needValidate()
end

--- 获取高度
function UIControl:getHeight()
    return self.height
end

--- 获取包围盒
function UIControl:getBoundingBox()
    return self.boundingBox
end

--- 设置父节点
function UIControl:setParent(parent)
    self.parent = parent
    self:needValidate()
end

--- 获取父节点
function UIControl:getParent()
    return self.parent
end

--- 设置控件开启状态
function UIControl:setEnabled(enabled)
    self.enabled = enabled
end

--- 控件是否开启
function UIControl:isEnabled()
    return self.enabled
end

--- 设置子控件开启状态
function UIControl:setChildrenEnabled(enabled)
    self.childrenEnabled = enabled
end

--- 子控件是否开启
function UIControl:isChildrenEnabled()
    return self.childrenEnabled
end

--- 检测坐标
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

--- 局部坐标转全局坐标
function UIControl:localToGlobal(x, y)
    x = (x or 0) + self.x
    y = (y or 0) + self.y

    if self.parent then
        x, y = self.parent:localToGlobal(x, y)
    end
    return x, y
end

--- 全局坐标转局部坐标
function UIControl:globalToLocal(x, y)
    x = (x or 0) - self.x
    y = (y or 0) - self.y

    if self.parent then
        x, y = self.parent:globalToLocal(x, y)
    end
    return x, y
end

--- 设置深度
function UIControl:setDepth(depth)
    self.depth = depth
    if self.parent then
        self.parent:sortChildren()
    end
end

--- 获取深度
function UIControl:getDepth()
    return self.depth
end

--- 添加一个子控件
function UIControl:addChild(child, depth)
    table.insert(self.children, child)
    child:setParent(self)
    if depth then
        child:setDepth(depth)
    end
    child.events:dispatch(UI_ON_ADD)
end

--- 移除一个子控件
function UIControl:removeChild(child)
    for i,v in ipairs(self.children) do
        if v == child then
            table.remove(self.children, i)
            child.events:dispatch(UI_ON_REMOVE)
            break
        end
    end
end

--- 对子控件排序
function UIControl:sortChildren()
    table.sort(self.children, function(a, b)
        return a.depth > b.depth
    end)
end

--- 获取所有子控件
function UIControl:getChildren()
    return self.children
end

--- 设置焦点
function UIControl:setFocus()
    UIManager:getInstance():setFocus(self)
end

return UIControl
