--#Points
function Points() end
Points={
  __call=function(_,data)
    return Points.new(data)
  end,
  __index = {
    new=function(data)--新建 Points
      return setmetatable(data,Points)
    end,
    insOfCL2d=function(c,l)
      return c:getIntersectPointWithLine2d(l)
    end,
  }
}
setmetatable(Points, Points)


return Points
