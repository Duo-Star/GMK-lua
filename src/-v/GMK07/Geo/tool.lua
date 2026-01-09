--以下是实现❤️❤️❤️引导栏





circularProgressDrawable.setStrokeWidth(dp2px(3.5)).setStrokeCap(Paint.Cap.ROUND)
.setColorFilter(PorterDuffColorFilter(ui.引导栏进度条颜色,PorterDuff.Mode.SRC_ATOP))



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
  toolInfo.P.N=0
  toolInfo.L.N=0
  toolInfo.C.N=0
  toolTab.selectTab(toolTabList[1])
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
    },
    zoommmmm=false,
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
  MidP={
    P1="",
    P2="",
  },
  Ellipse={
    DOWN={
      P1="",
      P2="",
      P3="",
    }
  },
  Hyperbola={
    DOWN={
      P1="",
      P2="",
      P3="",
    }
  },
  Parabola={
    F="",
    L="",
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
      LinearLayout,
      layout_width="fill",
      layout_height="fill",
      orientation=1,
      {RecyclerView,
        id="rec",
        layout_width="fill",
        layout_height="fill",
        layout_gravity="center",
      },
    },

    {Space,
      layout_height="30dp",
    },
  }
})








tools={
  {name="中点",icon="MidP",tool="MidP"},
  --{name="角平分线",icon="AngleBisector",tool="AngleBisector"},
  {name="三点圆",icon="CircleT3P",tool="CircleT3P"},
  {name="交点",icon="Intersect",tool="Intersect"},
  {name="椭圆",icon="Ellipse",tool="Ellipse"},
  {name="双曲线",icon="Hyperbola",tool="Hyperbola"},
  {name="抛物线",icon="Parabola",tool="Parabola"},


}

item={LinearLayout,
  {LinearLayout,
    Orientation=1,
    id="bsb_root",layout_margin="12dp",
    {MaterialCardView,
      strokeColor=0,
      strokeWidth=0,
      radius="13dp",
      CardBackgroundColor=cc.c.primary_container,
      id="bsb_mcd",
      onClick=function() end,
      { AppCompatImageView,
        layout_width="26dp",
        layout_height="26dp",layout_margin='12dp',
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
       elseif tool=="MidP"
        guide_card_set(0,"选择一点") reset()
       elseif tool=="Intersect"
        guide_card_set(0,"选择一个几何对象") reset()
       elseif tool=="Ellipse"
        guide_card_set(0,"选择一个焦点") reset()
       elseif tool=="Hyperbola"
        guide_card_set(0,"选择一个焦点") reset()
       elseif tool=="Parabola"
        guide_card_set(0,"选择一个焦点") reset()

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
      { MaterialTextView,
        layout_marginTop="14dp",
        layout_marginLeft="14dp",
        layout_gravity="center|left",
        textSize="26sp",
        textColor=cc.c.on_background,
        text=class..": "..name,
      },
      { MaterialTextView,
        layout_marginLeft="12dp",
        layout_gravity="center|left",
        textSize="14sp",
        textStyle="bold",
        --textColor=cc.c.on_background,
        text=""..gmt:translateToChinese(name),
      },

      --
      { LinearLayoutCompat,
        layout_marginTop="2dp",
        layout_marginLeft="15dp",
        layout_width="fill",
        layout_height="wrap",
        gravity="center",
        { MaterialTextView,
          text="显示",
          textStyle="bold",
          textSize="16sp",
        },
        { Space,
          layout_weight="1",
        },
        { MaterialCheckBox,
          id="显示对象复选框",
          onClick=function()
            gmt_.g.show=显示对象复选框.isChecked()
          end,
        },
      },
      { LinearLayoutCompat,
        layout_marginTop="2dp",
        layout_marginLeft="15dp",
        layout_width="fill",
        layout_height="wrap",
        gravity="center",
        { MaterialTextView,
          text="自由(免费",
          textStyle="bold",
          textSize="16sp",
        },
        { Space,
          layout_weight="1",
        },
        { MaterialCheckBox,
          id="自由对象复选框",
          onClick=function()
            gmt_.free=自由对象复选框.isChecked()
          end,
        },
      },
      { LinearLayoutCompat,
        layout_marginTop="2dp",
        layout_marginLeft="15dp",
        layout_width="fill",
        layout_height="wrap",
        gravity="center",
        { MaterialTextView,
          text="标签",
          textStyle="bold",
          textSize="16sp",
        },
        { Space,
          layout_weight="1",
        },
        { MaterialCheckBox,
          id="显示标签复选框",
          onClick=function()
            gmt_.g.label=显示标签复选框.isChecked()
          end,

        },
      },
      { MaterialTextView,
        text="颜色",
        layout_marginTop="2dp",
        layout_marginLeft="15dp",
        textStyle="bold",
        textSize="16sp",
      },
      {ChipGroup,
        layout_marginLeft="15dp",
        ChipSpacingHorizontal=dp2px(4),
        ChipSpacingVertical=dp2px(2),
        SingleSelection=true,
        id="颜色组",
      },
      { MaterialButton,
        layout_marginTop="12dp",
        layout_marginRight="48dp",
        text="删除",
        layout_gravity="right",
        id="删除_btn",
      },
      { Space,
        layout_height="30dp",
      },
    }
  })
  bsb_info.show()

  显示对象复选框.setChecked(gmt_.g.show)
  自由对象复选框.setChecked(gmt_.free)
  显示标签复选框.setChecked(gmt_.g.label)


  for i=1,#gmt.color do
    local c=gmt.color[i]
    颜色组.addView(loadlayout(
    { Chip,
      IconStartPadding=dp2px(8),
      IconEndPadding=dp2px(0),
      TextStartPadding=dp2px(8),
      TextEndPadding=dp2px(8),
      text=c,
      id="颜色组_"..c,
      ChipIconSize=dp2px(18),
      ChipStrokeWidth="1dp",
      ChipCornerRadius="8dp",
      CheckedIconResource=R.drawable.ic_mtrl_chip_checked_black,
      Checkable=true,

      onClick=function()
        gmt_.g.color=c
      end
    }
    ))
  end
  _ENV["颜色组_"..gmt_.g.color].setChecked(true)



  删除_btn.onClick=function()
    gmt:delete(data,name)
    cleanSelect()
    showInfo=false
    bsb_info.hide()
    local adp2=LuaCustRecyclerAdapter(AdapterCreator({
      getItemCount=function()
        return #gmt.step
      end,
      onCreateViewHolder=function(parent,viewType)
        local views={}
        holder1=LuaCustRecyclerHolder(loadlayout(item2,views))
        holder1.view.setTag(views)
        return holder1
      end,
      onBindViewHolder=function(holder,position)
        view=holder.view.getTag()
        local name=gmt.step[position+1]
        local gmt_item=gmt[name]
        view.name.text=name
        view.context.text=gmt:translateToChinese_WithNoName(name)
        view.cd.setCardBackgroundColor(graph.color[gmt_item.g.color][1])
        view.btnnn.onClick=function()
          showInfoDialog(name)
        end
      end,
    }))
    rec2.setAdapter(adp2)
    rec2.setLayoutManager(LinearLayoutManager(this))
  end
end

