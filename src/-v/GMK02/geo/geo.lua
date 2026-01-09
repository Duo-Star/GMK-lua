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
print_=function(_)
  txt.setText(txt.text.."\n"..tostring(_))
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
    text="GMK 1.0.0",textColor=primaryc,
    textSize="18dp",layout_margin="5dp",
    layout_gravity="bottom|right",
    id="txt",
  },
  { Button;
    layout_gravity="bottom|right";
    alpha=0;
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
    text="Duo";
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
          onClick=function() print_() end,
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
    cleanSelect()
    showInfo=false
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
  M={--移动工具
    DOWN={
      To="",--"A",
      HasMove=false,
      dis=1e5,
    }
  },
  L={--直线
    DOWN={
      P1="",
      P2="",

    },
    N=0,
    newName=function()
      toolInfo.L.N=toolInfo.L.N+1
      return "L"..toolInfo.L.N
    end
  },
  C={--圆周
    DOWN={
      P1="",
      P2="",

    },
    N=0,
    newName=function()
      toolInfo.C.N=toolInfo.C.N+1
      return "C"..toolInfo.C.N
    end
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
          o=graph.o Lambda=graph.lam onDraw(canvas,graph)

          gmt:run(data)--gmt刷新数据data
          if showInfo select_card.alpha=1 else select_card.alpha=0 end

          for i=#gmt.step,1,-1 do
            local a=gmt.step[i]
            local item=data[a]
            local class=getmetatable(item)
            if class == Line then--😆😆😆😆😆😆😆😆
              local g=gmt[a].g
              if selectWhat[a]
                graph.drawLine(canvas, item, graph.makePaint_2(g))
              end
              graph.drawLine(canvas, item, graph.makePaint(g))
              if showInfo==a
                local sp=graph.toSP(item:indexPoint(1))--该对象在屏幕上的位置
                select_card.x=sp.x+20
                select_card.y=sp.y+20
                select_card_title.text=gmt[a].class.." "..a
                select_card_text.text=gmt[a].class.."."..gmt[a].method..": "..dump(gmt[a].factor)
              end
             elseif class == Circle then--🍎🍎🍎🍎🍎🍎🍎🍎
              local g=gmt[a].g
              if selectWhat[a]
                graph.drawCircle(canvas, item, graph.makePaint_2(g))
              end
              graph.drawCircle(canvas, item, graph.makePaint(g))
              if showInfo==a
                local sp=graph.toSP(item:indexPoint(1))--该对象在屏幕上的位置
                select_card.x=sp.x+20
                select_card.y=sp.y+20
                select_card_title.text=gmt[a].class.." "..a
                select_card_text.text=gmt[a].class.."."..gmt[a].method..": "..dump(gmt[a].factor)
              end
             elseif class == Vector then--💦💦💦💦💦💦💦💦💦
              local g=gmt[a].g
              if selectWhat[a]
                graph.drawCircle_(canvas,item,(28/graph.lam),graph.makePaint_2(g))
              end
              graph.drawPoint(canvas, item, graph.makePaint(g))
              graph.drawText(canvas,tostring(a),item+Vector(1,1)*(10/graph.lam),paintText)
              if showInfo==a
                local sp=graph.toSP(item)--该对象在屏幕上的位置
                select_card.x=sp.x+20
                select_card.y=sp.y+20
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




btn2.onClick=function()

end


--
--处理触摸事件😋
surface.onTouch =function(v, event)
  graph.onTouch(v, event)
  local PointerCount = event.getPointerCount()
  graph.tpn=PointerCount
  --为每个手指记录触摸坐标💌
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
  --手指碰到屏幕👍
  if(event.getActionMasked() == MotionEvent.ACTION_DOWN)
    if graph.debugMode print_("手指碰到屏幕") end
    graph.o_0=graph.o
    graph.tps_0[1]=Vector(event.getX(1-1),event.getY(1-1))
    --触摸点在坐标系中的坐标
    local gtp=Vector((graph.tps[1].x-graph.o.x)/graph.lam,-(graph.tps[1].y-graph.o.y)/graph.lam)
    graph.onTouch_ACTION_DOWN(gtp)--触发监听器
    if tool==toolList.Move--选择移动工具
      cleanSelect()--清除已选择的项
      showInfo=false--停止显示标签
      toolInfo.M.DOWN.HasMove=false--初始化无位移
      for i=#gmt.step,1,-1 do
        local a=gmt.step[i]
        local item=data[a]
        local class=getmetatable(item)--获得到对象的类
        if class==Vector
          local dx=(#(gtp-item))*graph.lam-3
          if dx<70 and dx<toolInfo.M.DOWN.dis
            toolInfo.M.DOWN.To=a
            toolInfo.M.DOWN.dis=dx
          end
         elseif class==Circle
          local dx=(math.abs(#(gtp-item.p)-item.r))*graph.lam+12.3
          if dx<70 and dx<toolInfo.M.DOWN.dis
            toolInfo.M.DOWN.To=a
            toolInfo.M.DOWN.dis=dx
          end
         elseif class==Line
          local dx=(item:getPdisL(gtp)*graph.lam)+12.3
          if dx<70 and dx<toolInfo.M.DOWN.dis
            toolInfo.M.DOWN.To=a
            toolInfo.M.DOWN.dis=dx
          end
        end
      end
     elseif tool==toolList.Point--选择点工具
      gmt:addPoint(newPname(),gtp)
     elseif tool==toolList.Line
      for i=#gmt.step,1,-1 do
        local a=gmt.step[i]--名称
        local item=data[a]
        local class=getmetatable(item)--获得到对象的类
        if class==Vector
          local dx=(#(gtp-item))*graph.lam-3
          if dx<70
            if toolInfo.L.DOWN.P1~=""
              toolInfo.L.DOWN.P2=a
              gmt:addLine(toolInfo.L.newName(),toolInfo.L.DOWN.P1,toolInfo.L.DOWN.P2)
              toolInfo.L.DOWN.P1=""
              toolInfo.L.DOWN.P2=""
              cleanSelect()
             else
              toolInfo.L.DOWN.P1=a
              selectGeo(a)
            end
          end
        end
      end
     elseif tool==toolList.Circle
      for i=#gmt.step,1,-1 do
        local a=gmt.step[i]--名称
        local item=data[a]
        local class=getmetatable(item)--获得到对象的类
        if class==Vector
          local dx=(#(gtp-item))*graph.lam-3
          if dx<70
            if toolInfo.C.DOWN.P1~=""
              toolInfo.C.DOWN.P2=a
              gmt:addCircle(toolInfo.C.newName(),toolInfo.C.DOWN.P1,toolInfo.C.DOWN.P2)
              toolInfo.C.DOWN.P1=""
              toolInfo.C.DOWN.P2=""
              cleanSelect()
             else
              toolInfo.C.DOWN.P1=a
              selectGeo(a)
            end
          end
        end
      end



    end


   elseif(event.getActionMasked() == MotionEvent.ACTION_POINTER_DOWN && PointerCount <= 2)
    --print_("次要手指碰到屏幕")
    graph.tps_0[2]=Vector(event.getX(2-1),event.getY(2-1))
    graph.tpl_0 = #(graph.tps[1] - graph.tps[2])
    graph.lam_0 = graph.lam

    --手指移动🖐
   elseif(event.getActionMasked() == MotionEvent.ACTION_MOVE)
    --触摸点在坐标系中的坐标
    local gtp=Vector((graph.tps[1].x-graph.o.x)/graph.lam,-(graph.tps[1].y-graph.o.y)/graph.lam)

    showInfo=false--移动中不显示标签
    if tool==toolList.Move
      toolInfo.M.DOWN.HasMove=true--他真的动了
      local item=data[toolInfo.M.DOWN.To]
      if item and gmt[toolInfo.M.DOWN.To].free
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
    toolInfo.M.DOWN.dis=1e5



  end
  return true
end







