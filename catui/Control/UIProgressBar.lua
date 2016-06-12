local UIProgressBar = UIControl:extend("UIProgressBar", {
    value = 0,
    minValue = 0,
    maxValue = 100,
    color = nil,
    backgroundColor = nil
})

function UIProgressBar:init()
    UIControl.init(self)
    self:setEnabled(false)

    self:initTheme()

    self.events:on(UI_DRAW, self.onDraw, self)
end

--- 初始化主题
function UIProgressBar:initTheme(_theme)
    local theme = theme or _theme
    self.color = theme.progressBar.color
    self.backgroundColor = theme.progressBar.backgroundColor
end

function UIProgressBar:onDraw()
    local box = self:getBoundingBox()
    local r, g, b, a = love.graphics.getColor()

    -- 背景
    local color = self.backgroundColor
    love.graphics.setColor(color[1], color[2], color[3], color[4])
    love.graphics.rectangle("fill", box:getX(), box:getY(), box:getWidth(), box:getHeight())

    -- 高亮
    local barWidth = self.value / (self.maxValue-self.minValue) * box:getWidth()
    if barWidth < 0 then
        barWidth = 0
    elseif barWidth > box:getWidth() then
        barWidth = box:getWidth()
    end

    color = self.color
    love.graphics.setColor(color[1], color[2], color[3], color[4])
    love.graphics.rectangle("fill", box:getX(), box:getY(), barWidth, box:getHeight())

    love.graphics.setColor(r, g, b, a)
end

function UIProgressBar:setValue(value)
    self.value = value
end

function UIProgressBar:getValue()
    return self.value
end

function UIProgressBar:setMinValue(minValue)
    self.minValue = minValue
end

function UIProgressBar:getMinValue()
    return self.minValue
end

function UIProgressBar:setMaxValue(maxValue)
    self.maxValue = maxValue
end

function UIProgressBar:getMaxValue()
    return self.maxValue
end

return UIProgressBar
