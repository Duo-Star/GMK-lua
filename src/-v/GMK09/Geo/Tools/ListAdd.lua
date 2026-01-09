function list_add()
  local madb=MaterialAlertDialogBuilder(this)
  madb.setTitle("添加")
  madb.setView(loadlayout({
    LinearLayout,
    orientation="1",
    layout_width="fill",
    layout_height="fill",
    {Space,
      layout_height="18dp",
    },


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





  }))
  dialog=madb.show()



end


