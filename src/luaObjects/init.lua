local _PACKAGE = string.gsub(...,"%.","/") .. "/" or ""

uuid   = require(_PACKAGE .. "uuid")
object = require(_PACKAGE .. "object")
require(_PACKAGE .. "table")
require(_PACKAGE .. "array2D")