require "model.util"


--首先，申请权限😘😘😘
--[
if Permission({
    Manifest.permission.READ_EXTERNAL_STORAGE,
    Manifest.permission.WRITE_EXTERNAL_STORAGE
  })
  --xpcall(main,ERROR)
  activity.finish()
  activity.newActivity("home.lua")

end
--]]