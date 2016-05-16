local UILabel = UIControl:extend("UILabel", {
    text = "",
    drawable = nil
})

function UILabel:init()
    UIControl.init(self)
    self.events:on(UI_DRAW, self.onDraw, self)
end

function UILabel:setText(text)
    self.text = text
    self.drawable = love.graphics.newText(love.graphics.getFont(), text)
    self.width = self.drawable:getHeight()
    self.height = self.drawable:getWidth()
end

function UILabel:onDraw()
    local x, y = self:localToGlobal()
    love.graphics.draw(self.drawable, x, y)
end

return UILabel
