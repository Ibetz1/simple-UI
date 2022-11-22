local _PACKAGE = string.gsub(...,"%.","/") .. "/" or ""

require(_PACKAGE .. "luaObjects")

love.graphics.setDefaultFilter("nearest", "nearest")

-- ui lib
ui = {}

-- ui cls
require(_PACKAGE .. "tools")
require(_PACKAGE .. "aliases")
ui = table.merge(ui, require(_PACKAGE .. "widgets"))