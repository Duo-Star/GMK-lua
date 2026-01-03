function Thorn() end
Thorn={
  __call=function(_,data)
    return Thorn.new(data)
  end,
  __index = {
    new=function(data)
      local thorn={ }
      local modelData={ }
      local N=18
      for i=1,N-1 do
        modelData[i]=Vector(i/N-.5,0.04*((-1)^i)+0.1)
      end
      modelData[#modelData+1]=Vector(.5,0)
      modelData[#modelData+1]=Vector(-.5,0)
      thorn.model=Model2d(data.p,data.n:roll2d_90(),data.n, modelData)
      thorn.paint=data.paint or pix.paints.wall
      return setmetatable(thorn,Thorn)
    end,
    onDraw=function(thorn,graph)
      graph:drawModel(thorn.model,thorn.paint)
    end,
    collision_Me=function(thorn,me,f)
      local l=Line(thorn.model.p,thorn.model.u)
      local proP=l:getProjectPoint(me.par.p)
      if #(proP-thorn.model.p)<=(#thorn.model.u/2)
        and #(proP-me.par.p)<=(#thorn.model.u/4)
        f()
      end
    end,


  }
}
setmetatable(Thorn, Thorn)

return Thorn
