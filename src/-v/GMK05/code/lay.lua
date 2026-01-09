DynamicColors.applyIfAvailable(this)
themeUtil=LuaThemeUtil(this)
MDC_R=luajava.bindClass"com.google.android.material.R"
surfaceColor=themeUtil.getColorSurface()
--更多颜色分类 请查阅Material.io官方文档
backgroundc=themeUtil.getColorBackground()
surfaceVar=themeUtil.getColorSurfaceVariant()
titleColor=themeUtil.getTitleTextColor()
primaryc=themeUtil.getColorPrimary()
primarycVar=themeUtil.getColorPrimaryVariant()
resources=activity.getResources()
function m3c(s)
  value = resources.getColor(android.R.color[s])
  return value
end
function dp2px(i)
  return i*activity.resources.displayMetrics.scaledDensity+.5
end

function getFileDrawable(file)
  fis = FileInputStream(activity.getLuaDir().."/res/"..file..".png")
  bitmap = BitmapFactory.decodeStream(fis)
  return BitmapDrawable(activity.getResources(), bitmap)
end



function write_file(路径,内容)
  import"java.io.File"
  f=File(tostring(File(tostring(路径)).getParentFile())).mkdirs()
  io.open(tostring(路径),"w"):write(tostring(内容)):close()
end




data=...
data={src="/storage/emulated/0/AndroLua/project/GMK/init.lua"}

duo=
{LinearLayout,
  layout_width="fill",
  layout_height="fill",
  orientation=1,
  id="root_lay",
  { MaterialCardView,
    layout_height="55dp",
    layout_width="fill",
    backgroundColor=0xFFFFFFFF,
    cardElevation="10dp",
    strokeColor=0,strokeWidth=0,
    { FrameLayout,
      layout_width='fill',
      layout_height='fill',
      { TextView,
        layout_gravity='center|left',
        textSize='20dp',
        textColor=0xFF212121,
        layout_margin='10dp',
        id="tips",
        text="Nature",
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
            activity.newActivity("pages/Code/run",{lua_edit_.getText()})
          end,
          { ImageView,
            layout_width='25dp',
            layout_height='25dp',
            layout_gravity='center',
            src="res/run.png",
            layout_margin='3dp',
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
          { ImageView,
            layout_width='25dp',
            layout_height='25dp',
            layout_gravity='center',
            src="res/format.png",
            layout_margin='3dp',
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
              write_file(data.src,lua_edit_.getText())
              print("已保存")
            end
            menu.add('另存为').onMenuItemClick=function(a)
              Simple_input_dialog({
                title="另存为",
                hint="文件名",
                id="edit",
                PositiveButton={"确定",function()
                    lua_edit__txt=tostring(lua_edit_.getText())--代码文本
                    file_name=tostring(edit.getText())--文件名
                    write_file("/storage/emulated/0/Duo Nature/Explore/"..file_name..".lua",lua_edit__txt)
                  end
                },
                NegativeButton={"取消",nil},
                onCreate=function()
                end
              })
            end
            menu.add('新建').onMenuItemClick=function(a)

            end
            menu.add('打开').onMenuItemClick=function(a)

            end
            pop.show()

          end,
          { ImageView,
            layout_width='25dp',
            layout_height='25dp',
            layout_gravity='center',
            src="res/more.png",
            layout_margin='3dp',
          };
        },

      },

    },
  },
  {Space,id="top_lay",layout_width="0",layout_height="0",layout_gravity='top|right'},

  {
    MaterialCardView,
    CardBackgroundColor=0,
    radius="0dp",strokeColor=0,strokeWidth=0,
    cardElevation="0dp",
    {
      ScrimInsetsFrameLayout,
      layout_width="fill",
      layout_height="fill",
      {
        ScrimInsetsFrameLayout,
        layout_width="fill",
        layout_height="fill",
        --orientation="vertical",
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
    },
  },
}

activity.setContentView(loadlayout(duo))

--[[
lua_edit_.setDark(false)
lua_edit_.open(data.src)--("/storage/emulated/0/Duo Nature/Explore/demo.lua")
.setBackgroundColor(0xFFFFFFFF)
.setKeywordColor(0xffC62828)--function true
.setCommentColor(0xff9E9E9E)-- --aaa
.setTextColor(0xff202020)--this
.setUserwordColor(0xff388E3C)-- 1
--.setBasewordColor(0xff202020)  --require
--.setPanelBackgroundColor(0xff202020)



lua_edit_.addNames(String(
{ "Nature",
  "Duo",
  "vector",
  "i",
  "point",
  "line",
  "complex",
  "printf",
  "cas",
  'Add',
  'Sub',
  'Mul',
  'Div',
  'Sec',
  'Log',
  "Sqrt",
  "sym",
  'average',
  'list',
  "object",
  "force",
  "gravitation",
  "d3",
  "d2",
  "Env",



}))





--符号栏
function Shortcut_Symbol_Bar(id)
  local t=
  {
    "(",")","+","-","*","/","=","[","]","{","}",
    "\"",":",".",",","_",
    "\\","v.","o.","c.",
    "#","^","&","|",
    "<",">","~","'"
  }
  for k,v in ipairs(t) do
    Shortcut_Symbol_Item=loadlayout({
      LinearLayout,
      layout_width="40dp",
      layout_height="40dp",
      backgroundColor="#ffffffff",
      {
        MaterialTextView,
        layout_width="40dp",
        layout_height="40dp",
        gravity="center",
        --textColor=surfaceColorIn,
        clickable="true",
        focusable="true",
        --backgroundResource=rippleRes.resourceId,
        text=v,
        --Typeface=codeTypeFace,
        onClick=function()
          if v=="v." then v="vector" end
          if v=="o." then v="object" end
          if v=="c." then v="cas" end
          lua_edit_.paste(v)
        end,
      },
    })
    id.addView(Shortcut_Symbol_Item)
  end
end
activity.getWindow().setSoftInputMode(0x10)

task(10,Shortcut_Symbol_Bar(ps_bar))





function onDestroy()--退出时执行
  --write_file(data.src,lua_edit_.getText())
  --print("已保存")
end

--]]