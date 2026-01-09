require "model.util"
G=import "model.G"
mf=import "model.MathForest.main"


local layout =
{ FrameLayout,
  layout_width = 'fill',
  layout_height = 'fill',
  { SurfaceView;
    layout_width = 'fill',
    layout_height = 'fill',
    id = "surface",
  },
  { TextView,
    text="Duo提供技术支持",
    --textColor=0xFFF6F1ED,
    textSize="12dp",
    layout_gravity="bottom",
    id="txt",
  },
  { Button;
    layout_gravity="bottom|right";
    text="reset";
    onClick=function()
      graph:reset()
    end,
  },
}

activity.setContentView(loadlayout(layout))


graph=G(surface)

graph:init()


c=Circle(Vector(),1)

dA={c:indexPoint(mf.random_(0,2*pi,0.01)),
  c:indexPoint(mf.random_(0,2*pi,0.01))
}

dB={c:indexPoint(mf.random_(0,2*pi,0.01)),
  c:indexPoint(mf.random_(0,2*pi,0.01))
}

dC={c:indexPoint(mf.random_(0,2*pi,0.01)),
  c:indexPoint(mf.random_(0,2*pi,0.01))
}

l1a=Line(dA[1],dB[1])
l1b=Line(dA[2],dB[2])
p1=l1a:getIntersectPoint2d(l1b)

l2a=Line(dA[1],dC[1])
l2b=Line(dA[2],dC[2])
p2=l2a:getIntersectPoint2d(l2b)


l3a=Line(dB[1],dC[1])
l3b=Line(dB[2],dC[2])
p3=l3a:getIntersectPoint2d(l3b)

l=Line(p1,p1-p2)
print(l:getPdisL(p3))





drawD=function(g,d)
  g:drawPoint(d[1],g.paint.a)
  g:drawPoint(d[2],g.paint.a)
end

graph.onDraw=function(g)

  drawD(g,dA)
  drawD(g,dB)
  drawD(g,dC)

end


graph:setData({c,l,p1,p2,p3})





