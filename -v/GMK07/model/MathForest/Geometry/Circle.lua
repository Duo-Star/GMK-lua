--#Circle 圆2d
function Circle() end
Circle={
  __call=function(_,p,r)
    return Circle.new(p,r)
  end,
  __index = {
    new=function(p,r)--新建 圆
      return setmetatable({p=p or Vector(),r=r or 1 },Circle)
    end,
    newOfPRL=function(p,rl)--从圆心和半径线段创建
      return Circle(p,#rl)
    end,
    newOfOA=function(p,A)--从圆心和圆上一点创建
      return Circle(p,#(A-p))
    end,
    newFrom3P=function(p1,p2,p3)
      return Circle.newOfOA(Triangle(p1,p2,p3):getO(),p1)
    end,
    loadTest=function()--加载测试
      return Circle(Vector(),1)
    end,
    indexPoint=function(c,theta)--根据theta索引点
      return c.p + Vector(c.r*math.cos(theta),c.r*math.sin(theta))
    end,
    getIndex=function(c,p)--由一个点获得索引值
      local dv=p-c.p
      return dv:getAngle2d()
    end,
    random=function(x0,x1,s)
      return Circle(Vector.random2d(x0,x1,s),
      random(s,x1,s))
    end,
    randomInP=function(c)
      return c.p + Vector(c.r*math.cos(random(0,314,0.01)),c.r*math.sin(random(0,314,0.01))):scale(random(0,1,0.01))
    end,
    randomInP__=function(c)
      return c.p + Vector(c.r*math.cos(random(0,314,0.01)),c.r*math.sin(random(0,314,0.01))):scale(random(0.2,0.8,0.01))
    end,
    getProjectPoint=function(c,p)--获取点在圆上的投影点
      local theta=c:getIndex(p)
      return c:indexPoint(theta)
    end,
    getPdisC=function(c,p)--计算点到圆的距离
      return math.abs(#(p-c.p)-c.r)--(c:getProjectPoint(p)-p):len()
    end,
    --与直线相交🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎🍎
    getIntersectPointWithLine2d_theta=function(c,l)--获取两交点对应的theta
      local theta={Env.nan,Env.nan}
      if l.v.x==0 then--排除分母为零的情况
        theta=Equation.solveCosSinForMainRoot(c.r, 0, c.p.x-l.p.x)
       else--下面屎山不要动
        theta=Equation.solveCosSinForMainRoot(0-(c.r*l.v.y)/l.v.x,
        c.r,
        c.p.y-((c.p.x-l.p.x)*l.v.y)/l.v.x-l.p.y)
      end
      return theta
    end,
    getIntersectPointWithLine2d=function(c,l)--求得两个交点
      local theta=c:getIntersectPointWithLine2d_theta(l)
      return {c:indexPoint(theta[1]),c:indexPoint(theta[2])}
    end,
    getIntersectPointWithLine2d_indexPByTheta=function(c,l,n)--使用Theta来索引其中一个交点
      local theta=c:getIntersectPointWithLine2d_theta(l)
      table.sort(theta)
      return c:indexPoint(theta[n])
    end,
    getIntersectPointWithLine2d_lambda=function(c,l)--获取两交点对应的lambda
      local theta={Env.nan,Env.nan}
      local lambda_={Env.nan,Env.nan}
      if l.v.x==0 then
        theta=Equation.solveCosSinForMainRoot(c.r, 0, c.p.x-l.p.x)
        lambda_[1]=(c.p.y+math.sin(theta[1])*c.r-l.p.y)/(l.v.y)
        lambda_[2]=(c.p.y+math.sin(theta[2])*c.r-l.p.y)/(l.v.y)
       else
        theta=Equation.solveCosSinForMainRoot(0-(c.r*l.v.y)/l.v.x,c.r,c.p.y-((c.p.x-l.p.x)*l.v.y)/l.v.x-l.p.y)
        lambda_[1]=(c.p.x+math.cos(theta[1])*c.r-l.p.x)/(l.v.x)
        lambda_[2]=(c.p.x+math.cos(theta[2])*c.r-l.p.x)/(l.v.x)
      end
      return lambda_
    end,
    getIntersectPointWithLine2d_indexPByLambda=function(c,l,n)--使用Lambda来索引其中一个交点
      local lambda_=c:getIntersectPointWithLine2d_lambda(l)
      table.sort(lambda_)
      return l:indexPoint(lambda_[n])
    end,
    --与圆相交😊😊😊😊😊😊😊😊😊😊😊😊😊😊😊😊😊😊😊
    getIntersectPointWithCircle_theta=function(c1,c2)
      local theta=Equation.solveCosSinForMainRoot(2 * c2.p.x * c2.r - 2 * c1.p.x * c2.r,
      2 * c2.p.y * c2.r - 2 * c1.p.y * c2.r,
      (c1.p.x - c2.p.x)^2 + (c1.p.y - c2.p.y)^2 + c2.r^2 - c1.r^2)
      return theta--注意这里获取的theta是c2的
    end,
    getIntersectPointWithCircle=function(c1,c2)
      local theta=c1:getIntersectPointWithCircle_theta(c2)
      return {c2:indexPoint(theta[1]),c2:indexPoint(theta[2])}
    end,
    getIntersectPointWithCircle_indexPByTheta=function(c1,c2,n)--使用Theta来索引其中一个交点
      local theta=c1:getIntersectPointWithCircle_theta(c2)
      table.sort(theta)
      return c2:indexPoint(theta[n])
    end,
    getTangentL=function(c,p)
      return Line(p,(p-c.p):roll2d_90())
    end





  }
}
setmetatable(Circle, Circle)

return Circle
