local UIRoot = UIControl:extend("UIRoot", {
    coreContainer,
    popupContainer,
    optionContainer,
    tipContainer,
})

function UIRoot:init()
    UIControl.init(self)

    local width = love.graphics.getWidth()
    local height = love.graphics.getHeight()

    -- 自己
    self:setSize(width, height)
    -- 核心层
    self.coreContainer = UIControl:new()
    self.coreContainer:setSize(width, height)
    self:addChild(self.coreContainer, 1)
    -- 弹出层
    self.popupContainer = UIControl:new()
    self.popupContainer:setSize(width, height)
    self:addChild(self.popupContainer, 2)
    -- 选项层
    self.optionContainer = UIControl:new()
    self.optionContainer:setSize(width, height)
    self:addChild(self.optionContainer, 3)
    -- 提示层
    self.tipContainer = UIControl:new()
    self.tipContainer:setSize(width, height)
    self:addChild(self.tipContainer, 4)
end

return UIRoot
