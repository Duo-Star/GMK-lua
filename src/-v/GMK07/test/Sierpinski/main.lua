require "model.util"
graph=import "test.graph"

--graph.MATH_GRAPH=false
graph.lam=600

src="test.Sierpinski"
Sierpinski=import(src..".Sierpinski")

paint = Paint().setColor(0xee5E35B1).setStyle(Paint.Style.FILL).setStrokeWidth(10).setAntiAlias(true).setStrokeCap(Paint.Cap.ROUND)


s={
  Triangle(Vector.newUC(rad(-30)),
  Vector.newUC(rad(90)),
  Vector.newUC(rad(210)))
}

f=function(item)
  local cAB=item.a:mid(item.b)
  local cAC=item.a:mid(item.c)
  local cBC=item.b:mid(item.c)
  return {
    Triangle(item.a,cAB,cAC),
    Triangle(item.b,cAB,cBC),
    Triangle(item.c,cBC,cAC)
  }
end

mix=function(a,b)
  local r=a
  for i=1,#b
    r[#r+1]=b[i]
  end
  return r
end

function each(s)
  local r={}
  for i=1,#s
    r=mix(r,f(s[i]))
  end
  return r
end

for n=1,6 do
  s=each(s)
end

graph.onDraw=function(canvas,graph)
  for i=1,#s do
    s[i]:onDraw(canvas,graph,paint)
  end
end




