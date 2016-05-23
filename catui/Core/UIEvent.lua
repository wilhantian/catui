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
        return false
    end

    for i,v in ipairs(hands) do
        if v.callback then
            if v.targer then
                if v.callback(v.targer, ...) then
                    return true
                end
            else
                if v.callback(...) then
                    return true
                end
            end
        end
    end

    return false
end

---------------------------------------
-- 监听事件
-- 如果设置了targer, 回调函数中第一个参数/self就是targer
-- 反之, 如果未设置targer, 回调函数中的self为nil, 第一个参是正常的回调参数
-- @return [boolean] 是否截断后续派发
---------------------------------------
function UIEvent:on(name, callback, _targer)
    if not self.handlers[name] then
        self.handlers[name] = {}
    end
    local handle = {name=name, callback=callback, targer=_targer}
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
