local model={
  "Functions",
  "Complex",
  "Equation",
  "Number"

}

for i=1,#model do
  mf[model[i]]=require(mf.src..".Algebra."..model[i])
end