local UIEvent = class("UIEvent", {
    handlers = {}
})

---------------------------------------
-- 构造
---------------------------------------
function UIEvent:init()
end

---------------------------------------
-- 派发事件
---------------------------------------
function UIEvent:dispatch(name, ...)
    local hands = self.handlers[name]
    if not hands then
        return
    end

    for i,v in ipairs(hands) do
        if v.callback then
            v.callback(...)
        end
    end
end

---------------------------------------
-- 监听事件
---------------------------------------
function UIEvent:on(name, callback)
    if not self.handlers[name] then
        self.handlers[name] = {}
    end
    local handle = {name=name, callback=callback}
    table.insert(self.handlers[name], handle)
    return handle
end

---------------------------------------
-- 移除事件
---------------------------------------
function UIEvent:remove(handle)
    local handlers = self.handlers
    local name = handle.name

    if not handlers[name] then
        return
    end

    for i,v in ipairs(handlers[name]) do
        if v == handle then
            table.remove(handlers[name], i)
            return
        end
    end
end

---------------------------------------
-- 移除所有事件
---------------------------------------
function UIEvent:removeAll()
    self.handlers = {}
end

return UIEvent
