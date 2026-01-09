return function()
  pix.btns = {
    { label="left",
      sP=Vector(graph.w*0.16,graph.h*0.85),
      r=80,
      paint= pix.paints.btn,
      onDOWN=function()
        pix.me.run="left"
      end,
      onUP=function()
        pix.me.run="no"
      end,
    },
    { label="right",
      sP=Vector(graph.w*0.16+180,graph.h*0.85),
      r=80,
      paint= pix.paints.btn,
      onDOWN=function()
        pix.me.run="right"

      end,
      onUP=function()
        pix.me.run="no"
      end,
    },
    { label="up",
      sP=Vector(graph.w*0.8,graph.h*0.85),
      r=80,
      paint= pix.paints.btn,
      onDOWN=function()
        if pix.me.where=="ground"
          pix.me.where="jump"
          pix.me.par.v.y=mf.e
          task(5,function()
            pix.me.where="air"
          end)
        end
      end,
      onUP=function()

      end,
    },
    { label="test",
      sP=Vector(graph.w*0.8,graph.h*0.85-180),
      r=80,
      paint= pix.paints.btn,
      onDOWN=function()

      end,
      onUP=function()

      end,
    },
  }
  pix.me=Me({p=Vector(-1,.3)})
  pix.walls={
    Wall({p1=Vector(-3,-3),p2=Vector(.5,0),k=3e3}),
    Wall({p1=Vector(.4,-3),p2=Vector(3,0),k=3e3}),--活动板
    Wall({p1=Vector(.4,-3),p2=Vector(1.1,-1.5),k=3e3}),--刺下面
    Wall({p1=Vector(-3,2),p2=Vector(3,5),k=3e3}),
    Wall({p1=Vector(-3,-.1),p2=Vector(-2,2),k=3e3}),
    Wall({p1=Vector(2,-.1),p2=Vector(3,2.1),k=3e3}),
  }
  pix.thorns={
    Thorn{
      p=Vector(.75,-1.5),
      n=Vector(0,.6),
    },
  }
  pix.signs_s={
    Signs{
      p=Vector(.25,.1),
      f=function()
        local va=ValueAnimator.ofFloat({.5,1}).setDuration(250).setRepeatCount(0)--.setDurationScale(0)--.setRepeatMode(ValueAnimator.REVERSE)
        va.setInterpolator(luajava.bindClass "android.view.animation.DecelerateInterpolator"())
        va.addUpdateListener(ValueAnimator.AnimatorUpdateListener {
          onAnimationUpdate = function(animate)
            local k=va.getAnimatedValue()
            pix.walls[2].p1.x=k
          end
        })
        va.start()
      end
    },
    
  }
  graph.lam=250
  pix.debug=false
end
