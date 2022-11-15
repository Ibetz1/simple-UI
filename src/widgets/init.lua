local _PACKAGE = string.gsub(...,"%.","/") .. "/" or ""

return {
    button = require(_PACKAGE .. "button"),
    image = require(_PACKAGE .. "image")
}