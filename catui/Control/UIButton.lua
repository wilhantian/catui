local UIButton = UIControl:extend("UIButton", {
    isHoved = false,
    isPressed = false,
    label = nil,
    upImage = nil,
    downImage = nil,
    hoveImage = nil,
    disabledImage = nil
})

--- 构造
function UIButton:init(upFileName, downFileName, hoveFileName, disabledFileName)
    UIControl.init(self)

    self:setEnabled(true)

    self:setImage(upFileName, downFileName, hoveFileName, disabledFileName)
    self:resetSize()

    self.events:on(UI_MOUSE_ENTER, self.onMouseEnter, self)
    self.events:on(UI_MOUSE_LEAVE, self.onMouseLevel, self)
    self.events:on(UI_MOUSE_DOWN, self.onMouseDown, self)
    self.events:on(UI_MOUSE_UP, self.onMouseUp, self)
end

--- 绘制
function UIButton:onDraw()
    local box = self:getBoundingBox()
    local x, y = box.left, box.top
    local w, h = box:getWidth(), box:getHeight()

    local drawable = nil
    if self.isPressed then
        drawable = self.downImage or self.upImage
    elseif self.isHoved then
        drawable = self.hoveImage or self.upImage
    elseif self.enabled then
        drawable = self.upImage
    else
        drawable = self.disabledImage or self.upImage
    end

    if drawable then
        local sx = w / drawable:getWidth()
        local sy = h / drawable:getHeight()
        love.graphics.draw(drawable, x, y, 0, sx, sy)
    end
end

--- 鼠标进入
function UIButton:onMouseEnter()
    self.isHoved = true
end

--- 鼠标离开
function UIButton:onMouseLevel()
    self.isHoved = false
end

--- 鼠标按下
function UIButton:onMouseDown(x, y)
    self.isPressed = true
end

--- 鼠标抬起
function UIButton:onMouseUp(x, y)
    self.isPressed = false
end

--- 设置图像
function UIButton:setImage(upFileName, downFileName, hoveFileName, disabledFileName)
    if upFileName then self.upImage = love.graphics.newImage(upFileName) end
    if downFileName then self.downImage = love.graphics.newImage(downFileName) end
    if hoveFileName then self.hoveImage = love.graphics.newImage(hoveFileName) end
    if disabledFileName then self.disabledImage = love.graphics.newImage(disabledFileName) end
end

--- 同步Image宽高
function UIButton:resetSize()
    if self.upImage then
        self:setWidth(self.upImage:getWidth())
        self:setHeight(self.upImage:getHeight())
    else
        self:setWidth(0)
        self:setHeight(0)
    end
end

--- 设置按钮名字
function UIButton:setText(text)
    self:setText(text)
end

--- 获取按钮名字
function UIButton:getText()
    self.label:getText()
end

--- 获取label
function UIButton:getLabel()
    return self.label
end

return UIButton
