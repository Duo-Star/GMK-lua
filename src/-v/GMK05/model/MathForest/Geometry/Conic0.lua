--#Conic0 封闭形圆锥曲线
--当前位置 MathForest.Geometry.Conic0
--[[
#1: Conic0是由方程 p + cos(θ)*u + sin(θ)*v
    所确定的曲线，这里的p,u,v都是向量，θ是参数
    从形状上 不仅有椭圆,圆，还有点,线段类型，
    从位置上 不仅可以在原点处产生，还可以进行任意的平移和旋转，脱离2d平面
    向量p叫位置参数，向量u和向量v叫形状参数
    当u和为平行时(要求模长不同时为零)，则产生一条线段
    当u和v垂直时，分为模相等和模不等
                相等时 产生圆
                不相等时 产生以u和v为长轴和短轴的椭圆
    当u和v模长同时为零时 产生一个点
    当他们的模长不同时为零，且既不平行也不垂直的时候 产生一般的斜椭圆
#2: 在正投影与透视投影变换中类型不变，仍然为Conic0
#3: 创建方法如下
    Conic0()
    Conic0(Vector(),Vector(2,1),Vector(1,2))
    也可以使用其他以new作为开头的方法进行创建
    比如 使用两焦点和椭圆上一点建立平面椭圆
         Conic0.newEllipse2dBy3P(F1,F2,P)
    等等

--]]

function Conic0() end
Conic0={
  __call=function(_,p,u,v)
    return Conic0.new(p,u,v)
  end,
  __index = {
    new=function(p,u,v)--新建 椭圆形二次曲线
      return setmetatable({p=p or Vector(),u=u or Vector(1),v=v or Vector(0,1) },Conic0)
    end,
    newCircle2dByDiameter=function(pa,pb)--由直径两端点建立圆
      local p=pa:mid(pb)
      local u=pa-p
      local v=Vector(-u.y,u.x)
      return Conic0.new(p,u,v)
    end,
    newEllipse2dBy3P=function(F1,F2,P)--使用两焦点和椭圆上一点建立平面椭圆
      local F12=F2-F1
      local a=0.5*((F1-P):len()+(F2-P):len())
      local c=0.5*((F12):len())
      local b=math.sqrt(a^2-c^2)
      local p=(F2+F1):scale(0.5)
      local u=(F12):unit():scale(a)
      local v=(F12):roll2d_90():unit():scale(b)
      return Conic0.new(p,u,v)
    end,
    loadTest=function()--加载测试
      return Conic0(Vector(),Vector(2,1),Vector(1,2))
    end,
    indexPoint=function(c,theta)--根据theta索引点
      return c.p + c.u:scale(math.cos(theta)) + c.v:scale(math.sin(theta))
    end,
    onDraw=function(c,canvas,graph,p_)
      local p_=p_
      local p0=graph.toSP(c:indexPoint(0))
      local p1
      local dx=0.07*(1/graph.lam)
      local path = Path()
      path.moveTo(p0.x,p0.y)
      if dx<=0.05 then dx=0.05 end
      for theta=0,2*mf.pi+dx,dx do
        p1=graph.toSP(c:indexPoint(theta))
        path.lineTo(p1.x,p1.y)
      end
      canvas.drawPath(path,p_)
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
      return "我还没想好"
    end,
    getPdisConic0__dis2__=function(c,p,t)--❤️
      local dx=(c.p.x + c.u.x*math.cos(t) + c.v.x*math.sin(t)-p.x)
      local dy=(c.p.y + c.u.y*math.cos(t) + c.v.y*math.sin(t)-p.y)
      return dx*dx + dy*dy
    end,
    getPdisConic0__DerDis2__=function(c,p,t)
      local _x=2 * (-c.u.x*math.sin(t) + c.v.x*math.cos(t)) * (c.p.x + c.u.x*math.cos(t) + c.v.x*math.sin(t)-p.x)
      local _y=2 * (-c.u.y*math.sin(t) + c.v.y*math.cos(t)) * (c.p.y + c.u.y*math.cos(t) + c.v.y*math.sin(t)-p.y)
      return _x + _y
    end,
    getPdisConic0__bestTheta__=function(c,p)
      local t0
      if #c.u>=#c.v then
        if (p-c.p):dot(c.v)>0 then
          t0=mf.pi/2
         else
          t0=-mf.pi/2
        end
       else
        if (p-c.p):dot(c.u)>0 then
          t0=0
         else
          t0=mf.pi
        end
      end
      local t=t0
      local k=-0.05
      for i=1,12 do
        t=t+k*c:getPdisConic0__DerDis2__(p,t)
        k=k/math.exp(0.0618*i)
      end
      return t
    end,
    getPdisConic0__BestP__=function(c,p)
      return c:indexPoint(c:getPdisConic0__bestTheta__(p))
    end,
    getPdisConic0=function(c,p)
      return #(p-c:getPdisConic0__BestP__(p))
    end,
    getProjectPoint=function(c,p)
      return c:getPdisConic0__BestP__(p)
    end,







  }
}
setmetatable(Conic0, Conic0)










