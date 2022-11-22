local _PACKAGE = string.gsub(...,"%.","/") .. "/" or ""

-- tag references
ui.__tags = {}
ui.__tags.container = require(_PACKAGE .. "_container")
ui.__tags.button =    require(_PACKAGE .. "button")
ui.__tags.slider =    require(_PACKAGE .. "slider")
ui.__tags.checkBox =  require(_PACKAGE .. "checkBox")
ui.__tags.image =     require(_PACKAGE .. "image")
ui.__tags.text =      require(_PACKAGE .. "text")

return {
    button   = ui.tools.tagTable("button"),
    image    = ui.tools.tagTable("image"),
    slider   = ui.tools.tagTable("slider"),
    checkBox = ui.tools.tagTable("checkBox"),
    text     = ui.tools.tagTable("text"),
    group    = ui.tools.tagTable("container")
}