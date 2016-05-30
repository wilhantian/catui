local UIScrollBar = UIControl:extend("UIScrollBar", {
    upColor = nil,
    downColor = nil,
    hoverColor = nil,
    backgroundColor = nil,

    dir = "vertical", --horizontal
    ratio = 3, --bar占多少比例
    bar = nil,
    barDown = false,
    barPosRatio = 0,
})

--- 构造
function UIScrollBar:init()
    UIControl.init(self)

    self.bar = UIButton:new()
    self.bar.events:on(UI_MOUSE_DOWN, self.onBarDown, self)
    self.bar.events:on(UI_MOUSE_MOVE, self.onBarMove, self)
    self.bar.events:on(UI_MOUSE_UP, self.onBarUp, self)
    self:addChild(self.bar)

    self:initTheme()

    self:setEnabled(true)
    self.events:on(UI_DRAW, self.onDraw, self)
    self.events:on(UI_MOUSE_DOWN, self.onBgDown, self)
end

--- 绘制
function UIScrollBar:onDraw()
    local box = self:getBoundingBox()
    local x, y = box.left, box.top
    local w, h = box:getWidth(), box:getHeight()

    local r, g, b, a = love.graphics.getColor()
    local color = self.backgroundColor
    love.graphics.setColor(color[1], color[2], color[3], color[4])
    love.graphics.rectangle("fill", x, y, w, h)
    love.graphics.setColor(r, g, b, a)
end

--- 初始化主题
function UIScrollBar:initTheme(_theme)
    local theme = theme or _theme
    self.upColor = theme.scrollBar.upColor
    self.downColor = theme.scrollBar.downColor
    self.hoverColor = theme.scrollBar.hoverColor
    self.backgroundColor = theme.scrollBar.backgroundColor

    self.bar:setStroke(0)
    self.bar:setUpColor(self.upColor)
    self.bar:setDownColor(self.downColor)
    self.bar:setHoverColor(self.hoverColor)
end

--- 设置方向
function UIScrollBar:setDir(dir)
    self.dir = dir
    self:reset()
end

--- 获取方向
function UIScrollBar:getDir()
    return self.dir
end

--- bar按下时
function UIScrollBar:onBarDown(x, y)
    self.barDown = true
end

--- bar按移动时
function UIScrollBar:onBarMove(x, y, dx, dy)
    if not self.barDown then return end

    local bar = self.bar

    if self.dir == "vertical" then
        local after = bar:getY() + dy
        if after < 0 then
            after = 0
        elseif after + bar:getHeight() > self:getHeight() then
            after = self:getHeight() - bar:getHeight()
        end
        self.barPosRatio = after / (self:getHeight() - bar:getHeight())
    else
        local after = bar:getX() + dx
        if after < 0 then
            after = 0
        elseif after + bar:getWidth() > self:getWidth() then
            after = self:getWidth() - bar:getWidth()
        end
        self.barPosRatio = after / (self:getWidth() - bar:getWidth())
    end

    self:setBarPos(self.barPosRatio)
end

--- bar抬起时
function UIScrollBar:onBarUp(x, y)
    self.barDown = false
end

--- 背景按下时
function UIScrollBar:onBgDown(x, y)
    x, y = self:globalToLocal(x, y)

    if self.dir == "vertical" then
        self:setBarPos(y / self:getHeight())
    else
        self:setBarPos(x / self:getWidth())
    end
end

--- 复写setSize
function UIScrollBar:setSize(width, height)
    UIControl.setSize(self, width, height)
    self:reset()
end

--- 复写setWidth
function UIScrollBar:setWidth(width)
    UIControl.setWidth(self, width)
    self:reset()
end

--- 复写setHeight
function UIScrollBar:setHeight(height)
    UIControl.setHeight(self, height)
    self:reset()
end

--- 设置抬起颜色
function UIScrollBar:setUpColor(color)
    self.upColor = color
end

--- 设置按下颜色
function UIScrollBar:setDownColor(color)
    self.downColor = color
end

--- 设置悬浮颜色
function UIScrollBar:setHoverColor(color)
    self.hoverColor = color
end

--- 设置比例
-- 比例越大 滑动块越小
-- 不能小于1
function UIScrollBar:setRatio(ratio)
    self.ratio = ratio < 1 and 1 or ratio
    self:reset()
end

--- 刷新滚动块大小
function UIScrollBar:reset()
    local ratio = self.ratio
    if self.dir == "vertical" then
        self.bar:setWidth(self:getWidth())
        self.bar:setHeight(self:getHeight() / ratio)
    else
        self.bar:setWidth(self:getWidth() / ratio)
        self.bar:setHeight(self:getHeight())
    end
    self:setBarPos(self.barPosRatio)
end

--- 设置滑块位置
-- 单位: 比例
function UIScrollBar:setBarPos(ratio)
    if ratio < 0 then ratio = 0 end
    if ratio > 1 then ratio = 1 end

    self.barPosRatio = ratio
    if self.dir == "vertical" then
        self.bar:setX(0)
        self.bar:setY((self:getHeight() - self.bar:getHeight()) * ratio)
    else
        self.bar:setX((self:getWidth() - self.bar:getWidth()) * ratio)
        self.bar:setY(0)
    end

    self.events:dispatch(UI_ON_SCROLL, ratio)
end

--- 获取滑块位置
function UIScrollBar:getBarPos()
    return self.barPosRatio
end

return UIScrollBar
