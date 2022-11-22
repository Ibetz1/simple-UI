local _PACKAGE = string.gsub(...,"%.","/") .. "/" or ""

return {
    button = require(_PACKAGE .. "button"),
    image = require(_PACKAGE .. "image"),
    slider = require(_PACKAGE .. "slider"),
    checkBox = require(_PACKAGE .. "checkBox")
}