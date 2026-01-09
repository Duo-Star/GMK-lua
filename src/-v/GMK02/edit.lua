require "util"
import "class"
import "MaterialChip"
import "editLayout"


activity.setContentView(loadlayout(editLayout))

-------------💎
activity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_PAN);
local DataDir="/data/user/0/"..tostring(activity.getPackageName().."/gmk/")
local w=this.getWidth()
local h=this.getHeight()
local file=DataDir..activity.getSharedData("file")

edit.text=io.open(file):read("*a")

--print(file)
drag1.setOnTouchListener(View.OnTouchListener{
  onTouch=function(view, motionEvent)
    local event=motionEvent
    if (motionEvent.getAction() == MotionEvent.ACTION_DOWN) then
      downX = event.getX();
      downY = event.getY();
      return true;
     elseif motionEvent.getAction()== MotionEvent.ACTION_MOVE
      local x=motionEvent.getRawX()
      local y=motionEvent.getRawY()

      xDistance = event.getX() - downX;
      yDistance = event.getY() - downY;
      if (xDistance ~= 0 && yDistance ~= 0) then
        l = (card1.getLeft() + xDistance);
        r = (card1.getRight() + xDistance);
        t = (card1.getTop() + yDistance);
        b = (card1.getBottom() + yDistance);
        card1.x=x-downX
        card1.y=y-100
      end
     else
      return false;
    end
  end
})




-------------💎



drag2.setOnTouchListener(View.OnTouchListener{
  onTouch=function(view, motionEvent)
    local event=motionEvent

    if (motionEvent.getAction() == MotionEvent.ACTION_DOWN) then
      downX1 = event.getX();
      downY1 = event.getY();
      return true;
     elseif motionEvent.getAction()== MotionEvent.ACTION_MOVE
      local x=motionEvent.getRawX()
      local y=motionEvent.getRawY()

      -- local xDistance = event.getX() - downX;
      --  local yDistance = event.getY() - downY;
      --  if (xDistance ~= 0 && yDistance ~= 0) then
      card2l = (card2.getLeft() + x);
      card2r = (card2.getRight() + x);
      card2t = (card2.getTop() + y);
      card2b = (card2.getBottom() + y);
      --  card2.layout(card2l,card2t,card2r,card2b)
      card2.x=x-downX1
      card2.y=y-downY1-100
      -- end
     else
      return false;
    end
  end
})






-------------💎
windowsize.setOnTouchListener(View.OnTouchListener{
  onTouch=function(view, motionEvent)
    local event=motionEvent
    if (motionEvent.getAction() == MotionEvent.ACTION_DOWN) then
      local downX = event.getX();
      local downY = event.getY();
      return true;
     elseif motionEvent.getAction()== MotionEvent.ACTION_MOVE
      local x=motionEvent.getRawX()
      local y=motionEvent.getRawY()

      local xDistance = event.getX() -dp2px(50) -- downX;
      local yDistance = event.getY() -dp2px(30) -- downY;
      if (xDistance ~= 0 && yDistance ~= 0) then
        local l = (card1.getLeft() + xDistance);
        local r = (card1.getRight() + xDistance);
        local t = (card1.getTop() + yDistance);
        local b = (card1.getBottom() + yDistance);
        local layoutParams = card1.getLayoutParams();
        layoutParams.height = b;
        layoutParams.width = r;
        card1.setLayoutParams(layoutParams)
        -- card2.layout(card2l,card2t,card2r,card2b)
      end
     else
      return false;
    end
  end
})




windowsize2.setOnTouchListener(View.OnTouchListener{
  onTouch=function(view, motionEvent)
    local event=motionEvent
    if (motionEvent.getAction() == MotionEvent.ACTION_DOWN) then
      local downX = event.getX();
      local downY = event.getY();
      return true;
     elseif motionEvent.getAction()== MotionEvent.ACTION_MOVE
      local x=motionEvent.getRawX()
      local y=motionEvent.getRawY()

      local xDistance = event.getX() -dp2px(50) -- downX;
      local yDistance = event.getY() -dp2px(30) -- downY;
      if (xDistance ~= 0 && yDistance ~= 0) then
        local l = (card2.getLeft() + xDistance);
        local r = (card2.getRight() + xDistance);
        local t = (card2.getTop() + yDistance);
        local b = (card2.getBottom() + yDistance);
        local layoutParams = card2.getLayoutParams();
        layoutParams.height = b;
        layoutParams.width = r;
        card2.setLayoutParams(layoutParams)
        -- card2.layout(card2l,card2t,card2r,card2b)
      end
     else
      return false;
    end
  end
})

-------------💎

run.onClick=function()
  print"r"
end
-------------💎

import "BottomSheetDialog"
function onKeyDown(code,event)
  if string.find(tostring(event),"KEYCODE_BACK") ~= nil then
    newbsd({
      NestedScrollView,
      layout_width="fill",
      layout_height="fill",
      {
        LinearLayout,
        layout_height="fill",
        layout_width="fill",
        orientation=1,
        {MaterialCardView,
          MaxCardElevation=1,
          strokeWidth=0,
          cardElevation=1,
          strokeColor=0,
          layout_marginTop="12dp",
          layout_width="36dp",
          layout_height="4dp",
          layout_gravity="center",
          --cardBackgroundColor=,
          cardBackgroundColor=cc.c.xbt,
        },
        {MaterialTextView,
          layout_marginTop="12dp",
          layout_gravity="center",
          textSize="24sp",
          textColor=cc.c.on_background,
          text="Exit",
        },

        {MaterialTextView,
          layout_marginTop="4dp",
          layout_marginLeft="12dp",
          layout_marginRight="12dp",
          layout_gravity="center",
          textSize="14sp",
          id="内容文字",
          textStyle="bold",
          text="是否保存？",
        },




        {MaterialButton,
          layout_marginTop="12dp",
          text="保存并退出",
          layout_gravity="center",
          id="ok",
        },

        {Space,
          layout_height="64dp",
        },
      }
    }
    ).show()
    ok.onClick=function()
      --写文件
      io.open(file,"w"):write(edit.text):close()
      local intent=Intent()
      activity.setResult(2,intent)
      activity.finish()
    end
    return true
  end
end

