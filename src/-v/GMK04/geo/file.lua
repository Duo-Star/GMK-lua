cjson=require "cjson"

GMK_File={
  src_="/storage/emulated/0/Duo/Forest/GMK/Files",
  name="test",
  author="Duo",
  introduce="ooo",

  set=function(d)
    local d=d or {}
    GMK_File.name=d.name or "test"

  end,

  save=function()
    local data=cjson.encode({
      gmt=gmt,
      info={
        name=GMK_File.name,
        author=GMK_File.author,
        introduce=GMK_File.introduce,
      },
      setting={
        toolInfo=toolInfo,
        o=graph.o,
        lam=graph.lam,
        
      }
    })
    写入文件( (GMK_File.src_).."/"..(GMK_File.name)..".gmk",data)
  end,

  read=function(name)
    local data=io.open((GMK_File.src_).."/"..name..".gmk"):read("*a")
    local gmk_=cjson.decode(data)
    --加载几何结构
    gmt=GMT.normalize(gmk_.gmt)
    
    --恢复工具信息
    toolInfo=gmk_.setting.toolInfo
    
    --对视图缩放进行设置
    graph.o=GMT.toVector(gmk_.setting.o)
    graph.lam=gmk_.setting.lam
    
    
    
  end

}
