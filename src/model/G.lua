--#G
local G
G={
  __call=function(_,viewId)
    return G.new(viewId)
  end,
  __index = {
    new=function(view)
      local g={
        view=view,
        h=0,
        w=0,
        lam=250,
        o=Vector(),

        canvas=nil,
        paint={},
        context=nil,
        coordinateAxis=true,
        autoDrawData=true,
        canMove=true,
        color={background=0xFFffffff},
        data={},


        onDraw=function(_) end,
        onTouch=function(_, _) end,
        onTouch_ACTION_DOWN=function() end,
        onTouch_ACTION_MOVE=function() end,
        onTouch_ACTION_UP=function() end,



        --
        pointerCount=0,
        tps={},
        tps_={},
        tpl=0,
        tpl_=0,
        o_=Vector(),
        lam_=250





      }
      return setmetatable(g, G)
    end,
    init=function(g,callBack)
      callBack=callBack or function() end
      g.view.post(function()
        g.w=g.view.getWidth()
        g.h=g.view.getHeight()
        g.o=Vector(g.w/2,g.h/2)

        callBack()

        g.paint.a=Paint().setColor(0xff000000)
        .setStyle(Paint.Style.STROKE)
        .setStrokeWidth(8)
        .setAntiAlias(true)
        .setStrokeCap(Paint.Cap.ROUND)
        .setTextAlign(Paint.Align.LEFT)
        .setTextSize(50)


        g.view.setBackground(LuaDrawable(function(canvas, paint, context)
          g.canvas=canvas
          g.context=context
          --onDraw

          if g.coordinateAxis then
            canvas.drawColor(g.color.background)
            g:drawPoint(Vector())
            g:drawPoint(Vector(1))
            g:drawPoint(Vector(0,1))
            g.canvas.drawLine(-g.o.x+g.o.x,0+g.o.y,(g.w-g.o.x)+g.o.x,0+g.o.y, paint)
            g.canvas.drawLine(0+g.o.x,-g.o.y+g.o.y,0+g.o.x,(g.h-g.o.y)+g.o.y, paint)
          end

          if g.autoDrawData
            for a, item in pairs(g.data) do
              local class=getmetatable(item)
              if class == Conic0 then
                g.drawConic0(canvas,item,item.paint or paint)
               elseif class == Vector then
                g:drawPoint(item, item.paint or g.paint.a)
                g:drawText(tostring(a),item+Vector(1,1)*(3/g.lam),item.paint or g.paint.a)
               elseif class == Line then
                g:drawLine( item, item.paint or g.paint.a)
               elseif class == Curve then
                g.drawCurve(canvas, item, item.paint or paint)
               elseif class == Triangle then
                g.drawTriangle(canvas, item, item.paint or paint)
               elseif class == Particle then
                g.drawParticle(canvas, item, item.paint or paint)
               elseif class == Polygon then
                g.drawPolygon(canvas, item, item.paint or paint)
               elseif class == Circle then
                g:drawCircle( item, item.paint or g.paint.a)
               elseif class==nil
                local tp=type(item)
                if tp=="function"
                  g.drawFunction(canvas,item,paint)
                end
              end
            end
          end
          g.onDraw(g)
          context.invalidateSelf()
        end))

        g.view.onTouch =function(v, event)
          g.onTouch(v, event)
          g.pointerCount = event.getPointerCount()
          for i = 1, g.pointerCount do
            if g.pointerCount==1
              local p=Vector(event.getX(i-1),event.getY(i-1))
              g.tps[1]=p
              g.tps[2]=false
             else
              g.tps[i]=Vector(event.getX(i-1),event.getY(i-1))
            end
          end
          if g.canMove then
            if(event.getActionMasked() == MotionEvent.ACTION_DOWN)
              g.o_=g.o
              g.tps_[1]=Vector(event.getX(1-1),event.getY(1-1))
              local gtp=g:toCP(g.tps_[1])
              g.onTouch_ACTION_DOWN(event,g)
             elseif(event.getActionMasked() == MotionEvent.ACTION_POINTER_DOWN && g.pointerCount <= 2)
              g.tps_[2]=Vector(event.getX(2-1),event.getY(2-1))
              g.tpl_ = #(g.tps[1] - g.tps[2])
              g.lam_ = g.lam
             elseif(event.getActionMasked() == MotionEvent.ACTION_MOVE)
              local dtp= g.tps[1]-g.tps_[1]
              g.o = g.o_ + dtp*0.8
              if(g.pointerCount >= 2)
                g.tpl = #(g.tps[1] - g.tps[2])
                local dtpl = g.tpl - g.tpl_
                g.lam=g.lam_*(dtpl/g.tpl_+1)
               else
                g.onTouch_ACTION_MOVE(event,g)
              end
             elseif(event.getActionMasked() == MotionEvent.ACTION_POINTER_UP)
              g.o_=g.o
              g.tps_[1]=Vector(event.getX(1-1),event.getY(1-1))
             elseif(event.getActionMasked() == MotionEvent.ACTION_UP)
              g.o_=g.o
              g.tps_[1]=Vector(event.getX(1-1),event.getY(1-1))
              g.onTouch_ACTION_UP(event,g)
            end
            return true
          end
        end
        return g
      end)

    end,

    --辅助方法🐤🐤🐤🐤🐤🐤🐤🐤🐤🐤🐤🐤🐤🐤
    reset=function(g)--将视图缩放和位置复位
      g.lam=250
      g.o=Vector(g.w/2,g.h/2)
    end,
    toSP=function(g,v)--由坐标系坐标转为屏幕坐标
      return Vector(v.x*g.lam+g.o.x, v.y*(-g.lam)+g.o.y)
    end,
    toCP=function(g,v)--由屏幕坐标转为坐标系坐标
      return Vector((v.x-g.o.x)/g.lam,-(v.y-g.o.y)/g.lam)
    end,
    makePaint=function(graph,g)
      return Paint().setColor(graph.gmkStyle.color[g.color][1]).setStyle(Paint.Style[g.style]).setStrokeWidth(g.width).setAntiAlias(true).setStrokeCap(Paint.Cap.ROUND)
    end,
    makePaint_2=function(graph,g)
      return Paint().setColor(graph.gmkStyle.color[g.color][2]).setStyle(Paint.Style[g.style]).setStrokeWidth(g.width*2.9).setAntiAlias(true).setStrokeCap(Paint.Cap.ROUND)
    end,

    --设置方法😈😈😈😈😈😈😈😈😈😈😈
    setStyle=function(g,st)--设置风格
      g.style=st
    end,
    setData=function(g,data)--设置待绘制数据
      g.data=data
    end,

    --获得方法🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢
    getTCP=function(g)--获得触摸点在坐标系中的坐标
      return g:toCP(g.tps_[1])
    end,
    getTSP=function(g)--获得触摸点的屏幕坐标
      return g.tps_[1]
    end,

    --绘制方法😎😎😎😎😎😎😎😎😎😎
    drawPoint=function(g,v,p_)
      g.canvas.drawCircle(v.x*g.lam+g.o.x, v.y*(-g.lam)+g.o.y, 6, p_ or g.paint.a)
    end,
    drawText=function(g,str,p,p_)
      g.canvas.drawText(str,p.x*g.lam+g.o.x, p.y*(-g.lam)+g.o.y,p_)
    end,
    drawCircle=function(g,c,p_)
      local p=g:toSP(c.p)
      g.canvas.drawCircle(p.x,p.y,c.r*g.lam,p_)
    end,
    drawLine=function(g,l,p_)
      local a=1145.14
      g.canvas.drawLine(
      (l.p.x-a*l.v.x)*g.lam+g.o.x, -(l.p.y-a*l.v.y)*g.lam+g.o.y,
      (l.p.x+a*l.v.x)*g.lam+g.o.x, -(l.p.y+a*l.v.y)*g.lam+g.o.y, p_)
    end,
    drawSegment=function(g,p0,p1,p_)
      g.canvas.drawLine(
      p0.x*g.lam+g.o.x,
      -p0.y*g.lam+g.o.y,
      (p1.x)*g.lam+g.o.x,
      -(p1.y)*g.lam+g.o.y, p_)
    end,
    drawRect=function(g,p1,p2,p_)
      g.canvas.drawRect(p1.x*g.lam+g.o.x, p1.y*(-g.lam)+g.o.y,
      p2.x*g.lam+g.o.x, p2.y*(-g.lam)+g.o.y, p_)
    end,
    drawParticle=function(g,particle,p_)
      g.canvas.drawCircle(particle.p.x*g.lam+g.o.x, particle.p.y*(-g.lam)+g.o.y, 8, p_)
    end,
    drawFunction=function(g,f,p_)
      local p0=g:toSP(Vector(-g.o.x/g.lam,f(-g.o.x/g.lam)))
      local p1
      local dx=0.2*(1/g.lam)
      local path = Path()
      path.moveTo(p0.x,p0.y)
      if dx<=0.2 then dx=0.2 end
      for t=-g.o.x/g.lam,(g.w-g.o.x)/g.lam+dx,dx do
        p1=g:toSP(Vector(t,f(t)))
        path.lineTo(p1.x,p1.y)
      end
      g.canvas.drawPath(path,p_)
    end,
    drawModel=function(g,md,p_)
      local path = Path()
      local from_p=md:getItemP(1)
      local from_p_s=g:toSP(from_p)
      path.moveTo(from_p_s.x,from_p_s.y)
      for i=2,#md.data do
        local to_p_s=g:toSP(md:getItemP(i))
        path.lineTo(to_p_s.x,to_p_s.y)
      end
      g.canvas.drawPath(path,p_)
    end,








  }
}
setmetatable(G, G)

return G
