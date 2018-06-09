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
theme.button.upColor = {57/255, 69/255, 82/255, 1}
theme.button.downColor = {30/255, 35/255, 41/255, 1}
theme.button.hoverColor = {71/255, 87/255, 103/255, 1}
theme.button.disableColor = {48/255, 57/255, 66/255, 1}
theme.button.strokeColor = {25/255, 30/255, 35/255, 1}
theme.button.stroke = 1
theme.button.font = "font/visat.ttf"
theme.button.fontSize = 16
theme.button.fontColor = {1, 1, 1, 1}
theme.button.iconDir = "left"
theme.button.iconAndTextSpace = 8

theme.scrollBar.upColor = {84/255, 108/255, 119/255, 1}
theme.scrollBar.hoverColor = {112/255, 158/255, 184/255, 1}
theme.scrollBar.downColor = {84/255, 108/255, 119/255, 1}
theme.scrollBar.backgroundColor = {47/255, 59/255, 69/255, 1}

theme.content.backgroundColor = {31/255, 36/255, 43/255, 1}
theme.content.barSize = 14

theme.checkBox.upColor = {1, 1, 1, 1}
theme.checkBox.downColor = {0/255, 150/255, 224/255, 1}
theme.checkBox.hoverColor = {0/255, 150/255, 224/255, 1}
theme.checkBox.disableColor = {84/255, 108/255, 119/255, 1}
theme.checkBox.size = 16

theme.progressBar.color = {57/255, 104/255, 149/255, 1}
theme.progressBar.backgroundColor = {47/255, 59/255, 69/255, 1}

theme.editText.backgroundColor = {255/255, 255/255, 255/255, 1}
theme.editText.focusStrokeColor = {57/255, 104/255, 149/255, 1}
theme.editText.unfocusStrokeColor = {41/255, 50/255, 59/255, 1}
theme.editText.cursorColor = {82/255, 139/255, 255/255, 1}
theme.editText.stroke = 1

return theme
