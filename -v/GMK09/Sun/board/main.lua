require "import"
import "android.widget.*"
import "android.view.*"
local ViewPager = luajava.bindClass "androidx.viewpager.widget.ViewPager"

board_data={
  {
    {
      {show="x",input="x",todo=""},
      {show="y",input="y",todo=""},
      {show="π",input="pi",todo=""},
      {show="e",input="e",todo=""},
      {show="7",input="7",todo=""},
      {show="8",input="8",todo=""},
      {show="9",input="9",todo=""},
      {show="<×",input="",todo="undo()"}
    },
    {
      {show="□²",input="^2",todo=""},
      {show="x^",input="^",todo=""},
      {show="√",input="sqrt",todo=""},
      {show="|□|",input="abs",todo=""},
      {show="4",input="4",todo=""},
      {show="5",input="5",todo=""},
      {show="6",input="6",todo=""},
      {show="#",input="#",todo="print(a)"}
    },
    {
      {show="+",input="+",todo=""},
      {show="-",input="-",todo=""},
      {show="*",input="*",todo=""},
      {show="/",input="/",todo=""},
      {show="1",input="1",todo=""},
      {show="2",input="2",todo=""},
      {show="3",input="3",todo=""},
      {show="=",input="=",todo=""}
    },
    {
      {show="{",input="{",todo=""},
      {show="}",input="}",todo=""},
      {show="(",input="(",todo=""},
      {show=")",input=")",todo=""},
      {show=",",input=",",todo=""},
      {show="0",input="0",todo=""},
      {show=".",input=".",todo=""},
      {show="<-",input="",todo="next_line()"}
    },
  },
  { --第二页
    {
      {show="sin",input="sin",todo=""},
      {show="cos",input="cos",todo=""},
      {show="tan",input="tan",todo=""},
      {show="point",input="point",todo=""},
      {show="Vector",input="Vector",todo=""},
      {show="line",input="line",todo=""},
      {show="plane",input="plane",todo=""},
      {show="<×",input="",todo=""},
    },
    {
      {show="arcsin",input="arcsin",todo=""},
      {show="arccos",input="arccos",todo=""},
      {show="arctan",input="arctan",todo=""},
      {show="圆周",input="circle",todo=""},
      {show="椭圆",input="ellipse",todo=""},
      {show="双曲线",input="hyperbola",todo=""},
      {show="抛物线",input="=parabola",todo=""},
      {show="圆锥曲线",input="conic",todo=""},
    },
    {
      {show="log",input="log",todo=""},
      {show="ln",input="ln",todo=""},
      {show="lg",input="lg",todo=""},
      {show="函数",input="function",todo=""},
      {show="导数",input="导数",todo=""},
      {show="积分",input="积分",todo=""},
      {show="求根",input="求根",todo=""},
      {show="曲线",input="曲线",todo=""},
    },
    {
      {show="sgn",input="sgn",todo=""},
      {show="key",input="key",todo=""},
      {show="root",input="root",todo=""},
      {show="floor",input="floor",todo=""},
      {show="ceil",input="ceil",todo=""},
      {show="abs",input="abs",todo=""},
      {show="#ran",input="random",todo=""},
      {show="<-",input="",todo="next_line()"}
    },
  },
  { --第三页
    {
      {show="q",input="q",todo=""},
      {show="w",input="w",todo=""},
      {show="e",input="e",todo=""},
      {show="r",input="r",todo=""},
      {show="t",input="t",todo=""},
      {show="y",input="y",todo=""},
      {show="u",input="u",todo=""},
      {show="i",input="i",todo=""},
      {show="o",input="o",todo=""},
      {show="p",input="p",todo=""},
    },
    {
      {show="a",input="a",todo=""},
      {show="s",input="s",todo=""},
      {show="d",input="d",todo=""},
      {show="f",input="f",todo=""},
      {show="g",input="g",todo=""},
      {show="h",input="h",todo=""},
      {show="j",input="=j",todo=""},
      {show="k",input="k",todo=""},
      {show="l",input="l",todo=""},
    },
    {
      {show="↑",input="",todo="Capppp(1)"},
      {show="z",input="z",todo=""},
      {show="x",input="x",todo=""},
      {show="c",input="c",todo=""},
      {show="v",input="v",todo=""},
      {show="b",input="b",todo=""},
      {show="n",input="n",todo=""},
      {show="m",input="m",todo=""},
      {show="<×",input="",todo=""},
    },
    {
      {show="_",input="_",todo=""},
      {show="(",input="(",todo=""},
      {show=")",input=")",todo=""},
      {show=" ",input=" ",todo=""},
      {show=",",input=",",todo=""},
      {show="=",input="=",todo=""},
      {show="<-",input="",todo="next_line()"}
    },
  }
}





function Capppp(bool)
  for i=1,10 do
    for j=1,4 do
      if bool
        board_data[3][j][j].input=string.upper(board_data[3][j][j].input)
       else
        board_data[3][j][j]=string.lower(board_data[3][j][j])
      end
    end
  end
end




function setWindowSize()
  --主要逻辑
  if activity.getWidth()>activity.getHeight()
    --横屏情况
    return "31%h"
   else
    --竖屏情况
    return "28%h"
  end
end

function onConfigurationChanged()
  --监听窗口属性改变，调用setWindowSize()
  setWindowSize()
end




function fff(data,info)
  -- print(dump(data))

  if data==nil then
    data={show="!",input="!",todo=""}
  end
  if info==nil then
    info={
      textSize="22dp",
      layout_height="5%h",
      layout_width="10.7%w",
      layout_margin="0.935%w",
      layout_marginTop="0.7%w",
    }
  end
  return {LinearLayout,
    orientation=1,
    {MaterialCardView,
      layout_height=info["layout_height"],
      layout_width=info["layout_width"],
      layout_margin=info["layout_margin"],
      layout_marginTop=info["layout_marginTop"],
      strokeWidth="1dp",
      strokeColor="#AA9E9E9E",
      radius="5dp",
      cardElevation=0,
      onClick=function()
        if input_view_now==nil then
          input_view_now=input_view
        end
        --input_view_now.append(data["input"])
        insert_str(data["input"], input_view_now)
        if data["todo"]~="" then
          assert(loadstring(data["todo"]))()
        end
      end,
      {TextView,
        layout_gravity="center",
        --textColor=0xff000000,
        text=data["show"],
        textSize=info["textSize"],
        textStyle="bold",
        layout_margin="2",
      },
    }
  }


end

board_view={LinearLayout,
  orientation=1,
  layout_width="fill",
  layout_height=setWindowSize(),
  BackgroundColor="#FFFFFFF",
  layout_gravity='bottom',
  id="board",
  Visibility=8,
  {LinearLayout,
    orientation=0,
    layout_width="fill",
    layout_height="4%h",
    BackgroundColor="#80424242",
    layout_gravity='top',
    {MaterialCardView,
      layout_height="4%h",
      layout_width="10.7%w",
      layout_margin="0.1%h",
      cardBackgroundColor="0",
      strokeWidth="0",
      strokeColor=0,
      radius="5dp",
      cardElevation=0,
      onClick=function()
        board_page.setCurrentItem(0)
      end,
      {TextView,
        layout_gravity="center",
        textColor="#616161",
        text="123",
        textSize="20dp",
        textStyle="bold",
        layout_margin="3",
      },
    },
    {MaterialCardView,
      layout_height="4%h",
      layout_width="10.7%w",
      layout_margin="0.1%h",
      cardBackgroundColor="0",
      strokeWidth="0",
      strokeColor=0,
      radius="5dp",
      cardElevation=0,
      onClick=function()
        board_page.setCurrentItem(1)
      end,
      {TextView,
        layout_gravity="center",
        textColor="#616161",
        text="f(x)",
        textSize="20dp",
        textStyle="bold",
        layout_margin="3",
      },
    },
    {MaterialCardView,
      layout_height="4%h",
      layout_width="10.7%w",
      layout_margin="0.1%h",
      cardBackgroundColor="0",
      strokeWidth="0",
      strokeColor=0,
      radius="5dp",
      cardElevation=0,
      onClick=function()
        board_page.setCurrentItem(2)
      end,
      {TextView,
        layout_gravity="center",
        textColor="#616161",
        text="abc",
        textSize="20dp",
        textStyle="bold",
        layout_margin="3",
      },
    },

  },
  {LinearLayout,
    orientation=1,
    layout_width="fill",
    layout_height="fill",
    layout_gravity='bottom',

    {
      ViewPager,
      layout_width="fill",
      layout_height="fill",
      id="board_page",
      pages={
        "Sun/board/123",
        "Sun/board/fun",
        "Sun/board/abc",

      },
    },

  }
}

