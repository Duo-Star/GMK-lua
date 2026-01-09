--#Conic1 抛物线
--p + (t^2)*u + t*v
--#u = #v = 2*p

function Conic1() end
Conic1={
  __call=function(_,p,u,v)
    return Conic1.new(p,u,v)
  end,
  __index = {
    new=function(p,u,v)--新建
      return setmetatable({p=p or Vector(),u=u or Vector(1),v=v or Vector(0,1) },Conic1)
    end,
    newParabola2dByFL=function(F,L)
      local vF_=L:getProjectPoint(F)
      local p=(vF_+F):scale(0.5)
      local u=(F-vF_):scale(2)
      local v=u:roll2d_90()
      return Conic1(p,u,v)
    end,
    loadTest=function()--加载测试
      return Conic1(Vector(),Vector(2,1),Vector(1,-2))
    end,
    indexPoint=function(c,t)--根据theta索引点
      return c.p + c.u:scale(t^2) + c.v:scale(t)
    end,
    onDraw=function(c,canvas,graph,p_)
      local p0=graph.toSP(c:indexPoint(0.8*(-5)^3))
      local p1
      local dx=0.05*(1/graph.lam)
      local path = Path()
      path.moveTo(p0.x,p0.y)
      if dx<=0.05 then dx=0.05 end
      for theta=-5,5,dx do
        local theta=0.8*theta^3
        p1=graph.toSP(c:indexPoint(theta))
        path.lineTo(p1.x,p1.y)
      end
      canvas.drawPath(path,p_)
    end,

  }
}
setmetatable(Conic1, Conic1)

return Conic1