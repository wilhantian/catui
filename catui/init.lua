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

utf8 = require "utf8"
local args = {...}
local directory = args[1]
class = require (directory .. ".libs.30log")

require (directory .. ".Core.UIDefine")

theme = require (directory .. ".UITheme")

point = require (directory .. ".Utils.Utils")
Rect = require (directory .. ".Core.Rect")
UIEvent = require (directory .. ".Core.UIEvent")
UIControl = require (directory .. ".Core.UIControl")
UIRoot = require (directory .. ".Core.UIRoot")
UIManager = require (directory .. ".Core.UIManager")
UILabel = require (directory .. ".Control.UILabel")
UIButton = require (directory .. ".Control.UIButton")
UIImage = require (directory .. ".Control.UIImage")
UIScrollBar = require (directory .. ".Control.UIScrollBar")
UIContent = require (directory .. ".Control.UIContent")
UICheckBox = require (directory .. ".Control.UICheckBox")
UIProgressBar = require (directory .. ".Control.UIProgressBar")
UIEditText = require (directory .. ".Control.UIEditText")
