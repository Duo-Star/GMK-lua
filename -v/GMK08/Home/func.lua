
function newGMK()
  local 文件名=(os.date("%Y").."."..os.date("%m").."."..os.date("%d").."."..os.date("%H")..":"..os.date("%M")..":"..os.date("%S").."s")
  MaterialAlertDialogBuilder(this)
  .setTitle("创建新绘图")
  .setView(loadlayout({ LinearLayout,
    { TextInputLayout,
      layout_width="fill",
      layout_gravity="center",
      layout_margin="20dp",
      id="t1",
      hint="Name",
      boxBackgroundMode=TextInputLayout.BOX_BACKGROUND_OUTLINE,
      { TextInputEditText,
        id="内容",
        --text=文件名,
        padding="12dp";
        style=R.style.Widget_Material3_TextInputEditText_OutlinedBox_Dense,
        textSize=16,
        layout_width="fill",
      },
      {
        MaterialTextView,
        text="->"..CurrentDir,
        textStyle="bold",
        textSize="13sp",
      },
    },
  }))
  .setPositiveButton("确定",{onClick=function(v)
      if 内容.text=="" then
        print("error: 文件名不能为空")
       else
        local path=CurrentDir.."/"..内容.text..".gmk"
        File(path).createNewFile()
        reLoad()
        activity.newActivity("Geo/main.lua")
        activity.setSharedData("GeoRun_ToDo","new")
        activity.setSharedData("GeoRun_Path",path)
      end
    end
  })
  .setNegativeButton("取消",nil)
  .show()
end


function newGP()
  local 文件名=(os.date("%Y").."."..os.date("%m").."."..os.date("%d").."."..os.date("%H")..":"..os.date("%M")..":"..os.date("%S").."s")
  MaterialAlertDialogBuilder(this)
  .setTitle("创建几何证明")
  .setView(loadlayout({ LinearLayout,
    { TextInputLayout,
      layout_width="fill",
      layout_gravity="center",
      layout_margin="20dp",
      id="t1",
      hint="Name",
      boxBackgroundMode=TextInputLayout.BOX_BACKGROUND_OUTLINE,
      { TextInputEditText,
        id="内容",
        --text=文件名,
        padding="12dp";
        style=R.style.Widget_Material3_TextInputEditText_OutlinedBox_Dense,
        textSize=16,
        layout_width="fill",
      },
      {
        MaterialTextView,
        text="->"..CurrentDir,
        textStyle="bold",
        textSize="13sp",
      },
    },
  }))
  .setPositiveButton("确定",{onClick=function(v)
      if 内容.text=="" then
        print("error: 文件名不能为空")
       else
        local path=CurrentDir.."/"..内容.text..".gp"
        File(path).createNewFile()
        reLoad()
        写入文件(path,[[ξ ]]..内容.text..[[

]])
        activity.newActivity("GP/main.lua")
        activity.setSharedData("LuaEditRun_ToDo","open")
        activity.setSharedData("LuaEditRun_Path",path)
      end
    end
  })
  .setNegativeButton("取消",nil)
  .show()
end




function newLua()
  local 文件名=(os.date("%Y").."."..os.date("%m").."."..os.date("%d").."."..os.date("%H")..":"..os.date("%M")..":"..os.date("%S").."s")
  MaterialAlertDialogBuilder(this)
  .setTitle("创建程序")
  .setView(loadlayout({ LinearLayout,
    { TextInputLayout,
      layout_width="fill",
      layout_gravity="center",
      layout_margin="20dp",
      id="t1",
      hint="Name",
      boxBackgroundMode=TextInputLayout.BOX_BACKGROUND_OUTLINE,
      { TextInputEditText,
        id="内容",
        --text=文件名,
        padding="12dp";
        style=R.style.Widget_Material3_TextInputEditText_OutlinedBox_Dense,
        textSize=16,
        layout_width="fill",
      },
      {
        MaterialTextView,
        text="->"..CurrentDir,
        textStyle="bold",
        textSize="13sp",
      },
    },
  }))
  .setPositiveButton("确定",{onClick=function(v)
      if 内容.text=="" then
        print("error: 文件名不能为空")
       else
        local path=CurrentDir.."/"..内容.text..".lua"
        File(path).createNewFile()
        写入文件(path,[[require "model.graph"

]])
        reLoad()
        activity.newActivity("Code/main.lua")
        activity.setSharedData("LuaEditRun_ToDo","open")
        activity.setSharedData("LuaEditRun_Path",path)
      end
    end
  })
  .setNegativeButton("取消",nil)
  .show()
end




function newFolder()
  local 文件名=(os.date("%Y").."."..os.date("%m").."."..os.date("%d").."."..os.date("%H")..":"..os.date("%M")..":"..os.date("%S").."s")
  MaterialAlertDialogBuilder(this)
  .setTitle("新建文件夹")
  .setView(loadlayout({ LinearLayout,
    { TextInputLayout,
      layout_width="fill",
      layout_gravity="center",
      layout_margin="20dp",
      id="t1",
      hint="Name",
      boxBackgroundMode=TextInputLayout.BOX_BACKGROUND_OUTLINE,
      { TextInputEditText,
        id="内容",
        --text=文件名,
        padding="12dp";
        style=R.style.Widget_Material3_TextInputEditText_OutlinedBox_Dense,
        textSize=16,
        layout_width="fill",
      },
      {
        MaterialTextView,
        text="->"..CurrentDir,
        textStyle="bold",
        textSize="13sp",
      },
    },
  }))
  .setPositiveButton("确定",{onClick=function(v)
      if 内容.text=="" then
        print("error: 文件名不能为空")
       else
        local path=CurrentDir.."/"..(内容.text).."/haha.a"
        写入文件(path,"")
        File(path).delete()
        reLoad()
      end
    end
  })
  .setNegativeButton("取消",nil)
  .show()
end




function 导入_()
  local 文件名=(os.date("%Y").."."..os.date("%m").."."..os.date("%d").."."..os.date("%H")..":"..os.date("%M")..":"..os.date("%S").."s")
  MaterialAlertDialogBuilder(this)
  .setTitle("导入")
  .setView(loadlayout({ LinearLayout,
    { TextInputLayout,
      layout_width="fill",
      layout_gravity="center",
      layout_margin="20dp",
      id="t1",
      hint="Path",
      boxBackgroundMode=TextInputLayout.BOX_BACKGROUND_OUTLINE,
      { TextInputEditText,
        id="内容",
        padding="12dp";
        style=R.style.Widget_Material3_TextInputEditText_OutlinedBox_Dense,
        textSize=16,
        layout_width="fill",
      },
      {
        MaterialTextView,
        text="->"..CurrentDir,
        textStyle="bold",
        textSize="13sp",
      },
    },
  }))
  .setPositiveButton("确定",{onClick=function(v)
      if 内容.text=="" then
        print("error: 路径不能为空")
       else
        xpcall(function()
          local r=io.open(内容.text):read("*a")
          写入文件(CurrentDir..File(内容.text).getName(),r)
          reLoad()
        end,function() print("error") end)
      end
    end
  })
  .setNegativeButton("取消",nil)
  .show()
end







