# catui
A very light-weight GUI framework for the Löve2D

## What do I want in my GUI library?
+ Simple
+ Light-weight
+ Extensible
+ Rich events

## Explain
You should expand your own control, but you can also use the control folder under the control

## Example
```
require "catui"

local myBtn = UIControl:new()

myBtn.events:on(UI_DRAW, function()
    local box = self:getBoundingBox()
    local x, y = box.left, box.top
    local w, h = box:getWidth(), box:getHeight()
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.rectangle(x, y, w, h)
end, myBtn)

myBtn.events:on(UI_CLICK, function()
    print("my buton is click")
end)

UIManager:getInstance().rootCtrl.coreContainer:addChild(myBtn)
```

## API DOC
[Goto Read](http://htmlpreview.github.io/?https://github.com/wilhantian/catui/blob/master/doc/index.html)

## Screenshot
![Screenshot](doc/screen.jpg)

## License
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
