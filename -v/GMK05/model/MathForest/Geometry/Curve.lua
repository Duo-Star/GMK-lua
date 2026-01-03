--#Curve 曲线
function Curve() end
Curve={
  __call=function(_,func,range)
    return Curve.new(func,range)
  end,
  __index = {
    new=function(f,range)--新建 曲线
      return setmetatable({f=f or function(t) return Vector(t,t^2) end,range=range or {-1,1} },Curve)
    end,
    loadTest=function()--加载测试
      return Curve(function(t) return Vector(t,t^2) end,{-1,1})
    end,
    indexPoint=function(c,t)
      return c.f(t)
    end,


  }
}
setmetatable(Curve, Curve)