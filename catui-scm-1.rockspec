package = "catui"
version = "scm-1"
source = {
   url = "https://github.com/jamesalbert/catui"
}
description = {
   detailed = [[
## What do I want in my GUI library?
+ Simple
+ Light-weight
+ Extensible
+ Rich events]],
   homepage = "https://github.com/jamesalbert/catui",
   license = "MIT"
}
dependencies = {
   "lua >= 5.1, < 5.4"
}
build = {
   type = "builtin",
   modules = {
      catui = "catui/init.lua",
      ["catui.Control.UIButton"] = "catui/Control/UIButton.lua",
      ["catui.Control.UICheckBox"] = "catui/Control/UICheckBox.lua",
      ["catui.Control.UIContent"] = "catui/Control/UIContent.lua",
      ["catui.Control.UIEditText"] = "catui/Control/UIEditText.lua",
      ["catui.Control.UIImage"] = "catui/Control/UIImage.lua",
      ["catui.Control.UILabel"] = "catui/Control/UILabel.lua",
      ["catui.Control.UIProgressBar"] = "catui/Control/UIProgressBar.lua",
      ["catui.Control.UIScrollBar"] = "catui/Control/UIScrollBar.lua",
      ["catui.Core.Rect"] = "catui/Core/Rect.lua",
      ["catui.Core.UIControl"] = "catui/Core/UIControl.lua",
      ["catui.Core.UIDefine"] = "catui/Core/UIDefine.lua",
      ["catui.Core.UIEvent"] = "catui/Core/UIEvent.lua",
      ["catui.Core.UIManager"] = "catui/Core/UIManager.lua",
      ["catui.Core.UIRoot"] = "catui/Core/UIRoot.lua",
      ["catui.UITheme"] = "catui/UITheme.lua",
      ["catui.Utils.Utils"] = "catui/Utils/Utils.lua",
      ["catui.libs.30log"] = "catui/libs/30log.lua",
      conf = "conf.lua",
      main = "main.lua"
   },
   copy_directories = {
      "doc"
   }
}
