require "util"
import "class"
import "MaterialChip"

import "n.nature"
import "paint"
import "geo.gmt"


local Slider = luajava.bindClass "com.google.android.material.slider.Slider"
local MaterialCardView = luajava.bindClass "com.google.android.material.card.MaterialCardView"

--获取设备屏幕宽高
h=activity.getHeight()
w=activity.getWidth()

--初始化随机数种子
math.randomseed(os.time())

--重写print
print_=function(...)
  txt.setText(txt.text.."\n"..(...))
end


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

import "android.graphics.Typeface"
code_typeface=Typeface.createFromFile(activity.getLuaDir().."/res/code.ttf") --设置字体路径，page/main



graph={
  tps={},
  tps_0={},
  dtps=Vector(),
  o=Vector(w/2,h/2),
  o_0=Vector(w/2,h/2),--
  size=#Vector(w/2,h/2),--屏幕大小
  tpl_0=0,
  tpl=0,
  lam=150,
  lam_0=150,
  tpn=0,
  debugMode=false,
  select={},--被选择的几何对象,内部保存对象的标签
  backgroundColor=0xFFffffff,

}

--Animation
local animation = ValueAnimator.ofFloat({ 0, 5*math.pi }).setDuration(3000).setRepeatCount(-1).setRepeatMode(2).start()

function showDialog(标题,内容,Todo)
  local dialog=MaterialAlertDialogBuilder(activity)
  .setTitle(标题)
  .setMessage(内容)
  .setPositiveButton("确定",{onClick=function() Todo() end})
  .show()
end

--布局表
local layout =
{ FrameLayout,
  layout_width = 'fill',
  layout_height = 'fill',

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
    onClick=function()
    end,
    {--悬浮按钮
      FloatingActionButton;
      id="fab";
      layout_gravity="bottom|center";
      layout_marginBottom='10dp',
    };
  },
  { TextView,
    text="Duo提供技术支持",
    --textColor=0xFFF6F1ED,
    textSize="12dp",
    layout_gravity="bottom|right",
    id="txt",
  },
  { Button;
    layout_gravity="bottom|right";
    text="reset";
    onClick=function()
      graph.reset()
    end,
  },
  { Button;
    layout_width="220px";
    layout_height="130px";
    layout_gravity="top|right";
    id="btn2";
    text="";
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

  {MaterialCardView,
    layout_width="220dp",
    radius="3dp",cardElevation=10,
    strokeWidth=0,
    layout_margin='5dp',
    cardBackgroundColor=0xFFFFFFff,
    layout_gravity="top|center",
    id="select_card",
    { LinearLayout,
      orientation='1',
      layout_width="220dp",
      background='#00FFFFFF',
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
        },
      },
      { TextView,
        text="Text",
        textSize="13dp",
        layout_margin='5dp',layout_marginTop='-3dp',
        layout_gravity="top",
        id="select_card_text",
      },

    },
  },



}
activity.setContentView(loadlayout(layout))



fab.setImageDrawable(getFileDrawable("add"))

toolList={
  Move="Move",
  Point="Point",
  Line="Line",
  Circle="Circle",
}
tool=toolList.Move

toolTabList={
  toolTab.newTab().setIcon(getFileDrawable("sunny")).setId(1),
  toolTab.newTab().setIcon(getFileDrawable("dot")).setId(2),
  toolTab.newTab().setIcon(getFileDrawable("remove")).setId(3),
  toolTab.newTab().setIcon(getFileDrawable("circle")).setId(4),

}

for a, item in pairs(toolTabList) do
  toolTab.addTab(item)
end

toolTab.setOnTabSelectedListener{
  onTabSelected=function(tab)
    local id=tab.getId()
    if id==1
      tool=toolList.Move
     elseif id==2
      tool=toolList.Point
     elseif id==3
      tool=toolList.Line
     elseif id==4
      tool=toolList.Circle
    end
  end
}

selectWhat={
  --"A"
}
selectN=1
function selectGeo(name)
  selectWhat[name]=selectN
  selectN=selectN+1
end
function cleanSelect()
  selectWhat={}
  selectN=1
end
showInfo=false--"A"




toolInfo={
  pointN=1,
  movePointName="",
  newLineData={

  },
  M={
    DOWN={
      To="",--"A",
      HasMove=false,
    }
  }



}

newPname=function()
  local n="P"..toolInfo.pointN
  toolInfo.pointN=toolInfo.pointN+1
  return n
end

import "geo.graphLib"

data={}
gmt=GMT.new()

import "geo.test"



onDraw=function() end
graph.onTouch=function() end
graph.onTouch_ACTION_DOWN=function() end

local holder = surface.getHolder()
holder.addCallback(SurfaceHolder.Callback {
  surfaceChanged = function(holder, format, width, height)
  end,
  surfaceCreated = function(holder)
    animation.addUpdateListener(ValueAnimator.AnimatorUpdateListener {
      onAnimationUpdate = function(animate)
        local k = animate.getAnimatedValue()
        local canvas = holder.lockHardwareCanvas()
        if canvas ~= nil then
          --设置背景颜色
          canvas.drawColor(graph.backgroundColor)
          o=graph.o
          Lambda=graph.lam

          --[[
          graph.drawPoint(canvas,Vector())
          graph.drawPoint(canvas,Vector(1))
          graph.drawPoint(canvas,Vector(0,1))
          canvas.drawLine(-o.x+o.x,0+o.y,(w-o.x)+o.x,0+o.y, paint坐标轴)
          canvas.drawLine(0+o.x,-o.y+o.y,0+o.x,(h-o.y)+o.y, paint坐标轴)
--]]
          onDraw(canvas,graph)
          gmt:run(data)

          if showInfo select_card.alpha=1 else select_card.alpha=0 end


          for a, item in pairs(data) do
            local class=getmetatable(item)
            if class == Line then
              local g=gmt[a].g
              graph.drawLine(canvas, item, graph.makePaint(g))

             elseif class == Circle then
              local g=gmt[a].g
              graph.drawCircle(canvas, item, graph.makePaint(g))

             elseif class == Vector then
              local g=gmt[a].g
              if selectWhat[a]
                graph.drawCircle_(canvas,item,(28/graph.lam),graph.makePaint_2(g))
              end
              graph.drawPoint(canvas, item, graph.makePaint(g))
              graph.drawText(canvas,tostring(a),item+Vector(1,1)*(10/graph.lam),paintText)
              if showInfo==a
                local sp=graph.toSP(item)--该对象在屏幕上的位置
                select_card.x=sp.x
                select_card.y=sp.y
                select_card_title.text=gmt[a].class.." "..a
                select_card_text.text=gmt[a].class.."."..gmt[a].method..": "..dump(gmt[a].factor)
              end




            end

          end



        end
        holder.unlockCanvasAndPost(canvas)
      end
    })
  end,
  surfaceDestroyed = function(holder)
    animation.removeAllUpdateListeners()
    animation.cancel()
  end
})



--
--处理触摸事件
surface.onTouch =function(v, event)
  graph.onTouch(v, event)
  local PointerCount = event.getPointerCount()
  graph.tpn=PointerCount
  --为每个手指记录触摸坐标
  for i = 1, PointerCount do
    if PointerCount==2
      graph.tps[i]=Vector(event.getX(i-1),event.getY(i-1))
     elseif PointerCount==1
      local p=Vector(event.getX(i-1),event.getY(i-1))
      graph.tps[1]=p
      graph.tps[2]=false
    end
  end
  if graph.debugMode print_(""..type(graph.tps[1])) end
  --手指碰到屏幕
  if(event.getActionMasked() == MotionEvent.ACTION_DOWN)
    if graph.debugMode print_("手指碰到屏幕") end
    graph.o_0=graph.o
    graph.tps_0[1]=Vector(event.getX(1-1),event.getY(1-1))
    --触摸点在坐标系中的坐标
    local gtp=Vector((graph.tps[1].x-graph.o.x)/graph.lam,-(graph.tps[1].y-graph.o.y)/graph.lam)

    if tool==toolList.Move
      cleanSelect()
      showInfo=false
      toolInfo.M.DOWN.HasMove=false
      for a, item in pairs(data) do
        local class=getmetatable(item)
        if class==Vector
          local dx=gtp-item
          if (#dx)*graph.lam<80 then
            toolInfo.M.DOWN.To=a
           else
          end
        end
      end


     elseif tool==toolList.Point
      gmt:addPoint(newPname(),gtp)

     elseif tool==toolList.Line


    end

    graph.onTouch_ACTION_DOWN(gtp)
   elseif(event.getActionMasked() == MotionEvent.ACTION_POINTER_DOWN && PointerCount <= 2)
    --print_("次要手指碰到屏幕")
    graph.tps_0[2]=Vector(event.getX(2-1),event.getY(2-1))
    graph.tpl_0 = #(graph.tps[1] - graph.tps[2])
    graph.lam_0 = graph.lam
    --手指移动
   elseif(event.getActionMasked() == MotionEvent.ACTION_MOVE)
    --触摸点在坐标系中的坐标
    local gtp=Vector((graph.tps[1].x-graph.o.x)/graph.lam,-(graph.tps[1].y-graph.o.y)/graph.lam)

    showInfo=false
    if tool==toolList.Move
      toolInfo.M.DOWN.HasMove=true
      local item=data[toolInfo.M.DOWN.To]
      if item
        local class=getmetatable(item)
        if class==Vector
          gmt:alterFactor(toolInfo.M.DOWN.To,{gtp})
        end
       else--下方是实现滑动的💩山
        local dtp= graph.tps[1]-graph.tps_0[1]
        graph.o = graph.o_0 + dtp*0.75--滑动灵敏度🍎
        if(PointerCount >= 2)
          graph.tpl = #(graph.tps[1] - graph.tps[2])
          local dtpl = graph.tpl - graph.tpl_0
          graph.lam=graph.lam_0*(dtpl/graph.tpl_0+1)
        end
      end



     elseif tool==toolList.Line




    end

   elseif(event.getActionMasked() == MotionEvent.ACTION_POINTER_UP)
    graph.o_0=graph.o
    graph.tps_0[1]=Vector(event.getX(1-1),event.getY(1-1))

   elseif(event.getActionMasked() == MotionEvent.ACTION_UP)
    if tool==toolList.Move and toolInfo.M.DOWN.To
      if not(toolInfo.M.DOWN.HasMove)
        showInfo=toolInfo.M.DOWN.To
      end
      selectGeo(toolInfo.M.DOWN.To)
    end
    toolInfo.M.DOWN.To=nil




  end
  return true
end



function onFastClick()

end





