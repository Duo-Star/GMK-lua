--#Conic0 封闭形圆锥曲线
function Conic0() end
Conic0={
  __call=function(_,p,u,v)
    return Conic0.new(p,u,v)
  end,
  __index = {
    new=function(p,u,v)--新建 椭圆形二次曲线
      return setmetatable({p=p or Vector(),u=u or Vector(1),v=v or Vector(0,1) },Conic0)
    end,
    newCircle2dByDiameter=function(pa,pb)
      local p=pa:mid(pb)
      local u=pa-p
      local v=Vector(-u.y,u.x)
      return Conic0.new(p,u,v)
    end,
    loadTest=function()--加载测试
      return Conic0(Vector(),Vector(2,1),Vector(1,2))
    end,
    indexPoint=function(c,theta)--根据theta索引点
      return c.p + c.u:scale(math.cos(theta)) + c.v:scale(math.sin(theta))
    end,
    getTangentVector=function(c,theta)--根据theta获得切方向向量
      return c.u:scale(-math.sin(theta)) + c.v:scale(math.cos(theta))
    end,
    getTangentLine=function(c,theta)--根据theta获得切线
      return Line(c:indexPoint(theta),c:getTangentVector(theta))
    end,
    getAB=function(c)--计算长短轴(半)
      local a1=c.u:pow2()
      local a2=(c.u:dot(c.v))*2
      local a3=c.v:pow2()
      local b1=0.5*(a1+a3)
      local b2=sqrt( (0.5*(a1-a3))^2 + (0.5*a2)^2 )
      local A=math.sqrt(b1+b2)
      local B=math.sqrt(b1-b2)
      return {A=A,B=B}
    end,
    getThetaOfAB=function(c)
      local a1=c.u:pow2()
      local a2=(c.u:dot(c.v))*2
      local a3=c.v:pow2()
      local b3=math.atan((a1-a3)/a2)
      local result={A={},B={}}
      for k=1,2 do
        result.A[k]=math.pi*(k+0.25)-b3/2
        result.B[k]=math.pi*(k-0.25)-b3/2
      end
      return result
    end,
    getIntersectPointWithLine2d=function(c,l)
      local lams={Env.nan,Env.nan}
      if l.v.x==0 then--排除分母为零的情况
        lams=Equation.solveCosSinForMainRoot(c.u.x, c.v.x, c.p.x-l.p.x)
       else--下面屎山不要动
        lams=Equation.solveCosSinForMainRoot(c.u.y-(c.u.x*l.v.y)/l.v.x,
        c.v.y-(c.v.x*l.v.y)/l.v.x,
        c.p.y-((c.p.x-l.p.x)*l.v.y)/l.v.x-l.p.y)
      end
      return {c:indexPoint(lams[1]),c:indexPoint(lams[2])}
    end,
    getIntersectPointWithConic2d=function(c1,c2)
      local lams={Env.nan,Env.nan}
      lams=Equation.solveCosSinForMainRoot(c1.u.x-c2.u.x,
      c1.v.x-c2.v.x,
      c1.p.x-c2.p.x)
      return {c1:indexPoint(lams[1]),c1:indexPoint(lams[2])}

    end,


  }
}
setmetatable(Conic0, Conic0)

