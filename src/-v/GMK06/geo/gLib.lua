--几何库

gLib={}




gLib.Point={
  new=function(factor)
    local p=factor[1] or nil
    return p
  end,
  midP=function(factor,data)
    local p1,p2=(data[factor[1]]),(data[factor[2]])
    if p1==nil or p2==nil return nil
     else return p1:mid(p2)
    end
  end,
  index_Circle=function(factor,data)
    local c,theta=(data[factor[1]]),factor[2]
    return c:indexPoint(theta)
  end,
  index_Line=function(factor,data)
    local l,lam=data[factor[1]],factor[2]
    if l==nil or lam==nil return nil
     else return l:indexPoint(lam)
    end
  end,
  intersectOfLL=function(factor,data)
    local l1,l2=(data[(factor[1])]),(data[(factor[2])])
    if l1==nil or l2==nil return nil
     else return l1:getIntersectPoint2d(l2)
    end
  end,
  intersectOfCL=function(factor,data)
    local c,l,n=(data[(factor[1])]),(data[(factor[2])]),factor[3]
    if c==nil or l==nil or n==nil return nil
     else return c:getIntersectPointWithLine2d_indexPByLambda(l,n)
    end
  end,
  intersectOfCC=function(factor,data)
    local c1,c2,n=(data[(factor[1])]),(data[(factor[2])]),factor[3]
    if c1==nil or c2==nil or n==nil return nil
     else return c1:getIntersectPointWithCircle_indexPByTheta(c2,n)
    end
  end,



}

gLib.Line={
  new=function(factor,data)
    local p1,p2=(data[factor[1]]),(data[factor[2]])
    if p1==nil or p2==nil return nil
     else return Line.newBy2P(p1,p2)
    end
  end,



}



gLib.Circle={
  new=function(factor,data)
    local O,P=(data[factor[1]]),(data[factor[2]])
    if O==nil or P==nil return nil--"error: 依赖对象未定义"
     else return Circle.newOfOA(O,P)
    end
  end,
  newFrom3P=function(factor,data)
    local p1,p2,p3=(data[factor[1]]),(data[factor[2]]),(data[factor[3]])
    return Circle.newFrom3P(p1,p2,p3)
  end

}

gLib.Conic0={
  new=function(factor,data)
    local F1,F2,P=(data[factor[1]]),(data[factor[2]]),(data[factor[3]])
    return Conic0.newEllipse2dBy3P(F1,F2,P)
  end,


}

gLib.Conic1={
  new=function(factor,data)
    local F,L=(data[factor[1]]),(data[factor[2]])
    return Conic1.newParabola2dByFL(F,L)
  end,


}





gLib.Conic2={
  new=function(factor,data)
    local F1,F2,P=(data[factor[1]]),(data[factor[2]]),(data[factor[3]])
    return Conic2.newHyperbola2dBy3P(F1,F2,P)
  end,


}



return gLib