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

local theme = {}
theme.button = {}
theme.scrollBar = {}
theme.content = {}
theme.checkBox = {}
theme.progressBar = {}
theme.editText = {}

theme.button.width = 80
theme.button.height = 36
theme.button.upColor = {57, 69, 82, 255}
theme.button.downColor = {30, 35, 41, 255}
theme.button.hoverColor = {71, 87, 103, 255}
theme.button.disableColor = {48, 57, 66, 255}
theme.button.strokeColor = {25, 30, 35, 255}
theme.button.stroke = 1
theme.button.font = "font/visat.ttf"
theme.button.fontSize = 16
theme.button.fontColor = {255, 255, 255, 255}
theme.button.iconDir = "left"
theme.button.iconAndTextSpace = 8

theme.scrollBar.upColor = {84, 108, 119, 255}
theme.scrollBar.hoverColor = {112, 158, 184, 255}
theme.scrollBar.downColor = {84, 108, 119, 255}
theme.scrollBar.backgroundColor = {47, 59, 69, 255}

theme.content.backgroundColor = {31, 36, 43, 255}
theme.content.barSize = 14

theme.checkBox.upColor = {255, 255, 255, 255}
theme.checkBox.downColor = {0, 150, 224, 255}
theme.checkBox.hoverColor = {0, 150, 224, 255}
theme.checkBox.disableColor = {84, 108, 119, 255}
theme.checkBox.size = 16

theme.progressBar.color = {57, 104, 149, 255}
theme.progressBar.backgroundColor = {47, 59, 69, 255}

theme.editText.backgroundColor = {255, 255, 255, 255}
theme.editText.focusStrokeColor = {57, 104, 149, 255}
theme.editText.unfocusStrokeColor = {41, 50, 59, 255}
theme.editText.cursorColor = {82, 139, 255, 255}
theme.editText.stroke = 1

return theme
