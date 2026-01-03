require "model.util"





--
activity.SupportActionBar.hide()


import "android.graphics.Typeface"
code_typeface=Typeface.createFromFile(activity.getLuaDir().."/res/fonts/code.ttf") --设置字体路径，page/main
jost_book_typeface=Typeface.createFromFile(activity.getLuaDir().."/res/fonts/jost_book.ttf") --设置字体路径，page/main
jost_medium_typeface=Typeface.createFromFile(activity.getLuaDir().."/res/fonts/jost_medium.ttf") --设置字体路径，page/main


--输入法问题
--activity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_PAN);


import "Sun/board/main"
import "Sun/info"
import "model/MathForest/main"

--print_(dump(sun))
--print_(sun.getvar("1"))



MDC_R=import "com.google.android.material.R"

--import "com.google.android.material.color"





--import "layout"
activity.setTitle("科学计算器")
--activity.setContentView(loadlayout(layout))

--activity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE)
--窗口处理


--基础函数
function 状态栏高度()
  if Build.VERSION.SDK_INT >= 19 then
    resourceId = activity.getResources().getIdentifier("status_bar_height", "dimen", "android")
    return activity.getResources().getDimensionPixelSize(resourceId)
   else
    return 0
  end
end

--背景颜色
local themeUtil=LuaThemeUtil(this)
surfaceColor=themeUtil.getAnyColor(MDC_R.attr.colorSurface)
backgroundc=themeUtil.getAnyColor(android.R.attr.colorBackground)


color_={
}
if isNightMode()
  color_.text=0xff424242
 else
  color_.text=0xff424242
end




layout=
{
  CoordinatorLayout,
  layout_width="fill",
  layout_height="fill",
  id="root___",
  {
    LinearLayout,
    layout_width="fill",
    layout_height="fill",
    Orientation=1,
    {
      AppBarLayout,
      layout_width="fill",
      layout_height="wrap",
      id="appbar",
      {
        MaterialToolbar,
        id="toolbar",
        layout_scrollFlags=0,
        -- subtitle="我是一个子标题",
        title="Sun",
        --layout_marginTop=状态栏高度(),
        titleTextColor=color_.text,
        layout_width="fill",
        layout_height="56dp",
        BackgroundColor="#FFFDD835",

      },
    },
    {FrameLayout,
      --orientation=1,
      layout_width="fill",
      layout_height="fill",
      id="father___",
      {NestedScrollView,
        id="ns",
        BackgroundColor=backgroundc,
        layout_width="fill",
        layout_height="fill",

        {FrameLayout,
          --orientation=1,
          layout_width="fill",
          layout_height="fill",
          {RecyclerView,
            layout_width="match",
            layout_height="wrap",
            id="rec",

          },
          {Space,
            layout_height="100dp",
          },
        },
      },
      board_view,
      {Space,
        layout_height="1dp",
        layout_width="fill",
        layout_gravity='bottom',
        id="board_start",
      },
      {
        FloatingActionButton,
        imageResource=R.drawable.material_ic_edit_black_24dp,
        layout_gravity="bottom|end",
        layout_marginBottom="56dp",
        layout_marginEnd="24dp",
        layout_width="wrap_content",
        layout_height="wrap_content",
        BackgroundColor="#FDD835",
        id="fab",
      },
    },
  },
}

--布局
activity.setContentView(loadlayout(layout))
--activity.getSupportActionBar().hide()
--activity.getWindow().setNavigationBarColor(backgroundc)





--标题栏
toolbar.setNavigationIcon(MDC_R.drawable.abc_ic_ab_back_material)


import "android.content.res.ColorStateList"
toolbar.menu.add(0,0,0,"全选").setIcon(R.drawable.ic_mtrl_chip_checked_black).setShowAsAction(2).setIconTintList(ColorStateList.valueOf(color_.text))
--toolbar.menu.add(0,1,1,"删除").setIcon(loadsvg("delete",0xff212121,true)).setShowAsAction(2).setIconTintList(ColorStateList.valueOf(0xff212121))


menu=toolbar.menu
menu.setOptionalIconsVisible(true)
toolbar.menu.add(1,1,1,"文件").setShowAsAction(0).setIconTintList(ColorStateList.valueOf(color_.text))
toolbar.menu.add(2,2,2,"Nature").setShowAsAction(0).setIconTintList(ColorStateList.valueOf(color_.text))
toolbar.menu.add(3,3,3,"设置").setShowAsAction(0).setIconTintList(ColorStateList.valueOf(color_.text))



import "androidx.appcompat.widget.Toolbar$OnMenuItemClickListener"

toolbar.setOnMenuItemClickListener(OnMenuItemClickListener{
  onMenuItemClick=function(item)
    菜单=item.getItemId()
    switch 菜单
     case 0
     -- next_line()
      --activity.newActivity("pages/info",{{"变量表",dump(DATA)}})

     case 2
     -- activity.newActivity("funlist")

    end
  end
})


toolbar.setNavigationOnClickListener{
  onClick=function()
    activity.finish()
  end
}


阴影状态=true
ns.setOnScrollChangeListener{
  onScrollChange=function(_,_,c,_,_)
    if c==0 then
      阴影状态=true
      ObjectAnimator.ofFloat(appbar, "elevation", {30,0})
      .setDuration(200)
      .setInterpolator(AccelerateInterpolator())
      .start()
     else
      if 阴影状态 then
        阴影状态=false
        ObjectAnimator.ofFloat(appbar, "elevation", {0,30})
        .setDuration(200)
        .setInterpolator(AccelerateInterpolator())
        .start()
      end
    end
  end
}



item=
{
  LinearLayout,
  paddingBottom="0dp",
  layout_width="fill",
  layout_height="wrap",
  {
    MaterialTextView,
    paddingTop="10dp",
    layout_marginLeft="8dp",
    id="number",
    textSize="14dp",
    text="1)",
  },
  {Space,
    layout_width="36dp",
  },
  {LinearLayout,
    layout_width="fill",
    layout_height="wrap",
    Orientation=1,
    {
      LinearLayout,
      layout_width="fill",
      layout_height="wrap",
      { FrameLayout,
        layout_width="fill",
        --layout_height="fill",
        { EditText,
          hint="Input...",
          textSize="17dp",
          layout_width="fill",
          layout_marginRight="48dp",
          text="",
          id="input",
          --singleLine=true,
          backgroundColor=0x00ffffff,
          --inputType="none",
          --focusableInTouchMode=false,--禁止弹出输入法
        },
        { Space,
          layout_width="1dp",
          layout_marginRight="200dp",
          layout_gravity="right",
          id="item_pop",
        },
        { MaterialCardView,
          cardBackgroundColor=0,
          strokeWidth=0,
          radius=5,
          cardElevation=0,
          layout_gravity="right",
          layout_width="48dp",
          layout_height="fill",
          --Gravity="center",
          id="item_more",
          onClick=function()
            print()
          end,
          { ImageView,
            layout_gravity="center",
            id="item_more_img",
            ImageResource=MDC_R.drawable.abc_ic_menu_overflow_material
          },
        },
      },
    },
    {LinearLayout,
      id="result",
      layoutTransition=LayoutTransition()
      .enableTransitionType(LayoutTransition.CHANGING)
      .setDuration(LayoutTransition.CHANGE_APPEARING,400)
      .setDuration(LayoutTransition.CHANGE_DISAPPEARING,400),
      Visibility=8,
      {MaterialTextView,
        layout_gravity="center",
        layout_marginLeft="4dp",
        text="=",
        textSize="26dp",
      },
      {MaterialTextView,
        id="output",
        textIsSelectable=true,--可复制，但是会让回车无法选中下一个编辑框
        layout_gravity="center",
        layout_marginLeft="16dp",
        textSize="15dp",
        text="",
      },
      {Space,
        layout_width="fill",
        layout_gravity="center",
        layout_height="5dp",
      },
    },
    {LinearLayout,
      layout_height=3,
      layout_width="fill",
      BackgroundColor=0x88888888,
    }
  }
}


function run__(str)
  pcall(load(str,nil, nil,{ print=print }))
  --assert(loadstring("print()"))()
end


DATA={}
DATA[0]={}
DATA[1]={}


function next_line()--生成下一行(nil)
  table.insert(DATA,"")
  adp.notifyItemInserted(#DATA)
end

function insert_( s1,s2,s3)
  local content=输入框id or input_view_now
  local s2=s2 or ""
  local s3=s3 or 0
  local Start = content.getSelectionStart()
  local End = content.getSelectionEnd()+utf8.len(s1)
  local edit= content.getEditableText()
  edit.insert(Start,s1);
  edit.insert(End,s2);
  content.setSelection(content.getSelectionStart()-s3)
end

function insert_str(what)--在输入框中新增字符串
  insert_(what)
end



local String = luajava.bindClass "java.lang.String"
adp=LuaCustRecyclerAdapter(AdapterCreator({
  getItemCount=function()
    return #DATA
  end,
  onCreateViewHolder=function(parent,viewType)
    local views={}
    holder1=LuaCustRecyclerHolder(loadlayout(item,views))
    holder1.view.setTag(views)
    return holder1
  end,
  onBindViewHolder=function(holder,position)
    local view=holder.view.getTag()
    view.number.text=tostring(position+1)..")"
    view.number.getPaint().setTypeface(code_typeface)

    input_view=view.input
    input_view.getPaint().setTypeface(code_typeface)
    view.input.requestFocus()

    input_view.setOnFocusChangeListener( {
      onFocusChange=function( v, hasFocus)

      end
    })

    --大费周折终于解决了点击时弹出软键盘
    --input_view.setShowSoftInputOnFocus(false)


    --input_view.getTextCursorDrawable().setTintList(ColorStateList.valueOf(0xff263238))
    input_view.onTouch = function(view, event)
      if event.getAction() == MotionEvent.ACTION_UP then
        -- 将焦点转移到自定义的输入法控件
        -- 在这里写入你的代码，用于显示自定义的输入法控件
        --[[
        input_view_now=view
        if fab.getVisibility()~=8 then
          fab.setVisibility(8);
          ContainerTransitionBuilder(father___,board_start,board)
        end
--]]
        --return true -- 拦截触摸事件，防止弹出输入法键盘

       else
        return false
      end
    end




    view.output.getPaint().setTypeface(code_typeface)
    view.input.addTextChangedListener{
      --改变后监听
      afterTextChanged=function(s)

        if tostring(s):find("\n")
          next_line()

         else
          view.result.Visibility=0
          local var=sun.getvar(tostring(s))
          view.output.text=sun.toseeable(var)
          DATA[position]={
            str=tostring(s),
            var_name=sun.get_varname(tostring(s)),
            result=var,
            result_str=view.output.getText(),
            time=os.date("%Y").." "..os.date("%m").." "..os.date("%d").." "..os.date("%H")..":"..os.date("%M")..":"..os.date("%S"),
            type=sun.type(var),
          }
        end

        --[[
        if l~=#tostring(s) then
          if tostring(s):find(")=")~=nil and tostring(s):find("==")==nil then

            view.output.text=(tostring(s))
            local var=sun.getvar(tostring(s))
            DATA[position]={
              str=tostring(s),
              var_name=sun.get_varname(tostring(s)),
              result=var,
              result_str=view.output.getText(),
              time=os.date("%Y").." "..os.date("%m").." "..os.date("%d").." "..os.date("%H")..":"..os.date("%M")..":"..os.date("%S"),
              type=sun.type(var),
            }
           elseif tostring(s):find("y=")~=nil or tostring(s):find("x=")~=nil or tostring(s):find("ρ=")~=nil then
            view.output.text=(tostring(s))
            local var=sun.getvar(tostring(s))
            DATA[position]={
              str=tostring(s),
              var_name=sun.get_varname(tostring(s)),
              result=var,
              result_str=view.output.getText(),
              time=os.date("%Y").." "..os.date("%m").." "..os.date("%d").." "..os.date("%H")..":"..os.date("%M")..":"..os.date("%S"),
              type=sun.type(var),
            }
           else
            view.result.Visibility=0
            local var=sun.getvar(tostring(s))
            view.output.text=sun.toseeable(var)
            DATA[position]={
              str=tostring(s),
              var_name=sun.get_varname(tostring(s)),
              result=var,
              result_str=view.output.getText(),
              time=os.date("%Y").." "..os.date("%m").." "..os.date("%d").." "..os.date("%H")..":"..os.date("%M")..":"..os.date("%S"),
              type=sun.type(var),
            }
          end
        end
      --]]


      end,
      --改变前监听
      beforeTextChanged=function(s)
        l=#tostring(s)

      end,
      --正在改变监听
      onTextChanged=function(s)

      end
    }
    view.item_more.onClick=function(v)
      --print(view.input.Text)
      pop=PopupMenu(activity,view.item_pop)
      menu=pop.Menu
      menu.add("属性").onMenuItemClick=function(a)
        local s=view.input.Text

        local 标签=DATA[position]["var_name"] or "无" if 标签=="" then 标签= "无" end
        local 输出值=tostring(DATA[position]["result_str"]) or "无"
        local 原始值=tostring(DATA[position]["result"]) or "无"
        local 类型=DATA[position]["type"] or "无"
        Dialog("属性","标签: "..标签.."\n表达式: "..s.."\n输出值: "..输出值.."\n原始值: "..原始值.."\n类型: "..类型)
      end
      menu.add("重新计算").onMenuItemClick=function(a)
        the_text=view.input.Text
        view.input.append(" ")
        view.input.setText(the_text)
        --view.input.setSelection(2)--光标移动
      end
      menu.add("可视化").onMenuItemClick=function(a)
        print("暂不可用")
        --activity.newActivity("plot",{DATA[position]["str"]})
      end
      pop.show()
    end
    view.input.setOnKeyListener({
      onKey=function(v,keyCode,event)
        if (KeyEvent.KEYCODE_ENTER == keyCode and KeyEvent.ACTION_DOWN == event.getAction()) then
          if v.Text=="" then
           else
            --填写执行的事件
            if adp.getItemCount()-position ==1 then
              table.insert(DATA,1)
              adp.notifyItemInserted(#DATA)
            end
          end
          return true;
         else
          return false;
        end

      end
    })

  end,
}))

rec.setAdapter(adp)
rec.layoutManager=LinearLayoutManager(this)










local MaterialContainerTransform=import"com.google.android.material.transition.MaterialContainerTransform"

TransitionManager=import"androidx.transition.TransitionManager"
function ContainerTransitionBuilder(root,_start,_end)
  local trans=MaterialContainerTransform()
  .setScrimColor(Color.TRANSPARENT)
  .setStartView(_start)
  .setEndView(_end)
  .addTarget(_end)
  TransitionManager.beginDelayedTransition(this.findViewById(root.id),trans);
  _start.setVisibility(View.INVISIBLE);
  _end.setVisibility(View.VISIBLE);
end




fab.onClick=function()--点击事件
  fab.setVisibility(8);
  ContainerTransitionBuilder(father___,board_start,board)
end


