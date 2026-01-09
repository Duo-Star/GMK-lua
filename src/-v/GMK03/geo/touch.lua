surface.onTouch =function(v, event)

  graph.onTouch(v, event)
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
        end
      end
     elseif tool==toolList.Point--选择点工具
      gmt:addPoint(newPname(),gtp)
     elseif tool==toolList.Line
      for i=#gmt.step,1,-1 do
        local a=gmt.step[i]--名称
        local item=data[a]
        local class=getmetatable(item)--获得到对象的类
        if class==Vector
          local dx=(#(gtp-item))*graph.lam-5
          if dx<70
            if toolInfo.L.DOWN.P1~=""
              local name=toolInfo.L.newName()
              toolInfo.L.DOWN.P2=a
              gmt:addLine(name,toolInfo.L.DOWN.P1,toolInfo.L.DOWN.P2)
              toolInfo.L.DOWN.P1=""
              toolInfo.L.DOWN.P2=""
              cleanSelect() guide_card_set(1,"直线"..name.."已创建完毕") guide_card_dismiss(1000)
             else
              toolInfo.L.DOWN.P1=a
              selectGeo(a) guide_card_set(0.5,"选择直线上另外一点") guide_card_appear()
            end
          end
        end
      end
     elseif tool==toolList.Circle
      for i=#gmt.step,1,-1 do
        local a=gmt.step[i]--名称
        local item=data[a]
        local class=getmetatable(item)--获得到对象的类
        if class==Vector
          local dx=(#(gtp-item))*graph.lam-5
          if dx<70
            if toolInfo.C.DOWN.P1~=""
              local name=toolInfo.C.newName()
              toolInfo.C.DOWN.P2=a
              gmt:addCircle(name,toolInfo.C.DOWN.P1,toolInfo.C.DOWN.P2)
              toolInfo.C.DOWN.P1=""
              toolInfo.C.DOWN.P2=""
              cleanSelect() guide_card_set(1,"圆周"..name.."已创建完毕") guide_card_dismiss(1000)
             else
              toolInfo.C.DOWN.P1=a
              selectGeo(a) guide_card_set(0.5,"选择圆周上一点") guide_card_appear()
            end
          end
        end
      end
     elseif tool==toolList.CircleT3P
      for i=#gmt.step,1,-1 do
        local a=gmt.step[i]--名称
        local item=data[a]
        local class=getmetatable(item)--获得到对象的类
        if class==Vector
          local dx=(#(gtp-item))*graph.lam-5
          if dx<70
            if toolInfo.CircleT3P.DOWN.P1~="" and toolInfo.CircleT3P.DOWN.P2~=""
              local name=toolInfo.C.newName()
              toolInfo.CircleT3P.DOWN.P3=a
              gmt:addCircleFrom3P(name,toolInfo.CircleT3P.DOWN.P1,toolInfo.CircleT3P.DOWN.P2,toolInfo.CircleT3P.DOWN.P3)
              toolInfo.CircleT3P.DOWN.P1=""
              toolInfo.CircleT3P.DOWN.P2=""
              toolInfo.CircleT3P.DOWN.P3=""
              cleanSelect() guide_card_set(1,"圆周"..name.."已创建完毕,已切换至移动工具") guide_card_dismiss(1500)
              tool=toolList.Move
              toolTab.selectTab(toolTabList[1])
             elseif toolInfo.CircleT3P.DOWN.P1~="" and toolInfo.CircleT3P.DOWN.P2==""
              toolInfo.CircleT3P.DOWN.P2=a
              selectGeo(a) guide_card_set(0.66,"选择圆周上一点(2/3)") guide_card_appear()
             elseif toolInfo.CircleT3P.DOWN.P1=="" and toolInfo.CircleT3P.DOWN.P2==""
              toolInfo.CircleT3P.DOWN.P1=a
              selectGeo(a) guide_card_set(0.33,"选择圆周上一点(1/3)") guide_card_appear()
            end
          end
        end
      end




    end


   elseif(event.getActionMasked() == MotionEvent.ACTION_POINTER_DOWN && PointerCount <= 2)
    --print_("次要手指碰到屏幕")
    graph.tps_0[2]=Vector(event.getX(2-1),event.getY(2-1))
    graph.tpl_0 = #(graph.tps[1] - graph.tps[2])
    graph.lam_0 = graph.lam

    --手指移动🖐
   elseif(event.getActionMasked() == MotionEvent.ACTION_MOVE)
    --触摸点在坐标系中的坐标
    local gtp=Vector((graph.tps[1].x-graph.o.x)/graph.lam,-(graph.tps[1].y-graph.o.y)/graph.lam)

    showInfo=false--移动中不显示标签
    if tool==toolList.Move
      toolInfo.M.DOWN.HasMove=true--他真的动了
      local item=data[toolInfo.M.DOWN.To]
      if item and gmt[toolInfo.M.DOWN.To].free
        local class=getmetatable(item)
        if class==Vector
          gmt:alterFactor(toolInfo.M.DOWN.To,{gtp})
        end
       else--下方是实现滑动的💩山
        local dtp= graph.tps[1]-graph.tps_0[1]
        graph.o = graph.o_0 + dtp*0.75--滑动灵敏度🍎
        if(PointerCount >= 2)
          graph.tpl = #(graph.tps[1] - graph.tps[2])
          local dtpl = graph.tpl - graph.tpl_0
          graph.lam=graph.lam_0*(dtpl/graph.tpl_0+1)
        end
      end



     elseif tool==toolList.Line




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



  end
  return true
end


