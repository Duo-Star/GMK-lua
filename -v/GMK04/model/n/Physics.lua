
function Particle() end
Particle={
  __call=function(_,data)
    return Particle.new(data)
  end,
  __index = {
    new=function(data)--新建 质点
      local result={}
      result.m = data.m or 1
      result.q = data.q or 1
      result.p = data.p or Vector()
      result.v = data.v or Vector()
      result.a = data.a or Vector()
      return setmetatable(result,Particle)
    end,
    update=function(particle)--更新物体位置
      particle.v = (particle.v):add(particle.a:scale(Env.dt))
      particle.p = (particle.p):add(particle.v:scale(Env.dt))
    end,
    getMomentum=function(particle)--获得动量  <向量>
      return particle.v:scale(particle.m)
    end,
    getEnergy=function(particle)--获得动能   <数字>
      return (particle.v:square()):scale(0.5*particle.m)
    end,
    setForce=function(particle,f)--加载力
      particle.a=f:scale(1/particle.m)
    end,
    stop=function(particle)--使物体停止运动
      particle.v=Vector()
    end,
    toUnreal=function(particle)--将物体破坏
      particle.p=Vector.new_nan()
      particle.v=Vector.new_nan()
      particle.a=Vector.new_nan()
    end,
    getForceFromField=function(particle,field)
      return Field.getForce(field, particle)
    end,
    getGravity=function(particle)
      return Vector(0,particle.m*Env.g)
    end,


  }
}
setmetatable(Particle, Particle)


function Field() end
Field={
  __call=function(_,data)
    return Field.new(data)
  end,
  __index = {
    None="None",--空白
    Gravity="Gravity",--重力


    new=function(data)--新建 场
      data.type=data.type or Field.None
      return setmetatable(data,Interaction)
    end,
    newGravity=function(data)--重力场 g <Vector>
      return setmetatable({type="Gravity",g=data.g or Vector(0,-9.8)},Field)
    end,
    newFluidResistance=function(data)--流体阻力场 s <Number>
      return setmetatable({type="FluidResistance",s=data.s or 1},Field)
    end,
    newUniformElectric=function(data)--均匀电场 E <Vector>
      return setmetatable({type="UniformElectric",E=data.E or Vector(0,1)},Field)
    end,
    newUniformMagnetic=function(data)--均匀磁场 B <Vector>
      return setmetatable({type="UniformMagnetic",B=data.B or Vector(0,0,1)},Field)
    end,
    getForce=function(field, particle)--计算力
      local F
      if field.type=="none" then
        F=Vector()
       elseif field.type=="Gravity" then
        F=field.g:scale(particle.m)
       elseif field.type=="FluidResistance" then
        local v=particle.v
        F=v:scale(v:len()*field.s)
       elseif field.type=="UniformElectric" then
        F=field.E:scale(particle.q)
       elseif field.type=="UniformMagnetic" then
        F=(particle.v:cross(field.B)):scale(particle.q)
       else
        F=Vector()
      end
      return F
    end


  }
}
setmetatable(Field, Field)





function Interaction() end
Interaction={
  __call=function(_,data)
    return Interaction.new(data)
  end,
  __index = {
    None="None",--空白
    Gravity="Gravity",--万有引力

    new=function(data)--新建 相互作用
      data.type=data.type or Interaction.None
      return setmetatable(data,Interaction)
    end,


    getForce=function(a, inter, b)
      local F
      if inter.type=="None" then
        F=Vector()
       elseif inter.type=="Gravity" then
        local dx = a.x - b.x
        local len = (dx):len()
        F=dx:scale((inter.G*a.m*b.m)/(len^3))
       else
        F=Vector()
      end
      return F
    end,
  },
}
setmetatable(Interaction, Interaction)



function Rope() end
Rope={
  __call=function(_,data)
    return Rope.new(data)
  end,
  __index = {
    new=function(data)
      local rp= {
        info={
          l=data.l or 1,
          k=data.k or 1000,
          n=data.n or 10,
          l0=nil,
          m0=0.1,P1=Vector(),P2=Vector(1)
        },
        data={}
      }
      rp.info.l0=rp.info.l/(rp.info.n+1)
      return setmetatable(rp,Rope)
    end,
    unit=function(a,b,info)
      local dp=a.p-b.p
      local r=#dp
      local dr=r-info.l0
      if dr > 0 return dp:scale(info.k*dr*(1/r))
       else return Vector()
      end
    end,
    initLineShape=function(rp,p1,p2)
      local v=p2-p1
      for i=1,rp.info.n do
        rp.data[i]=Particle{p=p1+(i)*(v:unit():scale(rp.info.l0)),m=rp.info.m0}
      end
      rp.P1=p1
      rp.P2=p2
    end,
    onDraw=function(rp,canvas)
      for i=1,#rp.data-1 do
        graph.drawSegment(canvas, rp.data[i].p,rp.data[i+1].p, rp.paint or paint_Blue)
      end
    end,
    update=function(rp,O,P)
      local last_, next_, F1, F2=nil,nil,nil,nil
      for i=1,rp.info.n do
        local item=rp.data[i]
        if i==1
          last_ = Rope.unit(O, item, rp.info)
          F1= last_:unm()
         else
          last_ = Rope.unit(rp.data[i-1], item, rp.info)
        end
        if i==rp.info.n
          next_ = Rope.unit(P, item, rp.info)
          F2=next_:unm()
         else
          next_ = Rope.unit(rp.data[i+1], item, rp.info)
        end
        item:setForce(last_+next_+item:getGravity()*0.0+(-4)*item.v)
        item:update()
      end
      return F1,F2
    end,
  }
}
setmetatable(Rope, Rope)


