UI_MOUSE_DOWN = "mouseDown"
UI_MOUSE_UP = "mouseUp"
UI_MOUSE_MOVE = "mouseMove"
UI_MOUSE_ENTER = "mouseEnter"
UI_MOUSE_LEAVE = "mouseLeave"

UI_CLICK = "click"
UI_DB_CLICK = "dbClick"
UI_FOCUS = "focus"
UI_UN_FOCUS = "unFocus"

UI_KEY_DOWN = "keyDown"
UI_KEY_UP = "keyUp"

UI_UPDATE = "update"
UI_DRAW = "draw"

COLOR_BG_NULL = {r=255, g=255, b=255}
COLOR_BG_NONE = {r=247, g=247, b=249}
COLOR_BG_STROKE = {r=225, g=225, b=225}
COLOR_TEXT = {r=51, g=51, b=51}
COLOR_TEXT_DISABLED = {r=153, g=153, b=153}
COLOR_BTN = {r=70, g=147, b=200}
COLOR_BTN_HOVE = {r=54, g=119, b=175}
COLOR_BTN_DOWN = {r=50, g=110, b=160}

function Color4(tab)
    return tab.r, tab.g, tab.b, 255
end
