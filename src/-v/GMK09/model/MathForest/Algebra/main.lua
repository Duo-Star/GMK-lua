local model={
  "Functions",
  "Complex",
  "Equation",
  "Number",
  "Random",
  "Sun",
  "Sunold"


}

for i=1,#model do
  mf[model[i]]=require(mf.src..".Algebra."..model[i])
end