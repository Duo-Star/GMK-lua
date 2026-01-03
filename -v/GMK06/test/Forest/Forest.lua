function Forest() end
Forest={
  __call=function(_,data)
    return Forest.new(data)
  end,
  __index = {
    new=function(data)--新建 Forest
      local data=data or {}
      data.t=data.t or 17
      data.color=data.color or {
        tree={A=255,R=50,G=81,B=32},
        sky={A=255,R=135,G=231,B=254}
      }
      data.objects=data.objects or {}

      return setmetatable(data,Forest)
    end,
    init=function()

    end,
    add=function(f,ob,name)
      f.data.objects[name or ("object_"..os.time())]=ob
    end



  }
}
setmetatable(Forest, Forest)

return Forest