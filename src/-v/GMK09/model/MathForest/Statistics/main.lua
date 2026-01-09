local model={
  "DataList",
 

}

for i=1,#model do
  mf[model[i]]=require(mf.src..".Statistics."..model[i])
end