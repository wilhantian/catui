local UIEditText = UIControl:extend("UIEditText", {
    backgroundColor = nil,
    focusStrokeColor = nil,
    unfocusStrokeColor = nil,
    stroke = 1,

    focus = false,
    label = nil,
    maxLines = 1
})

function UIEditText:init()
    UIControl.init(self)
    self:setClip(false)
    self:setEnabled(true)

    self:initTheme()

    self.label = UILabel:new(nil, nil, 24)
    self.label:setSize(120, 50)
    self.label:setAutoSize(false)
    self:addChild(self.label)

    self.events:on(UI_DRAW, self.onDraw, self)
    self.events:on(UI_KEY_DOWN, self.onKeyDown, self)
    self.events:on(UI_MOUSE_ENTER, self.onMouseEnter, self)
    self.events:on(UI_MOUSE_LEAVE, self.onMouseLevel, self)
    self.events:on(UI_FOCUS, self.onFocus, self)
    self.events:on(UI_UN_FOCUS, self.onUnFocus, self)
end

function UIEditText:initTheme(_theme)
    local theme = theme or _theme
    self.backgroundColor = theme.editText.backgroundColor
    self.focusStrokeColor = theme.editText.focusStrokeColor
    self.unfocusStrokeColor = theme.editText.unfocusStrokeColor
    self.stroke = theme.editText.stroke
end

function UIEditText:onDraw()
    local box = self:getBoundingBox()
    local x, y = box.left, box.top
    local w, h = box:getWidth(), box:getHeight()
    local r, g, b, a = love.graphics.getColor()

    -- 背景
    local color = self.backgroundColor
    love.graphics.setColor(color[1], color[2], color[3], color[4])
    love.graphics.rectangle("fill", x, y, w, h)

    -- 描边
    if self.focus then
        color = self.focusStrokeColor
    else
        color = self.unfocusStrokeColor
    end
    local lineWidth = love.graphics.getLineWidth()
    love.graphics.setLineWidth(self.stroke)
    love.graphics.setColor(color[1], color[2], color[3], color[4])
    love.graphics.rectangle("line", x, y, w, h)
    love.graphics.getLineWidth(lineWidth)

    love.graphics.setColor(r, g, b, a)
end

function UIEditText:onKeyDown(key, scancode, isrepeat)
    self.label:setText(self.label:getText()..scancode)
    self.events:dispatch(UI_TEXT_CHANGE, self.label:getText())
end

function UIEditText:onMouseEnter()
    love.mouse.setCursor(love.mouse.getSystemCursor("ibeam"))
end

function UIEditText:onMouseLevel()
    love.mouse.setCursor()
end

function UIEditText:onFocus()
    self.focus = true
end

function UIEditText:onUnFocus()
    self.focus = false
end

function UIEditText:setMaxLines(maxLines)
    self.maxLines = maxLines
end

function UIEditText:getMaxLines()
    return self.maxLines
end

function UIEditText:setMaxLength(length)
    self.maxLength = length
end

function UIEditText:getMaxLength(length)
    return self.maxLength
end

return UIEditText
