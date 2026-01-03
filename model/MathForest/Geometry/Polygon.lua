function Polygon() end
Polygon={
  __call=function(_,ps)
    return Polygon.new(ps)
  end,
  __index = {
    new=function(ps)--新建 多边形
      return setmetatable({ps=ps or {Vector(1,1),Vector(2,2),Vector(3,2)} },Polygon)
    end,
    loadTest=function()--加载测试
      return Polygon()
    end,


  }
}
setmetatable(Polygon, Polygon)
return Polygon