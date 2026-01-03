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


return Rope

