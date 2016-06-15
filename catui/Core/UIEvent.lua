--[[
The MIT License (MIT)

Copyright (c) 2016 WilhanTian  田伟汉

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]--

-------------------------------------
-- UIEvent
-- @usage
-- local event = UIEvent:new()
-- event:on("fuck", function(param)
--     print("fuck you too " .. param)
-- end)
-- event:dispatch("fuck", "hahahah")
-------------------------------------
local UIEvent = class("UIEvent", {
    handlers = {}
})

-------------------------------------
-- construct
-------------------------------------
function UIEvent:init()
end

-------------------------------------
-- dispatch event
-- @string name event name
-- @param ...
-------------------------------------
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
-- listen event
-- @string name event name
-- @param callback
-- @param _targer
-- @treturn bool is stop dispatch
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
-- remove listen
-- @param handle
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
-- remove all listen
---------------------------------------
function UIEvent:removeAll()
    self.handlers = {}
end

return UIEvent
