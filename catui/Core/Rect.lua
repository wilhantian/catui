local Rect = class("Rect", {
    left = 0,
    top = 0,
    right = 0,
    bottom = 0
})

function Rect:init(left, top, right, bottom)
    self.left = left or 0
    self.top = top or 0
    self.right = right or 0
    self.bottom = bottom or 0
end

function Rect:contains(x, y)
    if x < self.left or x >= self.right or y < self.top or y >= self.bottom then
        return false
    end
    return true
end

function Rect:getSize()
    local w = self.right - self.left
    local h = self.bottom - self.top
    return w, h
end

function Rect:getWidth()
    return self.right - self.left
end

function Rect:getHeight()
    return self.bottom - self.top
end

return Rect
