
--[[
gmt:addPoint("cO",Vector())
gmt:addPoint("cA",Vector(1))
gmt:addLine("l","cO","cA")
gmt:addCircle("c","cO","cA")
gmt:addPoint("A",Vector(3))
gmt:addCircle("c2","A","cO")
--]]




--[
gmt:addPoint("A",Vector())
n=17
for i=1,n do
  gmt:addPoint("P"..i,Vector.new_angUnit(i*(2*pi/n)))
end
for i=1,n do
  gmt:addCircle("c"..i,"P"..i,"A")
end
--]]
