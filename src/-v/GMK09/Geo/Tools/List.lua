






listDialogLay=
{ LinearLayout,
  layout_width="fill",
  orientation='1',
  { MaterialCardView,
    strokeWidth=0,
    layout_marginTop="12dp",
    layout_width="36dp",
    layout_height="4dp",
    layout_gravity="center",
    cardBackgroundColor=themeUtil.getColorOnSurface(),
    alpha=0.8,
  },
  {
    LinearLayoutCompat,
    layout_width="fill",
    layout_height="wrap",
    gravity="center",
    { MaterialTextView,
      layout_marginTop="8dp",
      layout_marginLeft="15dp",
      layout_marginRight="20dp",
      layout_gravity="center|left",
      textSize="26sp",
      textColor=cc.c.on_background,
      Typeface=jost_book_typeface,
      text="做图步序",
    },
    {
      Space,
      layout_weight="1",
    },
    {MaterialCardView,
      layout_width='45dp',
      layout_height='45dp',
      CardBackgroundColor=0,
      radius="30dp",strokeColor=0,strokeWidth=0,
      cardElevation="0dp",
      layout_margin='5dp';
      onClick=function()
        list_add()
      end,
      { AppCompatImageView,
        layout_width='25dp',
        layout_height='25dp',
        layout_gravity='center',
        src="res/imgs/add.png",
        layout_margin='3dp',
        colorFilter=primaryc,
      };
    },
  },

  { RecyclerView,
    id="list_rec",
    layout_width="fill",
    layout_height="fill",
    layout_marginBottom='20dp',
  },

}
listDialog = BottomSheetDialog(activity)
listDialog.setContentView(loadlayout(listDialogLay))




list_item={
  LinearLayout,
  Orientation=0,
  paddingTop="16dp",
  layout_width="fill",
  layout_height="wrap",
  {MaterialCardView,
    strokeColor=0,
    strokeWidth=0,
    layout_marginLeft="16dp",
    h="fill",w="5dp",radius="16dp",id="cd",
    CardBackgroundColor=cc.c.primary,
  },
  {LinearLayout,
    layout_marginLeft="10dp",
    layout_marginRight="16dp",
    Orientation=1,
    --layoutTransition=LayoutTransition().enableTransitionType(LayoutTransition.CHANGING),
    {TextView,
      textSize="19sp",
      textColor=cc.c.primary,
      id="name",Typeface=jost_book_typeface,
    },
    {TextView,
      id="context",layout_marginTop="5dp",
      textSize="14sp",Typeface=jost_book_typeface,
    },
  },
  {
    Space,
    layout_weight="1",
  },
  {MaterialCardView,
    strokeWidth=0,CardBackgroundColor=0,radius="20dp",
    layout_width="30dp",layout_gravity="center|right",
    layout_height="30dp",layout_margin='13dp',
    onClick=function() end,id="btnnn",
    { AppCompatImageView,
      layout_width="26dp",
      layout_height="26dp",
      colorFilter=primaryc,
      src="res/settings.png",
      layout_gravity="center",
    },
  },

}


function refreshList()


  list_adp=LuaDiffRecyclerAdapter(LuaDiffRecyclerAdapter.LuaInterface {
    getItemViewType=function(position)
      return int(0)
    end,
    onCreateViewHolder=function(parent,types)
      local tag={}
      local view= loadlayout(list_item,tag,parent.class)
      view.tag=tag
      return view
    end,
    areContentsTheSame=function(old,new)
      return old.name==new.name
    end,
    areItemsTheSame=function(old,new)
      return old.name==new.name
    end,
    onBindViewHolder=function(holder,position)
      local view=holder.itemView.tag
      local item=gmt.step[position+1]
      if item
        view.name.text=item
        view.context.text=gmt:translateToChinese_WithNoName(item)
        view.cd.setCardBackgroundColor(graph.color[gmt[item].g.color][1])
        view.btnnn.onClick=function()
          showInfoDialog(item)
        end
      end
    end
  })
  list_rec.setAdapter(list_adp)
  list_rec.layoutManager=StaggeredGridLayoutManager(1,1)
  list_adp.submitList(gmt.step)
  task(10,function()
    list_adp.notifyItemRangeChanged(0, list_adp.getItemCount())
  end)









end


