function XLine() end
XLine={
  __call=function(_,l1,l2)
    return XLine.new(l1,l2)
  end,
  __index = {
    new=function(l1,l2)--新建 XLine
      return setmetatable({l1,l2},XLine)
    end,
    newBypvv=function(p,v1,v2)
      return XLine(Line(p,v1),Line(p,v2))
    end,
  
  

  }
}
setmetatable(XLine,XLine)
return XLine