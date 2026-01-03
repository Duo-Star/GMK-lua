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
        paint=nil,
        context=nil,
        classic=true,
        color={background=0xFFffffff},


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
    init=function(g,_)
      g.view.post(function()
        g.w=g.view.getWidth()
        g.h=g.view.getHeight()
        g.o=Vector(g.w/2,g.h/2)
      end)
      g.view.setBackground(LuaDrawable(function(canvas, paint, context)
        g.canvas=canvas
        g.paint=paint
        g.context=context
        --onDraw
        g.onDraw(g)
        if g.classic then
          canvas.drawColor(g.color.background)
          g:drawPoint(Vector())
          g:drawPoint(Vector(1))
          g:drawPoint(Vector(0,1))
          g.canvas.drawLine(-g.o.x+g.o.x,0+g.o.y,(g.w-g.o.x)+g.o.x,0+g.o.y, paint)
          g.canvas.drawLine(0+g.o.x,-g.o.y+g.o.y,0+g.o.x,(g.h-g.o.y)+g.o.y, paint)
        end


        context.invalidateSelf()
      end))

      g.view.onTouch =function(v, event)
        g.onTouch(v, event)
        g.pointerCount = event.getPointerCount()
        for i = 1, g.pointerCount do
          if g.pointerCount==2
            g.tps[i]=Vector(event.getX(i-1),event.getY(i-1))
           elseif g.pointerCount==1
            local p=Vector(event.getX(i-1),event.getY(i-1))
            g.tps[1]=p
            g.tps[2]=false
          end
        end
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
    end,
    reset=function(g)
      g.lam=250
      g.o=Vector(g.w/2,g.h/2)
    end,
    toSP=function(g,v)
      return Vector(v.x*g.lam+g.o.x, v.y*(-g.lam)+g.o.y)
    end,
    toCP=function(g,v)
      return Vector((v.x-g.o.x)/g.lam,-(v.y-g.o.y)/g.lam)
    end,
    drawPoint=function(g,v,p_):
      g.canvas.drawCircle(v.x*g.lam+g.o.x, v.y*(-g.lam)+g.o.y, 8, p_ or g.paint)
    end





  }
}
setmetatable(G, G)

return G
