--[[
╭⌒╮
⌒╮ ╭⌒╮
╭⌒╮ ⌒⌒╮
╱◥███████◣
｜田｜田田 │
╱◥██████████◣ ╬
｜田｜田田 田 │ ╬
╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬╬
--]]

--#Triangle 三角形
function Triangle() end
Triangle={
  __call=function(_,a,b,c)
    return Triangle.new(a,b,c)
  end,
  __index = {
    new=function(a,b,c)--新建 三角形
      return setmetatable({a=a or Vector(),b=b or Vector(1),c=c or Vector(1,1) },Triangle)
    end,
    loadTest=function()--加载测试
      return Triangle()
    end,
    newRight=function(p, v, n, l)
      return Triangle(p, p+v, p+v:cross(n):unit():scale(l))
    end,
    newRight2d=function(p, v, l)
      return Triangle(p, p+v, p+v:roll2d_90():unit():scale(l))
    end,
    randomRight2d=function(x0,x1,s)
      return Triangle.newRight2d(Vector.random(x0,x1,s),
      Vector.random(x0,x1,s),
      random(0+s,x1,s))
    end,
    random=function(x0,x1,s)
      return Triangle(Vector.random(x0,x1,s),
      Vector.random(x0,x1,s),
      Vector.random(x0,x1,s))
    end,
    random2d=function(x0,x1,s)
      return Triangle(Vector.random(x0,x1,s),
      Vector.random(x0,x1,s),
      0.0)
    end,
    getAB=function(t)
      return Line.newFrom2Point(t.a,t.b)
    end,
    getAC=function(t)
      return Line.newFrom2Point(t.a,t.c)
    end,
    getBC=function(t)
      return Line.newFrom2Point(t.b,t.c)
    end,
    getO=function(t)
      --[[
      --能💩是能💩,但是c不能是直角(nan)
      local a,b,c=t.a,t.b,t.c
      local vab,vac,vbc=b-a,c-a,c-b
      local c_C=vac:cosAngle(vbc)
      local c_B=vab:cosAngle(-vbc)
      local c_A=vab:cosAngle(vac)
      local AA=(-1)/(vab:len()*c_B)
      local BB=(-1)/(vac:len()*c_C)
      local CC=1/(vac:len()*c_A)
      local DD=vbc:len()/vab:len()
      local lambda_=((1)/(2*(AA+BB-CC*DD)))
      local v1=(vab:unit()):scale(-1/vab:cosAngle(vbc))
      local v2=(vac:unit()):scale(1/vac:cosAngle(vbc))
      return ((b+c):scale(0.5))+lambda_*(v1+v2)
      --]]
      --三行解决😘😘
      local l1=(t.a):perpendicularBisector2d(t.c)
      local l2=(t.a):perpendicularBisector2d(t.b)
      return l1:getIntersectPoint2d(l2)
    end,
    onDraw=function(t,canvas,graph,p_)
      local path = Path()
      local pa=graph.toSP(t.a)
      path.moveTo(pa.x,pa.y)
      local pb=graph.toSP(t.b)
      path.lineTo(pb.x,pb.y)
      local pc=graph.toSP(t.c)
      path.lineTo(pc.x,pc.y)
      path.close()
      canvas.drawPath(path,p_)
    end,






  }
}
setmetatable(Triangle, Triangle)

return Triangle
