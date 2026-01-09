local model={
  "Functions",
  "Complex",
  "Equation",
  "Number",
  "Random"

}

for i=1,#model do
  mf[model[i]]=require(mf.src..".Algebra."..model[i])
end