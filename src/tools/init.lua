local _PACKAGE = string.gsub(...,"%.","/") .. "/" or ""

ALIGN_CENTER = "center"
ALIGN_RIGHT  = "right"
ALIGN_LEFT   = "left"
ALIGN_TOP    = "top"
ALIGN_BOTTOM = "bottom"

ORIENT_HORIZONTAL = "horizontal"
ORIENT_VERTICAL   = "vertical"


-- tools --
-----------

-- ui tools
ui.tools = {}
require(_PACKAGE .. "color")
ui.tools.baseEnv = require(_PACKAGE .. "baseEnv")
require(_PACKAGE .. "tools")
require(_PACKAGE .. "logging")