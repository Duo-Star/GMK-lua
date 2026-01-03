require "import"
import "model.util"
import "model.class"
import "model.MaterialChip"
import "android.graphics.*"


function loggg(e)
  写入文件("/storage/emulated/0/Duo/Forest/GMK/Logs/"
  .."Runtime_"..os.time()..".log",e)
end


function Main()

  sharedData= import "model.SharedData"
  Translate=import "model.Translate"
  translate=Translate.translate

  code_typeface=Typeface.createFromFile(activity.getLuaDir().."/res/fonts/code.ttf") --设置字体路径，page/main
  jost_book_typeface=Typeface.createFromFile(activity.getLuaDir().."/res/fonts/jost_book.ttf") --设置字体路径，page/main
  jost_medium_typeface=Typeface.createFromFile(activity.getLuaDir().."/res/fonts/jost_medium.ttf") --设置字体路径，page/main

  --初始化随机数种子
  math.randomseed(os.time())
  
  import "Geo.layout"
  import "model.MathForest.main"--数学库
  import "model.paint"--画笔
  import "model.GMK_Core.main"--GMK
  
  








  function onKeyDown(key)
    if key==4 then
      print("已保存")
      return false
    end
  end



end

xpcall(Main,
function(e)
  写入文件("/storage/emulated/0/Duo/Forest/GMK/Logs/"
  .."Runtime_"..os.time()..".log",e)
end)