--没人要的💩山


local lambda_=g1:getIntersectPointWithLine2d_lambda(g2)
local p={g2:indexPoint(lambda_[1]),g2:indexPoint(lambda_[2])}
local dis={gtp-p[1],gtp-p[2]}
if dis[1] <= dis[2] and dis[1]*graph.lam < 75
  if lambda_[1]<lambda_[2]
    gmt:intersectOfCL(toolInfo.P.newName(),toolInfo.Intersect.g1,toolInfo.Intersect.g2,1)
   else
    gmt:intersectOfCL(toolInfo.P.newName(),toolInfo.Intersect.g1,toolInfo.Intersect.g2,2)
  end
 elseif dis[2] <= dis[1] and dis[2]*graph.lam < 75
  if lambda_[1]<lambda_[2]
    gmt:intersectOfCL(toolInfo.P.newName(),toolInfo.Intersect.g1,toolInfo.Intersect.g2,2)
   else
    gmt:intersectOfCL(toolInfo.P.newName(),toolInfo.Intersect.g1,toolInfo.Intersect.g2,1)
  end
end





function list_add()
  local madb=MaterialAlertDialogBuilder(this)
  madb.setTitle("添加")
  madb.setView(loadlayout({
    LinearLayout,
    orientation="1",
    {
      MaterialButtonToggleGroup,
      id="MBTG",
      layout_width="wrap",
      layout_height="wrap",
      layout_gravity="center",
      singleSelection=true,
      {
        MaterialButton,
        text="几何",
        id="MBTG_几何",
        style=2130903819,
        onClick=function(v)
          add_vpg.setCurrentItem(0)
        end,
      },
      {
        MaterialButton,
        text="数值",
        id="MBTG_数值",
        style=2130903819,
        onClick=function(v)
          add_vpg.setCurrentItem(1)
        end,
      },
    },
    {Space,
      layout_height="18dp",
    },
    {
      ViewPager,
      id="add_vpg",
      layout_width="fill",
      layout_height="fill",
      pages={
        {
          LinearLayout,
          orientation="1",
          { TextInputLayout,
            layout_width="fill",
            layout_gravity="center",
            layout_margin="20dp",
            id="t1",
            hint="Name",
            boxBackgroundMode=TextInputLayout.BOX_BACKGROUND_OUTLINE,
            { TextInputEditText,
              id="内容",
              --text=文件名,
              padding="12dp";
              style=R.style.Widget_Material3_TextInputEditText_OutlinedBox_Dense,
              textSize=16,
              layout_width="fill",
            },
          },

        },
        {
          LinearLayout,
          orientation="1",
        },
      },
    },
  }))
  dialog=madb.show()

  MBTG_几何.setChecked(true)

  add_vpg.setOnPageChangeListener(ViewPager.OnPageChangeListener{
    onPageSelected=function(v)
      if v==0
        MBTG_几何.setChecked(true)
       else
        MBTG_数值.setChecked(true)
      end
    end
  })

end



