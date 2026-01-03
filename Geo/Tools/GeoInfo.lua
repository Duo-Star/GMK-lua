--这是展示某一个对象的自我属性

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
        strokeWidth=0,
        layout_marginTop="12dp",
        layout_width="36dp",
        layout_height="4dp",
        layout_gravity="center",
        cardBackgroundColor=themeUtil.getColorOnSurface(),
        alpha=0.8,
      },
      { MaterialTextView,
        layout_marginTop="14dp",
        layout_marginLeft="20dp",
        layout_marginRight="20dp",
        layout_gravity="center|left",
        textSize="26sp",
        textColor=cc.c.on_background,
        Typeface=jost_book_typeface,
        text=class..": "..name,
      },
      { MaterialTextView,
        layout_marginLeft="20dp",
        layout_marginRight="20dp",
        layout_gravity="center|left",
        textSize="14sp",
        Typeface=jost_book_typeface,
        text=""..gmt:translateToChinese(name),
      },

      --
      { LinearLayoutCompat,
        layout_marginTop="0dp",
        layout_marginLeft="20dp",
        layout_marginRight="20dp",
        layout_width="fill",
        layout_height="wrap",
        gravity="center",
        { MaterialTextView,
          text="显示",
          textSize="16sp",
          Typeface=jost_book_typeface,
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
        layout_marginTop="-10dp",
        layout_marginLeft="20dp",
        layout_marginRight="20dp",
        layout_width="fill",
        layout_height="wrap",
        gravity="center",
        { MaterialTextView,
          text="自由(免费",
          textSize="16sp",
          Typeface=jost_book_typeface,
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
        layout_marginTop="-10dp",
        layout_marginLeft="20dp",
        layout_marginRight="20dp",
        layout_width="fill",
        layout_height="wrap",
        gravity="center",
        { MaterialTextView,
          text="标签",
          textSize="16sp",
          Typeface=jost_book_typeface,
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
        Typeface=jost_book_typeface,
        layout_marginTop="2dp",
        layout_marginLeft="20dp",
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
      textSize="15dp",
      Typeface=jost_book_typeface,
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
    refreshList()
  end
end

