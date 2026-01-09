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

  import "Geo.layout"--框架及布局
  import "model.MathForest.main"--数学库
  import "model.paint"--画笔
  import "model.GMK_Core.main"--GMK

  data={}--准备一张表，存放几何对象
  gmt=GMT.newNone()--创建几何环境

  import "Geo.file"--文件管理工具

  import "Geo.Tools.main"

  import "Geo.graphLib"--绘图库
  import "Geo.touch"--处理触摸事件😋

  import "Geo.test"


  if sharedData.GeoRun_ToDo=="new"
    GMK_File.set({path=sharedData.GeoRun_Path})
   elseif sharedData.GeoRun_ToDo=="open"
    GMK_File.set({path=sharedData.GeoRun_Path})
    GMK_File.read()
  end

  toolbar.setTitle(GMK_File.name)
  toolbar.setSubtitle(GMK_File.author)

  gmt.t=0
  gmt.dt=0.01

  tk=Ticker()
  tk.Period=gmt.dt*1000
  tk.onTick=function(...)--执行事件
    gmt.t=gmt.t + gmt.dt


  end
  tk.start()


  function onKeyDown(key)
    if key==4 then
      GMK_File.save()
      print("已保存")
      tk.stop()

      return false
    end
  end



end

xpcall(Main,
function(e)
  写入文件("/storage/emulated/0/Duo/Forest/GMK/Logs/"
  .."Runtime_"..os.time()..".log",e)
end)