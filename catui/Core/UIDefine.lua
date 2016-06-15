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
-- UI Event define
-------------------------------------

UI_MOUSE_DOWN = "mouseDown"
UI_MOUSE_UP = "mouseUp"
UI_MOUSE_MOVE = "mouseMove"
UI_MOUSE_ENTER = "mouseEnter"
UI_MOUSE_LEAVE = "mouseLeave"
UI_WHELL_MOVE = "whellMove"

UI_CLICK = "click"
UI_DB_CLICK = "dbClick"
UI_FOCUS = "focus"
UI_UN_FOCUS = "unFocus"

UI_KEY_DOWN = "keyDown"
UI_KEY_UP = "keyUp"
UI_TEXT_INPUT = "textInput"

UI_TEXT_CHANGE = "textChange"

UI_UPDATE = "update"
UI_DRAW = "draw"
UI_MOVE = "move"    -- UI position changed event
UI_ON_ADD = "onAdd" -- UI on add to parent event
UI_ON_REMOVE = "onRemove" -- UI remove event

UI_ON_SCROLL = "onScroll" -- scroll
UI_ON_SELECT = "onSelect" -- CheckBox status change event
