require "model.util"
mf=import "model.MathForest.main"
G=import "model.G"

_path="test.pixelPath"

local layout={ FrameLayout,
  layout_width = 'fill',
  layout_height = 'fill',
  id="root",
  { SurfaceView;
    layout_width = 'fill',
    layout_height = 'fill',
    id = "surface",
  },
}

activity.setContentView(loadlayout(layout))

graph=G(surface)
graph.coordinateAxis=false
graph.autoDrawData=false


function Main()
  pix={}
  pix.bgc=0xFFFFBD0E
  pix.debug=true
  pix.paints={
    text=Paint().setColor(0xFFffffff) .setTextSize(35),
    btn=Paint().setColor(0xFF212C36).setStrokeWidth(5) .setStyle(Paint.Style.FILL),
    wall=Paint().setColor(0xFF8F6101).setStrokeWidth(5) .setStyle(Paint.Style.FILL),
    me=Paint().setColor(0xFF212C36).setStrokeWidth(5) .setStyle(Paint.Style.FILL),
    debug=Paint().setColor(0xFFFF0040).setStrokeWidth(2) .setStyle(Paint.Style.FILL).setTextSize(20),

  }

  --我 类型
  pix.Me=import(_path..".Me")
  --刺 类型
  pix.Thorn=import(_path..".Thorn")
  --墙 类型
  pix.Wall=import(_path..".Wall")
  --触发点 类型
  import(_path..".Signs")

  pix.levelNumber=1

  pix.loadLevel=function(n)
    pix.level=import(_path.."/Levels/"..(n or pix.levelNumber))
    pix.level()
  end

  pix.loadLevel()

  Canvas=Canvas
  graph.onDraw=function(graph)
    graph.canvas.drawColor(pix.bgc)

    for i=1,#pix.walls do
      local item=pix.walls[i]
      item:onDraw(graph)
      if pix.debug
        graph:drawText("Wall_"..i,item.p1:mid(item.p2),pix.paints.debug)
      end
    end

    for i=1,#pix.thorns do
      local item=pix.thorns[i]
      item:onDraw(graph)
      if pix.debug
        graph:drawText("Thorn_"..i,item.model.p,pix.paints.debug)
      end
    end
    if pix.debug
      for i=1,#pix.signs_s do
        local item=pix.signs_s[i]
        item:onDraw(graph)
      end
    end


    pix.me:onDraw(graph)

    if pix.debug
      graph:drawText("Me",pix.me.par.p+Vector(.05,.1),pix.paints.debug)
    end

    for i=1,#pix.btns do
      local item=pix.btns[i]
      graph.canvas.drawRect(item.sP.x+item.r,item.sP.y+item.r,item.sP.x-item.r,item.sP.y-item.r,item.paint)
      graph.canvas.drawText(item.label,item.sP.x,item.sP.y,pix.paints.text)
    end
    if pix.debug
      graph:drawPoint(Vector(),pix.paints.debug)
      graph:drawPoint(Vector(1),pix.paints.debug)
      graph:drawPoint(Vector(0,1),pix.paints.debug)
      graph.canvas.drawLine(-graph.o.x+graph.o.x,0+graph.o.y,(graph.w-graph.o.x)+graph.o.x,0+graph.o.y, pix.paints.debug)
      graph.canvas.drawLine(0+graph.o.x,-graph.o.y+graph.o.y,0+graph.o.x,(graph.h-graph.o.y)+graph.o.y, pix.paints.debug)
    end
  end


  graph.onTouch=function(v, event)

    for i = 1, event.getPointerCount() do
      local tsp=Vector(event.getX(i-1),event.getY(i-1))
      for i=1,#pix.btns do
        local item=pix.btns[i]
        if #(tsp - item.sP)<item.r
          if (event.getActionMasked() == MotionEvent.ACTION_DOWN) or (event.getActionMasked() == MotionEvent.ACTION_POINTER_DOWN)
            item.onDOWN()

           elseif (event.getActionMasked() == MotionEvent.ACTION_UP)
            item.onUP()
          end
        end
      end
    end
  end

  Env.dt=0.01
  tk=Ticker()
  tk.Period=Env.dt*1000
  tk.onTick=function()
    local me=pix.me
    Env.t=Env.t+Env.dt

    for i=1,#pix.thorns do
      local item=pix.thorns[i]
      item:collision_Me(pix.me,function()
        if pix.me.life
          pix.me.life=false
          pix.me:loadDeadParticle()
          pix.me:deadShake()
          task(1500,function()            
            pix.loadLevel()            
          end)
        end
      end)
    end

    for i=1,#pix.signs_s do
      local item=pix.signs_s[i]
      item:collision_Me(pix.me)
    end

    me:update()

  end
  tk.start()
  function onDestroy()
    tk.stop()
  end

end

graph:init(Main)

