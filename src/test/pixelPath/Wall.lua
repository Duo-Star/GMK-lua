function Wall() end
Wall={
  __call=function(_,data)
    return Wall.new(data)
  end,
  __index = {
    new=function(data)
      local par=Particle({p=data.p})
      par.p1=data.p1
      par.p2=data.p2
      par.k=data.k or 1000
      par.paint=data.paint or pix.paints.wall
      return setmetatable(par,Wall)
    end,
    onDraw=function(Wall_,graph)
      if pix.debug
        graph:drawPoint(Wall_.p1,pix.paints.debug)
        graph:drawPoint(Wall_.p2,pix.paints.debug)
      end
      graph:drawRect(Wall_.p1,Wall_.p2,Wall_.paint)
      --graph:drawSegment(Wall_.p1,Wall_.p2,pix.paints.debug)

    end,

    collision_Particle=function(Wall_,par)
      local x,y=par.p.x,par.p.y
      local x1,y1=Wall_.p1.x,Wall_.p1.y
      local x2,y2=Wall_.p2.x,Wall_.p2.y
      --print(x-Wall_.p2.y)
      local v_1=Vector(x1-x)
      local v_2=Vector(x2-x)
      local v_3=Vector(0,y1-y)
      local v_4=Vector(0,y2-y)
      if v_1.x*v_2.x<0 and v_3.y*v_4.y<0
        local vs={v_1,v_2,v_3,v_4}
        table.sort(vs,function(a,b)
          return #a<#b
        end)
        if #par.v>3
          --par.v=Vector()
        end
        return vs[1]*Wall_.k*.8 + (-9)*par.v
       else return Vector()
      end
    end,

    collision_Me=function(Wall_,me)
      local ss=-11.4514
      local isCollision=false
      local x,y=me.par.p.x,me.par.p.y
      local x1,y1=Wall_.p1.x,Wall_.p1.y
      local x2,y2=Wall_.p2.x,Wall_.p2.y
      local v_1=Vector(x1-x-me.r/2)
      local v_2=Vector(x2-x+me.r/2)
      local v_3=Vector(0,y1-y-me.r)
      local v_4=Vector(0,y2-y+me.r)
      if v_1.x*v_2.x<0 and v_3.y*v_4.y<0
        local vs={v_1,v_2,v_3,v_4}
        table.sort(vs,function(a,b)
          return #a<#b
        end)
        if not(pix.me.where=="jump")
          if vs[1].x==0
            pix.me.par.v.y=0--停止向下坠落
            pix.me.where="ground"--修改位置标注
           else
            ss=0
          end
        end
        if pix.me.where=="air"
          pix.me.status="stand"--将姿态改为站立
        end
        if pix.me.run=="no"
          pix.me.par.v.x=0
        end
        return vs[1]*Wall_.k + (ss)*me.par.v
       else return Vector()
      end
    end,



  }
}
setmetatable(Wall, Wall)


return Wall
