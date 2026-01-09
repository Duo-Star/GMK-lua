return {
  { label="left",
    sP=Vector(graph.w*0.16,graph.h*0.85),
    r=80,
    paint= pix.paints.btn,
    onDOWN=function()
      pix.me.run="left"
    end,
    onUP=function()
      pix.me.run="no"
    end,
  },
  { label="right",
    sP=Vector(graph.w*0.16+180,graph.h*0.85),
    r=80,
    paint= pix.paints.btn,
    onDOWN=function()
      pix.me.run="right"

    end,
    onUP=function()
      pix.me.run="no"
    end,
  },
  { label="up",
    sP=Vector(graph.w*0.8,graph.h*0.85),
    r=80,
    paint= pix.paints.btn,
    onDOWN=function()
      if pix.me.where=="ground"
        pix.me.where="jump"
        pix.me.par.v.y=mf.e
        task(5,function()
          pix.me.where="air"
        end)
      end
    end,
    onUP=function()

    end,
  },

  { label="test",
    sP=Vector(graph.w*0.8,graph.h*0.85-180),
    r=80,
    paint= pix.paints.btn,
    onDOWN=function()
      
    end,
    onUP=function()

    end,
  },


}