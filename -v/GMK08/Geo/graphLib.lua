--获取设备屏幕宽高
h=activity.getHeight()
w=activity.getWidth()


graph={
  tps={},
  tps_0={},
  w=w,
  h=h,
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
  backgroundColor=0xFFffffff,
  textColor=0xFF131313,

}
graph.color={
  purple={0xFF673AB7,0x50673AB7},
  red={0xFFD32F2F,0x70D32F2F},
  blue={0xFF3F51B5,0x505C6BC0},
  teal={0xFF00796B,0x5000796B},
  cyan={0xFF00ACC1,0x7000ACC1},
  amber={0xFFFFC107,0x70FFC107},
  brown={0xFF795548,0x70795548},
  grey={0xFF757575,0x70757575}
}
graph.colorIndexList={"purple","red","blue","teal","cyan","amber","brown","grey"}



if isNightMode()
  graph.backgroundColor=0xff000000
  graph.color={
    purple={0xFFB39DDB,0x80EDE7F6},--
    red={0xFFD32F2F,0x70D32F2F},
    blue={0xFF7986CB,0x709FA8DA},--
    teal={0xFF00796B,0x7000796B},
    cyan={0xFF00ACC1,0x7000ACC1},
    amber={0xFFFFC107,0x70FFC107},
    brown={0xFF795548,0x70A1887F},--
    grey={0xFF9E9E9E,0x70BDBDBD}--
  }
  graph.textColor=0xFFEEEEEE
  paintText = Paint().setColor(graph.textColor).setAntiAlias(true).setTextAlign(Paint.Align.LEFT).setTextSize(40).setStrokeCap(Paint.Cap.ROUND).setStyle(Paint.Style.FILL).setStrokeWidth(3)
 else
  graph.backgroundColor=0xFFffffff
  paintText = Paint().setColor(graph.textColor).setAntiAlias(true).setTextAlign(Paint.Align.LEFT).setTextSize(40).setStrokeCap(Paint.Cap.ROUND).setStyle(Paint.Style.FILL).setStrokeWidth(3)

end


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


paint = Paint().setColor(0xee5E35B1).setStyle(Paint.Style.STROKE).setStrokeWidth(10).setAntiAlias(true).setStrokeCap(Paint.Cap.ROUND)


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
  local dx=0.07*(1/graph.lam)
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



graph.drawFunction=function(canvas,f,p)
  local p_=p_ or paint
  local p0=graph.toSP(Vector(-graph.o.x/graph.lam,f(-graph.o.x/graph.lam)))
  local p1
  local dx=0.2*(1/graph.lam)
  local path = Path()
  path.moveTo(p0.x,p0.y)
  if dx<=0.2 then dx=0.2 end
  for t=-graph.o.x/graph.lam,(graph.w-graph.o.x)/graph.lam+dx,dx do
    p1=graph.toSP(Vector(t,f(t)))
    path.lineTo(p1.x,p1.y)
  end
  canvas.drawPath(path,p_)
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



          --graph.drawFunction(canvas,sin,paint)


          for i=#gmt.step,1,-1 do
            local a=gmt.step[i]
            local item=data[a]
            local gmt_item=gmt[a]
            local class_=gmt_item.class
            local g=gmt_item.g


            if class_ == "Line" then--😆😆😆😆😆😆😆😆
              if g.show then
                if selectWhat[a]
                  graph.drawLine(canvas, item, graph.makePaint_2(g))
                end
                graph.drawLine(canvas, item, graph.makePaint(g))
                if g.label then
                  --graph.drawText(canvas,tostring(a),item:getProjectPoint(graph.toCP(Vector(w/2,h/2)))+item.v:roll2d_90():unit():scale(30/graph.lam),paintText)
                  graph.drawText(canvas,tostring(a),item:indexPoint(0.6)+item.v:roll2d_90():unit():scale(30/graph.lam),paintText)
                end
              end
              if showInfo==a
                local sp=graph.toSP(item:getProjectPoint(graph.toCP(Vector(w/2,h/2))))--该对象在屏幕上的位置
                select_card.x=sp.x+20
                select_card.y=sp.y+20
                select_card_title.text=gmt[a].class.." "..a
                select_card_text.text=gmt:translateToChinese_WithNoName(a)
              end
             elseif class_ == "Circle" then--🍎🍎🍎🍎🍎🍎🍎🍎
              if g.show then
                if selectWhat[a]
                  graph.drawCircle(canvas, item, graph.makePaint_2(g))
                end
                graph.drawCircle(canvas, item, graph.makePaint(g))
                if g.label then
                  graph.drawText(canvas,tostring(a),item:indexPoint(0.6),paintText)
                end
              end
              if showInfo==a then
                local sp=graph.toSP(item:getProjectPoint(graph.toCP(Vector(w/2,h/2))))--该对象在屏幕上的位置
                select_card.x=sp.x+20
                select_card.y=sp.y+20
                select_card_title.text=gmt[a].class.." "..a
                select_card_text.text=gmt:translateToChinese_WithNoName(a)
              end
             elseif class_ == "Point" then--💦💦💦💦💦💦💦💦💦
              if g.show then
                if selectWhat[a] then
                  graph.drawCircle_(canvas,item,(28/graph.lam),graph.makePaint_2(g))
                end
                graph.drawPoint(canvas, item, graph.makePaint(g))
                if g.label then
                  graph.drawText(canvas,tostring(a),item+Vector(1,1)*(10/graph.lam),paintText)
                end
              end
              if showInfo==a then
                local sp=graph.toSP(item)--该对象在屏幕上的位置
                select_card.x=sp.x+20
                select_card.y=sp.y+20
                select_card_title.text=gmt[a].class.." "..a
                select_card_text.text=gmt:translateToChinese_WithNoName(a)
              end
             elseif class_ == "Conic0" then
              if g.show then
                if selectWhat[a]
                  item:onDraw(canvas,graph,graph.makePaint_2(g))
                end
                item:onDraw(canvas,graph,graph.makePaint(g))
              end
            
              if showInfo==a
                local sp=graph.toSP(item:getProjectPoint(graph.toCP(Vector(w/2,h/2))))--该对象在屏幕上的位置
                select_card.x=sp.x+20
                select_card.y=sp.y+20
                select_card_title.text=gmt[a].class.." "..a
                select_card_text.text=gmt:translateToChinese_WithNoName(a)
              end

             elseif class_ == "Conic1" then
              item:onDraw(canvas,graph,graph.makePaint(g))

             elseif class_ == "Conic2" then
              item:onDraw(canvas,graph,graph.makePaint(g))

             elseif class_=="Function" then
              graph.drawFunction(canvas,item,graph.makePaint(g))








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
