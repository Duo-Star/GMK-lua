require "util"
import "class"
import "MaterialChip"

import "n.nature"
import "n.gmkcore"

--设置主题
--activity.setTheme(R.style.Theme_ReOpenLua_Material3)
import "com.google.android.material.color.DynamicColors"
DynamicColors.applyIfAvailable(this)
local themeUtil=LuaThemeUtil(this)
MDC_R=luajava.bindClass"com.google.android.material.R"
surfaceColor=themeUtil.getColorSurface()
--更多颜色分类 请查阅Material.io官方文档
backgroundc=themeUtil.getColorBackground()
surfaceVar=themeUtil.getColorSurfaceVariant()
titleColor=themeUtil.getTitleTextColor()
primaryc=themeUtil.getColorPrimary()
primarycVar=themeUtil.getColorPrimaryVariant()


local resources=activity.getResources()
function m3c(s)
  value = resources.getColor(android.R.color[s])
  return value
end


function getFileDrawable(file)
  fis = FileInputStream(activity.getLuaDir().."/res/"..file..".png")
  bitmap = BitmapFactory.decodeStream(fis)
  return BitmapDrawable(activity.getResources(), bitmap)
end


local DataDir="/data/user/0/"..tostring(activity.getPackageName().."/gmk/")
local file=DataDir..activity.getSharedData("file")
local 编辑框原始文字=io.open(file):read("*a")

import "android.graphics.Typeface"
code_typeface=Typeface.createFromFile(activity.getLuaDir().."/res/code.ttf") --设置字体路径，page/main



lay={
  CoordinatorLayout,
  layout_width="fill",
  layout_height="fill",
  {
    AppBarLayout,
    layout_width="fill",
    layout_height="56.8dp",
    {
      CollapsingToolbarLayout,
      layout_width="fill",
      layout_height="fill",
      title="File Name",
      background=ColorDrawable(surfaceVar),
      --expandedTitleColor="#FFFFFF",
      --collapsedTitleTextColor="#FFFFFF",
      --展开 和 收起 时的标题颜色
      {
        MaterialToolbar,
        id="toolbar",
        layout_collapseMode="pin",
        background=ColorDrawable(surfaceVar),
        layout_width="fill",
        layout_height="56dp",
      },
    },
  },
  {
    LinearLayoutCompat,
    orientation="vertical",
    layout_width="fill",
    layout_height="fill",
    layoutTransition=LayoutTransition().enableTransitionType(LayoutTransition.CHANGING),
    {
      TabLayout,
      id="mtab",
      layout_marginTop="56dp",
      layout_width="fill",
      layout_height="wrap",
    },
    {
      ViewPager,
      id="cvpg",
      layout_width="fill",
      layout_height="fill",
      pagesWithTitle={
        {--view
          {
            LinearLayoutCompat,
            orientation="vertical",
            layout_width="fill",
            layout_height="fill",
            padding="16dp",
            {
              MaterialCardView,
              radius="16dp",
              layout_marginTop="18dp",
              layout_width="fill",
              layout_height="wrap",
              --strokeWidth="0dp",--设置边框宽度
              {LuaEditor,
                id="edit",
                layout_marginTop="3dp",
                layout_margin="3dp",
                layout_width="fill",
                layout_height="500dp",
              },
            },
            {
              FrameLayout,
              layout_width="fill",
              layout_height="fill",
              {
                MaterialButton,
                layout_marginTop="12dp",
                layout_gravity="left",
                text="API",
                icon=getFileDrawable("sunny"),
                onClick=function(v)
                  print("none")
                end,
              },
              {
                MaterialButton,
                layout_marginTop="12dp",
                layout_gravity="end",
                text="Run",
                onClick=function(v)
                  see(GMK.new(edit.text or ""):run())
                end,
              },
            },
          },
          {
            SwipeRefreshLayout,
            id="mSwipe",
            layout_width="fill",
            layout_height="fill",
            {
              LinearLayoutCompat,
              orientation="vertical",
              layout_width="fill",
              layout_height="fill",
              gravity="center",
              { LinearLayout, orientation="vertical", layout_width='fill', layout_height='fill',
               
                { HorizontalScrollView, layout_width='fill', layout_height='wrap',
                  { ScrollView, id="scrollView", layout_width="fill", layout_height="fill", 
                    { LinearLayout, orientation=1, layout_width='fill', layout_height='fill', id="broad"},
                  },
                },
              }


            },
          },
        },
        {--title
          "GeoMKy",
          "Result",
        },
      },
    },



  },
}

activity.setContentView(loadlayout(lay))


mtab.setupWithViewPager(cvpg)

edit.text=编辑框原始文字

import "BottomSheetDialog"
function onKeyDown(code,event)
  if 编辑框原始文字~=edit.text and string.find(tostring(event),"KEYCODE_BACK") ~= nil then
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
          text="Exit?",
        },
        {MaterialButton,
          layout_marginTop="12dp",
          text="保存并退出",
          layout_gravity="center",
          id="ok",
        },
        {MaterialTextView,
          layout_marginTop="12dp",
          text="不保存",
          layout_gravity="center",
          id="no",
        },
        {Space,
          layout_height="64dp",
        },
      }
    }
    ).show()
    ok.onClick=function()
      io.open(file,"w"):write(edit.text):close()
      print("已保存")
      local intent=Intent()
      activity.setResult(2,intent)
      activity.finish()
    end
    no.onClick=function()
      activity.finish()
    end
    return true
  end
end

local see_n=0
function see(data)
  see_n=see_n+1
  local data=tostring(data)
  broad.addView(loadlayout(
  { LinearLayout, orientation='vertical',
    {TextView, text="Out["..see_n.."]: "..data, textColor="#FF343225",Typeface=code_typeface, textSize="18dp",padding="2dp",layout_gravity="top|left"},
    { LinearLayout, layout_gravity="center|top",orientation=0, layout_width='fill', layout_height='2', background='#FF343225' }
  }))
end
--see("Hello world!(๑>؂<๑）")