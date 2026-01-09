require "import"
import "model.util"
import "model.class"
import "model.MaterialChip"
import "android.graphics.*"


  import "Geo.layout"--框架及布局
  import "model.MathForest.main"--数学库
  import "model.paint"--画笔
  import "model.GMK_Core.main"--GMK

  data={}--准备一张表，存放几何对象
  gmt=GMT.newNone()--创建几何环境

  import "Geo.test"--加载测试程序
  import "Geo.file"--文件管理工具

  import "Geo.graphLib"--绘图库
  import "Geo.tool"--工具
  import "Geo.touch"--处理触摸事件😋

  sharedData= import "model.SharedData"

  if sharedData.GeoRun_ToDo=="new"
    GMK_File.set({path=sharedData.GeoRun_Path})
   elseif sharedData.GeoRun_ToDo=="open"
    GMK_File.set({path=sharedData.GeoRun_Path})
    GMK_File.read()
  end

  toolbar.setTitle(sharedData.GeoRun_Path:match("Files/" .. "(.+)"..".gmk").."")
  toolbar.setSubtitle(GMK_File.author)
  

  function onKeyDown(key)
    if key==4 then
      GMK_File.save()
      print("已保存")
      return false
    end
  end

