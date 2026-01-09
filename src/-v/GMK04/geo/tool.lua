--以下是实现❤️❤️❤️引导栏
circularProgressDrawable.setStrokeWidth(dp2px(3.5)).setStrokeCap(Paint.Cap.ROUND)
.setColorFilter(PorterDuffColorFilter(themeUtil.getColorOnPrimary(),PorterDuff.Mode.SRC_ATOP))
circularProgressDrawable.setStartEndTrim(0.75,0.75+0.3)
guide_card_progress_var=0
guide_card_progress_var_now=0
guide_card_set=function(pro,str)--向引导栏上设置内容
  if pro==0 guide_card_progress.setVisibility(8)
   else guide_card_progress.setVisibility(View.VISIBLE)
  end
  guide_card_appear()
  guide_card_progress_var=pro
  guide_card_text.text=str
end
guide_card_anim = ObjectAnimator.ofFloat(guide_card, "alpha", {1, 1, 1, 1, 0}).setDuration( 500).setRepeatCount(0)
guide_card_dismiss=function(t)
  guide_card_anim = ObjectAnimator.ofFloat(guide_card, "alpha", {1, 1, 1, 1, 0}).setDuration(t or 500).setRepeatCount(0)
  guide_card_anim.start()
end
guide_card_appear=function(t)
  if guide_card_anim.isRunning() guide_card_anim.pause() end
  guide_card.setAlpha(1)
end
guide_card.setAlpha(0)
--❤️❤️❤️






toolList={
  Move="Move",
  Point="Point",
  Line="Line",
  Circle="Circle",
  CircleT3P="CircleT3P",
}
tool=toolList.Move

toolTabList={
  toolTab.newTab().setIcon(getFileDrawable("Move")).setId(1),
  toolTab.newTab().setIcon(getFileDrawable("Point")).setId(2),
  toolTab.newTab().setIcon(getFileDrawable("Line")).setId(3),
  toolTab.newTab().setIcon(getFileDrawable("Circle")).setId(4),

}

for a, item in pairs(toolTabList) do
  toolTab.addTab(item)
end

toolTab.setOnTabSelectedListener{
  onTabSelected=function(tab)
    local id=tab.getId()
    if id==1
      tool=toolList.Move guide_card.setAlpha(0)
     elseif id==2
      tool=toolList.Point guide_card.setAlpha(0)
     elseif id==3
      tool=toolList.Line guide_card_set(0,"选择直线上一点") guide_card_appear()
     elseif id==4
      tool=toolList.Circle guide_card_set(0,"选择圆心") guide_card_appear()
    end
    reset()
  end
}

selectWhat={
  --"A"
}
selectN=1
function selectGeo(name)
  selectWhat[name]=selectN
  selectN=selectN+1
end
function cleanSelect()
  selectWhat={}
  selectN=1
end
showInfo=false--"A"

cleanAll=function()
  data={}
  gmt=GMT.newNone()
  cleanSelect()
  showInfo=false
end

reset=function()
  cleanSelect()
  showInfo=false
  toolInfo.L.DOWN.P1=""
  toolInfo.L.DOWN.P2=""
  toolInfo.C.DOWN.P1=""
  toolInfo.C.DOWN.P2=""

end






newName_P=function()
  toolInfo.P.N=toolInfo.P.N+1
  return "P"..toolInfo.P.N
end

newName_L=function()
  toolInfo.L.N=toolInfo.L.N+1
  return "L"..toolInfo.L.N
end

newName_C=function()
  toolInfo.C.N=toolInfo.C.N+1
  return "C"..toolInfo.C.N
end




toolInfo={
  P={--点工具
    DOWN={
      To=nil,--"A",
      index=0,
      dis=1e5,
    },
    N=0,
  },
  M={--移动工具
    DOWN={
      To=nil,--"A",
      HasMove=false,
      dis=1e5,
    }
  },
  L={--直线
    DOWN={
      P1="",
      P2="",

    },
    N=0,
  },
  C={--圆周
    DOWN={
      P1="",
      P2="",
    },
    UP={
      afterP1=false
    },
    N=0,
  },
  CircleT3P={
    DOWN={
      P1="",
      P2="",
      P3="",
    }
  },
  Intersect={
    g1="",
    g2="",
    dis=1e5,
  },
  midP={
    P1="",
    P2="",
  },
}




import "model.BottomSheetDialog"
bsb_=newbsd({
  LinearLayout,
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
      cardBackgroundColor=cc.c.xbt,
    },
    {MaterialTextView,
      layout_marginTop="12dp",
      layout_gravity="center",
      textSize="24sp",
      textColor=cc.c.on_background,
      text="New",
    },
    {
      TabLayout,
      id="mtab",
      layout_width="fill",
      layout_height="wrap",
    },
    {
      ViewPager,
      id="cvpg",
      layout_width="fill",
      --layout_height="fill",
      pagesWithTitle={
        {
          {
            LinearLayout,
            layout_height="fill",
            --layout_width="fill",
            orientation=1,
            {RecyclerView,
              id="rec",
              layout_gravity="center",
            },
          },
          {
            NestedScrollView,
            layout_width="fill",
            layout_height="fill",
            {
              LinearLayoutCompat,
              orientation="vertical",
              layout_width="fill",
              layout_height="fill",
              padding="16dp",
              layoutTransition=LayoutTransition().enableTransitionType(LayoutTransition.CHANGING),
              { MaterialTextView,
                text="常规",
                textStyle="bold",
                textSize="16sp",
              },
              {
                LinearLayoutCompat,
                layout_marginTop="12dp",
                layout_width="fill",
                layout_height="wrap",
                gravity="center",
                {
                  LinearLayoutCompat,
                  orientation="vertical",
                  layout_width="wrap",
                  layout_height="wrap",
                  {
                    MaterialTextView,
                    text="夜?",
                    textStyle="bold",
                    textSize="18sp",
                  },
                  {
                    MaterialTextView,
                    text="切换浅色与深色模式",
                    textSize="14sp",
                  },
                },
                {
                  Space,
                  layout_weight="1",
                },
                {
                  MaterialSwitch,
                  id="切换浅色与深色模式sw",

                },
              },
              { LinearLayout,
                layout_marginTop="24dp",
                layout_width="fill",
                layout_height="wrap",
                gravity="center",
                { LinearLayout,
                  orientation="vertical",
                  layout_width="wrap",
                  layout_height="wrap",
                  { MaterialTextView,
                    text="坐标系",
                    textStyle="bold",
                    textSize="18sp",
                  },
                  { MaterialTextView,
                    text="显示坐标系",
                    textSize="14sp",
                  },
                },
                { Space,
                  layout_weight="1",
                },
                { MaterialSwitch,
                  checked="true",
                  onClick=function(v)
                    print("按钮状态 "..tostring(v.isChecked()))
                  end,
                },
              },
              { MaterialButton,
                layout_marginTop="12dp",
                layout_marginRight="48dp",
                text="OK",
                layout_gravity="right",
                id="ok",
              },
            },
          },
          {
            NestedScrollView,
            layout_width="fill",
            layout_height="fill",
            {
              LinearLayoutCompat,
              orientation="vertical",
              layout_width="fill",
              layout_height="fill",
              padding="16dp",
              layoutTransition=LayoutTransition().enableTransitionType(LayoutTransition.CHANGING),
              { MaterialTextView,
                text="图表信息[尚未保存]",
                textStyle="bold",
                textSize="16sp",
              },
              {
                TextInputLayout,
                layout_gravity="center",
                hint="名称",
                layout_marginTop="4dp",
                layout_marginLeft="8dp",
                boxBackgroundMode=TextInputLayout.BOX_BACKGROUND_OUTLINE,
                layout_width="76%w",
                {TextInputEditText,
                  id="名称et",
                  padding="12dp";
                  style=R.style.Widget_Material3_TextInputEditText_OutlinedBox_Dense,
                  textSize=16,
                  layout_width="fill",
                },
              },
              {
                TextInputLayout,
                layout_gravity="center",
                hint="作者",
                layout_marginTop="4dp",
                layout_marginLeft="8dp",
                boxBackgroundMode=TextInputLayout.BOX_BACKGROUND_OUTLINE,
                layout_width="76%w",
                {TextInputEditText,
                  id="作者et",
                  padding="12dp";
                  style=R.style.Widget_Material3_TextInputEditText_OutlinedBox_Dense,
                  textSize=16,
                  layout_width="fill",
                },
              },
              {
                TextInputLayout,
                layout_gravity="center",
                hint="介绍",
                layout_marginTop="4dp",
                layout_marginLeft="8dp",
                boxBackgroundMode=TextInputLayout.BOX_BACKGROUND_OUTLINE,
                layout_width="76%w",
                {TextInputEditText,
                  id="介绍et",
                  padding="12dp";
                  style=R.style.Widget_Material3_TextInputEditText_OutlinedBox_Dense,
                  textSize=16,
                  layout_width="fill",
                },
              },


              { MaterialButton,
                layout_marginTop="12dp",
                layout_marginRight="48dp",
                text="保存",
                layout_gravity="right",
                id="ok",
              },
            },
          },
        },
        {--title
          "   构造   ",
          "   设置   ",
          "   文件   "
        },
      },
    },




    {Space,
      layout_height="30dp",
    },
  }
})


切换浅色与深色模式sw.setChecked(isNightMode())

切换浅色与深色模式sw.onClick=function()
  activity.recreate()
  activity.switchDayNight()

end



mtab.setupWithViewPager(cvpg)


tools={
  {name="中点",icon="midP",tool="midP"},
  {name="角平分线",icon="AngleBisector",tool="AngleBisector"},
  {name="三点圆",icon="CircleT3P",tool="CircleT3P"},
  {name="交点",icon="Intersect",tool="Intersect"},



}

item={LinearLayout,
  {LinearLayout,
    Orientation=1,
    id="bsb_root",layout_margin="16dp",
    {MaterialCardView,
      strokeColor=0,
      strokeWidth=0,
      radius="13dp",
      CardBackgroundColor=cc.c.primary_container,
      id="bsb_mcd",
      onClick=function() end,
      { AppCompatImageView,
        layout_width="26dp",
        layout_height="26dp",layout_margin='13dp',
        layout_gravity="center",
        colorFilter=primaryc,
        id="bsb_img",
      },
    },
    {TextView,
      textSize="13sp",
      textColor=cc.c.primary,
      id="bsb_name",layout_gravity="center",
    },
  }
}

local adp=LuaCustRecyclerAdapter(AdapterCreator({
  getItemCount=function()
    return #tools
  end,
  onCreateViewHolder=function(parent,viewType)
    local views={}
    holder1=LuaCustRecyclerHolder(loadlayout(item,views))
    holder1.view.setTag(views)
    return holder1
  end,
  onBindViewHolder=function(holder,position)
    view=holder.view.getTag()
    view.bsb_name.text=tools[position+1].name
    view.bsb_img.setImageDrawable(getFileDrawable(tools[position+1].icon))
    view.bsb_mcd.onClick=function()
      bsb_.dismiss()
      tool=tools[position+1].tool
      if tool==toolList.CircleT3P
        guide_card_set(0,"选择圆上一点(0/3)") reset()
       elseif tool=="midP"
        guide_card_set(0,"选择一点") reset()
       elseif tool=="Intersect"
        guide_card_set(0,"选择一个几何对象") reset()


      end


    end
  end,
}))
rec.setAdapter(adp)
rec.layoutManager=StaggeredGridLayoutManager(5,1)





showInfoDialog=function(name)
  local gmt_=gmt[name]
  local class=gmt_.class
  import "model.BottomSheetDialog"
  bsb_info=newbsd({
    NestedScrollView,
    layout_width="fill",
    layout_height="fill",
    { LinearLayout,
      layout_height="fill",
      layout_width="fill",
      orientation=1,
      { MaterialCardView,
        MaxCardElevation=1,
        strokeWidth=0,
        cardElevation=1,
        strokeColor=0,
        layout_marginTop="12dp",
        layout_width="36dp",
        layout_height="4dp",
        layout_gravity="center",
        cardBackgroundColor=cc.c.xbt,
      },
      {MaterialTextView,
        layout_margin="12dp",
        layout_gravity="center|left",
        textSize="24sp",
        textColor=cc.c.on_background,
        text=class..": "..name,
      },
      {MaterialTextView,
        layout_marginTop="4dp",
        layout_marginLeft="12dp",
        layout_marginRight="12dp",
        layout_gravity="center",
        textSize="14sp",
        textStyle="bold",
        text=gmt:translateToChinese(name),
      },
      {MaterialTextView,
        layout_marginTop="4dp",
        layout_marginLeft="12dp",
        layout_marginRight="12dp",
        layout_gravity="center",
        textSize="14sp",
        textStyle="bold",
        text=gmt:translateToSymbolEquation(name),
      },
      {MaterialButton,
        layout_marginTop="12dp",
        layout_marginRight="48dp",
        text="删除",
        layout_gravity="right",
        id="删除_btn",
      },
      {Space,
        layout_height="30dp",
      },
    }
  })
  bsb_info.show()
  删除_btn.onClick=function()
    gmt:delete(data,name)
    cleanSelect()
    showInfo=false
  end
end

