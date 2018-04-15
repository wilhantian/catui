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

-------------------------------------
-- Apply a scissor to the current scissor (intersect the rects)
-------------------------------------
function clipScissor(nx, ny, nw, nh)
    local ox, oy, ow, oh = love.graphics.getScissor()
    if ox then
        -- Intersect both rects
        nw = nx + nw
        nh = ny + nh
        nx, ny = math.max(nx, ox), math.max(ny, oy)
        nw = math.max(0, math.min(nw, ox + ow) - nx)
        nh = math.max(0, math.min(nh, oy + oh) - ny)
    end
    -- Set new scissor
    love.graphics.setScissor(nx, ny, nw, nh)
    -- Return old scissor
    return ox, oy, ow, oh
end


function csplit(str,sep)
   local ret={}
   local n=1
   for w in str:gmatch("([^"..sep.."]*)") do
      ret[n] = ret[n] or w -- only set once (so the blank after a string is ignored)
      if w=="" then
         n = n + 1
      end -- step forwards on a blank but not a string
   end
   return ret
end

return point
