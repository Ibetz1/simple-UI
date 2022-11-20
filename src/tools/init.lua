local _PACKAGE = string.gsub(...,"%.","/") .. "/" or ""

-- place holder variables / shortcuts --
----------------------------------------

-- object alignment
ALIGN_CENTER = "center"
ALIGN_LEFT   = "left"
ALIGN_TOP    = "top"
ALIGN_RIGHT  = "right"
ALIGN_BOTTOM = "bottom"

-- object orientation
ORIENT_HORIZONTAL = "horizontal"
ORIENT_VERTICAL   = "vertical"

-- ui tools
ui.tools = {}
ui.tools.baseEnv = require(_PACKAGE .. "baseEnv")

require(_PACKAGE .. "tools")
require(_PACKAGE .. "logging")
require(_PACKAGE .. "arr2D")