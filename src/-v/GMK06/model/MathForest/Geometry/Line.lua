--#Line 直线
function Line() end
Line={
  __call=function(_,p,v)
    return Line.new(p,v)
  end,
  __len=function(l)
    return Line.len(l)
  end,
  __index = {
    new=function(p,v)--新建 直线
      return setmetatable({p=p or Vector(),v=v or Vector(0,1) },Line)
    end,
    newBy2P=function(p1,p2)--由直线上两点新建直线
      return Line(p1,p2-p1)
    end,
    random=function(x0,x1,s)
      return Line(Point.random(x0,x1,s),
      Vector.random(x0,x1,s))
    end,
    random2d=function(x0,x1,s)
      return Line(Vector.random2d(x0,x1,s),
      Vector.random2(x0,x1,s))
    end,
    randomCrossP2d=function(p,x0,x1,s)
      return Line(p,Vector.random2d(x0,x1,s))
    end,
    loadTest=function()--加载测试
      return Line(Vector(1),Vector(1,1))
    end,
    indexPoint=function(l,lam)
      return l.p+l.v:scale(lam)
    end,
    len=function(l)
      return l.v:len()
    end,
    getProjectPoint=function(l,p)
      return l.p+(p-l.p):projectV(l.v)
    end,
    getIndex=function(l,p)
      local dv=(p-l.p):projectV(l.v)
      if Is.Zero(dv.x) return (dv.y) / (l.v.y)
       else return (dv.x) / (l.v.x)
      end
    end,
    getPdisL=function(l,p)
      local dp=p-l.p
      return #(l.p+dp:projectV(l.v)-p)
    end,
    getIntersectPoint2d=function(la,lb)
      if la==nil or lb==nil then return Vector.new_nan()
       else
        local x,y=Equation.solve2x2LinearSystem(
        la.v.x,-lb.v.x,lb.p.x-la.p.x,
        la.v.y,-lb.v.y,lb.p.y-la.p.y)
        if x~=nil return la:indexPoint(x) else
          return Vector.new_nan()
        end
      end
    end,
    getAngleBisector=function(l1,l2)
      return Line(l1:getIntersectPoint2d(l2),l1.v:unit()+l2.v:unit())
    end,
    getLamByP=function(l,p)
      if l.v~=0.0 return (p-l.p).x/l.v.x
       else return (p-l.p).y/l.v.y
      end
    end,
    isPOnSegment=function(l,p)
      local lam=l:getLamByP(p)
      return lam<1 and lam>0
    end,

  }
}
setmetatable(Line, Line)


return Line