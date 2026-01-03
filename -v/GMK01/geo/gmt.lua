--几何结构表
require "geo.gLib"

function GMT() end

GMT={__index={}}

GMT.__index.new=function(data)
  local data={step={}}
  return setmetatable(data,GMT)
end


--在表中添加一个几何结构
GMT.__index.add=function(gmt,name,item)
  gmt[name]=item
end

local cl={"purple","red","blue","teal","cyan","amber","brown","grey"}

--在表中添加一个点
GMT.__index.addPoint=function(gmt,name,p)
  gmt.step[#gmt.step+1]=name
  gmt:add(name,{
    name=name,
    class="Point",
    method="new",
    factor={p},--从json打开时会丢失metatable数据
    g={color="blue",width=8.0,style="FILL"}
  })
end


GMT.__index.addLine=function(gmt,name,p1,p2)
  gmt.step[#gmt.step+1]=name
  gmt:add(name,{
    name=name,
    class="Line",
    method="new",
    factor={p1,p2},--这里存放的是字符串
    g={color="teal",width=8.0,style="STROKE"}
  })
end

GMT.__index.addCircle=function(gmt,name,p1,p2)
  gmt.step[#gmt.step+1]=name
  gmt:add(name,{
    name=name,
    class="Circle",
    method="new",
    factor={p1,p2},--这里存放的是字符串
    g={color="grey",width=8.0,style="STROKE"}
  })
end


--运行几何结构表并产生几何数据
GMT.__index.run=function(gmt,data)
  for i=1,#gmt.step do
    local a=gmt.step[i]
    local item=gmt[a]
    data[a]=gLib[item.class][item.method](item.factor,data)
  end
end


--修改参数
GMT.__index.alterFactor=function(gmt,name,factor)
  gmt[name].factor=factor
end

setmetatable(GMT,GMT)
return GMT