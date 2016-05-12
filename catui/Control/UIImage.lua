local UIImage = UIControl:extend("UIImage", {
    drawable = nil
})

function UIImage:init(fileName)
    UIControl.init(self)

    if fileName then
        self.drawable = love.graphics.newImage(fileName)
    end

    self.events:on(UI_DRAW, self.onDraw, self)
end

function UIImage:onDraw()
    local x, y = self:localToGlobal()
    love.graphics.draw(self.drawable, x, y)
    -- love.graphics.draw(drawable, x, y, r, sx, sy, ox, oy, kx, ky)
end

return UIImage
