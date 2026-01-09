require "model.util"

--数据管理
sharedData= import "model.SharedData"
cjson=require "cjson"

--运算
import "model.MathForest.main"
GMKinfo=import "Home/info"
import "model.GMK_Core.main"


--颜色
themeUtil=LuaThemeUtil(this)
状态栏颜色(themeUtil.getColorSecondaryContainer())
ColorOutline=themeUtil.getColorOutline()

--字体
code_typeface=Typeface.createFromFile(activity.getLuaDir().."/res/fonts/code.ttf") --设置字体路径，page/main
jost_book_typeface=Typeface.createFromFile(activity.getLuaDir().."/res/fonts/jost_book.ttf") --设置字体路径，page/main
jost_medium_typeface=Typeface.createFromFile(activity.getLuaDir().."/res/fonts/jost_medium.ttf") --设置字体路径，page/main

--翻译
Translate=import "model.Translate"
translate=Translate.translate


--自定义视图
import "android.animation.ValueAnimator"
import "android.animation.TimeInterpolator"

import "model.class"
SeaDivider=import "model.SeaDivider"



if activity.getPackageName()=="duo.forest.gmk" then
  import "model.tj"
end

eggN=0

import "Home/lay"


import "android.content.Context"
import "com.google.firebase.analytics.FirebaseAnalytics"



--[[
mFirebaseAnalytics = FirebaseAnalytics(Context())

bundle=Bundle()
bundle.putString(FirebaseAnalytics.Param.ITEM_ID, "iddd")

mFirebaseAnalytics.logEvent(FirebaseAnalytics.Event.SELECT_CONTENT, bundle)

--FirebaseAnalytics.getInstance(this)
--]]




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
bottombar.menu.findItem(0).setIcon(getFileDrawable("imgs/round_home_black_24dp"))--这里findItem取的是home id
bottombar.menu.findItem(1).setIcon(getFileDrawable("imgs/round_bar_chart_black_24dp"))
bottombar.menu.findItem(2).setIcon(getFileDrawable("imgs/round_settings_black_24dp"))


vpg.setOnPageChangeListener(ViewPager.OnPageChangeListener{
  onPageSelected=function(v)
    bottombar.getMenu().getItem(v).setChecked(true)
    
end
})


bottombar.setOnNavigationItemSelectedListener(BottomNavigationView.OnNavigationItemSelectedListener{
  onNavigationItemSelected = function(item)
    vpg.setCurrentItem(item.getItemId())
    return true
  end
})



切换浅色与深色模式sw.onClick=function()
  --activity.recreate()--用不着这个
  activity.switchDayNight()
  task(5,function()
    bottombar.getMenu().getItem(2).setChecked(true)
  end)
end
task(800,function()
  切换浅色与深色模式sw.setChecked(isNightMode())
end)


双列显示sw.setOnCheckedChangeListener(function(view,c)
  sharedData.set("双列",tostring(双列显示sw.isChecked()))
  file_rec.layoutManager=StaggeredGridLayoutManager((function() if c return 2 else return 1 end end)(),1)
end)

双列显示sw.setChecked(sharedData.双列=="true")
数量text.text=sharedData.GP_N
临界text.text=sharedData.GP_critical_phi
判定策略text.text=sharedData.GP_tactics
语言text.text=sharedData.Language



--数据路径📎
GMKDir="/storage/emulated/0/Duo/Forest/GMK"
DataDir=GMKDir.."/Files"
CurrentDir=DataDir



--判断文件夹📂存在，创建文件夹
if File(DataDir.."/").exists() then
 else
  --os.execute("mkdir "..DataDir.."/")
  写入文件(DataDir.."/a","")
  File(DataDir.."/a").delete()
end


SimpleDateFormat = luajava.bindClass "java.text.SimpleDateFormat"
sdf = SimpleDateFormat("yyyy-MM-dd HH:mm:ss")



function getFileType(path)
  local str=String(path or "xxx.png")
  local index=str.lastIndexOf(".")
  return str.substring(index+1)
end


-------------💎加载数据

gmkTable={}

function shuffle(t)
  local n = #t
  for i = n, 2, -1 do
    local j = math.random(i)
    t[i], t[j] = t[j], t[i]
  end
end

function loaddata(dir)
  CachegmkTable=io.ls(dir)
  for i=1,#CachegmkTable do
    local path=dir.."/"..CachegmkTable[i]
    local name=CachegmkTable[i]
    local file=File(path)
    local lastModifiedTime = file.lastModified()
    local lastModifiedDate = Date(lastModifiedTime)
    local time = sdf.format(lastModifiedDate)
    local type_=getFileType(path)
    local isFile=file.isFile()
    table.insert(gmkTable,{
      path=path,
      name=name,
      time=time,
      type_=type_,
      isFile=isFile,
    })
  end
  --回收♻️
  CachegmkTable=nil
  if SharedData.get("SortOrder")=="时间" then
    table.sort(gmkTable,function(a,b)
      return a.time>b.time
    end)
   elseif SharedData.get("SortOrder")=="名称" then
    table.sort(gmkTable,function(a,b)
      return a.name<b.name
    end)
   elseif SharedData.get("SortOrder")=="瞎排" then
    shuffle(gmkTable)

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
      layout_margin="6dp",
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
            paddingLeft="5dp", paddingRight="5dp",padding="0.8dp",
            id="label",
            textSize="13sp", Typeface=jost_book_typeface,
            text="♪",
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
        textColor=ColorOutline,
        Typeface=jost_book_typeface,
      },
      {MaterialTextView,
        text="2022.11.21",
        Typeface=jost_book_typeface,
        textColor=ColorOutline,
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
    if item

      local path=item.path

      view.title.text=item.name
      view.date.text=item.time

      if item.isFile then

        view.content.text=tostring(io.open(path):read("*a")):sub(1,45).."..."

        view.label.text=(function(tp)
          if tp=="gmk" return translate"图形"
           elseif tp=="gp" return translate"证明"
           elseif tp=="lua" return translate"程序"
           else return "¿"
          end
        end) (item.type_)

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

            activity.newActivity("GP/main.lua")
            activity.setSharedData("LuaEditRun_ToDo","open")
            activity.setSharedData("LuaEditRun_Path",path)

          end
        end
       else
        view.label.text=translate"文件夹"
        view.content.text="/"
        --view.card.cardBackgroundColor=themeUtil.getColorPrimaryContainer()
        view.card.onClick=function(v)
          task(200,function()
            CurrentDir=item.path
            reLoad(CurrentDir)

          end)
          ObjectAnimator().ofFloat(file_rec,"alpha",{0,0,1}).setDuration(567).start()

        end
      end


      view.card.onLongClick=function(v)

        文件操作(path)


      end
    end
  end
})

file_rec.setAdapter(file_adp)
file_rec.layoutManager=StaggeredGridLayoutManager(
(function() if sharedData.双列=="true" return 2 else return 1 end end)()
,1)



--瀑布流列表视图
file_adp.submitList(gmkTable)

import "Home/func"


Dir_tv.onClick=function()
  CurrentDir=DataDir
  reLoad(CurrentDir)
end


fresh.setColorSchemeColors{cc.c.primary}
.setProgressBackgroundColorSchemeColor(backgroundc)
.setOnRefreshListener{
  onRefresh=function()
    reLoad(CurrentDir)
    local Dir_Second=((CurrentDir):match(DataDir .. "(.+)"))
    task(666,function()
      fresh.refreshing=false
    end)
  end
}


reLoad=function(dir)
  local dir=dir or CurrentDir
  table.clear(gmkTable)
  loaddata(dir)
  file_adp.submitList(gmkTable)
  task(10,function()
    recyclernotify()
  end)
  local Dir_Second=((CurrentDir):match(DataDir .. "(.+)"))
  if Dir_Second
    Dir_Second_tv.text=Dir_Second
   else Dir_Second_tv.text=""
  end

  if (#gmkTable)==0 then
    file_rec.visibility=8
    noneFile_tv.visibility=0
   else
    file_rec.visibility=0
    noneFile_tv.visibility=8
  end

end


function recyclernotify()
  file_adp.notifyItemRangeChanged(0, file_adp.getItemCount());
end


reLoad(CurrentDir)


--回调事件
function onActivityResult(s1,s2,s3)
  if s1==1 then
    task(10,function()
      fresh.setRefreshing(true)
      reLoad(CurrentDir)
      task(666,function()
        fresh.refreshing=false
      end)
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
