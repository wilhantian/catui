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

-------------------------------------
-- Used by UIEditText (source: http://lua-users.org/lists/lua-l/2014-04/msg00590.html)
-------------------------------------
function utf8.sub(s,i,j)
    i = i or 1
    j = j or -1
    if i<1 or j<1 then
        local n = utf8.len(s)
        if not n then return nil end
        if i<0 then i = n+1+i end
        if j<0 then j = n+1+j end
        if i<0 then i = 1 elseif i>n then i = n end
        if j<0 then j = 1 elseif j>n then j = n end
    end
    if j<i then return "" end
    i = utf8.offset(s,i)
    j = utf8.offset(s,j+1)
    if i and j then return s:sub(i,j-1)
        elseif i then return s:sub(i)
        else return ""
    end
end

return point
