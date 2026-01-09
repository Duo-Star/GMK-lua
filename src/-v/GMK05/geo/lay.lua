Slider = luajava.bindClass "com.google.android.material.slider.Slider"
MaterialCardView = luajava.bindClass "com.google.android.material.card.MaterialCardView"
import "com.google.android.material.color.DynamicColors"
DynamicColors.applyIfAvailable(this)
themeUtil=LuaThemeUtil(this)
MDC_R=luajava.bindClass"com.google.android.material.R"
surfaceColor=themeUtil.getColorSurface()
--更多颜色分类 请查阅Material.io官方文档
backgroundc=themeUtil.getColorBackground()
surfaceVar=themeUtil.getColorSurfaceVariant()
titleColor=themeUtil.getTitleTextColor()
primaryc=themeUtil.getColorPrimary()
primarycVar=themeUtil.getColorPrimaryVariant()
resources=activity.getResources()
function m3c(s)
  value = resources.getColor(android.R.color[s])
  return value
end
function dp2px(i)
  return i*activity.resources.displayMetrics.scaledDensity+.5
end

function getFileDrawable(file)
  fis = FileInputStream(activity.getLuaDir().."/res/"..file..".png")
  bitmap = BitmapFactory.decodeStream(fis)
  return BitmapDrawable(activity.getResources(), bitmap)
end




--初始化随机数种子
math.randomseed(os.time())

--重写print
print_=function(_)
  txt.setText(txt.text.."\n"..tostring(_))
end


import "android.graphics.Typeface"
code_typeface=Typeface.createFromFile(activity.getLuaDir().."/res/code.ttf") --设置字体路径，page/main


--Animation
animation = ValueAnimator.ofFloat({ 0, 5*math.pi }).setDuration(3000).setRepeatCount(-1).setRepeatMode(2).start()


CircularProgressDrawable = luajava.bindClass "androidx.swiperefreshlayout.widget.CircularProgressDrawable"
circularProgressDrawable=CircularProgressDrawable(activity)



function showDialog(标题,内容,Todo)
  local dialog=MaterialAlertDialogBuilder(activity)
  .setTitle(标题)
  .setMessage(内容)
  .setPositiveButton("确定",{onClick=function() Todo() end})
  .show()
end


ui={}
if isNightMode()
  ui.引导栏进度条颜色=0xffffffff
  ui.引导栏背景颜色=0xFF5A5A5C
  ui.引导栏文字颜色=0xffffffff
  ui.卡片颜色=0xFF5A5A5C
 else
  ui.引导栏进度条颜色=0xffffffff
  ui.引导栏背景颜色=0xff000000
  ui.引导栏文字颜色=0xffffffff
  ui.卡片颜色=0xffffffff
end


--布局表
local layout =

  {
    LinearLayout,
    orientation=0,
    layout_width="fill",
    layout_height="fill",
    
    { FrameLayout,
      layout_width = 'fill',
      layout_height = 'fill',
      id="root",
      { SurfaceView;
        layout_width = 'fill',
        layout_height = 'fill',
        id = "surface",
      },
      {MaterialCardView,
        layout_height="fill",
        layout_width="72dp",
        radius="0dp",
        cardElevation=0,
        strokeWidth=0,
        layout_margin='0dp',
        cardBackgroundColor=0xffC5CAE9,
        visibility=(View.INVISIBLE),
        onClick=function()
        end,
        {--悬浮按钮
          FloatingActionButton;
          id="fab";
          layout_gravity="bottom|center";
          layout_marginBottom='10dp',
        };
      },
      {--悬浮按钮
        FloatingActionButton;
        id="fab";
        layout_gravity="bottom|left";
        layout_marginBottom='10dp',layout_margin="20dp",
      };
      { TextView,
        text="GMK 1.0.0",--textColor=primaryc,
        textSize="18dp",layout_margin="5dp",
        layout_gravity="bottom|right",
        id="txt",
      },
      { Button;
        layout_width="220px";
        layout_height="130px";
        layout_gravity="top|left";
        id="btn2";
        text="测试操作";
      },

      {MaterialCardView,
        radius="3dp",
        cardElevation=10,
        strokeWidth=0,
        layout_marginBottom='1dp',
        cardBackgroundColor=0xffffffff,
        onClick=function() end,
        layout_gravity="bottom|center";
        {
          TabLayout,
          id="toolTab",
          layout_width = 'fill',
          layout_height = 'fill',
        },
      },
      {MaterialCardView,--❤️❤️❤️引导栏
        --layout_width="220dp",
        radius="3dp",cardElevation=10,
        strokeWidth=0,
        layout_margin='5dp',
        cardBackgroundColor=ui.引导栏背景颜色,
        layout_gravity="top|right",
        id="guide_card",
        { LinearLayout,
          orientation='0',
          --backgroundColor=themeUtil.getColorOnBackground(),
          onClick=function() end,
          { View,--仅用来支撑
            layout_width="0dp",layout_height="30dp", layout_marginTop='10dp',layout_marginBottom='10dp',layout_marginLeft='10dp',
          },
          { View,
            layout_width="30dp",
            layout_height="30dp",
            layout_margin='5dp',
            layout_gravity="center",
            id="guide_card_progress",
            backgroundDrawable=circularProgressDrawable;
          },
          { TextView,
            text="Text",
            textSize="17dp",
            textColor=ui.引导栏文字颜色,
            layout_gravity="center",layout_margin='5dp',
            id="guide_card_text",layout_marginRight='18dp',
          },
        }
      },
      {MaterialCardView,--信息栏💧💧💧💧💧
        layout_width="220dp",
        radius="3dp",cardElevation=10,
        strokeWidth=0,
        layout_margin='5dp',
        cardBackgroundColor=ui.卡片颜色,
        layout_gravity="top|center",
        id="select_card",
        { LinearLayout,
          orientation='1',
          layout_width="220dp",
          background='#00FFFFFF',
          onClick=function() end,
          { FrameLayout,
            layout_width="fill",
            layout_marginTop='5dp',layout_marginLeft='5dp',layout_marginRight='5dp',
            layout_gravity="top",
            background='#00FFFFFF',
            { TextView,
              text="Text",
              textSize="22dp",
              id="select_card_title",
            },
            { AppCompatImageView,
              layout_width="24dp",
              layout_height="24dp",layout_margin='3dp',
              layout_gravity="right",
              colorFilter=primaryc,
              src="res/info.png",
              onClick=function() showInfoDialog(showInfo) end,
            },
          },
          { TextView,
            text="Text",
            textSize="13dp",
            layout_margin='8dp',layout_marginTop='0dp',
            layout_gravity="top",
            id="select_card_text",
          },

        },
      },

    },
    {
      LinearLayoutCompat,
      orientation="vertical",
      layout_width="fill",
      layout_height="fill",
      layoutTransition=LayoutTransition().enableTransitionType(LayoutTransition.CHANGING),
    },
  }






activity.setContentView(loadlayout(layout))






fab.setImageDrawable(getFileDrawable("sunny"))
fab.onClick=function()

  bsb_.show()

end


--[[
mainLayTab.setOnTabSelectedListener{
  onTabSelected=function(tab)
    local id=tab.getId()
    if id==-1
      geoList_ReFrfresh()
    end
  end
}
--]]




item2={
  LinearLayout,
  Orientation=0,
  paddingTop="16dp",
  layout_width="fill",
  layout_height="wrap",
  {MaterialCardView,
    strokeColor=0,
    strokeWidth=0,
    layout_marginLeft="16dp",
    h="fill",w="5dp",radius="16dp",id="cd",
    CardBackgroundColor=cc.c.primary,
  },
  {LinearLayout,
    layout_marginLeft="10dp",
    layout_marginRight="16dp",
    Orientation=1,
    {TextView,
      textSize="19sp",
      textColor=cc.c.primary,
      id="name",
    },
    {TextView,
      id="context",layout_marginTop="5dp",
      textSize="14sp",
    },
  },
  {
    Space,
    layout_weight="1",
  },
  {MaterialCardView,
    strokeWidth=0,CardBackgroundColor=0,radius="20dp",
    layout_width="30dp",layout_gravity="center|right",
    layout_height="30dp",layout_margin='13dp',
    onClick=function() end,id="btnnn",
    { AppCompatImageView,
      layout_width="26dp",
      layout_height="26dp",
      colorFilter=primaryc,
      src="res/settings.png",
      layout_gravity="center",
    },
  },

}


geoList_ReFrfresh=function()
  --[[
  local adp2=LuaCustRecyclerAdapter(AdapterCreator({
    getItemCount=function()
      return #gmt.step
    end,
    onCreateViewHolder=function(parent,viewType)
      local views={}
      holder1=LuaCustRecyclerHolder(loadlayout(item2,views))
      holder1.view.setTag(views)
      return holder1
    end,
    onBindViewHolder=function(holder,position)
      view=holder.view.getTag()
      local name=gmt.step[position+1]
      local gmt_item=gmt[name]
      view.name.text=name
      view.context.text=gmt:translateToChinese_WithNoName(name)
      view.cd.setCardBackgroundColor(graph.color[gmt_item.g.color][1])
      view.btnnn.onClick=function()
        showInfoDialog(name)
      end
    end,
  }))
  rec2.setAdapter(adp2)
  rec2.setLayoutManager(LinearLayoutManager(this))
  --]]
end




