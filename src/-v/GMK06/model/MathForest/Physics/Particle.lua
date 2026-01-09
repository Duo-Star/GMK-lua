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

return Particle
