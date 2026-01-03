

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



resetTool=function()
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



tools={
  {name="中点",icon="MidP",tool="MidP"},
  {name="交点",icon="Intersect",tool="Intersect"},

  ---
  {name="角平分线",icon="AngleBisector",tool="AngleBisector"},
  {name="切线",icon="Tangent",tool="Tangent"},
  {name="中垂线",icon="PerpendicularBisector",tool="PerpendicularBisector"},

  ---
  {name="三点圆",icon="CircleT3P",tool="CircleT3P"},
  {name="椭圆",icon="Ellipse",tool="Ellipse"},
  {name="双曲线",icon="Hyperbola",tool="Hyperbola"},
  {name="抛物线",icon="Parabola",tool="Parabola"},


}



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

    P1="",
    P2="",
    P3="",

  },
  Parabola={
    F="",
    L="",
  },
  AngleBisector={
    P1="",
    P2="",
    P3="",
  },
  Tangent={
    P="",
    geo=""
  },



}






