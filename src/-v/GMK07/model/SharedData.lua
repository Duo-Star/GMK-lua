local sharedData={}
sharedData.whats={
  "GeoRun_ToDo",
  "GeoRun_Path",
  "LuaEditRun_ToDo",
  "LuaEditRun_Path",
}


for i=1,#sharedData.whats do
  local item=sharedData.whats[i]
  sharedData[item]=activity.getSharedData(item)
end

return sharedData
