local _PACKAGE = string.gsub(...,"%.","/") .. "/" or ""

uuid   = require(_PACKAGE .. "uuid")
object = require(_PACKAGE .. "object")
table.deepcopy = require(_PACKAGE .. "deepcopy")