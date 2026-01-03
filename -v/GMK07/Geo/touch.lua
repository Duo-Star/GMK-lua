TC={}
TC.tcP=function(gtp,dx,todo)
  for i=#gmt.step,1,-1 do
    local a=gmt.step[i]--名称
    local item=data[a]
    local class=getmetatable(item)--获得到对象的类
    if class==Vector
      local dx_=(#(gtp-item))*graph.lam
      if dx_<dx todo(a,dx_) end--触发 回调函数 并传入 触摸对象名称 和 触摸误差
    end
  end
end




surface.onTouch =function(v, event)
  graph.onTouch(v, event)--提供回调接口🎃🎃🎃🎃🎃
  local PointerCount = event.getPointerCount()
  graph.tpn=PointerCount
  --为每个手指记录触摸坐标💌
  for i = 1, PointerCount do
    if PointerCount==2
      graph.tps[i]=Vector(event.getX(i-1),event.getY(i-1))
     elseif PointerCount==1
      local p=Vector(event.getX(i-1),event.getY(i-1))
      graph.tps[1]=p
      graph.tps[2]=false
    end
  end
  if graph.debugMode print_(""..type(graph.tps[1])) end
  --手指碰到屏幕👍
  if(event.getActionMasked() == MotionEvent.ACTION_DOWN)
    if graph.debugMode print_("手指碰到屏幕") end
    graph.o_0=graph.o
    graph.tps_0[1]=Vector(event.getX(1-1),event.getY(1-1))
    --触摸点在坐标系中的坐标
    local gtp=Vector((graph.tps[1].x-graph.o.x)/graph.lam,-(graph.tps[1].y-graph.o.y)/graph.lam)
    graph.onTouch_ACTION_DOWN(gtp)--触发监听器
    if tool==toolList.Move--选择移动工具
      cleanSelect()--清除已选择的项
      showInfo=false--停止显示标签
      toolInfo.M.DOWN.HasMove=false--初始化无位移
      for i=#gmt.step,1,-1 do
        local a=gmt.step[i]
        local item=data[a]
        local class=getmetatable(item)--获得到对象的类
        if class==Vector
          local dx=(#(gtp-item))*graph.lam-5
          if dx<70 and dx<toolInfo.M.DOWN.dis
            toolInfo.M.DOWN.To=a
            toolInfo.M.DOWN.dis=dx
          end
         elseif class==Circle
          local dx=(math.abs(#(gtp-item.p)-item.r))*graph.lam+12.3
          if dx<70 and dx<toolInfo.M.DOWN.dis
            toolInfo.M.DOWN.To=a
            toolInfo.M.DOWN.dis=dx
          end
         elseif class==Line
          local dx=(item:getPdisL(gtp)*graph.lam)+12.3
          if dx<70 and dx<toolInfo.M.DOWN.dis
            toolInfo.M.DOWN.To=a
            toolInfo.M.DOWN.dis=dx
          end
         elseif class==Conic0
          local dx=(item:getPdisConic0(gtp)*graph.lam)+12.3
          if dx<70 and dx<toolInfo.M.DOWN.dis
            toolInfo.M.DOWN.To=a
            toolInfo.M.DOWN.dis=dx
          end
        end
      end
     elseif tool==toolList.Point--选择点工具😋😋😋😋😋😋😋😋😋😋😋😋😋
      for i=#gmt.step,1,-1 do
        local a=gmt.step[i]
        local item=data[a]
        local class=getmetatable(item)--获得到对象的类
        if class==Vector
          local dx=(#(gtp-item))*graph.lam-5
          if dx<70 and dx<toolInfo.P.DOWN.dis
            toolInfo.P.DOWN.To=a
            toolInfo.P.DOWN.dis=dx
          end
         elseif class==Circle
          local dx=(math.abs(#(gtp-item.p)-item.r))*graph.lam+12.3
          if dx<70 and dx<toolInfo.P.DOWN.dis
            toolInfo.P.DOWN.To=a
            toolInfo.P.DOWN.dis=dx
            toolInfo.P.DOWN.index=item:getIndex(gtp)
          end
         elseif class==Line
          local dx=(item:getPdisL(gtp)*graph.lam)+12.3
          if dx<70 and dx<toolInfo.P.DOWN.dis
            toolInfo.P.DOWN.To=a
            toolInfo.P.DOWN.dis=dx
            toolInfo.P.DOWN.index=item:getIndex(gtp)
          end
        end
      end
      if toolInfo.P.DOWN.To
        local class=gmt[toolInfo.P.DOWN.To].class
        if class=="Line"
          gmt:index_Line(newName_P(),toolInfo.P.DOWN.To,toolInfo.P.DOWN.index)
         elseif class=="Circle"
          gmt:index_Circle(newName_P(),toolInfo.P.DOWN.To,toolInfo.P.DOWN.index)
        end
       else
        local name=newName_P()
        gmt:addPoint(name,gtp)
        cleanSelect() selectGeo(name)

      end

     elseif tool==toolList.Line--选择直线工具💰💰💰💰💰💰💰
      TC.tcP(gtp,75,function(a,dx)--构造直线
        if toolInfo.L.DOWN.P1~=""
          local name=newName_L()
          toolInfo.L.DOWN.P2=a
          gmt:addLine(name,toolInfo.L.DOWN.P1,toolInfo.L.DOWN.P2)
          toolInfo.L.DOWN.P1=""
          toolInfo.L.DOWN.P2=""
          cleanSelect() guide_card_set(1,"直线"..name.."已创建完毕") guide_card_dismiss(1000)
         else
          toolInfo.L.DOWN.P1=a
          selectGeo(a) guide_card_set(0.5,"选择直线上另外一点") guide_card_appear()
        end
      end)
     elseif tool==toolList.Circle
      TC.tcP(gtp,75,function(a,dx)
        if toolInfo.C.DOWN.P1~="" and toolInfo.C.UP.afterP1
          local name=newName_C()
          toolInfo.C.DOWN.P2=a
          gmt:addCircle(name,toolInfo.C.DOWN.P1,toolInfo.C.DOWN.P2)
          toolInfo.C.DOWN.P1=""
          toolInfo.C.DOWN.P2=""
          cleanSelect() guide_card_set(1,"圆周"..name.."已创建完毕") guide_card_dismiss(1000)
         else
          toolInfo.C.DOWN.P1=a
          toolInfo.C.UP.afterP1=false
          selectGeo(a) guide_card_set(0.5,"选择圆周上一点") guide_card_appear()
        end
      end)
     elseif tool=="MidP"
      TC.tcP(gtp,75,function(a,dx)
        if toolInfo.MidP.P1~=""
          local name=newName_P()
          toolInfo.MidP.P2=a
          gmt:midP(name,toolInfo.MidP.P1,toolInfo.MidP.P2)
          toolInfo.MidP.P1=""
          toolInfo.MidP.P2=""
          cleanSelect() guide_card_set(1,"中点"..name.."已创建完毕") guide_card_dismiss(1000) tool=toolList.Move toolTab.selectTab(toolTabList[1])
         else
          toolInfo.MidP.P1=a
          selectGeo(a) guide_card_set(0.5,"选择另一点") guide_card_appear()
        end
      end)
     elseif tool==toolList.CircleT3P
      TC.tcP(gtp,75,function(a,dx)
        if toolInfo.CircleT3P.DOWN.P1~="" and toolInfo.CircleT3P.DOWN.P2~=""
          local name=newName_C()
          toolInfo.CircleT3P.DOWN.P3=a
          gmt:addCircleFrom3P(name,toolInfo.CircleT3P.DOWN.P1,toolInfo.CircleT3P.DOWN.P2,toolInfo.CircleT3P.DOWN.P3)
          toolInfo.CircleT3P.DOWN.P1=""
          toolInfo.CircleT3P.DOWN.P2=""
          toolInfo.CircleT3P.DOWN.P3=""
          cleanSelect() guide_card_set(1,"圆周"..name.."已创建完毕") guide_card_dismiss(1000)
          tool=toolList.Move
          toolTab.selectTab(toolTabList[1])
         elseif toolInfo.CircleT3P.DOWN.P1~="" and toolInfo.CircleT3P.DOWN.P2==""
          toolInfo.CircleT3P.DOWN.P2=a
          selectGeo(a) guide_card_set(0.66,"选择圆周上一点(2/3)") guide_card_appear()
         elseif toolInfo.CircleT3P.DOWN.P1=="" and toolInfo.CircleT3P.DOWN.P2==""
          toolInfo.CircleT3P.DOWN.P1=a
          selectGeo(a) guide_card_set(0.33,"选择圆周上一点(1/3)") guide_card_appear()
        end
      end)
     elseif tool=="Intersect"
      for i=#gmt.step,1,-1 do
        local a=gmt.step[i]
        local item=data[a]
        local class=getmetatable(item)--获得到对象的类
        if class==Circle
          local dx=(math.abs(#(gtp-item.p)-item.r))*graph.lam+10
          if dx<70 and dx<toolInfo.Intersect.dis selectGeo(a)
            if toolInfo.Intersect.g1==""
              toolInfo.Intersect.g1=a guide_card_set(0.5,"选择另外的几何对象")
             elseif toolInfo.Intersect.g1~="" and toolInfo.Intersect.g2==""
              toolInfo.Intersect.g2=a
            end
            toolInfo.Intersect.dis=dx
          end
         elseif class==Line
          local dx=(item:getPdisL(gtp)*graph.lam)+10
          if dx<70 and dx<toolInfo.Intersect.dis selectGeo(a)
            if toolInfo.Intersect.g1==""
              toolInfo.Intersect.g1=a guide_card_set(0.5,"选择另外的几何对象")
             elseif toolInfo.Intersect.g1~="" and toolInfo.Intersect.g2==""
              toolInfo.Intersect.g2=a
            end
            toolInfo.Intersect.dis=dx
          end
        end
      end
      toolInfo.Intersect.dis=1e5
      if toolInfo.Intersect.g1~="" and toolInfo.Intersect.g2~=""
        local g1,g2=data[toolInfo.Intersect.g1],data[toolInfo.Intersect.g2]
        local c1,c2=gmt[toolInfo.Intersect.g1].class,gmt[toolInfo.Intersect.g2].class
        if c1=="Line" and c2=="Line"
          gmt:intersectOfLL(newName_P(),toolInfo.Intersect.g1,toolInfo.Intersect.g2)
          guide_card_set(1,"已获得两条直线的交点") guide_card_dismiss(1000)tool=toolList.Move toolTab.selectTab(toolTabList[1])
         elseif c1=="Circle" and c2=="Circle"
          gmt:intersectOfCC(newName_P(),toolInfo.Intersect.g1,toolInfo.Intersect.g2,1)
          gmt:intersectOfCC(newName_P(),toolInfo.Intersect.g1,toolInfo.Intersect.g2,2)
          guide_card_set(1,"已获得两个圆周的交点") guide_card_dismiss(1000)tool=toolList.Move toolTab.selectTab(toolTabList[1])
         elseif c1=="Circle" and c2=="Line"
          gmt:intersectOfCL(newName_P(),toolInfo.Intersect.g1,toolInfo.Intersect.g2,1)
          gmt:intersectOfCL(newName_P(),toolInfo.Intersect.g1,toolInfo.Intersect.g2,2)
          guide_card_set(1,"已获得圆和直线的交点") guide_card_dismiss(1000)tool=toolList.Move toolTab.selectTab(toolTabList[1])
         elseif c1=="Line" and c2=="Circle"
          gmt:intersectOfCL(newName_P(),toolInfo.Intersect.g2,toolInfo.Intersect.g1,1)
          gmt:intersectOfCL(newName_P(),toolInfo.Intersect.g2,toolInfo.Intersect.g1,2)
          guide_card_set(1,"已获得直线和圆的交点") guide_card_dismiss(1000)tool=toolList.Move toolTab.selectTab(toolTabList[1])
        end
        toolInfo.Intersect={ g1="",g2="",dis=1e5 }
        cleanSelect()
      end
     elseif tool=="Ellipse"
      TC.tcP(gtp,75,function(a,dx)
        if toolInfo.Ellipse.DOWN.P1~="" and toolInfo.Ellipse.DOWN.P2~=""
          local name=newName_C()
          toolInfo.Ellipse.DOWN.P3=a
          gmt:addEllipse(name,toolInfo.Ellipse.DOWN.P1,toolInfo.Ellipse.DOWN.P2,toolInfo.Ellipse.DOWN.P3)
          toolInfo.Ellipse.DOWN.P1=""
          toolInfo.Ellipse.DOWN.P2=""
          toolInfo.Ellipse.DOWN.P3=""
          cleanSelect() guide_card_set(1,"椭圆"..name.."已创建完毕") guide_card_dismiss(1000)
          tool=toolList.Move
          toolTab.selectTab(toolTabList[1])
         elseif toolInfo.Ellipse.DOWN.P1~="" and toolInfo.Ellipse.DOWN.P2==""
          toolInfo.Ellipse.DOWN.P2=a
          selectGeo(a) guide_card_set(0.66,"选择椭圆上一点(2/3)") guide_card_appear()
         elseif toolInfo.Ellipse.DOWN.P1=="" and toolInfo.Ellipse.DOWN.P2==""
          toolInfo.Ellipse.DOWN.P1=a
          selectGeo(a) guide_card_set(0.33,"选择另外的焦点(1/3)") guide_card_appear()
        end
      end)
     elseif tool=="Hyperbola"
      TC.tcP(gtp,75,function(a,dx)
        if toolInfo.Hyperbola.DOWN.P1~="" and toolInfo.Hyperbola.DOWN.P2~=""
          local name=newName_C()
          toolInfo.Hyperbola.DOWN.P3=a
          gmt:addHyperbola(name,toolInfo.Hyperbola.DOWN.P1,toolInfo.Hyperbola.DOWN.P2,toolInfo.Hyperbola.DOWN.P3)
          toolInfo.Hyperbola.DOWN.P1=""
          toolInfo.Hyperbola.DOWN.P2=""
          toolInfo.Hyperbola.DOWN.P3=""
          cleanSelect() guide_card_set(1,"双曲线"..name.."已创建完毕") guide_card_dismiss(1000)
          tool=toolList.Move
          toolTab.selectTab(toolTabList[1])
         elseif toolInfo.Hyperbola.DOWN.P1~="" and toolInfo.Hyperbola.DOWN.P2==""
          toolInfo.Hyperbola.DOWN.P2=a
          selectGeo(a) guide_card_set(0.66,"选择双曲线上一点(2/3)") guide_card_appear()
         elseif toolInfo.Hyperbola.DOWN.P1=="" and toolInfo.Hyperbola.DOWN.P2==""
          toolInfo.Hyperbola.DOWN.P1=a
          selectGeo(a) guide_card_set(0.33,"选择另外的焦点(1/3)") guide_card_appear()
        end
      end)
     elseif tool=="Parabola"
      if toolInfo.Parabola.F~=""
        for i=#gmt.step,1,-1 do
          local a=gmt.step[i]
          local item=data[a]
          local class=getmetatable(item)--获得到对象的类
          if class==Line and (item:getPdisL(gtp)*graph.lam)+10<70
            local name=newName_C()
            toolInfo.Parabola.L=a
            gmt:addParabola(name,toolInfo.Parabola.F,toolInfo.Parabola.L)
            print_(toolInfo.Parabola.F)
            print_(toolInfo.Parabola.L)
            toolInfo.Parabola.F=""
            toolInfo.Parabola.L=""
            cleanSelect() guide_card_set(1,"抛物线"..name.."已创建完毕") guide_card_dismiss(1000) tool=toolList.Move toolTab.selectTab(toolTabList[1])
          end
        end
       else
        TC.tcP(gtp,75,function(a,dx)
          toolInfo.Parabola.F=a
          selectGeo(a) guide_card_set(0.5,"选择一条直线作为准线") guide_card_appear()
        end)
      end



    end


   elseif(event.getActionMasked() == MotionEvent.ACTION_POINTER_DOWN && PointerCount <= 2)
    --print_("次要手指碰到屏幕")--🐟🐟🐟🐟🐟
    graph.tps_0[2]=Vector(event.getX(2-1),event.getY(2-1))
    graph.tpl_0 = #(graph.tps[1] - graph.tps[2])
    graph.lam_0 = graph.lam


    --手指移动🖐🖐🖐🖐🖐
   elseif(event.getActionMasked() == MotionEvent.ACTION_MOVE)
    --触摸点在坐标系中的坐标
    local gtp=Vector((graph.tps[1].x-graph.o.x)/graph.lam,-(graph.tps[1].y-graph.o.y)/graph.lam)

    showInfo=false--移动中不显示标签
    if tool==toolList.Move
      toolInfo.M.DOWN.HasMove=true--他真的动了
      local item=data[toolInfo.M.DOWN.To]
      local gmt_=gmt[toolInfo.M.DOWN.To]
      local HUA=false
      if item--首先得有这个对象
        if gmt_.free--其次，它是免费的
          if gmt_.class=="Point"
            if gmt_.method=="new"
              gmt:alterFactor(toolInfo.M.DOWN.To,{gtp})
             elseif gmt_.method=="index_Line"
              gmt:alterFactor(toolInfo.M.DOWN.To,{gmt_.factor[1], data[gmt_.factor[1]]:getIndex(gtp)})
             elseif gmt_.method=="index_Circle"
              gmt:alterFactor(toolInfo.M.DOWN.To,{gmt_.factor[1], data[gmt_.factor[1]]:getIndex(gtp)})
             else HUA=true
            end
           else HUA=true
          end
        
        end
       else HUA=true
      end
      if HUA--下方是实现滑动的💩💩💩山
        local dtp= graph.tps[1]-graph.tps_0[1]
        graph.o = graph.o_0 + dtp*0.75--滑动灵敏度🍎
        if(PointerCount >= 2)
          graph.tpl = #(graph.tps[1] - graph.tps[2])
          local dtpl = graph.tpl - graph.tpl_0
          --缩放存在限度🍎🍎🍎🍎
          if graph.lam_0*(dtpl/graph.tpl_0+1)>0.5 and graph.lam_0*(dtpl/graph.tpl_0+1)<3000
            graph.lam=graph.lam_0*(dtpl/graph.tpl_0+1)
            guide_card_set((graph.lam-0.5)/(3000-0.5),"缩放:"..math.floor(graph.lam*10)/10) guide_card_appear()
            toolInfo.M.zoommmmm=true
          end
        end
      end
    end

   elseif(event.getActionMasked() == MotionEvent.ACTION_POINTER_UP)
    graph.o_0=graph.o
    graph.tps_0[1]=Vector(event.getX(1-1),event.getY(1-1))

   elseif(event.getActionMasked() == MotionEvent.ACTION_UP)
    if tool==toolList.Move and toolInfo.M.DOWN.To
      if not(toolInfo.M.DOWN.HasMove)
        showInfo=toolInfo.M.DOWN.To
      end
      selectGeo(toolInfo.M.DOWN.To)
    end
    toolInfo.M.DOWN.To=nil
    toolInfo.M.DOWN.dis=1e5
    toolInfo.P.DOWN.To=nil
    toolInfo.P.DOWN.dis=1e5
    toolInfo.C.UP.afterP1=true
    if toolInfo.M.zoommmmm
      guide_card_dismiss(1000)
      toolInfo.M.zoommmmm=false
    end


  end
  return true
end


