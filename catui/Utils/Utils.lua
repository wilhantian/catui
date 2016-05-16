local point = {}

function point.rotate(x, y, ox, oy, r)
    local angle = r * math.pi / 180
    local sinAngle = math.sin(angle)
    local cosAngle = math.cos(angle)

    if ox == 0 and oy == 0 then
        local tempX = x * cosAngle - y * sinAngle
        y = y * cosAngle + x * sinAngle
        x = tempX
    else
        local tempX = x - ox
        local tempY = y - oy

        x = tempX * cosAngle - tempY * sinAngle + ox
        y = tempY * cosAngle + tempX * sinAngle + oy
    end

    return x, y
end

return point
