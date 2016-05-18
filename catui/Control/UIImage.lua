local UIImage = UIControl:extend("UIImage", {
    drawable = nil
})

--- 构造
function UIImage:init(fileName)
    UIControl.init(self)

    self:setImage(fileName)
    self:resetSize()

    self.events:on(UI_DRAW, self.onDraw, self)
end

--- 绘制
function UIImage:onDraw()
    local box = self:getBoundingBox()
    local x, y = box:getX(), box:getY()
    local w, h = box:getWidth(), box:getHeight()
    love.graphics.draw(self.drawable, x, y)
end

--- 设置新的图片
function UIImage:setImage(fileName)
    if fileName then
        self.drawable = love.graphics.newImage(fileName)
    end
end

--- 同步Image宽高
function UIImage:resetSize()
    if self.drawable then
        self:setWidth(self.drawable:getWidth())
        self:setHeight(self.drawable:getHeight())
    else
        self:setWidth(0)
        self:setHeight(0)
    end
end

return UIImage
