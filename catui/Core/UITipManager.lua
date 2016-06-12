local UITipManager = class("UITipManager", {
    registerControls = {}
})

function UITipManager:init()
end

function UITipManager:getInstance()
end

function UITipManager:registerControl(control, text)
    self.registerControls[control] = text
end

function UITipManager:unRegisterControl(control)
    self.registerControls[control] = nil
end

function UITipManager:show(control)
    local text = self.registerControls[control]
    if text then
        -- TODO
    end
end

function UITipManager:hide()
end

function UITipManager:setDelayTime()
end

return UITipManager
