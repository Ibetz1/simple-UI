local _PACKAGE = string.gsub(...,"%.","/") .. "/" or ""

-- tools --
-----------

-- ui tools
ui.tools = {}
require(_PACKAGE .. "color")
require(_PACKAGE .. "tools")
require(_PACKAGE .. "logging")