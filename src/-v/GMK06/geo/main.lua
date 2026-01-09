require "import"
import "model.util"
import "model.class"
import "model.MaterialChip"
import "android.graphics.*"

function main()

  import "geo.lay"--框架及布局
  import "model.MathForest.main"--数学库
  import "model.paint"--画笔
  import "geo.gmt"--GMT编译器

  data={}--准备一张表，存放几何对象
  gmt=GMT.newNone()--创建几何环境

  import "geo.test"--加载测试程序
  import "geo.file"--文件管理工具

  import "geo.graphLib"--绘图库
  import "geo.tool"--工具
  import "geo.touch"--处理触摸事件😋

  sharedData={}
  sharedData.todo=activity.getSharedData("GeoRun_ToDo")
  sharedData.path=activity.getSharedData("GeoRun_Path")
  if sharedData.todo=="new"
    GMK_File.set({path=sharedData.path})
   elseif sharedData.todo=="open"
    GMK_File.set({path=sharedData.path})
    GMK_File.read()
  end

  toolbar.setTitle(sharedData.path:match("gmk/" .. "(.+)"..".gmk").."")


  function onKeyDown(key)
    if key==4 then
      GMK_File.save()
      print("已保存")
      return false
    end
  end



end

function ERROR(error_)
  写入文件("/storage/emulated/0/Duo/Forest/GMK/Debug/runtime"..os.time()..".txt",error_)
end

main()