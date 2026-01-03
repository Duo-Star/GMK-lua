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
code_typeface=Typeface.createFromFile(activity.getLuaDir().."/res/fonts/code.ttf") --设置字体路径，page/main



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
  ui.卡片颜色=0xFF2C2C2C
  ui.黑白图标底色=0xffffffff
 else
  ui.引导栏进度条颜色=0xffffffff
  ui.引导栏背景颜色=0xff000000
  ui.引导栏文字颜色=0xffffffff
  ui.卡片颜色=0xffffffff
  ui.黑白图标底色=0xff000000
end


--布局表
local layout =
{
  LinearLayout,
  layout_width="match",
  layout_height="match",
  Orientation=1,
  {
    AppBarLayout,
    layout_width="fill",
    layout_height="wrap",
    id="appbar",
    {
      MaterialToolbar,
      id="toolbar",
      layout_scrollFlags=0,
      title="GeoMKY",
      subtitle="1.0.0",
      layout_width="fill",
      layout_height="58dp",
      background=ColorDrawable(surfaceVar),
    },
  },
  { FrameLayout,
    layout_width = 'fill',
    layout_height = 'fill',
    id="geoRoot",
    { SurfaceView;
      layout_width = 'fill',
      layout_height = 'fill',
      id = "surface",
    },
    { MaterialCardView,--
      layout_width="210dp",
      radius="3dp",cardElevation=10,
      strokeWidth=0,
      layout_margin='5dp',
      cardBackgroundColor=ui.卡片颜色,
      layout_gravity="top|center",
      id="slc",visibility=(View.INVISIBLE),
      { LinearLayout,
        orientation=1,
        { TextView,
          text="a=0",
          textSize="17dp",
          textColor=ui.引导栏文字颜色,
          layout_gravity="center|left",layout_margin='5dp',
        },
        { Slider,
          id="sl",layout_gravity="center";
          layout_width="200dp",
        },
      },
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
      --visibility=(View.INVISIBLE),
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
          Typeface=jost_book_typeface,
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
            layout_marginLeft='5dp',
            textSize="22dp",
            id="select_card_title",
            Typeface=jost_book_typeface,
          },
          { AppCompatImageView,
            layout_width="24dp",
            layout_height="24dp",layout_margin='3dp',
            layout_gravity="right",
            colorFilter=primaryc,
            src="res/imgs/info.png",
            onClick=function() showInfoDialog(showInfo) end,
          },
        },
        { TextView,
          text="Text",
          textSize="13dp",
          layout_margin='8dp',
          layout_marginTop='0dp',
          layout_gravity="top",
          id="select_card_text",
          Typeface=jost_book_typeface,
        },

      },
    },


  }
}

activity.setContentView(loadlayout(layout))





toolbar.menu.setOptionalIconsVisible(true)
toolbar_ACList={
  {2,"imgs/sunny"},
  {1,translate"导出"},
  --{1,"API"},
  {1,translate"清空画布"},
  {1,translate"保存"},

}

for i=1,#toolbar_ACList do
  local item=toolbar_ACList[i]
  if item[1]==1 then
    toolbar.menu.add(i,i,i,item[2]).setShowAsAction(0)
   elseif item[1]==2 then
    toolbar.menu.add(i,i,i,item[2]).setIcon(getFileDrawable(item[2])).setShowAsAction(2).setIconTintList(ColorStateList.valueOf(ui.黑白图标底色))
  end
end

local MimeTypeMap = luajava.bindClass "android.webkit.MimeTypeMap"
local Intent = luajava.bindClass "android.content.Intent"
local Uri = luajava.bindClass "android.net.Uri"




toolbar.setOnMenuItemClickListener({
  onMenuItemClick=function(item)
    local id=item.getItemId()
    local item=toolbar_ACList[id]
    switch item[2]
     case translate"清空画布"
      cleanAll()
      print("已清🙃")

     case translate"保存"
      GMK_File.save()
      print("保存成功😘")

     case "imgs/sunny"
      
      refreshList()
      listDialog.show()
      
     case translate"导出"
      GMK_File.save("/storage/emulated/0/Download/"..GMK_File.name)
      print("已导出在Download")

    end
  end
})


fab.setImageDrawable(getFileDrawable("imgs/add"))
fab.onClick=function()
  toolbs.show()
end









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





