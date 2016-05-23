local UIContent = UIControl:extend("UIContent", {
    contentCtrl = nil
})

function UIContent:init()
    UIControl.init(self)

    self:setClip(true)
    self:setEnabled(true)
    self.events:on(UI_WHELL_MOVE, self.onWhellMove, self)

    self.contentCtrl = UIControl:new()
    self.contentCtrl.events:on(UI_DRAW, function()
        local box = self.contentCtrl:getBoundingBox()
        love.graphics.push("all")
        love.graphics.setLineWidth(6)
        love.graphics.setColor(0, 255, 0, 255)
        love.graphics.rectangle("line", box:getX(), box:getY(), box:getWidth(), box:getHeight())
        love.graphics.pop()
    end)
    UIControl.addChild(self, self.contentCtrl)
end

--- 鼠标滚轮事件
function UIContent:onWhellMove(x, y)
    local isHandled = false
    local cx = self.contentCtrl:getX() + x * 3
    local cy = self.contentCtrl:getY() + y * 3

    if x ~= 0 and self:getWidth() > self.contentCtrl:getWidth() then -- 内容小于容器
        return false
    end

    if y ~= 0 and self:getHeight() > self.contentCtrl:getHeight() then -- 内容小于容器
        return false
    end

    -- 垂直滚动
    if y < 0 then -- 向上滚动
        local offset = self:getHeight() - self.contentCtrl:getHeight()
        if cy <= offset then
            self.contentCtrl:setY(offset)
        else
            self.contentCtrl:setY(cy)
        end
    else -- 向下滚动
        if cy >= 0 then
            self.contentCtrl:setY(0)
        else
            self.contentCtrl:setY(cy)
        end
    end

    -- 水平滚动
    if x < 0 then -- 向左滚动
        local offset = self:getWidth() - self.contentCtrl:getWidth()
        if cx <= offset then
            self.contentCtrl:setX(offset)
        else
            self.contentCtrl:setX(cx)
        end
    else -- 向右滚动
        if cx >= 0 then
            self.contentCtrl:setX(0)
        else
            self.contentCtrl:setX(cx)
        end
    end

    return isHandled
end

--- 获取内容控件
function UIContent:getContent()
    return self.contentCtrl
end

--- 设置内容大小
function UIContent:setContentSize(width, height)
    self.contentCtrl:setSize(width, height)
end

--- 获取内容大小
function UIContent:getContentSize()
    return self.contentCtrl:getSize()
end

--- 复写addChild
function UIContent:addChild(child, depth)
    self.contentCtrl:addChild(child, depth)
end

--- 复写removeChild
function UIContent:removeChild(child)
    self.contentCtrl:removeChild(child)
end

return UIContent
