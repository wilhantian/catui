local UIStencilManager = class("UIStencilManager", {
    instance = nil,
    stencilList = {},
    maxX1 = 0,
    maxY1 = 0,
    maxX2 = 0,
    maxY2 = 0
})

--- 获取一个模板管理器单例
function UIStencilManager:getInstance()
    if not UIStencilManager.instance then
        UIStencilManager.instance = UIStencilManager:new()
    end
    return UIStencilManager.instance
end

--- 模板绘图开始
--- XXX 此处需要性能调优
function UIStencilManager:stencilBegin(x, y, w, h)
    --找出当前可是区域
    if #self.stencilList == 0 then
        self.maxX1 = x
        self.maxY1 = y
        self.maxX2 = x + w
        self.maxY2 = y + h
    end

    local x1 = x
    local y1 = y
    local x2 = x + w
    local y2 = y + h

    if x1 < self.maxX1 then x1 = self.maxX1 else self.maxX1 = x1 end
    if y1 < self.maxY1 then y1 = self.maxY1 else self.maxY1 = y1 end
    if x2 > self.maxX2 then x2 = self.maxX2 else self.maxX2 = x2 end
    if y2 > self.maxY2 then y2 = self.maxY2 else self.maxY2 = y2 end

    table.insert(self.stencilList, {x1=x1, y1=y1, x2=x2, y2=y2})

    local stencilfunc = function()
        for i,v in ipairs(self.stencilList) do
            love.graphics.rectangle("fill", v.x1, v.y1, v.x2-v.x1, v.y2-v.y1)
        end
    end

    love.graphics.stencil(stencilfunc, "replace", 1)
    love.graphics.setStencilTest("greater", 0)
end

--- 模板绘图结束
function UIStencilManager:stencilEnd()
    table.remove(self.stencilList, #self.stencilList)
    love.graphics.setStencilTest()
end

return UIStencilManager
