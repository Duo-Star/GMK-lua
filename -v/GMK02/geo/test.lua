神兽保佑=[[
　　┏┓　　　┏┓+ +
　┏┛┻━━━┛┻┓ + +
　┃　　　　　　　┃ 　
　┃　　　━　　　┃ ++ + + +
 ████━████ ┃+
　┃　　　　　　　┃ +
　┃　　　┻　　　┃
　┃　　　　　　　┃ + +
　┗━┓　　　┏━┛
　　　┃　　　┃　　　　　　　　　　　
　　　┃　　　┃ + + + +
　　　┃　　　┃
　　　┃　　　┃ +  神兽保佑
　　　┃　　　┃    代码无bug　　
　　　┃　　　┃　　+　　　　　　　　　
　　　┃　 　　┗━━━┓ + +
　　　┃ 　　　　　　　┣┓
　　　┃ 　　　　　　　┏┛
　　　┗┓┓┏━┳┓┏┛ + + + +
　　　　┃┫┫　┃┫┫
　　　　┗┻┛　┗┻┛+ + + +]]



--[[
gmt:addPoint("A",Vector())
gmt:addPoint("B",Vector(2))
gmt:addCircle("c","A","B")
gmt:addLine("l","A","B")

gmt:index_Circle("C","c",1)
gmt:index_Line("D","l",2)
gmt:addCircle("c2","C","D")
--]]


--[[
gmt:addPoint("cO",Vector(1,1))
gmt:addPoint("cA",Vector(1))
gmt:addLine("l","cO","cA")
gmt:addCircle("c","cO","cA")
gmt:addPoint("A",Vector(3))
gmt:addCircle("c2","A","cO")
--]]


--[[
gmt:addPoint("A",Vector())
n=17
for i=1,n do
  gmt:addPoint("P"..i,Vector.new_angUnit(i*(2*pi/n)))
end
for i=1,n do
  gmt:addCircle("c"..i,"P"..i,"A")
end
--]]

--[[
vA=Vector(-5,5)
vB=Vector()
vC=Vector(5,5)
lAB=Line.newFrom2Point(vA,vB)
lBC=Line.newFrom2Point(vB,vC)
gmt:addPoint("A",vA)
gmt:addPoint("B",vB)
gmt:addPoint("C",vC)
gmt:addLine("AB","A","B")
gmt:addLine("BC","B","C")
n=20
for i=1,n-1 do
  gmt:index_Line("A"..i,"AB",(i/n))
  gmt:index_Line("C"..i,"BC",(i/n))
end
for i=1,n-1 do
  gmt:addLine("l"..i,"C"..i,"A"..i)
end
--]]

