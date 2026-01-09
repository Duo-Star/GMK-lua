local model={
  "Is",

}

for i=1,#model do
  mf[model[i]]=require(mf.src..".Logic."..model[i])
end