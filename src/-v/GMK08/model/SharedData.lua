local sharedData={}
sharedData.whats={
  "GeoRun_ToDo",
  "GeoRun_Path",
  "LuaEditRun_ToDo",
  "LuaEditRun_Path",
  "双列",
  "GP_N",--验证数量
  "GP_critical_phi",--临界正确率
  "GP_tactics",--策略
  "web_Context",
  "web_ToDo",
  "MD_md",
  "Language",
  "SortOrder",

}

sharedData.set=function(what,data)
  activity.setSharedData(what,data)
end

if activity.getSharedData("双列")==nil then
  sharedData.set("双列","false")
end

if activity.getSharedData("GP_N")==nil then
  sharedData.set("GP_N","1e5")
end

if activity.getSharedData("GP_critical_phi")==nil then
  sharedData.set("GP_critical_phi","0.98")
end

if activity.getSharedData("GP_tactics")==nil then
  sharedData.set("GP_tactics","承认浮点误差")
end

if activity.getSharedData("Language")==nil then
  sharedData.set("Language","zh")
end

if activity.getSharedData("SortOrder")==nil then
  sharedData.set("SortOrder","名称")
end


for i=1,#sharedData.whats do
  local item=sharedData.whats[i]
  sharedData[item]=activity.getSharedData(item)
end

sharedData.get=function(what)
  return activity.getSharedData(what)
end


return sharedData
