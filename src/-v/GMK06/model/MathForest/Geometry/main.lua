local model={
  "Vector",
  "Conic0",
  "Conic1",
  "Conic2",
  "Circle",
  "Line",
  "Plane",
  "Curve",
  "Triangle",
  "Model",
  "Polygon",
  "Points",

}

for i=1,#model do
  mf[model[i]]=require(mf.src..".Geometry."..model[i])
end