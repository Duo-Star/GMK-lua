
graph.color={
  purple={0xFF673AB7,0xFFD1C4E9},
  red={0xFFD32F2F,0xFFEF9A9A},
  blue={0xFF3F51B5,0xFFC5CAE9},
  teal={0xFF00796B,0xFFB2DFDB},
  cyan={0xFF00ACC1,0xFFB2EBF2},
  amber={0xFFFFC107,0xFFFFECB3},
  brown={0xFF795548,0xFFD7CCC8},
  grey={0xFF757575,0xFFEEEEEE}
}
graph.colorIndexList={"purple","red","blue","teal","cyan","amber","brown","grey"}


graph.reset=function()
  graph.lam=250
  graph.o=Vector(w/2,h/2)
end

graph.toSP=function(v)
  return Vector(v.x*graph.lam+graph.o.x,
  v.y*(-graph.lam)+graph.o.y)
end


--用于检查一个点是否在几何对象上？
graph.checkOnGeo=function(geo,p,dx0)
  local class=getmetatable(item)
  local dx=0
  if class==Vector
    dx=p-item

   elseif class==Line
    dx=item:getPdisL(p)

   elseif class==Circle
    dx=item:getPdisL(p)

  end
  return (#dx)<dx0
end


graph.findP=function(data,p,dx0,info)
  local result,name=p,"自己看着办吧"
  for a, item in pairs(data) do
    if a~= info.exclude
      local class=getmetatable(item)
      local dx=0
      if class==Vector
        dx=p-item
        if (#dx)<dx0
          result = item
          name = a
        end
       elseif class==Line
        dx=item:getPdisL(p)
        if (dx)<dx0
          result = item:getProjectPoint(p)
          name = "自己看着办吧"
        end


      end
    end
  end

  return result
end


graph.makePaint=function(g)
  return Paint().setColor(graph.color[g.color][1]).setStyle(Paint.Style[g.style]).setStrokeWidth(g.width).setAntiAlias(true).setStrokeCap(Paint.Cap.ROUND)
end

graph.makePaint_2=function(g)
  return Paint().setColor(graph.color[g.color][2]).setStyle(Paint.Style[g.style]).setStrokeWidth(g.width*2.9).setAntiAlias(true).setStrokeCap(Paint.Cap.ROUND)
end


graph.drawPoint=function(canvas,v,p_)
  local p_=p_ or paint
  canvas.drawCircle(v.x*graph.lam+graph.o.x, v.y*(-graph.lam)+graph.o.y, 14, p_)
end

graph.drawParticle=function(canvas,particle,p_)
  local p_=p_ or paint
  canvas.drawCircle(particle.p.x*graph.lam+graph.o.x, particle.p.y*(-graph.lam)+graph.o.y, 8, p_)
end


canvas__=Canvas

graph.drawRect=function(canvas,p1,p2,p_)
  local p_=p_ or paint
  canvas.drawRect(p1.x*graph.lam+graph.o.x, p1.y*(-graph.lam)+graph.o.y,
  p2.x*graph.lam+graph.o.x, p2.y*(-graph.lam)+graph.o.y,
  p_)
end

graph.drawText=function(canvas,str,p,p_)
  local p_=p_ or paint
  canvas.drawText(str,p.x*graph.lam+graph.o.x, p.y*(-graph.lam)+graph.o.y,p_)
end


graph.drawSegment=function(canvas,p0,p1,p_)
  local p_=p_ or paint
  canvas.drawLine(
  p0.x*graph.lam+o.x,
  -p0.y*graph.lam+o.y,
  (p1.x)*graph.lam+o.x,
  -(p1.y)*graph.lam+o.y, p_)
end


graph.drawLine=function(canvas,l,p_)
  local p_=p_ or paint
  local a=1e3
  canvas.drawLine(
  (l.p.x-a*l.v.x)*graph.lam+o.x,
  -(l.p.y-a*l.v.y)*graph.lam+o.y,
  (l.p.x+a*l.v.x)*graph.lam+o.x,
  -(l.p.y+a*l.v.y)*graph.lam+o.y, p_)
end

graph.drawConic0=function(canvas,c,p_)
  local p_=p_ or paint
  local p0=graph.toSP(c:indexPoint(0))
  local p1
  local dx=0.15*(1/graph.lam)
  local path = Path()
  path.moveTo(p0.x,p0.y)
  if dx<=0.05 then dx=0.05 end
  for theta=0,2*pi+dx,dx do
    p1=graph.toSP(c:indexPoint(theta))
    path.lineTo(p1.x,p1.y)
  end
  canvas.drawPath(path,p_)
end

graph.drawCircle=function(canvas,c,p_)
  local p=graph.toSP(c.p)
  canvas.drawCircle(p.x,p.y,c.r*graph.lam,p_)
end

graph.drawCircle_=function(canvas,p,r,p_)
  local p=graph.toSP(p)
  canvas.drawCircle(p.x,p.y,r*graph.lam,p_)
  --canvas.drawPath(path,p_)
end

graph.drawTriangle=function(canvas,t,p_)
  local p_=p_ or paint
  local path = Path()
  local pa=graph.toSP(t.a)
  path.moveTo(pa.x,pa.y)
  local pb=graph.toSP(t.b)
  path.lineTo(pb.x,pb.y)
  local pc=graph.toSP(t.c)
  path.lineTo(pc.x,pc.y)
  path.close()
  canvas.drawPath(path,p_)
end


graph.drawCurve=function(canvas,c,p_)
  local p_=p_ or paint
  local p0=graph.toSP(c:indexPoint(c.range[1]))
  local p1
  local dx=0.15*(1/graph.lam)
  local path = Path()
  path.moveTo(p0.x,p0.y)
  if dx<=0.05 then dx=0.05 end
  for t=c.range[1],c.range[2]+dx,dx do
    p1=graph.toSP(c:indexPoint(t))
    path.lineTo(p1.x,p1.y)
  end
  canvas.drawPath(path,p_)
end


graph.drawPolygon=function(canvas, polygon, p_)
  local path = Path()
  local p0=graph.toSP(polygon.ps[1])
  local p1
  path.moveTo(p0.x,p0.y)
  for i=2,#polygon.ps do
    p1=graph.toSP(polygon.ps[i])
    path.lineTo(p1.x,p1.y)
  end
  p1=graph.toSP(polygon.ps[1])
  path.lineTo(p1.x,p1.y)
  canvas.drawPath(path,p_)
  --canvas.drawPath(path,Paint().setColor(p_.getColor()).setStrokeWidth(5).setStyle(Paint.Style.FILL))
end
