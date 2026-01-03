function DPoint() end
DPoint={
  __call=function(_,p1,p2)
    return DPoint.new(p1,p2)
  end,
  __index = {
    new=function(p1,p2)--新建 曲线
      return setmetatable({p1,p2},DPoint)
    end,
    insCL=function(c,l)
      return c:getIntersectPointWithLine2d(l)
    end,
  
  

  }
}
setmetatable(DPoint,DPoint)
return DPoint