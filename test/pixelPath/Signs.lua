function Signs() end
Signs={
  __call=function(_,data)
    return Signs.new(data)
  end,
  __index = {
    new=function(data)
      local signs={ }
      local modelData={ Vector(-1), Vector(0,-1), Vector(1), Vector(0,1), Vector(-1)}
      signs.model=Model2d(data.p,.08*Vector.i,.08*Vector.j, modelData)
      signs.paint=data.paint or pix.paints.debug
      signs.r=data.r or .1
      signs.n=data.n or 0
      signs.N=data.N or 1
      signs.f=data.f or function() end
      return setmetatable(signs,Signs)
    end,
    onDraw=function(signs,graph)
      graph:drawText("Signs",signs.model.p+Vector(.06,.06),signs.paint)
      graph:drawModel(signs.model,signs.paint)
    end,
    collision_Me=function(signs,me)
      if #(me.par.p-signs.model.p)<=signs.r and signs.n<signs.N
        signs.f()
        signs.n=signs.n+1
      end
    end,
    


  }
}
setmetatable(Signs, Signs)

return Signs
