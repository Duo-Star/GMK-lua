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


