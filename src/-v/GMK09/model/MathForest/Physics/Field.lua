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

return Field
