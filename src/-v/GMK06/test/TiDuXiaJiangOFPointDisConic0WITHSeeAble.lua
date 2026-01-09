require "test.graph"

a=1
b=4
c=Conic0(Vector(),Vector(a),Vector(0,b))

p=Vector(3,3)
t=pi

dis2=c:getPdisConic0__dis2__(p,t)

A=c:indexPoint(t)
print_((A-p):pow2())
print_(dis2)

dt=5e-8
DerDis2=(c:getPdisConic0__dis2__(p,t+dt)-c:getPdisConic0__dis2__(p,t))/dt
print_(DerDis2)
print_(c:getPdisConic0__DerDis2__(p,t))


f=function(x)
  return c:getPdisConic0__dis2__(p,x)
end


data={
  c=c,
  p=p
}

t=(p-c.p):getAngle2d()
t=pi
print_(t)
tt=t
k=-0.02
for i=1,10 do
  tt=tt+k*c:getPdisConic0__DerDis2__(p,tt)
  k=k+0.001
  data["#"..i]=c:indexPoint(tt)
end



data.vv=Vector(0,1)>>Vector(1,1)





graph.setData(data)

surface.onTouch = function(v, event)
  local stp=Vector(event.getX(),event.getY())
  local gtp=Vector((stp.x-graph.o.x)/graph.lam,-(stp.y-graph.o.y)/graph.lam)
  data={}
  data.c=c
  data.p=gtp
  --[[
  t=pi/2
  if #c.u>=#c.v then
    if (data.p-c.p):dot(c.v)>0 then
      t=pi/2
     else
      t=-pi/2
    end
   else
   if (data.p-c.p):dot(c.u)>0 then
      t=0
     else
      t=pi
    end
   
  end

  tt=t
  k=-0.05
  for i=1,10 do
    tt=tt+k*c:getPdisConic0__DerDis2__(data.p,tt)
    k=k/math.exp(0.05*i)
    data["#"..i]=c:indexPoint(tt)
  end
  data.init=c:indexPoint(t)
  data.best=c:indexPoint(tt)
  data.l=Line.newFrom2Point(data.p,data.best)
  --]]
  data.best=c:getPdisConic0__BestP__(gtp)
  a=c:getPdisConic0(gtp)
  graph.setData(data)
  return true
end
