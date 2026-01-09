
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



function 文件操作(path)
  local file=File(path)
  local dialog
  local madb=MaterialAlertDialogBuilder(this)
  madb.setTitle("文件: "..file.getName())
  madb.setView(loadlayout({
    LinearLayout,
    orientation="1",
    { MaterialCardView,
      layout_height="50dp",
      layout_width="fill",
      radius="30dp",
      cardElevation=0,
      strokeWidth=0,
      layout_marginLeft='25dp',
      layout_marginRight='25dp',
      layout_marginTop="15dp",
      cardBackgroundColor=(themeUtil.getColorSurfaceVariant()),
      layout_gravity="top|center",
      onClick=function()
        dialog.dismiss()
        this.shareFile(path)
      end,
      { LinearLayout,
        orientation="0",
        layout_height="fill",
        layout_width="fill",
        {
          AppCompatImageView,
          layout_width="46dp",
          layout_height="46dp",
          layout_gravity="center|left",
          padding="13dp",
          paddingStart="15dp",
          colorFilter=primaryc,
          src="res/imgs/share_black.png",
        },
        {
          MaterialTextView,
          layout_width="fill",
          layout_marginLeft="5dp",
          layout_gravity="center|left",
          text="分享",
          textSize="18sp",
          Typeface=jost_book_typeface,
          textColor=primaryc,
        },
      },
    },
    { MaterialCardView,
      layout_height="50dp",
      layout_width="fill",
      radius="30dp",
      cardElevation=0,
      strokeWidth=0,
      layout_marginLeft='25dp',
      layout_marginRight='25dp',
      layout_marginTop="9dp",
      cardBackgroundColor=(themeUtil.getColorSurfaceVariant()),
      layout_gravity="top|center",
      onClick=function()
        MaterialAlertDialogBuilder(this)
        .setTitle("注意")
        .setMessage("即将删除"..path)
        .setPositiveButton("给老子删了",function()
          删除文件(path)
          dialog.dismiss()
          reLoad()
        end)
        .setNegativeButton("取消",nil)
        .show()
      end,
      { LinearLayout,
        orientation="0",
        layout_height="fill",
        layout_width="fill",
        {
          AppCompatImageView,
          layout_width="46dp",
          layout_height="46dp",
          layout_gravity="center|left",
          padding="13dp",
          paddingStart="15dp",
          colorFilter=primaryc,
          src="res/imgs/delete_forever_black.png",
        },
        {
          MaterialTextView,
          layout_width="fill",
          layout_marginLeft="5dp",
          layout_gravity="center|left",
          text="删除",
          textSize="18sp",
          Typeface=jost_book_typeface,
          textColor=primaryc,
        },
      },
    },

    { MaterialCardView,
      layout_height="50dp",
      layout_width="fill",
      radius="30dp",
      cardElevation=0,
      strokeWidth=0,
      layout_marginLeft='25dp',
      layout_marginRight='25dp',
      layout_marginTop="9dp",
      cardBackgroundColor=(themeUtil.getColorSurfaceVariant()),
      layout_gravity="top|center",
      onClick=function()
        local lastModifiedTime = file.lastModified()
        local lastModifiedDate = Date(lastModifiedTime)
        local time = sdf.format(lastModifiedDate)
        local msg=""
        msg=msg.."文件名称: "..file.getName()
        .."\n".."大小: "..file.getUsableSpace()
        .."\n".."位置: "..path
        .."\n".."时间: "..time
        MaterialAlertDialogBuilder(this)
        .setTitle("属性")
        .setMessage(msg)
        .setNegativeButton("取消",nil)
        .show()
      end,
      { LinearLayout,
        orientation="0",
        layout_height="fill",
        layout_width="fill",
        {
          AppCompatImageView,
          layout_width="46dp",
          layout_height="46dp",
          layout_gravity="center|left",
          padding="13dp",
          paddingStart="15dp",
          colorFilter=primaryc,
          src="res/imgs/info_black.png",
        },
        {
          MaterialTextView,
          layout_width="fill",
          layout_marginLeft="5dp",
          layout_gravity="center|left",
          text="属性",
          textSize="18sp",
          Typeface=jost_book_typeface,
          textColor=primaryc,
        },
      },
    },
    {Space,
      layout_height="18dp",
    },
  }))
  dialog=madb.show()
end











