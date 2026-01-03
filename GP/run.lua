require "model.util"
local mf=import "model.MathForest.main"
import "model.GMK_Core.main"
local sharedData=import "model.SharedData"
local GP_N=math.floor(tonumber(sharedData.GP_N))
local GP_critical_phi=tonumber(sharedData.GP_critical_phi)
local GP_tactics=sharedData.GP_tactics
local env_=mf


import "android.graphics.Typeface"
code_typeface=Typeface.createFromFile(activity.getLuaDir().."/res/fonts/code.ttf") --设置字体路径，page/main
jost_book_typeface=Typeface.createFromFile(activity.getLuaDir().."/res/fonts/jost_book.ttf") --设置字体路径，page/main
jost_medium_typeface=Typeface.createFromFile(activity.getLuaDir().."/res/fonts/jost_medium.ttf") --设置字体路径，page/main


Duo=loadlayout(
{ FrameLayout,
  layout_width = 'fill',
  layout_height = 'fill',
  {ProgressBar,
    layout_gravity="center",
    id="progress",
  },
  { LinearLayout,
    orientation="vertical",
    layout_width='fill',
    layout_height='fill',
    {TextView,
      text="Output",
      --textColor="#FF4F4100",
      Typeface=jost_medium_typeface,
      textSize="28dp",
      padding="2dp",
      layout_gravity="center|top",
    },
    { HorizontalScrollView,
      layout_width='fill',
      layout_height='wrap',
      { ScrollView,
        id="scrollView",
        layout_width="fill",
        layout_height="fill",
        { LinearLayout,
          orientation=1,
          layout_width='fill',
          layout_height='fill',
          id="broad"
        },
      },
    },
  },
})
activity.contentView=Duo

local see_n=0
function see(data)
  see_n=see_n+1
  local data=tostring(data)
  broad.addView(loadlayout(
  { LinearLayout,
    orientation='vertical',
    {TextView,
      text="Out["..see_n.."]: "..data,
      textIsSelectable="true",
      Typeface=jost_book_typeface,
      textSize="18dp",
      padding="8dp",
      layout_gravity="top|left"
    },
    { LinearLayout,
      layout_gravity="center|top",
      orientation=0,
      layout_width='fill',
      layout_height='2',
      background='#FF343225'
    }
  }))
end



local code=io.open(sharedData.LuaEditRun_Path):read("*a")


if GP_tactics=="严格判定" then
  mf.Env.d=0
 else
  mf.Env.d=3e-6
end
math.randomseed(mf.int(os.clock()*114514))

if code==nil then
 else
  task(100,function()
    xpcall(function()
      gpl=GPL(code)
      gpl.N=GP_N
      gpl.critical_phi=GP_critical_phi
      gpl:run(env_)
      see(dump(gpl.gmt))
      for i=1,#gpl.log do
        see(gpl.log[i])
      end
    end,
    function(e)
      see("error: 请检查文件内容")
      see(e)
    end)
    progress.setVisibility(View.GONE)
  end)
end