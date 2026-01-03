require "model.util"
import "model.class"
import "model.MaterialChip"

themeUtil=LuaThemeUtil(this)
cjson=require "cjson"


import "android.graphics.Typeface"
code_typeface=Typeface.createFromFile(activity.getLuaDir().."/res/fonts/code.ttf") --设置字体路径，page/main
jost_book_typeface=Typeface.createFromFile(activity.getLuaDir().."/res/fonts/jost_book.ttf") --设置字体路径，page/main
jost_medium_typeface=Typeface.createFromFile(activity.getLuaDir().."/res/fonts/jost_medium.ttf") --设置字体路径，page/main


if activity.getPackageName()=="duo.forest.gmk" then
  import "model.tj"
end


import "model.GMK_Core.main"

layout={
  CoordinatorLayout,
  layout_width="fill",
  layout_height="fill",
  {
    NestedScrollView,
    layout_width="fill",
    layout_height="fill",
    fillViewport="true",
    backgroundColor=backgroundc,
    {
      LinearLayoutCompat,
      id="content",
      layout_width="fill",
      layout_height="fill",
      orientation="vertical",
      {
        ViewPager,
        id="vpg",
        layout_width="fill",
        layout_height="fill",
        pages={
          {
            NestedScrollView,
            layout_width="fill",
            layout_height="fill",
            fillViewport="true",
            backgroundColor=backgroundc,
            {
              LinearLayoutCompat,
              layout_width="fill",
              layout_height="fill",
              orientation="vertical",
              layoutTransition=LayoutTransition().enableTransitionType(LayoutTransition.CHANGING),
              {
                MaterialTextView,
                layout_marginTop="35dp",
                layout_gravity="top|center",
                text="GeoMKY",
                singleLine="true",
                textSize="55sp",
                textColor=primaryc,
                Typeface=jost_medium_typeface,
              },
              {
                MaterialTextView,
                layout_marginTop="14dp",layout_margin="8dp",
                layout_gravity="center",
                text="探索神圣几何的城堡",
                singleLine="true",
                textSize="23sp",
                Typeface=jost_book_typeface,
              },
              {Space,
                layout_height="35dp",
              },
              {
                MaterialTextView,
                layout_margin="16dp",
                layout_gravity="center|left",
                text="借助您面前这台机器的计算能力，以及MathForest引擎，让我们开始吧!",
                textSize="18sp",
                Typeface=jost_book_typeface,
                textColor=themeUtil.getColorOutline(),
              },
              { MaterialCardView,
                layout_height="50dp",
                layout_width="fill",
                radius="3dp",
                cardElevation=0,
                strokeWidth=dp2px(0),
                strokeColor=themeUtil.getColorPrimaryContainer(),
                layout_marginLeft='25dp',
                layout_marginRight='25dp',
                cardBackgroundColor=(0),
                layout_gravity="top|center",
                onClick=function()
                  newGMK()
                end,
                {
                  MaterialTextView,
                  layout_marginLeft="10dp",
                  layout_gravity="center|left",
                  text="> 交互式几何工具",
                  textSize="18sp",
                  Typeface=jost_book_typeface,
                  textColor=primaryc,
                },
              },
              { MaterialCardView,
                layout_height="50dp",
                layout_width="fill",
                radius="3dp",
                cardElevation=0,
                strokeWidth=0,
                strokeColor=themeUtil.getColorPrimaryContainer(),
                layout_marginLeft='25dp',
                layout_marginRight='25dp',
                cardBackgroundColor=(0),
                layout_gravity="top|center",
                onClick=function()
                  newGP()
                end,
                {
                  MaterialTextView,
                  layout_marginLeft="10dp",
                  layout_gravity="center|left",
                  text="> GMK几何证明",
                  textSize="18sp",
                  Typeface=jost_book_typeface,
                  textColor=primaryc,
                },
              },
              { MaterialCardView,
                layout_height="50dp",
                layout_width="fill",
                radius="3dp",
                cardElevation=0,
                strokeWidth=dp2px(0),
                strokeColor=themeUtil.getColorPrimaryContainer(),
                layout_marginLeft='25dp',
                layout_marginRight='25dp',
                cardBackgroundColor=(0),
                layout_gravity="top|center",
                onClick=function()
                  newLua()
                end,
                {
                  MaterialTextView,
                  layout_marginLeft="10dp",
                  layout_gravity="center|left",
                  text="> Code",
                  textSize="18sp",
                  Typeface=jost_book_typeface,
                  textColor=primaryc,
                },
              },
              {
                MaterialCardView,
                radius="16dp",layout_margin="25dp",
                layout_marginTop="24dp",
                layout_width="fill",
                layout_height="wrap",
                --strokeWidth="0dp",--设置边框宽度
                {
                  LinearLayoutCompat,
                  orientation="vertical",
                  layout_width="fill",
                  layout_height="wrap",
                  padding="16dp",
                  {
                    LinearLayoutCompat,
                    layout_width="fill",
                    layout_height="wrap",
                    gravity="center",
                    {
                      AppCompatImageView,
                      layout_width="55dp",
                      layout_height="55dp",
                      padding="10dp",
                      paddingStart="0",
                      colorFilter=primaryc,
                      src="res/Duo.png",
                    },
                    {
                      MaterialTextView,
                      layout_width="fill",
                      paddingEnd="16dp",
                      text="Duo: \n注意，您目前看到的是GMK 1.0.0_7.31测试版\n部分功能没有实装",Typeface=jost_book_typeface,
                      textSize="16sp",
                    },
                  },
                  {
                    MaterialButton,
                    layout_marginTop="12dp",
                    layout_gravity="end",
                    text="明白",
                    onClick=function(v)
                      v.getParent().getParent().setVisibility(8)
                    end,
                  },
                },
              },
              {
                MaterialTextView,
                layout_margin="16dp",
                layout_gravity="center|left",
                text=[[正所谓孤木不成林，很高兴与独一无二的你交流互鉴！我们的APP也将在这里发布更新]],
                textSize="18sp",
                Typeface=jost_book_typeface,
                textColor=themeUtil.getColorOutline(),
              },
              { MaterialCardView,
                layout_height="50dp",
                layout_width="fill",
                radius="3dp",
                cardElevation=0,
                strokeWidth=dp2px(0),
                strokeColor=themeUtil.getColorPrimaryContainer(),
                layout_marginLeft='25dp',
                layout_marginRight='25dp',
                cardBackgroundColor=(0),
                layout_gravity="top|center",
                onClick=function()
                  加QQ群(663251235)
                end,
                {
                  MaterialTextView,
                  layout_marginLeft="10dp",
                  layout_gravity="center|left",
                  text="> 加入QQ群组",
                  textSize="18sp",
                  Typeface=jost_book_typeface,
                  textColor=primaryc,
                },
              },
              {
                MaterialTextView,
                layout_marginTop="16dp",
                layout_margin="10dp",
                layout_gravity="center|left",
                text=[[关于GeoMKY]],
                textSize="22sp",
                Typeface=jost_book_typeface,
                textColor=primaryc,
              },
              {
                MaterialTextView,
                layout_margin="16dp",
                layout_marginTop="5dp",
                layout_gravity="center|left",
                text=[[精心打造的几何软件，全称Geometry Monkey。旨在利用现代计算机的强大计算能力，帮助我们直观，便捷地探索几何世界。
几何是广泛的，它总会出现在生活的各个角落。它是美丽的，总是用最简洁的元素组成令人惊叹的结构。
如果你使用过GeoGebra,Desmos，你会发现，虽然它们都具有强大的计算与作图能力，但他们对于编程的支持并不突出。GeoMKY开放了以Lua为语言的编程接口，通过MathForest内置的数学计算api控制几何元素的呈现。
当然，你也可以使用我们的绘图库实现动画演示，简单游戏开发，等等更精彩的想法！
让我们开启几何之旅吧 (๑>؂<๑）[Duo 2024.7.31] ]],
                textSize="18sp",
                Typeface=jost_book_typeface,
                textColor=themeUtil.getColorOutline(),
              },



              {Space,
                layout_height="100dp",
              },
            },

          },
          {
            LinearLayoutCompat,
            layout_width="fill",
            layout_height="fill",
            orientation="vertical",
            padding="16dp",
            {
              MaterialTextView,
              text="Files",
              textStyle="bold",
              textSize="46sp",
              Typeface=jost_medium_typeface,
            },
            {Space,
              layout_height="30dp",
            },
            { SwipeRefreshLayout,
              id="fresh",
              layout_width="match_parent",
              layout_height="match_parent",
              layout_marginLeft="12dp",
              layout_marginRight="12dp",
              { RecyclerView,
                id="file_rec",
                layout_width="fill",
                layout_height="fill",


              },
            },

          },
          {
            NestedScrollView,
            layout_width="fill",
            layout_height="fill",
            {
              LinearLayoutCompat,
              orientation="vertical",
              layout_width="fill",
              layout_height="fill",
              padding="16dp",
              layoutTransition=LayoutTransition().enableTransitionType(LayoutTransition.CHANGING),
              {
                MaterialTextView,
                text="Settings",
                textStyle="bold",
                textSize="46sp",
                Typeface=jost_medium_typeface,
              },
              {Space,
                layout_height="30dp",
              },
              {
                MaterialTextView,
                text="界面",
                textStyle="bold",
                textSize="16sp",
                Typeface=jost_book_typeface,
                textColor=primaryc,
              },
              {
                LinearLayoutCompat,
                layout_marginTop="12dp",
                layout_width="fill",
                layout_height="wrap",
                gravity="center",
                {
                  LinearLayoutCompat,
                  orientation="vertical",
                  layout_width="wrap",
                  layout_height="wrap",
                  {
                    MaterialTextView,
                    text="夜?",
                    textStyle="bold",
                    textSize="18sp",
                  },
                  {
                    MaterialTextView,
                    text="切换浅色与深色模式",
                    textSize="14sp",
                  },
                },
                {
                  Space,
                  layout_weight="1",
                },
                {
                  MaterialSwitch,
                  id="切换浅色与深色模式sw",
                  --checked=isNightMode(),
                },
              },



            },
          }


        },
      },
    },
  },
  {
    BottomNavigationView,
    id="bottombar",
    layout_gravity="bottom",
    layout_width="fill",
    layout_height="wrap",
  },
  {
    ExtendedFloatingActionButton,
    id="fab",
    text="Add",
    onClick="onClickFab",
    icon=getFileDrawable("add"),
    layout_gravity="bottom|end",
    layout_marginBottom="110dp",
    layout_marginEnd="16dp",
  },

}

--设置布局
activity.setContentView(loadlayout(layout))
--隐藏自带ActionBar
activity.getSupportActionBar().hide()
--配置状态栏颜色
local window = activity.getWindow()
window.setStatusBarColor(surfaceVar)
window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
window.clearFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS)
window.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR)
window.setNavigationBarColor(surfaceVar)

--设置Material底栏。谷歌将启用新的BottomAppBar,两者区别不大，故不再作展示
--得益于CoordinatorLayout的强大支持，配合layout_behavior轻松实现滚动隐藏
local bottombarBehavior=luajava.bindClass"com.google.android.material.behavior.HideBottomViewOnScrollBehavior"
bottombar.layoutParams.setBehavior(bottombarBehavior())
bottombar.setLabelVisibilityMode(2)--设置tab样式

--设置底栏项目
bottombar.menu.add(0,0,0,"Home")--参数分别对应groupid homeid order name
bottombar.menu.add(0,1,1,"Chart")
bottombar.menu.add(0,2,2,"Settings")
--设置底栏图标
bottombar.menu.findItem(0).setIcon(getFileDrawable("round_home_black_24dp"))--这里findItem取的是home id
bottombar.menu.findItem(1).setIcon(getFileDrawable("round_bar_chart_black_24dp"))
bottombar.menu.findItem(2).setIcon(getFileDrawable("round_settings_black_24dp"))


vpg.setOnPageChangeListener(ViewPager.OnPageChangeListener{
  onPageSelected=function(v)
    bottombar.getMenu().getItem(v).setChecked(true)
    if v~=1 then
      Show_Hide_fab(fab,200,{1,0})
      task(200,function() fab.setVisibility(8)end)
     else
      fab.setVisibility(0)
      Show_Hide_fab(fab,200,{0,1})
    end
end})

fab.setVisibility(8)
--appBarL.setVisibility(8)

bottombar.setOnNavigationItemSelectedListener(BottomNavigationView.OnNavigationItemSelectedListener{
  onNavigationItemSelected = function(item)
    vpg.setCurrentItem(item.getItemId())
    return true
end})



task(1000,function()
  切换浅色与深色模式sw.setChecked(isNightMode())
end)

切换浅色与深色模式sw.onClick=function()
  --activity.recreate()--用不着这个
  activity.switchDayNight()
  bottombar.getMenu().getItem(2).setChecked(true)
end




--数据路径📎
GMKDir="/storage/emulated/0/Duo/Forest/GMK/"
DataDir=GMKDir.."Files/"


--判断文件夹📂存在，创建文件夹
if File(DataDir).exists() then
 else
  os.execute("mkdir "..DataDir)
end


local SimpleDateFormat = luajava.bindClass "java.text.SimpleDateFormat"
local sdf = SimpleDateFormat("yyyy-MM-dd HH:mm:ss")



function getFileType(path)
  local str=String(path or "xxx.png")
  local index=str.lastIndexOf(".")
  return str.substring(index+1)
end


-------------💎加载数据

gmkTable={}

function loaddata()
  CachegmkTable=io.ls(DataDir)
  gmkTable={}
  for i=1,#CachegmkTable do
    local path=DataDir..CachegmkTable[i]
    local name=CachegmkTable[i]
    local file=File(path)
    local lastModifiedTime = file.lastModified()
    local lastModifiedDate = Date(lastModifiedTime)
    local time = sdf.format(lastModifiedDate)
    local type_=getFileType(path)
    table.insert(gmkTable,{
      path=path,
      name=name,
      time=time,
      type_=type_,
    })
  end
  --回收♻️
  CachegmkTable=nil
end

local demo=import "Home/demoData"
for i=1,#demo do
  local item=demo[i]
  if not(File(item[1]).exists())
    写入文件(item[1],item[2])
  end
end

item={ LinearLayout,
  layout_width="fill",
  Gravity="center",
  padding="4dp",
  paddingBottom="8dp",
  paddingTop="0dp",
  id="father",
  {MaterialCardView,
    style=aa.a.cvos,
    CardElevation=0,
    id="card",
    layout_width="fill",
    layout_height="wrap",
    {LinearLayout,
      Orientation=1,
      layout_width="fill",
      layout_height="fill",
      {LinearLayout,
        Orientation=0,
        layout_width="fill",
        layout_height="wrap",
        {MaterialTextView,
          layout_weight=1,
          Typeface=jost_medium_typeface,
          layout_marginTop="16dp",
          layout_marginLeft="16dp",
          id="title",
          textSize="18sp",
          maxLines=1,
          ellipsize="end",
        },
        {MaterialCardView,
          id="labelcard",
          layout_marginTop="16dp",
          layout_marginRight="16dp",
          layout_width="wrap",
          layout_height="wrap",
          cardBackgroundColor=cc.c.primary,
          strokeWidth=0,
          radius="3dp",
          {MaterialTextView,
            paddingLeft="3dp", paddingRight="3dp",padding="0.2dp",
            id="label",
            textSize="13sp", Typeface=jost_book_typeface,
            text="MD",
            layout_gravity="center",
            textColor=cc.c.background,
          },
        }
      },
      {MaterialTextView,
        layout_marginTop="8dp",
        layout_marginLeft="16dp",
        layout_marginRight="16dp",
        id="content",
        textSize="13sp",
        Typeface=jost_book_typeface,
      },
      {MaterialTextView,
        text="2022.11.21",
        Typeface=jost_book_typeface,
        layout_marginTop="8dp",
        layout_marginLeft="16dp",
        layout_marginRight="16dp",
        layout_marginBottom="16dp",
        id="date",
      },

    },
  }
}

file_adp=LuaDiffRecyclerAdapter(LuaDiffRecyclerAdapter.LuaInterface {
  getItemViewType=function(position)
    return int(0)
  end,
  onCreateViewHolder=function(parent,types)
    local tag={}
    local view= loadlayout(item,tag,parent.class)
    view.tag=tag
    return view
  end,
  areContentsTheSame=function(old,new)
    return old.title==new.title and old.des == new.des and old.date==new.date and old.color==new.color
  end,
  areItemsTheSame=function(old,new)
    return old.title==new.title and old.des == new.des and old.date==new.date and old.color==new.color
  end,
  onBindViewHolder=function(holder,position)
    local view=holder.itemView.tag

    local item=gmkTable[position+1]
    local path=item.path
    view.title.text=item.name

    view.content.text=tostring(io.open(path):read("*a")):sub(1,50).."..."

    view.date.text=item.time

    view.label.text=(function(tp) if tp=="gmk" return "图形" elseif tp=="gp" return "证明" elseif tp=="lua" return "程序" else return "¿" end end)(item.type_)

    getFileType(path)

    view.card.onClick=function(v)
      if item.type_=="gmk" then
        activity.newActivity("Geo/main.lua")
        activity.setSharedData("GeoRun_ToDo","open")
        activity.setSharedData("GeoRun_Path",path)
       elseif item.type_=="lua" then
        activity.newActivity("Code/main.lua")
        activity.setSharedData("LuaEditRun_ToDo","open")
        activity.setSharedData("LuaEditRun_Path",path)
       elseif item.type_=="gp" then

      end
    end

    view.card.onLongClick=function(v)
      MaterialAlertDialogBuilder(this)
      .setTitle("注意")
      .setMessage("即将删除文件"..path)
      .setPositiveButton("给老子删了",function()
        File(path).delete() reLoad()
      end)
      .setNegativeButton("取消",nil)
      .show()
    end
  end
})

file_rec.setAdapter(file_adp)
file_rec.layoutManager=StaggeredGridLayoutManager(2,1)--3为网格行数,可换HORIZONTAL
--瀑布流列表视图
file_adp.submitList(gmkTable)


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
    },
  }))
  .setPositiveButton("确定",{onClick=function(v)
      if 内容.text=="" then
        print("error: 文件名不能为空")
       else
        local path=DataDir..内容.text..".gmk"
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
    },
  }))
  .setPositiveButton("确定",{onClick=function(v)
      if 内容.text=="" then
        print("error: 文件名不能为空")
       else
        local path=DataDir..内容.text..".gp"
        File(path).createNewFile()
        reLoad()
        --[[
        activity.newActivity("geo/main.lua")
        activity.setSharedData("GeoRun_ToDo","new")
        activity.setSharedData("GeoRun_Path",path)
        --]]
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
    },
  }))
  .setPositiveButton("确定",{onClick=function(v)
      if 内容.text=="" then
        print("error: 文件名不能为空")
       else
        local path=DataDir..内容.text..".lua"
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



fab.onClick=function()
  newGMK()
end


fresh.setColorSchemeColors{cc.c.primary}
.setProgressBackgroundColorSchemeColor(backgroundc)
.setOnRefreshListener{
  onRefresh=function()
    reLoad()
    task(300,function()
      fresh.refreshing=false
    end)
  end
}



reLoad=function()
  table.clear(gmkTable)
  loaddata()
  file_adp.submitList(gmkTable)
  task(100,function()
    recyclernotify()
  end)
end


function print(str)
  local tip_layout={
    LinearLayout;
    {MaterialCardView,
      strokeColor=0,radius="8dp",layout_margin="3dp";
      strokeWidth=0,cardElevation=10,
      {
        TextView;
        id="text";
        textSize="13sp";
        layout_margin="15dp";layout_marginLeft="20dp";layout_marginRight="20dp";
        layout_gravity="center";
      };
    },
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

function recyclernotify()
  file_adp.notifyItemRangeChanged(0, file_adp.getItemCount());
end


reLoad()


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



神兽保佑=[[
　　┏┓　　　┏┓+ +
　┏┛┻━━━┛┻┓ + +
　┃　　　　　　　┃ 　
　┃　　　━　　　┃ ++ + + +
 ████━████ ┃+
　┃　　　　　　　┃ +
　┃　　　┻　　　┃
　┃　　　　　　　┃ + +
　┗━┓　　　┏━┛
　　　┃　　　┃　　　　　　　　　　　
　　　┃　　　┃ + + + +
　　　┃　　　┃
　　　┃　　　┃ +  神兽保佑
　　　┃　　　┃    代码无bug　　
　　　┃　　　┃　　+　　　　　　　　　
　　　┃　 　　┗━━━┓ + +
　　　┃ 　　　　　　　┣┓
　　　┃ 　　　　　　　┏┛
　　　┗┓┓┏━┳┓┏┛ + + + +
　　　　┃┫┫　┃┫┫
　　　　┗┻┛　┗┻┛+ + + +]]
