function Me() end
Me={
  __call=function(_,data)
    return Me.new(data)
  end,
  __index = {
    new=function(data)
      local me={}
      me.par=Particle({
        p = data.p or Vector(),
      })
      me.r=data.r or .11
      me.action="none"
      me.run="no"--left right no
      me.where="ground"--ground air jump
      me.onGround=false
      me.life=true
      me.portraiture={
        stand={
          {Vector(-.025,0.075),Vector(.025,.125)},
          {Vector(-.05,-.05),Vector(.05,.075)},
          {Vector(-.05,-.11),Vector(-.01,-.05)},
          {Vector(.01,.0-.11),Vector(.05,-.05)},
        },
        runLeft_1={
          {Vector(-.025,0.075),Vector(.025,.13)},--👦
          {Vector(-.05,-.05),Vector(.05,.08)},--👕
          {Vector(-.08,-.07),Vector(-.02,-.04)},--迈出去的大腿
          {Vector(-.085,-.09),Vector(-.05,-.05)},--👖
          {Vector(.01,-.085),Vector(.085,-.05)},--👖
          {Vector(.05,.055),Vector(.075,-.01)},--💪
        },
        runLeft_2={
          {Vector(-.025,0.075),Vector(.025,.125)},--👦
          {Vector(-.05,-.05),Vector(.05,.075)},--👕
          {Vector(-.05,-.11),Vector(-.01,-.05)},
          {Vector(.01,.0-.11),Vector(.05,-.05)},
          {Vector(.05,.055),Vector(.075,-.02)},--💪
        },

        runRight_1={
          {Vector(-.025,0.075),Vector(.025,.13)},--👦
          {Vector(-.05,-.05),Vector(.05,.08)},--👕
          {Vector(.08,-.07),Vector(.02,-.04)},--迈出去的大腿
          {Vector(.085,-.09),Vector(.05,-.05)},--👖
          {Vector(-.01,-.085),Vector(-.085,-.05)},--👖
          {Vector(-.05,.055),Vector(-.075,-.01)},--💪
        },
        runRight_2={
          {Vector(-.025,0.075),Vector(.025,.125)},--👦
          {Vector(-.05,-.05),Vector(.05,.075)},--👕
          {Vector(.05,-.11),Vector(.01,-.05)},
          {Vector(-.01,.0-.11),Vector(-.05,-.05)},
          {Vector(-.05,.055),Vector(-.075,-.02)},--💪
        },
      }
      me.status="stand"
      me.deadParticle={}
      return setmetatable(me,Me)
    end,
    onDraw=function(me,graph)
      if me.life
        for i=1,#me.portraiture[me.status] do
          local item=me.portraiture[me.status][i]
          --graph:drawPoint(me.p,pix.paints.me)
          graph:drawRect(me.par.p + item[1],me.par.p + item[2],pix.paints.me)
        end
      end
      for i_=1,#me.deadParticle do
        local dp=me.deadParticle[i_]
        graph:drawRect(dp.p,dp.p+Vector(.05,.05),pix.paints.me)
        if pix.debug
          graph:drawText("dP_"..i_,dp.p,pix.paints.debug)
        end
      end
    end,
    loadDeadParticle=function(me)
      for i=1,15 do
        me.deadParticle[i]=Particle{
          p=me.par.p,
          v=Vector.newUC(mf.random()*2*mf.pi,mf.random_(.8,1.2,1e-3))
        }
      end
    end,
    deadShake=function(me)
      local deadShake_va=ValueAnimator.ofFloat({0,.5,-.8,.5,0}).setDuration(432.1).setRepeatCount(0)--.setDurationScale(0)--.setRepeatMode(ValueAnimator.REVERSE)
      deadShake_va.setInterpolator(luajava.bindClass "android.view.animation.DecelerateInterpolator"())
      deadShake_va.addUpdateListener(ValueAnimator.AnimatorUpdateListener {
        onAnimationUpdate = function(animate)
          local k=deadShake_va.getAnimatedValue()
          graph.o.x=graph.w/2+60*mf.sin(k)
          graph.o.y=graph.h/2+60*mf.cos(k)
        end
      })
      deadShake_va.start()
    end,
    update=function(me)
      local F=Vector()
      if me.run=="left"
        if me.where=="air"--在空中保留跳跃姿态
          pix.me.status="runLeft_1"
         else--在地上迈开双腿
          pix.me.status="runLeft_"..(math.floor(Env.t*12)%2)+1
        end
        pix.me.par.v.x=-1.5--拥有速度
       elseif pix.me.run=="right"
        if pix.me.where=="air"
          pix.me.status="runRight_1"
         else
          pix.me.status="runRight_"..(math.floor(Env.t*12)%2)+1
        end
        pix.me.par.v.x=1.5
       elseif pix.me.run=="no"
        pix.me.status="stand"
      end
      for i=1,#pix.walls do
        local item=pix.walls[i]
        F=F+item:collision_Me(pix.me)
        for i_=1,#pix.me.deadParticle do
          local dp=pix.me.deadParticle[i_]
          dp.a=(1/dp.m) * item:collision_Particle(dp)+Vector(0,-2)
          dp:update()
        end
      end
      pix.me.par.a=Vector(0,-8) + (1/pix.me.par.m)*F
      pix.me.par:update()


    end,


  }
}
setmetatable(Me,Me)

return Me