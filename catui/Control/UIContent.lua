local UIContent = UIControl:extend("UIContent", {
    backgroundColor = nil,
    barSize = 12,

    contentCtrl = nil,
    vBar = nil,
    hBar = nil
})

function UIContent:init()
    UIControl.init(self)

    self:initTheme()

    self:setClip(true)
    self:setEnabled(true)
    self.events:on(UI_WHELL_MOVE, self.onWhellMove, self)
    self.events:on(UI_DRAW, self.onDraw, self)

    self.contentCtrl = UIControl:new()
    UIControl.addChild(self, self.contentCtrl)

    -- 垂直
    self.vBar = UIScrollBar:new()
    self.vBar:setDir("vertical")
    self.vBar.events:on(UI_ON_SCROLL, self.onVBarScroll, self)
    UIControl.addChild(self, self.vBar)

    -- 水平
    self.hBar = UIScrollBar:new()
    self.hBar:setDir("horizontal")
    self.hBar.events:on(UI_ON_SCROLL, self.onHBarScroll, self)
    UIControl.addChild(self, self.hBar)
end

--- 初始化主题
function UIContent:initTheme(_theme)
    local theme = theme or _theme
    self.barSize = theme.content.barSize
    self.backgroundColor = theme.content.backgroundColor
end

--- 绘制
function UIContent:onDraw()
    local box = self:getBoundingBox()
    local r, g, b, a = love.graphics.getColor()
    local color = self.backgroundColor
    love.graphics.setColor(color[1], color[2], color[3], color[4])
    love.graphics.rectangle("fill", box:getX(), box:getY(), box:getWidth(), box:getHeight())
    love.graphics.setColor(r, g, b, a)
end

--- 鼠标滚轮事件
function UIContent:onWhellMove(x, y)
    local cx = self.contentCtrl:getX() + x * 3
    local cy = self.contentCtrl:getY() + y * 3

    if x ~= 0 and self:getWidth() > self.contentCtrl:getWidth() then -- 内容小于容器
        return false
    end

    if y ~= 0 and self:getHeight() > self.contentCtrl:getHeight() then -- 内容小于容器
        return false
    end

    -- 水平滚动
    if x < 0 then -- 向左滚动
        local offset = self:getWidth() - self.contentCtrl:getWidth()
        if cx <= offset then
            self:setContentOffsetX(offset)
        else
            self:setContentOffsetX(cx)
        end
    else -- 向右滚动
        if cx >= 0 then
            self:setContentOffsetX(0)
        else
            self:setContentOffsetX(cx)
        end
    end

    -- 垂直滚动
    if y < 0 then -- 向上滚动
        local offset = self:getHeight() - self.contentCtrl:getHeight()
        if cy <= offset then
            self:setContentOffsetY(offset)
        else
            self:setContentOffsetY(cy)
        end
    else -- 向下滚动
        if cy >= 0 then
            self:setContentOffsetY(0)
        else
            self:setContentOffsetY(cy)
        end
    end

    return true
end

--- 垂直滚动条
function UIContent:onVBarScroll(ratio)
    local offset = -ratio * self:getContentHeight()
    self:setContentOffsetY(offset)
end

--- 水平滚动条
function UIContent:onHBarScroll(ratio)
    local offset = -ratio * self:getContentWidth()
    self:setContentOffsetX(offset)
end

--- 复写
function UIContent:setSize(width, height)
    UIControl.setSize(self, width, height)
    self:resetBar()
end

--- 复写
function UIContent:setWidth(width)
    UIControl.setWidth(self, width)
    self:resetBar()
end

--- 复写
function UIContent:setHeight(height)
    UIControl.setHeight(self, height)
    self:resetBar()
end

--- 获取内容控件
function UIContent:getContent()
    return self.contentCtrl
end

--- 设置内容大小
function UIContent:setContentSize(width, height)
    self.contentCtrl:setSize(width, height)
    self:resetBar()
end

--- 获取内容大小
function UIContent:getContentSize()
    return self.contentCtrl:getSize()
end

--- 获取内容宽度
function UIContent:getContentWidth()
    return self.contentCtrl:getWidth()
end

--- 获取内容高度
function UIContent:getContentHeight()
    return self.contentCtrl:getHeight()
end

--- 设置偏移量
function UIContent:setContentOffsetPos(x, y)
    self.contentCtrl:setPos(x, y)
end

--- 设置x偏移量
function UIContent:setContentOffsetX(x)
    self.contentCtrl:setX(x)
end

--- 设置y偏移量
function UIContent:setContentOffsetY(y)
    self.contentCtrl:setY(y)
end

--- 复写addChild
function UIContent:addChild(child, depth)
    self.contentCtrl:addChild(child, depth)
end

--- 复写removeChild
function UIContent:removeChild(child)
    self.contentCtrl:removeChild(child)
end

--- 重置bar大小与位置
function UIControl:resetBar()
    self.vBar:setSize(self.barSize, self:getHeight() - self.barSize)
    self.vBar:setPos(self:getWidth() - self.barSize, 0)

    self.hBar:setSize(self:getWidth() - self.barSize, self.barSize)
    self.hBar:setPos(0, self:getHeight() - self.barSize)

    local cw, ch = self:getContentSize()
    self.vBar:setRatio(ch/self:getHeight())
end

return UIContent
