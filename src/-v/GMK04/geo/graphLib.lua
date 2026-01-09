--获取设备屏幕宽高
h=activity.getHeight()
w=activity.getWidth()


graph={
  tps={},
  tps_0={},
  dtps=Vector(),
  o=Vector(w/2,h/2),
  o_0=Vector(w/2,h/2),
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

--graph.backgroundColor=0xFF424242


graph.color={
  purple={0xFF673AB7,0x70673AB7},
  red={0xFFD32F2F,0x70D32F2F},
  blue={0xFF3F51B5,0x705C6BC0},
  teal={0xFF00796B,0x7000796B},
  cyan={0xFF00ACC1,0x7000ACC1},
  amber={0xFFFFC107,0x70FFC107},
  brown={0xFF795548,0x70795548},
  grey={0xFF757575,0x70757575}
}
graph.colorIndexList={"purple","red","blue","teal","cyan","amber","brown","grey"}


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

graph.makePaint=function(g)
  return Paint().setColor(graph.color[g.color][1]).setStyle(Paint.Style[g.style]).setStrokeWidth(g.width).setAntiAlias(true).setStrokeCap(Paint.Cap.ROUND)
end

graph.makePaint_2=function(g)
  return Paint().setColor(graph.color[g.color][2]).setStyle(Paint.Style[g.style]).setStrokeWidth(g.width*2.9).setAntiAlias(true).setStrokeCap(Paint.Cap.ROUND)
end


graph.drawPoint=function(canvas,v,p_)
  local p_=p_ or paint
  canvas.drawCircle(v.x*graph.lam+graph.o.x, v.y*(-graph.lam)+graph.o.y, 14, p_)
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
  local a=1e3
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


--print_(dump(activity.is))


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

          guide_card_progress_var_now=guide_card_progress_var_now+0.456789*(guide_card_progress_var-guide_card_progress_var_now)
          circularProgressDrawable.setStartEndTrim(0.75,0.75+guide_card_progress_var_now)

          gmt:run(data)--gmt刷新数据data
          if showInfo select_card.setVisibility(0) else select_card.setVisibility(8) end

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
                local sp=graph.toSP(item:getProjectPoint(graph.toCP(Vector(w/2,h/2))))--该对象在屏幕上的位置
                select_card.x=sp.x+20
                select_card.y=sp.y+20
                select_card_title.text=gmt[a].class.." "..a
                --select_card_text.text=gmt[a].class.."."..gmt[a].method..": "..dump(gmt[a].factor)
                select_card_text.text=gmt:translateToChinese_WithNoName(a)
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
                select_card_text.text=gmt:translateToChinese_WithNoName(a)
              end
             elseif class == Vector then--💦💦💦💦💦💦💦💦💦
              local g=gmt[a].g --print_(gmt[a].g.color)
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
                select_card_text.text=gmt:translateToChinese_WithNoName(a)
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
