--几何库



local toVector=function(data)
  return Vector(data.x,data.y,data.z)
end


gLib={}
gLib.Point={
  new=function(data)
    local p=toVector(data[1])
    return p
  end,
  midP=function(data)
    local p1,p2=toVector(data[1]),toVector(data[2])
    return p1:mid(p2)
  end,



}

gLib.Line={
  new=function(factor,data)
    local p1,p2=(data[factor[1]]),(data[factor[2]])
    return Line.newFrom2Point(p1,p2)
  end,



}



gLib.Circle={
  new=function(factor,data)
    local O,P=(data[factor[1]]),(data[factor[2]])
    return Circle.newOfOA(O,P)
  end,



}



return gLib