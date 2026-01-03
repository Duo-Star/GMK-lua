local model={
  "Particle",
  "Rope",
  "Field",
  "Interaction",

}

for i=1,#model do
  mf[model[i]]=require(mf.src..".Physics."..model[i])
end