--#Plane 平面
function Plane() end
Plane={
  __call=function(_,p,u,v)
    return Plane.new(p,u,v)
  end,
  __index = {
    new=function(p,v)--新建 平面
      return setmetatable({p=p or Vector(),u=u or Vector(1),v=v or Vector(0,1) },Plane)
    end,
    loadTest=function()--加载测试
      return Plane(Vector(1),Vector(0,1),Vector(0,0,1))
    end,

  }
}
setmetatable(Plane, Plane)

return Plane