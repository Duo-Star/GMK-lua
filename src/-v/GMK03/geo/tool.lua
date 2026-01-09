--以下是实现❤️❤️❤️引导栏
circularProgressDrawable.setStrokeWidth(dp2px(3.5)).setStrokeCap(Paint.Cap.ROUND)
.setColorFilter(PorterDuffColorFilter(themeUtil.getColorOnPrimary(),PorterDuff.Mode.SRC_ATOP))
circularProgressDrawable.setStartEndTrim(0.75,0.75+0.3)
guide_card_progress_var=0
guide_card_progress_var_now=0
guide_card_set=function(pro,str)--向引导栏上设置内容
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
      tool=toolList.Move
     elseif id==2
      tool=toolList.Point
     elseif id==3
      tool=toolList.Line guide_card_set(0,"选择直线上一点") guide_card_appear()
     elseif id==4
      tool=toolList.Circle guide_card_set(0,"选择圆心") guide_card_appear()
    end
    toolInfo.reset()
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
  gmt=GMT.new()
  cleanSelect()
  showInfo=false
end

newPname=function()
  local n="P"..toolInfo.pointN
  toolInfo.pointN=toolInfo.pointN+1
  return n
end


toolInfo={
  pointN=1,
  reset=function()
    cleanSelect()
    showInfo=false
    toolInfo.L.DOWN.P1=""
    toolInfo.L.DOWN.P2=""
    toolInfo.C.DOWN.P1=""
    toolInfo.C.DOWN.P2=""
  end,
  M={--移动工具
    DOWN={
      To="",--"A",
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
    newName=function()
      toolInfo.L.N=toolInfo.L.N+1
      return "L"..toolInfo.L.N
    end
  },
  C={--圆周
    DOWN={
      P1="",
      P2="",

    },
    N=0,
    newName=function()
      toolInfo.C.N=toolInfo.C.N+1
      return "C"..toolInfo.C.N
    end
  },
  CircleT3P={
    DOWN={
      P1="",
      P2="",
      P3="",
    }
  }

}




import "model.BottomSheetDialog"
bsb_=newbsd({
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
      cardBackgroundColor=cc.c.xbt,
    },
    {MaterialTextView,
      layout_marginTop="12dp",
      layout_gravity="center",
      textSize="24sp",
      textColor=cc.c.on_background,
      text="New",
    },
    {RecyclerView,
      id="rec",
    },
    {MaterialTextView,
      layout_marginTop="4dp",
      layout_marginLeft="12dp",
      layout_marginRight="12dp",
      layout_gravity="center",
      textSize="14sp",
      textStyle="bold",
      text="选择工具",
    },
    {MaterialButton,
      layout_marginTop="12dp",
      layout_marginRight="48dp",
      text="OK",
      layout_gravity="right",
      id="ok",
    },
    {Space,
      layout_height="30dp",
    },
  }
})


tools={
  {name="中点",icon="MidP",tool=""},
  {name="角平分线",icon="AngleBisector",tool=""},
  {name="三点圆",icon="CircleT3P",tool="CircleT3P"},

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
        guide_card_set(0,"选择圆上一点(0/3)") guide_card_appear()
       else
      end


    end
  end,
}))
rec.setAdapter(adp)
rec.layoutManager=StaggeredGridLayoutManager(2,1)


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
      {MaterialButton,
        layout_marginTop="12dp",
        layout_marginRight="48dp",
        text="OK",
        layout_gravity="right",
        id="ok",
      },
      {Space,
        layout_height="30dp",
      },
    }
  })

bsb_info.show()
end



showInfoDialog("A")

