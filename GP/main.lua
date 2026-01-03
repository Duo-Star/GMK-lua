require "model.util"

themeUtil=LuaThemeUtil(this)
cjson=require "cjson"
sharedData= import "model.SharedData"


import "android.graphics.Typeface"
code_typeface=Typeface.createFromFile(activity.getLuaDir().."/res/fonts/code.ttf") --设置字体路径，page/main
jost_book_typeface=Typeface.createFromFile(activity.getLuaDir().."/res/fonts/jost_book.ttf") --设置字体路径，page/main
jost_medium_typeface=Typeface.createFromFile(activity.getLuaDir().."/res/fonts/jost_medium.ttf") --设置字体路径，page/main

sharedData= import "model.SharedData"
Translate=import "model.Translate"
translate=Translate.translate



import "GP/lay"


lua_edit__.addNames(String(
{ "mf",
  "Duo",
  "Vector",
  "Point",
  "Circle",
  "Is",
  "MidP",
  "on",
  "//",

}))

local c_=0xFF8D750A

lua_edit__.setKeywordColor(c_)--function true
.setCommentColor(0xff9E9E9E)-- --aaa
--.setTextColor(0xff202020)--普通文本
.setUserwordColor(c_)-- 1
.setBasewordColor(c_) --关键字
.setPanelBackgroundColor(0xff202020)

if sharedData.LuaEditRun_ToDo=="open" then
  lua_edit__.open(sharedData.LuaEditRun_Path)
end

function onDestroy()
  lua_edit__.save()
  local intent=Intent()
  activity.setResult(1,intent)
end


