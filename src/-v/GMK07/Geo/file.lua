cjson=require "cjson"

GMK_File={
  path="",
  author="Duo",
  introduce="ooo",

  set=function(d)
    local d=d or {}
    GMK_File.path=d.path
    

  end,

  save=function()
    local data=cjson.encode({
      gmt=gmt,
      info={
        author=GMK_File.author,
        introduce=GMK_File.introduce,
      },
      setting={
        toolInfo=toolInfo,
        o=graph.o,
        lam=graph.lam,

      }
    })
    写入文件(GMK_File.path,data)
  end,

  read=function()
    local data=io.open(GMK_File.path):read("*a")
    
    local gmk_=cjson.decode(data)
    --加载几何结构
    gmt=GMT.normalize(gmk_.gmt)
    
    GMK_File.author=gmk_.info.author
    GMK_File.introduce=gmk_.info.introduce

    --恢复工具信息
    --toolInfo=gmk_.setting.toolInfo
    toolInfo.P.N=mf.int(gmk_.setting.toolInfo.P.N)
    toolInfo.C.N=mf.int(gmk_.setting.toolInfo.C.N)
    toolInfo.L.N=mf.int(gmk_.setting.toolInfo.L.N)
    
    --对视图缩放进行设置
    graph.o=GMT.toVector(gmk_.setting.o)
    graph.lam=gmk_.setting.lam

  end




}
