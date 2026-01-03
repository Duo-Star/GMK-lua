--几何库

gLib={}
gLib.Class={
  method=function(factor,data)
    return dump(factor)
  end,
}


gLib.Point={
  new=function(factor,data)
    local p=factor[1] or nil
    return p
  end,
  random=function(factor,data)
    local randomMaster=factor[1]
    if randomMaster
      return Vector.RM2d(randomMaster)
    end
  end,
  randomOn=function(factor,data)
    local geo,randomMaster=data[factor[1]],factor[2]
    if geo and randomMaster
      local class=getmetatable(geo)
      if class==Circle then
        return geo:indexPoint(randomMaster:compute())
       else
        return Vector.newNan()
      end
    end
  end,
  randomIn=function(factor,data)
    local geo,randomMaster=data[factor[1]],factor[2]
    if geo and randomMaster
      local class=getmetatable(geo)
      if class==Circle then
        return Circle(geo.p,mf.rand()*geo.r*0.9):indexPoint(randomMaster:compute())
       else
        return Vector.newNan()
      end
    end
  end,
  center=function(factor,data)
    local geo=data[factor[1]]
    if geo
      local class=getmetatable(geo)
      if class==Circle then
        return geo.p
      end
    end
  end,
  midP=function(factor,data)
    local p1,p2=(data[factor[1]]),(data[factor[2]])
    if p1 and p2
      return p1:mid(p2)
    end
  end,
  at=function(factor,data)
    local p=(data[factor[1]])
    if p
      return p
    end
  end,
  index_Circle=function(factor,data)
    local c,theta=(data[factor[1]]),factor[2]
    if c and theta
      return c:indexPoint(theta)
    end
  end,
  index_Line=function(factor,data)
    local l,lam=data[factor[1]],factor[2]
    if l and lam
      return l:indexPoint(lam)
    end
  end,
  index_DPoint=function(factor,data)
    local dp,n=data[factor[1]],factor[2]
    if dp and n
      return dp[n]
    end
  end,
  insLL=function(factor,data)
    return gLib.Point.intersectOfLL(factor,data)
  end,
  intersectOfLL=function(factor,data)
    local l1,l2=(data[(factor[1])]),(data[(factor[2])])
    if l1 and l2
      return l1:getIntersectPoint2d(l2)
    end
  end,
  intersectOfCL=function(factor,data)
    local c,l,n=(data[(factor[1])]),(data[(factor[2])]),factor[3]
    if c and l and n
      return c:getIntersectPointWithLine2d_indexPByLambda(l,n)
    end
  end,
  intersectOfCC=function(factor,data)
    local c1,c2,n=(data[(factor[1])]),(data[(factor[2])]),factor[3]
    if c1 and c2 and n
      return c1:getIntersectPointWithCircle_indexPByTheta(c2,n)
    end
  end,
  is3PCollinear=function(factor,data)
    local p1,p2,p3=(data[(factor[1])]),(data[(factor[2])]),(data[(factor[3])])
    if p1==nil or p2==nil or p3==nil return nil
     else return p1:getIntersectPoint2d(p2,p3)
    end
  end,
  --在线段上找点，使之等于另一个线段,参数一初始点,参数二射线,参数三目标长度线段
  move=function(factor,data)
    local p,L,l_=(data[(factor[1])]),(data[(factor[2])]),(data[(factor[3])])
    if p==nil or L==nil or l_==nil return nil
     else return Vector.moveP(p,L.v,#l_)
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
  random=function(factor,data)
    local randomMaster=factor[1]
    return Line.RM2d(randomMaster)
  end,
  cross=function(factor,data)
    local p1,randomMaster=(data[factor[1]]),factor[2]
    if p1==nil return nil
     else return Line(p1,Vector.RM2d(randomMaster))
    end
  end,
  tangent=function(factor,data)
    local p,geo=(data[factor[1]]),(data[factor[2]])
    if p and geo
      if getmetatable(geo)==Circle
        return geo:getTangentLByP(p)
      end
    end
  end,
  angleBisector=function(factor,data)
    local F1,F2,F3=(data[factor[1]]),(data[factor[2]]),(data[factor[3]])
    if F1 and F2 and F3
      return Line(F2,(F1-F2):unit()+(F3-F2):unit())
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
  end,
  random=function(factor)
    local randomMaster=factor[1]
    return Circle.RM2d(randomMaster)
  end,



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

function mergeTables(table1, table2)
  local result = {}
  -- 复制table1的所有键值对到result中
  for key, value in pairs(table1) do
    result[key] = value
  end
  -- 复制table2的所有键值对到result中，注意如果table1和table2有相同的键，table2的值会覆盖result中对应的值
  for key, value in pairs(table2) do
    result[key] = value
  end
  return result
end


gLib.Bool={
  new_lua=function(factor,data)
    local result=GPL.sandbox("return "..factor[1],data)
    return result
  end,
}


gLib.DPoint={
  insCL=function(factor,data)
    local c,l=(data[factor[1]]),(data[factor[2]])
    if c==nil or l==nil return nil
     else return DPoint.insCL(c,l)
    end
  end
}



gLib.Triangle={
  newRandomRight=function(factor,data)
    local randomMaster=factor[1]
    return Triangle.newRight2d(Vector.RM2d(randomMaster),
    Vector.RM2d(randomMaster),
    mf.abs(randomMaster:compute())+1)
  end,
}

gLib.Slider={
  distribute_core=function(t,info)
    --@ info = {type, speed, max, min}
    if info.type=="Oscillating"
      --/\/\/
      local range=info.max-info.min
      local t0=range/info.speed
      if (0.5*t)%t0<range/4
        return (info.speed*t)%range+info.min
       else return (-info.speed*t)%range+info.min
      end
     elseif info.type=="Increasing"
      --///
      local range=info.max-info.min
      return (info.speed*t)%range+info.min
     elseif info.type=="Increasing_Once"
      --/-
      local range=info.max-info.min
      local v=info.speed*t+info.min
      if v<info.max return v
       else return info.max
      end
     elseif info.type=="Decreasing"
      --\
      local range=info.max-info.min
      return (-info.speed*t)%range+info.min
     elseif info.type=="Static"
      return info.min
     elseif info.type=="Sin"
      local range=info.max-info.min
      return (info.max+info.min)*0.5
      + range*0.5*mf.sin(info.speed*t)
     else
      return 0
    end
  end,
  distribute=function(factor,data,gmt)
    local info=factor.info
    local actting=factor.actting
    local v=gLib.Slider.distribute_core(gmt.t,info)
    for i=1,#actting do
      local item=actting[i]
      if gmt[item.name]
        gmt[item.name].factor[item.wfac]=v
       else
        table.remove(actting,i)
      end
    end
    return v
  end,
  global_t=function()
    return gmt.t
  end

}


return gLib