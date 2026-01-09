--#Conic2 双曲线
function Conic2() end
Conic2={
  __call=function(_,p,u,v)
    return Conic2.new(p,u,v)
  end,
  __index = {
    new=function(p,u,v)--新建 双曲线
      return setmetatable({p=p or Vector(),u=u or Vector(1),v=v or Vector(0,1) },Conic2)
    end,
    newHyperbola2dBy3P=function(F1,F2,P)--由两焦点和双曲线上一点确定双曲线
      local F12=F2-F1
      local a=0.5*(mf.abs((F1-P):len()-(F2-P):len()))
      local c=0.5*((F12):len())
      local b=math.sqrt(c^2-a^2)
      local p=(F2+F1):scale(0.5)
      local u=(F12):unit():scale(a)
      local v=(F12):roll2d_90():unit():scale(b)
      return Conic2.new(p,u,v)
    end,
    loadTest=function()--加载测试
      return Conic2(Vector(),Vector(2,1),Vector(1,2))
    end,
    indexPoint=function(c,theta)
      return c.p+c.u:scale(mf.sec(theta))+c.v:scale(mf.tan(theta))
    end,
    onDraw=function(c,canvas,graph,p_)
      local p1
      local dx=0.07*(1/graph.lam)
      
      local p0=graph.toSP(c:indexPoint(-mf.pi/2))
      local path1 = Path()
      path1.moveTo(p0.x,p0.y)
      if dx<=0.05 then dx=0.05 end
      for theta=-mf.pi/2,mf.pi/2,dx do
        p1=graph.toSP(c:indexPoint(theta))
        path1.lineTo(p1.x,p1.y)
      end
      local p0=graph.toSP(c:indexPoint(mf.pi/2+dx))
      local path2 = Path()
      path2.moveTo(p0.x,p0.y)
      for theta=mf.pi/2+dx,mf.pi*1.5,dx do
        p1=graph.toSP(c:indexPoint(theta))
        path2.lineTo(p1.x,p1.y)
      end
      canvas.drawPath(path1,p_)
      canvas.drawPath(path2,p_)
    end,


  }
}
setmetatable(Conic2, Conic2)
