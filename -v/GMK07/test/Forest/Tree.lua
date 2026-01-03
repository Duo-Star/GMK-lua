function Tree() end
Tree={
  __call=function(_,data)
    return Tree.new(data)
  end,
  __index = {
    new=function(data)--新建 Forest
      data=data or {}
      data.r=2
      return setmetatable(data,Tree)
    end,
    Pine_Models={
      trunk=Model2d(Vector(),Vector.i,Vector.j,{
        Vector(-1),
        Vector(1),
        Vector(0,1),
        Vector(-1)
      }),

    },

    onDraw=function(t,canvas,graph)
      if t.species=="Pine" then
        t:onDraw_Pine(canvas,graph)
      end

    end,
    onDraw_Pine=function(t,canvas,graph)
      Pine_Models.trunk:onDraw(canvas,graph,paint)


    end

  }
}
setmetatable(Tree, Tree)