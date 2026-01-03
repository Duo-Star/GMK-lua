require "model.util"
graph=import "test.graph"

--graph.MATH_GRAPH=false

src="test.Forest"
Forest=import(src..".Forest")
Tree=import(src..".Tree")

forest=Forest{}
forest.init()


c=Conic2.newHyperbola2dBy3P(Vector(1,1),Vector(2),Vector())


graph.onDraw=function(canvas,graph)
  for i=3.14/2,3.14*1.5,.05 do
    local p=Vector()+mf.sec(i)*Vector(1)+mf.tan(i)*Vector(0,2)
    graph.drawPoint(canvas,p,paint)
  end
  c:onDraw(canvas,graph,paint)


end