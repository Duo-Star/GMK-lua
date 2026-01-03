require "model.util"
import "com.androlua.LuaEditor"
themeUtil=LuaThemeUtil(this)


function write_file(路径,内容)
  import"java.io.File"
  f=File(tostring(File(tostring(路径)).getParentFile())).mkdirs()
  io.open(tostring(路径),"w"):write(tostring(内容)):close()
end

import "android.graphics.Typeface"
code_typeface=Typeface.createFromFile(activity.getLuaDir().."/res/fonts/code.ttf") --设置字体路径，page/main
jost_book_typeface=Typeface.createFromFile(activity.getLuaDir().."/res/fonts/jost_book.ttf") --设置字体路径，page/main
jost_medium_typeface=Typeface.createFromFile(activity.getLuaDir().."/res/fonts/jost_medium.ttf") --设置字体路径，page/main

sharedData= import "model.SharedData"

duo={ LinearLayout,
  layout_width="fill",
  layout_height="fill",
  orientation=1,
  id="root_lay",
  { MaterialCardView,
    layout_height="55dp",
    layout_width="fill",
    --backgroundColor=0xFFFFFFFF,
    cardElevation="10dp",
    strokeColor=0,strokeWidth=0,
    { FrameLayout,
      layout_width='fill',
      layout_height='fill',
      { TextView,
        layout_gravity='center|left',
        textSize='20dp',
        --textColor=0xFF212121,
        layout_margin='10dp',
        id="tips",
        text=sharedData.LuaEditRun_Path:match("Files/" .. "(.+)"..".lua").."",
        style="blod",
      },
      { LinearLayout,
        orientation="0",
        layout_height="50dp",
        layout_width="fill",
        gravity="center|right",
        {MaterialCardView,
          layout_width='45dp',
          layout_height='45dp',
          CardBackgroundColor=0,
          radius="30dp",strokeColor=0,strokeWidth=0,
          cardElevation="0dp",
          layout_margin='5dp';
          onClick=function()
            lua_edit_.save()
            activity.newActivity("Code/run")
          end,
          { AppCompatImageView,
            layout_width='25dp',
            layout_height='25dp',
            layout_gravity='center',
            src="res/run.png",
            layout_margin='3dp',
            colorFilter=primaryc,
          };
        },
        {MaterialCardView,
          layout_width='45dp',
          layout_height='45dp',
          CardBackgroundColor=0,
          radius="30dp",strokeColor=0,strokeWidth=0,
          cardElevation="0dp",
          layout_margin='5dp';
          onClick=function()
            lua_edit_.format()
          end,
          { AppCompatImageView,
            layout_width='25dp',
            layout_height='25dp',
            layout_gravity='center',
            src="res/format.png",
            layout_margin='3dp',
            colorFilter=primaryc,
          };
        },
        {MaterialCardView,
          layout_width='45dp',
          layout_height='45dp',
          CardBackgroundColor=0,
          radius="30dp",strokeColor=0,strokeWidth=0,
          cardElevation="0dp",
          layout_margin='5dp';
          onClick=function()
            pop=PopupMenu(activity,top_lay)
            menu=pop.Menu
            menu.add('保存').onMenuItemClick=function(a)
              lua_edit_.save()
              print("已保存")
            end
            menu.add('API').onMenuItemClick=function(a)

            end
            pop.show()
          end,
          { AppCompatImageView,
            layout_width='25dp',
            layout_height='25dp',
            layout_gravity='center',
            src="res/more.png",
            layout_margin='3dp',
            colorFilter=primaryc,
          };
        },
      },
    },
  },
  {Space,id="top_lay",layout_width="0",layout_height="0",layout_gravity='top|right'},
  {
    MaterialCardView,
    --CardBackgroundColor=0xffffffff,
    radius="0dp",strokeColor=0,strokeWidth=0,
    cardElevation="0dp",
    {
      LuaEditor,
      layout_height="fill",
      layout_width="fill",
      layout_marinBottom="40dp",
      id="lua_edit_",
    },
    {
      HorizontalScrollView,
      horizontalScrollBarEnabled=false,
      layout_width="fill",
      layout_gravity='bottom',
      {
        LinearLayout,
        layout_width="fill",
        id="ps_bar",
      },
    },
  },
}
activity.setContentView(loadlayout(duo))


if sharedData.LuaEditRun_ToDo=="open" then
  lua_edit_.open(sharedData.LuaEditRun_Path)
end


--lua_edit_.setDark(isNightMode())
--.setKeywordColor(0xffC62828)--function true
--.setCommentColor(0xff9E9E9E)-- --aaa
--.setTextColor(0xff202020)--this
--.setUserwordColor(0xff388E3C)-- 1
--.setBasewordColor(0xff202020)  --require
--.setPanelBackgroundColor(0xff202020)
--]]



lua_edit_.addNames(String(
{ "mf",
  "Duo",
  "Vector",
  "i",
  "printf",

}))


--符号栏
function Shortcut_Symbol_Bar(id)
  local t=
  {
    "(",")",".",",",
    "+","-","*","/","=",
    "#","[","]","{","}","^","_",
    "\"",":",
    "&","|",
    "<",">","~","'"
  }
  for k,v in ipairs(t) do
    Shortcut_Symbol_Item=loadlayout({
      LinearLayout,
      layout_width="40dp",
      layout_height="40dp",
      backgroundColor=themeUtil.getColorPrimaryContainer(),
      { MaterialTextView,
        layout_width="40dp",
        layout_height="40dp",
        gravity="center",
        text=v,
        onClick=function()
          lua_edit_.paste(v)
        end,
      },
    })
    id.addView(Shortcut_Symbol_Item)
  end
end
activity.getWindow().setSoftInputMode(0x10)
task(10,Shortcut_Symbol_Bar(ps_bar))


function onDestroy()
  lua_edit_.save()
end

