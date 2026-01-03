--几何结构表

function GMT() end

GMT={__index={}}

GMT.__call=function(_,data)
  return GMT.new(data)
end

GMT.__index.new=function(data)
  return setmetatable(data,GMT)
end

GMT.__index.newNone=function()
  local data={step={}}
  return setmetatable(data,GMT)
end

--在表中添加一个几何结构
GMT.__index.add=function(gmt,name,item)
  gmt[name]=item
end




--从json打开时会丢失metatable数据
GMT.__index.normalize=function(data)
  local gmt_={step=data.step}
  for i=1,#data.step do
    local a=data.step[i]--对象名称
    local item=data[a]
    if item.class=="Point" and item.method=="new"
      local ii=data[a]
      ii.factor[1]=GMT.toVector(ii.factor[1])
      gmt_[a]=ii
     else
      gmt_[a]=item
    end
  end
  return GMT(gmt_)
end


GMT.__index.toVector=function(data)
  return Vector(data.x,data.y,data.z)
end

GMT.__index.delete=function(gmt,data,name)
  for i=1,#gmt.step do
    local a=gmt.step[i]
    if a==name table.remove(gmt.step,i) end
  end
  gmt[name]=nil
  data[name]=nil
end


GMT.__index.color={"purple","red","blue","teal","cyan","amber","brown","grey"}

GMT.__index.Pg={color="purple",width=8.0,style="FILL",label=true,fill=false,show=true}


--在表中添加一个点
GMT.__index.addPoint=function(gmt,name,p)
  gmt.step[#gmt.step+1]=name
  gmt:add(name,{
    name=name,
    class="Point",
    method="new",
    factor={p},
    free=true,
    g=GMT.Pg
  })
end


GMT.__index.addLine=function(gmt,name,p1,p2)
  gmt.step[#gmt.step+1]=name
  gmt:add(name,{
    name=name,
    class="Line",
    method="new",
    factor={p1,p2},--这里存放的是字符串
    free=true,
    g={color="blue",width=8.0,style="STROKE",label=false,fill=false,show=true}
  })
end

GMT.__index.addCircle=function(gmt,name,p1,p2)
  gmt.step[#gmt.step+1]=name
  gmt:add(name,{
    name=name,
    class="Circle",
    method="new",
    factor={p1,p2},
    free=true,
    g={color="brown",width=8.0,style="STROKE",label=false,fill=false,show=true}
  })
end

GMT.__index.addCircleFrom3P=function(gmt,name,p1,p2,p3)
  gmt.step[#gmt.step+1]=name
  gmt:add(name,{
    name=name,
    class="Circle",
    method="newFrom3P",
    factor={p1,p2,p3},
    free=true,
    g={color="brown",width=8.0,style="STROKE",label=true,fill=false,show=true}
  })
end


GMT.__index.index_Circle=function(gmt,name,c,theta)
  gmt.step[#gmt.step+1]=name
  gmt:add(name,{
    name=name,
    class="Point",
    method="index_Circle",
    factor={c,theta},
    free=true,
    g={color="grey",width=8.0,style="STROKE",label=true,fill=false,show=true}
  })
end

GMT.__index.index_Line=function(gmt,name,l,lam)
  gmt.step[#gmt.step+1]=name
  gmt:add(name,{
    name=name,
    class="Point",
    method="index_Line",
    factor={l,lam},
    free=true,
    g={color="grey",width=8.0,style="STROKE",label=true,fill=false,show=true}
  })
end




GMT.__index.midP=function(gmt,name,p1,p2)
  gmt.step[#gmt.step+1]=name
  gmt:add(name,{
    name=name,
    class="Point",
    method="midP",
    factor={p1,p2},
    free=true,
    g={color="grey",width=8.0,style="FILL",label=true,fill=false,show=true}
  })
end



GMT.__index.intersectOfLL=function(gmt,name,l1,l2)
  gmt.step[#gmt.step+1]=name
  gmt:add(name,{
    name=name,
    class="Point",
    method="intersectOfLL",
    factor={l1,l2},
    free=true,
    g={color="grey",width=8.0,style="FILL",label=true,fill=false,show=true}
  })
end


GMT.__index.intersectOfCL=function(gmt,name,c,l,n)
  gmt.step[#gmt.step+1]=name
  gmt:add(name,{
    name=name,
    class="Point",
    method="intersectOfCL",
    factor={c,l,n},
    free=true,
    g={color="grey",width=8.0,style="FILL",label=true,fill=false,show=true}
  })
end


GMT.__index.intersectOfCC=function(gmt,name,c1,c2,n)
  gmt.step[#gmt.step+1]=name
  gmt:add(name,{
    name=name,
    class="Point",
    method="intersectOfCC",
    factor={c1,c2,n},
    free=true,
    g={color="grey",width=8.0,style="FILL",label=true,fill=false,show=true}
  })
end


GMT.__index.addEllipse=function(gmt,name,F1,F2,P)
  gmt.step[#gmt.step+1]=name
  gmt:add(name,{
    name=name,
    class="Conic0",
    method="new",
    factor={F1,F2,P},--这里存放的是字符串
    free=true,
    g={color="teal",width=8.0,style="STROKE",label=true,fill=false,show=true}
  })
end

GMT.__index.addParabola=function(gmt,name,F,L)
  gmt.step[#gmt.step+1]=name
  gmt:add(name,{
    name=name,
    class="Conic1",
    method="new",
    factor={F,L},--这里存放的是字符串
    free=true,
    g={color="teal",width=8.0,style="STROKE",label=true,fill=false,show=true}
  })
end



GMT.__index.addHyperbola=function(gmt,name,F1,F2,P)
  gmt.step[#gmt.step+1]=name
  gmt:add(name,{
    name=name,
    class="Conic2",
    method="new",
    factor={F1,F2,P},--这里存放的是字符串
    free=true,
    g={color="teal",width=8.0,style="STROKE",label=true,fill=false,show=true}
  })
end


GMT.__index.addFunction=function(gmt,name,str,P)
  gmt.step[#gmt.step+1]=name
  gmt:add(name,{
    name=name,
    class="Function",
    method="new",
    factor={str},--这里存放的是字符串
    free=true,
    g={color="red",width=8.0,style="STROKE",label=true,fill=false,show=true}
  })
end


GMT.__index.tangent=function(gmt,name,p,geo,P)
  gmt.step[#gmt.step+1]=name
  gmt:add(name,{
    name=name,
    class="Line",
    method="tangent",
    factor={p,geo},
    free=true,
    g={color="red",width=8.0,style="STROKE",label=true,fill=false,show=true}
  })
end











GMT.__index.translateToChinese=function(gmt,name)
  return name.."为"..gmt:translateToChinese_WithNoName(name)
end

GMT.__index.translateToChinese_WithNoName=function(gmt,name)
  local gmt_=gmt[name]
  local class=gmt_.class
  local method=gmt_.method
  local factor=gmt_.factor
  local result="这个鬼东西我不认识"
  if class=="Point"
    if method=="new"
      result="画布上一点 "..(factor[1]):translate2d_simple()
     elseif method=="index_Line"
      result="直线 "..factor[1].."上一点(λ="..Number.approximately(factor[2],-3)..")"
     elseif method=="index_Circle"
      result="圆周 "..factor[1].."上一点(θ="..Number.approximately(factor[2],-3)..")"
     elseif method=="intersectOfLL"
      result="直线 "..factor[1].." , "..factor[2].."的交点"
     elseif method=="midP"
      result=""..factor[1].." , "..factor[2].." 中点"
     elseif method=="intersectOfCL"
      result="圆周 "..factor[1].." 和直线 "..factor[2].." 的交点("..factor[3]..")"
     elseif method=="intersectOfCC"
      result="圆周 "..factor[1].." 和圆周 "..factor[2].." 的交点("..factor[3]..")"



    end
   elseif class=="Line"
    if method=="new"
      result="过 "..factor[1].." 和 "..factor[2].." 的直线"
    end
   elseif class=="Circle"
    if method=="new"
      result="以 "..factor[1].." 为圆心，并且穿过 "..factor[2].." 的圆周"
     elseif method=="newFrom3P"
      result="穿过 "..factor[1].." , "..factor[2].." , "..factor[3].."的圆周"


    end
   elseif class=="Conic0"
    if method=="new"
      result="以 "..factor[1].." , "..factor[2].." 为焦点,并且穿过 "..factor[3].."的椭圆"
    end

  end
  return result
end


GMT.__index.translateToSymbolEquation=function(gmt,name)
  local gmt_=gmt[name]
  local class=gmt_.class
  local method=gmt_.method
  local factor=gmt_.factor
  local result="RuLai!"
  if class=="Point"
    if method=="new"
      result=name.." = p"
     elseif method=="index_Line"
      result=name.." = "..factor[1].."["..Number.approximately(factor[2],-3).."]"
     elseif method=="index_Circle"
      result=name.." = "..factor[1].."["..Number.approximately(factor[2],-3).."]"
     elseif method=="intersectOfLL"
      result=name.." = "..factor[1].."∩"..factor[2]..""
     elseif method=="midP"
      result=name.." = p"
     elseif method=="intersectOfCL"
      result=name.." = "..factor[1].."∩"..factor[2]..", index="..factor[3]
     elseif method=="intersectOfCC"
      result=name.." = "..factor[1].."∩"..factor[2]..", index="..factor[3]



    end
   elseif class=="Line"
    if method=="new"
      result=name.." = λ"..factor[2].."+(1-λ)"..factor[1]
    end
   elseif class=="Circle"
    if method=="new"
      result="以 "..factor[1].." 为圆心，并且穿过 "..factor[2].." 的圆周"
     elseif method=="newFrom3P"
      result="穿过 "..factor[1].." , "..factor[2].." , "..factor[3].."的圆周"


    end
  end
  return result
end



--运行几何结构表并产生几何数据
GMT.__index.run=function(gmt,data)
  for i=1,#gmt.step do
    local a=gmt.step[i]
    local item=gmt[a]
    local d_=gLib[item.class][item.method](item.factor,data)
    if d_ data[a]=d_
     else gmt:delete(data,a)--依赖对象未定义, 删除此对象
    end
  end
end
--Nature Math 维持类型不变原则
--当遇到超出实数域的解释返回基于原类型的inf or nan
--并不会返回nil 因此此处的d_=nil 只可能是: 依赖对象未定义


--修改参数
GMT.__index.alterFactor=function(gmt,name,factor)
  gmt[name].factor=factor
end

setmetatable(GMT,GMT)
return GMT