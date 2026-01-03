
--mode属性
--0 默认有边框
--1 无边框，有阴影
--choose选择
--chose关闭
--icon 图标 写res/图片名.png的图片名不要.png
MaterialChip=class{
  name="MaterialChip",
  extends=Chip,
  constructor=function(super,context,attrs,defStyle)
    return super(context)
  end,
  fields={
    text="Chip",
  },
  methods={
    setMode=function(view,s)
    if s==0 then
      return view
    elseif s==1 then
      return view.setChipStrokeWidth(0).setChipStrokeWidth(0).setElevation(8)
    end
    end,
    setChoose=function(view,s)
    if s then
      return view.setCheckable(true).setCheckedIconEnabled(true).setCheckedIconResource(R.drawable.ic_m3_chip_check)
    end
    end,
    setClose=function(view,s)
    if s then
      return view.setCloseIconEnabled(true).setOnCloseIconClickListener{onClick=function(v) v.Visibility=8 end}
    end
    end,
    setIcon=function(view,s)
      return view.setChipIcon(getFileDrawable(tostring(s)))
    end,
  },
}