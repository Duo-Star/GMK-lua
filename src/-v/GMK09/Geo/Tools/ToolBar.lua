--这里是屏幕下方的工具选择框

toolList={
  Move="Move",
  Point="Point",
  Line="Line",
  Circle="Circle",
  CircleT3P="CircleT3P",
}
tool=toolList.Move

toolTabList={
  toolTab.newTab().setIcon(getFileDrawable("imgs/Move")).setId(1),
  toolTab.newTab().setIcon(getFileDrawable("imgs/Point")).setId(2),
  toolTab.newTab().setIcon(getFileDrawable("imgs/Line")).setId(3),
  toolTab.newTab().setIcon(getFileDrawable("imgs/Circle")).setId(4),

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
    resetTool()
  end
}
