require "util"
import "class"
import "MaterialChip"
import "layout"


activity.finish()
activity.newActivity("geo/geo.lua")



activity.setContentView(loadlayout(layout))
--activity.newActivity("edit.lua")
--activity.finish()
-------------💎调式模式，打印全部数据不省略
function print(str)
  local tip_layout={
    LinearLayout;
    {
      TextView;
      id="text";
      textSize="12sp";
      layout_marginLeft="5dp";
      layout_marginRight="5dp";
      layout_gravity="center";
    };
  };
  local toast=Toast.makeText(activity,"t",Toast.LENGTH_LONG).setView(loadlayout(tip_layout))
  text.Text=tostring(str)
  --兼容手册夜间模式
  if isNightMode() then
    text.textColor=0xffffffff
   else
    text.textColor=0xff000000
  end
  toast.show()
end



--------------💎路径

--数据路径📎
DataDir="/data/user/0/"..tostring(activity.getPackageName().."/gmk/")

--判断文件夹📂存在，创建文件夹
if File(DataDir).exists() then
 else
  os.execute("mkdir "..DataDir)
end


-------------💎加载数据
function loaddata()
  CachegmkTable=io.ls(DataDir)
  table.remove(CachegmkTable,1)--删除.
  table.remove(CachegmkTable,1)--删除..
  gmkTable=CachegmkTable

  --回收♻️
  CachegmkTable=nil
end
loaddata()
--------------💎Recycler&适配器




--适配器布局🖼️
item={LinearLayout,
  Orientation=0,
  paddingTop="16dp",
  id="root",
  w="fill",
  h="wrap",
  {MaterialCardView,
    strokeColor=0,
    strokeWidth=0,
    layout_marginLeft="16dp",
    h="fill",
    w="4dp",
    radius="16dp",
    CardBackgroundColor=cc.c.primary,
  },
  {LinearLayout,
    layout_marginLeft="16dp",
    layout_marginRight="16dp",
    Orientation=1,
    {TextView,
      textSize="17sp",
      textColor=cc.c.primary,
      id="name",
    },
    {TextView,
      id="context",
      textSize="13sp",
    },

  },
}

local adp=LuaCustRecyclerAdapter(AdapterCreator({
  getItemCount=function()
    return #gmkTable
  end,
  onCreateViewHolder=function(parent,viewType)
    local views={}
    holder1=LuaCustRecyclerHolder(loadlayout(item,views))
    holder1.view.setTag(views)
    return holder1
  end,
  onBindViewHolder=function(holder,position)
    view=holder.view.getTag()

    view.name.text=gmkTable[position+1]:sub(1,#gmkTable[position+1]-4)
    local str1=""
    for c in io.lines(DataDir..gmkTable[position+1]) do
      str1=str1.."\n"..c
      if #str1>=150 then
        break
      end
    end

    view.context.text=str1

    view.root.onClick=function()
      activity.setSharedData("file",gmkTable[position+1])
      activity.newActivity("gmkedit.lua")
    end

  end,
}))
rec.setAdapter(adp)
rec.setLayoutManager(LinearLayoutManager(this))


--[[
require "svg"
icon图=setSvg("Jetpack.svg",画布id)

画布id.setBackground(icon图)
]]
-------------💎
--print(DataDir..gmkTable[2])

import "BottomSheetDialog"
fab.onClick=function()
  newbsd({
    NestedScrollView,
    layout_width="fill",
    layout_height="fill",
    {
      LinearLayout,
      layout_height="fill",
      layout_width="fill",
      orientation=1,
      {MaterialCardView,
        MaxCardElevation=1,
        strokeWidth=0,
        cardElevation=1,
        strokeColor=0,
        layout_marginTop="12dp",
        layout_width="36dp",
        layout_height="4dp",
        layout_gravity="center",
        --cardBackgroundColor=,
        cardBackgroundColor=cc.c.xbt,
      },
      {MaterialTextView,
        layout_marginTop="12dp",
        layout_gravity="center",
        textSize="24sp",
        textColor=cc.c.on_background,
        text="New",
      },

      {MaterialTextView,
        layout_marginTop="4dp",
        layout_marginLeft="12dp",
        layout_marginRight="12dp",
        layout_gravity="center",
        textSize="14sp",
        id="内容文字",
        textStyle="bold",
        text="设置工程名称",
      },

      {
        TextInputLayout,
        layout_gravity="center",
        id="t1",
        hint="Name",
        layout_marginTop="4dp",
        layout_marginLeft="8dp",
        boxBackgroundMode=TextInputLayout.BOX_BACKGROUND_OUTLINE,
        layout_width="76%w",
        {TextInputEditText,
          id="内容",
          padding="12dp";
          style=R.style.Widget_Material3_TextInputEditText_OutlinedBox_Dense,
          textSize=16,
          layout_width="fill",
        },
      },


      {MaterialButton,
        layout_marginTop="12dp",
        layout_marginRight="48dp",
        text="OK",
        layout_gravity="right",
        id="ok",
      },

      {Space,
        layout_height="30dp",
      },
    }
  }
  ).show()

  ok.onClick=function()
    File(DataDir..内容.text..".gmk").createNewFile()
    activity.setSharedData("file",内容.text..".gmk")
    activity.newActivity("edit.lua")
  end

end

function recyclernotify()
  adp.notifyItemRangeChanged(0, adp.getItemCount());
end

--回调事件
function onActivityResult(s1,s2,s3)
  if s2==2 then

    table.clear(gmkTable)
    loaddata()
    task(500,function()
      recyclernotify()
    end)
  end
end