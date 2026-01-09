
--这个是工具下拉列表



toolbs=newbsd({
  LinearLayout,
  layout_width="fill",
  layout_height="fill",
  {
    LinearLayout,
    layout_height="fill",
    layout_width="fill",
    orientation=1,
    { MaterialCardView,
      strokeWidth=0,
      layout_marginTop="12dp",
      layout_width="36dp",
      layout_height="4dp",
      layout_gravity="center",
      cardBackgroundColor=themeUtil.getColorOnSurface(),
      alpha=0.8,
    },
    { LinearLayout,
      layout_width="fill",
      layout_height="fill",
      orientation=1,
      {RecyclerView,
        id="tool_rec",
        layout_height="fill",
        layout_marginTop="20dp",
        layout_marginBottom="30dp",
        layout_gravity="center",
      },
    },

  }
})


item={ LinearLayout,
  layout_width="fill",
  Gravity="center",
  paddingLeft="8dp",
  paddingRight="8dp",
  paddingTop="15dp",
  Orientation=1,
  id="father",
  {MaterialCardView,
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

tool_adp=LuaDiffRecyclerAdapter(LuaDiffRecyclerAdapter.LuaInterface {
  getItemViewType=function(position)
    return int(0)
  end,
  onCreateViewHolder=function(parent,types)
    local tag={}
    local view= loadlayout(item,tag,parent.class)
    view.tag=tag
    return view
  end,
  areContentsTheSame=function(old,new)
    return old.title==new.title and old.des == new.des and old.date==new.date and old.color==new.color
  end,
  areItemsTheSame=function(old,new)
    return old.title==new.title and old.des == new.des and old.date==new.date and old.color==new.color
  end,
  onBindViewHolder=function(holder,position)
    local view=holder.itemView.tag
    local item=tools[position+1]
    if item
      view.bsb_name.text=item.name
      view.bsb_img.setImageDrawable(getFileDrawable("imgs/"..item.icon))

      view.bsb_mcd.onClick=function()
        toolbs.dismiss()
        tool=tools[position+1].tool
        if tool==toolList.CircleT3P
          guide_card_set(0,"选择圆上一点(0/3)") resetTool()
         elseif tool=="MidP"
          guide_card_set(0,"选择一点") resetTool()
         elseif tool=="Intersect"
          guide_card_set(0,"选择一个几何对象") resetTool()
         elseif tool=="Ellipse"
          guide_card_set(0,"选择一个焦点") resetTool()
         elseif tool=="Hyperbola"
          guide_card_set(0,"选择一个焦点") resetTool()
         elseif tool=="Parabola"
          guide_card_set(0,"选择一个焦点") resetTool()
         elseif tool=="AngleBisector"
          guide_card_set(0,"选择一个点") resetTool()
         elseif tool=="Tangent"
          guide_card_set(0,"选择一个点") resetTool()

        end
      end

    end
  end
})

tool_rec.setAdapter(tool_adp)
tool_rec.layoutManager=StaggeredGridLayoutManager(5,1)

--瀑布流列表视图
tool_adp.submitList(tools)

