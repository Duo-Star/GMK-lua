require "model.util"

local __={
  "Home/main.lua",
}

local pg=__[1]

--首先，申请权限😘😘😘
if Permission({
    Manifest.permission.READ_EXTERNAL_STORAGE,
    Manifest.permission.WRITE_EXTERNAL_STORAGE
  })
  activity.finish()
  activity.newActivity(pg)
end
