local UIPanel = UIControl:extend("UIPanel", {
})

function UIPanel:init()
    UIControl.init(self)
    self.events:on(UI_DRAW, self.onDraw, self)
end

function UIPanel:onDraw()
    local x, y = self:localToGlobal()
    local width, height = self.width, self.height

    love.graphics.push("all")
    -- 背景
    love.graphics.setColor(Color4(COLOR_BG_NULL))
    love.graphics.rectangle("fill", x, y, width, height)
    -- 描边
    love.graphics.setLineWidth(1)
    love.graphics.setLineStyle("rough")--smooth
    love.graphics.setColor(Color4(COLOR_BG_STROKE))
    love.graphics.rectangle("line", x, y, width, height)
    love.graphics.pop()
end

return UIPanel
