function Model2d() end
Model2d={
  __call=function(_,p,u,v,data)
    return Model2d.new(p,u,v,data)
  end,
  __index = {
    new=function(p,u,v,data)--新建 Model
      return setmetatable({p=p or Vector(),u=u or Vector(1),v=v or Vector(0,1),data=data },Model2d)
    end,
    getItemP=function(md,n)
      return Vector.tp2d(md.p,md.u,md.v,md.data[n])
    end,
    onDraw=function(md,canvas,graph,pt)
      local path = Path()
      local from_p=md:getItemP(1)
      local from_p_s=graph.toSP(from_p)
      path.moveTo(from_p_s.x,from_p_s.y)

      for i=2,#md.data do
        local to_p_s=graph.toSP(md:getItemP(i))
        path.lineTo(to_p_s.x,to_p_s.y)
      end
      canvas.drawPath(path,pt)
    end,
    moveTo=function(md,p)
      md.p=p
      return md
    end,
    roll=function(md,w)
      md.u=md.u:roll2d(w)
      md.v=md.v:roll2d(w)
      return md
    end,
    roll90=function(md,w)
      md.u=md.u:roll2d_90()
      md.v=md.v:roll2d_90()
      return md
    end,



  }
}
setmetatable(Model2d, Model2d)

return Model2d



--[[
md=Model2d(Vector(),Vector.i,Vector.j,{
  Vector(3.21,2.85),
  Vector(3.3,3.5),--脖上
  Vector(3.88,3.43),--下巴
  Vector(4.04,3.85),--嘴
  Vector(3.9,3.85),
  Vector(4.04,3.85),
  Vector(4.08,4.05),
  Vector(4.18,4.3),
  Vector(4.0,4.4),--眼
  Vector(3.9,4.5),
  Vector(3.87,4.66),
  Vector(3.9,4.8),--额
  Vector(3.75,5.2),
  Vector(3.4,4.6),
  Vector(3.2,4.4),
  Vector(3.4,4.0),
  Vector(3.1,4.0),
  Vector(2.9,3.5),
  Vector(3.1,3.1),
  Vector(2.75,3.35),
  Vector(2.6,3.6),
  Vector(2.5,4.2),
  Vector(2.6,3.6),
  Vector(2.35,3.15),
  Vector(2.75,3.35),
  Vector(2.6,3.6),
  Vector(2.5,4.2),
  Vector(2.2,3.5),--后脖
  Vector(1.8,3.8),
  Vector(1.9,3.9),--#
  Vector(1.45,4.2),
  Vector(1.22,4.7),
  Vector(1.27,5.2),
  Vector(1.5,5.7),
  Vector(1.1,5.3),
  Vector(1.5,5.9),
  Vector(1.8,6),
  Vector(1.5,6.1),
  Vector(1.9,6.15),


})


graph.onDraw=function(canvas,graph)
  md:onDraw(canvas,graph,paint)
end
--]]

