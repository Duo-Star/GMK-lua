require "import"
import "model.util"
import "model.class"
import "model.MaterialChip"
import "android.graphics.*"

--首先，申请权限😘😘😘
if Permission({
    Manifest.permission.READ_EXTERNAL_STORAGE,
    Manifest.permission.WRITE_EXTERNAL_STORAGE
  })

  import "geo.lay"--框架及布局
  import "model.n.nature"--数学库
  import "model.paint"--画笔
  import "geo.gmt"--GMT编译器


  data={}--准备一张表，存放几何对象
  gmt=GMT.newNone()--创建几何环境

  import "geo.test"--加载测试程序
  import "geo.file"--文件管理工具

  import "geo.graphLib"--绘图库
  import "geo.tool"--工具
  import "geo.touch"--处理触摸事件😋
  
  
end