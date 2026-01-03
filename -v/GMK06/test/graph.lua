
--[[


--]]

require "import"
import "android.os.*"
import "android.app.*"
import "android.view.*"
import "android.widget.*"
import "android.graphics.*"
import "android.animation.*"
import "com.bumptech.glide.Glide"
import "com.google.android.material.dialog.MaterialAlertDialogBuilder"

--导入nature库，手册没有(
import "model.MathForest.main"

import "model.paint"


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


graph={
  tps={},
  w=w,
  h=h,
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
  MATH_GRAPH=true,



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

  { TextView,
    text="Duo提供技术支持",
    --textColor=0xFFF6F1ED,
    textSize="12dp",
    layout_gravity="bottom",
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
    layout_gravity="top|left";
    id="btn1";

  },

  { Button;
    layout_width="220px";
    layout_height="130px";
    layout_gravity="top|right";
    id="btn2";
    text="";
  },

  {
    Slider,--滑动条
    layout_marginBottom="50dp",
    layout_gravity="bottom",
    id="var_a",
    ValueFrom=-5,
    Value=0,
    ValueTo=5,
    alpha=0.9,
  },


  {MaterialCardView,
    layout_height="150dp",
    layout_width="220dp",
    radius="3dp",cardElevation=0,
    layout_margin='5dp',strokeColor=0xFFB2B2B2,
    strokeWidth=1.5,cardBackgroundColor=0xFFFFFFff,
    layout_gravity="top|center",
    id="select_card",
    { LinearLayout,
      orientation='vertical',
      layout_width='fill',
      layout_height='fill',
      background='#00FFFFFF',
      {MaterialCardView,
        layout_height="30dp",
        layout_width="220dp",
        radius="0dp",cardElevation=0,
        layout_margin='0dp',
        strokeWidth=0,cardBackgroundColor=0xFFD2E9FF,
        layout_gravity="top|center",
        { TextView,
          text="Duo提供技术支持",
          --textColor=0xFFF6F1ED,
          textSize="16dp",layout_margin='2dp',
          layout_gravity="bottom",
          id="select_card_title",
        },
      },
      {MaterialCardView,
        layout_height="1.5dp",
        layout_width="fill",
        radius="6dp",cardElevation=0,
        layout_margin='0dp',
        strokeWidth=0,cardBackgroundColor=0xFF999999,
        layout_gravity="top|center",
      },
      {MaterialCardView,
        layout_height="fill",
        layout_width="fill",
        radius="6dp",cardElevation=0,
        layout_margin='0dp',
        strokeWidth=0,cardBackgroundColor=0xFFFFFFFF,
        layout_gravity="top|center",
        { TextView,
          text="Duo提供技术支持",
          --textColor=0xFFF6F1ED,
          textSize="12dp",layout_margin='2dp',
          layout_gravity="top",
          id="select_card_txt",
        },
      },

    },
  }

}
activity.setContentView(loadlayout(layout))

select_card_dimiss=function(a)
  if a then
    select_card.alpha=0
   else
    select_card.alpha=1
  end
end
select_card_dimiss(true)


graph.reset=function()
  graph.lam=250
  graph.o=Vector(w/2,h/2)
end

graph.toSP=function(v)
  return Vector(v.x*graph.lam+graph.o.x,
  v.y*(-graph.lam)+graph.o.y)
end

graph.toCP=function(v)
  return Vector((v.x-graph.o.x)/graph.lam,-(v.y-graph.o.y)/graph.lam)
end

graph.drawPoint=function(canvas,v,p_)
  local p_=p_ or paint
  canvas.drawCircle(v.x*graph.lam+graph.o.x, v.y*(-graph.lam)+graph.o.y, 8, p_)
end

graph.drawParticle=function(canvas,particle,p_)
  local p_=p_ or paint
  canvas.drawCircle(particle.p.x*graph.lam+graph.o.x, particle.p.y*(-graph.lam)+graph.o.y, 8, p_)
end


canvas__=Canvas

graph.drawRect=function(canvas,p1,p2,p_)
  local p_=p_ or paint
  canvas.drawRect(p1.x*graph.lam+graph.o.x, p1.y*(-graph.lam)+graph.o.y,
  p2.x*graph.lam+graph.o.x, p2.y*(-graph.lam)+graph.o.y,
  p_)
end

graph.drawText=function(canvas,str,p,p_)
  local p_=p_ or paint
  canvas.drawText(str,p.x*graph.lam+graph.o.x, p.y*(-graph.lam)+graph.o.y,p_)
end


graph.drawSegment=function(canvas,p0,p1,p_)
  local p_=p_ or paint
  canvas.drawLine(
  p0.x*graph.lam+o.x,
  -p0.y*graph.lam+o.y,
  (p1.x)*graph.lam+o.x,
  -(p1.y)*graph.lam+o.y, p_)
end


graph.drawLine=function(canvas,l,p_)
  local p_=p_ or paint
  local a=(graph.size/graph.lam)
  canvas.drawLine(
  (l.p.x-a*l.v.x)*graph.lam+o.x,
  -(l.p.y-a*l.v.y)*graph.lam+o.y,
  (l.p.x+a*l.v.x)*graph.lam+o.x,
  -(l.p.y+a*l.v.y)*graph.lam+o.y, p_)
end

graph.drawConic0=function(canvas,c,p_)
  local p_=p_ or paint
  local p0=graph.toSP(c:indexPoint(0))
  local p1
  local dx=0.15*(1/graph.lam)
  local path = Path()
  path.moveTo(p0.x,p0.y)
  if dx<=0.05 then dx=0.05 end
  for theta=0,2*pi+dx,dx do
    p1=graph.toSP(c:indexPoint(theta))
    path.lineTo(p1.x,p1.y)
  end
  canvas.drawPath(path,p_)
end

graph.drawCircle=function(canvas,c,p_)
  local p=graph.toSP(c.p)
  canvas.drawCircle(p.x,p.y,c.r*graph.lam,p_)
  --canvas.drawPath(path,p_)
end

graph.drawCircle_=function(canvas,p,r,p_)
  local p=graph.toSP(p)
  canvas.drawCircle(p.x,p.y,r*graph.lam,p_)
  --canvas.drawPath(path,p_)
end

graph.drawTriangle=function(canvas,t,p_)
  local p_=p_ or paint
  local path = Path()
  local pa=graph.toSP(t.a)
  path.moveTo(pa.x,pa.y)
  local pb=graph.toSP(t.b)
  path.lineTo(pb.x,pb.y)
  local pc=graph.toSP(t.c)
  path.lineTo(pc.x,pc.y)
  path.close()
  canvas.drawPath(path,p_)
end


graph.drawCurve=function(canvas,c,p_)
  local p_=p_ or paint
  local p0=graph.toSP(c:indexPoint(c.range[1]))
  local p1
  local dx=0.15*(1/graph.lam)
  local path = Path()
  path.moveTo(p0.x,p0.y)
  if dx<=0.05 then dx=0.05 end
  for t=c.range[1],c.range[2]+dx,dx do
    p1=graph.toSP(c:indexPoint(t))
    path.lineTo(p1.x,p1.y)
  end
  canvas.drawPath(path,p_)
end


graph.drawPolygon=function(canvas, polygon, p_)
  local path = Path()
  local p0=graph.toSP(polygon.ps[1])
  local p1
  path.moveTo(p0.x,p0.y)
  for i=2,#polygon.ps do
    p1=graph.toSP(polygon.ps[i])
    path.lineTo(p1.x,p1.y)
  end
  p1=graph.toSP(polygon.ps[1])
  path.lineTo(p1.x,p1.y)
  canvas.drawPath(path,p_)
  --canvas.drawPath(path,Paint().setColor(p_.getColor()).setStrokeWidth(5).setStyle(Paint.Style.FILL))
end



graph.drawFunction=function(canvas,f,p)
  local p_=p_ or paint
  local p0=graph.toSP(Vector(-graph.o.x/graph.lam,f(-graph.o.x/graph.lam)))
  local p1
  local dx=0.1*(1/graph.lam)
  local path = Path()
  path.moveTo(p0.x,p0.y)
  if dx<=0.1 then dx=0.1 end
  for t=-graph.o.x/graph.lam,(graph.w-graph.o.x)/graph.lam+dx,dx do
    p1=graph.toSP(Vector(t,f(t)))
    path.lineTo(p1.x,p1.y)
  end
  canvas.drawPath(path,p_)
end




graph.setData=function(data)
  graph.data=data
end


graph.data={}

graph.onDraw=function() end
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
          
          if graph.MATH_GRAPH then
            graph.drawPoint(canvas,Vector())
            graph.drawPoint(canvas,Vector(1))
            graph.drawPoint(canvas,Vector(0,1))
            canvas.drawLine(-o.x+o.x,0+o.y,(w-o.x)+o.x,0+o.y, paint坐标轴)
            canvas.drawLine(0+o.x,-o.y+o.y,0+o.x,(h-o.y)+o.y, paint坐标轴)
          end

          graph.onDraw(canvas,graph)

          for a, item in pairs(graph.data) do
            local class=getmetatable(item)
            if class == Conic0 then
              graph.drawConic0(canvas,item,item.paint or paint_Black)
             elseif class == Vector then
              graph.drawPoint(canvas, item, item.paint or paint_Blue)
              graph.drawText(canvas,tostring(a),item+Vector(1,1)*(3/graph.lam),item.paint or paintText)
             elseif class == Line then
              graph.drawLine(canvas, item, item.paint or paint_Green)
             elseif class == Curve then
              graph.drawCurve(canvas, item, item.paint or paint_Red)
             elseif class == Triangle then
              graph.drawTriangle(canvas, item, item.paint or paint_Red)
             elseif class == Particle then
              graph.drawParticle(canvas, item, item.paint or paint_Blue)
             elseif class == Polygon then
              graph.drawPolygon(canvas, item, item.paint or paint_Blue)
             elseif class == Circle then
              graph.drawCircle(canvas, item, item.paint or paint_Blue)
             elseif class==nil
              local tp=type(item)
              if tp=="function"
                graph.drawFunction(canvas,item,paint_Blue)
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


Env.t=0
Env.dt=0.02
timer_=Ticker()
timer_.Period=Env.dt*1000
timer_.onTick=function()
  Env.t=Env.t+Env.dt
  main()
end
--timer_.start()



--退出程序后回收Ticker
function onDestroy()
  timer_.stop()

end



--处理触摸事件
surface.onTouch =function(v, event)
  graph.onTouch(v, event)

  --获取有多少个手指碰到屏幕
  local PointerCount = event.getPointerCount()

  graph.tpn=PointerCount

  --print_(event.getActionMasked())



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
    local gtp=Vector((graph.tps_0[1].x-graph.o.x)/graph.lam,-(graph.tps_0[1].y-graph.o.y)/graph.lam)
    --print_(dump(gtp))



    graph.onTouch_ACTION_DOWN(gtp)
   elseif(event.getActionMasked() == MotionEvent.ACTION_POINTER_DOWN && PointerCount <= 2)
    --print_("次要手指碰到屏幕")
    --graph.o_0=graph.o
    graph.tps_0[2]=Vector(event.getX(2-1),event.getY(2-1))
    graph.tpl_0 = #(graph.tps[1] - graph.tps[2])
    graph.lam_0 = graph.lam
    --]]
    --手指移动
   elseif(event.getActionMasked() == MotionEvent.ACTION_MOVE)
    graph.select={}
    select_card_dimiss(true)
    --local dtp= 0.5*(graph.tps[1]+graph.tps[2]) - 0.5*(graph.tps_0[1]+graph.tps_0[2])
    local dtp= graph.tps[1]-graph.tps_0[1]

    graph.o = graph.o_0 + dtp*0.8--*Number.BooleanToNumber(not(graph.tps[2]))


    if(PointerCount >= 2)
      --print_("当有两根手指落下就计算缩放")
      --[
      graph.tpl = #(graph.tps[1] - graph.tps[2])
      local dtpl = graph.tpl - graph.tpl_0
      graph.lam=graph.lam_0*(dtpl/graph.tpl_0+1)
      --]]
    end

   elseif(event.getActionMasked() == MotionEvent.ACTION_POINTER_UP)
    --print_("次要手指离开")


    graph.o_0=graph.o

    graph.tps_0[1]=Vector(event.getX(1-1),event.getY(1-1))



   elseif(event.getActionMasked() == MotionEvent.ACTION_UP)
    -- print_("手指离开")




  end


  return true
end


return graph
