function 转0x(a)
  if not a:find("#") then
    return 0xff000000
  end
  if #a==7 then
    aa=a:match("#(.+)")
    aaa=tonumber("0xff"..aa)
   else
    aa=a:match("#(.+)")
    aaa=tonumber("0x"..aa)
  end
  return aaa
end
paths={}
currentAngle=0
曲线控制点={}
当前位置={0,0}

function svg2path(s)
  w,h=s:match("viewBox=\"0 0 (%d+) (%d+)\"")

  缩放w=activity.getWidth()/w
  缩放h=activity.getHeight()/h
  for p in string.gmatch(s,"<path(.-)/>") do
    local d=p:match("d=\"(.-)\"")
    local colors=转0x(p:match("fill=\"(.-)\""))
    local path = Path()--构建路径
    --path.setFillType(FillType.INVERSE_EVEN_ODD)
    for i=1,#d do
      local o=d:sub(i,i)
      if o=="M" then
        local x=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,x_len2=d:find("%-?%d+%.*%d*",i)
        i=x_len2+1
        local y=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,y_len2=d:find("%-?%d+%.*%d*",i)
        i=y_len2+1
        当前位置={x,y}
        path.moveTo(x,y)
       elseif o=="m" then
        local x=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,x_len2=d:find("%-?%d+%.*%d*",i)
        i=x_len2+1
        local y=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,y_len2=d:find("%-?%d+%.*%d*",i)
        i=y_len2+1
        当前位置[1]=当前位置[1]+x
        当前位置[2]=当前位置[2]+y
        path.rMoveTo(x,y)
       elseif o=="L" then
        local x=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,x_len2=d:find("%-?%d+%.*%d*",i)
        i=x_len2+1
        local y=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,y_len2=d:find("%-?%d+%.*%d*",i)
        i=y_len2+1
        当前位置={x,y}
        path.lineTo(x,y)
       elseif o=="l" then
        local x=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,x_len2=d:find("%-?%d+%.*%d*",i)
        i=x_len2+1
        local y=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,y_len2=d:find("%-?%d+%.*%d*",i)
        i=y_len2+1
        当前位置[1]=当前位置[1]+x
        当前位置[2]=当前位置[2]+y
        path.rLineTo(x,y)
       elseif o=="H" then
        local x=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,x_len2=d:find("%-?%d+%.*%d*",i)
        i=x_len2+1
        path.lineTo(x,当前位置[2])
        当前位置[1]=x
       elseif o=="h" then
        local x=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,x_len2=d:find("%-?%d+%.*%d*",i)
        i=x_len2+1
        path.rLineTo(x,0)
        当前位置[1]=当前位置[1]+x
       elseif o=="V" then
        local y=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,y_len2=d:find("%-?%d+%.*%d*",i)
        i=y_len2+1
        path.lineTo(当前位置[1],y)
        当前位置[2]=y
       elseif o=="v" then
        local y=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,y_len2=d:find("%-?%d+%.*%d*",i)
        i=y_len2+1

        path.rLineTo(0,y)
        当前位置[2]=当前位置[2]+y
       elseif o=="C" then
        local x1=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,x_len2=d:find("%-?%d+%.*%d*",i)
        i=x_len2+1
        local y1=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,y_len2=d:find("%-?%d+%.*%d*",i)
        i=y_len2+1

        local x2=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,x_len2=d:find("%-?%d+%.*%d*",i)
        i=x_len2+1
        local y2=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,y_len2=d:find("%-?%d+%.*%d*",i)
        i=y_len2+1

        local x=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,x_len2=d:find("%-?%d+%.*%d*",i)
        i=x_len2+1
        local y=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,y_len2=d:find("%-?%d+%.*%d*",i)
        i=y_len2+1
        path.cubicTo(x1,y1,x2,y2,x,y)
        --  曲线控制点[1]=x2
        --   曲线控制点[2]=y2
        当前位置[1]=x
        当前位置[2]=y
       elseif o=="c" then
        local x1=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,x_len2=d:find("%-?%d+%.*%d*",i)
        i=x_len2+1
        local y1=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,y_len2=d:find("%-?%d+%.*%d*",i)
        i=y_len2+1

        local x2=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,x_len2=d:find("%-?%d+%.*%d*",i)
        i=x_len2+1
        local y2=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,y_len2=d:find("%-?%d+%.*%d*",i)
        i=y_len2+1

        local x=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,x_len2=d:find("%-?%d+%.*%d*",i)
        i=x_len2+1
        local y=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,y_len2=d:find("%-?%d+%.*%d*",i)
        i=y_len2+1
        path.rCubicTo(x1,y1,x2,y2,x,y)
        当前位置[1]=当前位置[1]+x
        当前位置[2]=当前位置[2]+y
        -- 曲线控制点[1]=x2
        --  曲线控制点[2]=y2
       elseif o=="S" then
        local x1=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,x_len2=d:find("%-?%d+%.*%d*",i)
        i=x_len2+1
        local y1=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,y_len2=d:find("%-?%d+%.*%d*",i)
        i=y_len2+1

        local x=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,x_len2=d:find("%-?%d+%.*%d*",i)
        i=x_len2+1
        local y=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,y_len2=d:find("%-?%d+%.*%d*",i)
        i=y_len2+1

        local controlX1, controlY1 = mirrorControlPoint(当前位置[1], 当前位置[2], x1, y1)

        path.cubicTo(controlX1, controlY1, x1, y1, x, y)
        当前位置[1]=x
        当前位置[2]=y
       elseif o=="s" then
        local x1=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,x_len2=d:find("%-?%d+%.*%d*",i)
        i=x_len2+1
        local y1=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,y_len2=d:find("%-?%d+%.*%d*",i)
        i=y_len2+1

        local x=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,x_len2=d:find("%-?%d+%.*%d*",i)
        i=x_len2+1
        local y=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,y_len2=d:find("%-?%d+%.*%d*",i)
        i=y_len2+1

        local controlX1, controlY1 = mirrorControlPoint(当前位置[1], 当前位置[2], 当前位置[1] + x1, 当前位置[2] + y1)
        local currentX = 当前位置[1] + x
        local currentY = 当前位置[2] + y
        path.rCubicTo(controlX1 - currentX, controlY1 - currentY, x1, y1, x, y)
        当前位置[1]=当前位置[1]+x
        当前位置[2]=当前位置[2]+y
       elseif o=="Q" then


        local x1=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,x_len2=d:find("%-?%d+%.*%d*",i)
        i=x_len2+1
        local y1=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,y_len2=d:find("%-?%d+%.*%d*",i)
        i=y_len2+1

        local x=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,x_len2=d:find("%-?%d+%.*%d*",i)
        i=x_len2+1
        local y=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,y_len2=d:find("%-?%d+%.*%d*",i)
        i=y_len2+1



        path.quadTo(x1,y1,x,y)
        当前位置[1]=x
        当前位置[2]=y

       elseif o=="q" then


        local x1=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,x_len2=d:find("%-?%d+%.*%d*",i)
        i=x_len2+1
        local y1=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,y_len2=d:find("%-?%d+%.*%d*",i)
        i=y_len2+1

        local x=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,x_len2=d:find("%-?%d+%.*%d*",i)
        i=x_len2+1
        local y=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,y_len2=d:find("%-?%d+%.*%d*",i)
        i=y_len2+1



        path.rQuadTo(x1,y1,x,y)
        当前位置[1]=当前位置[1]+x
        当前位置[2]=当前位置[2]+y


       elseif o == "T" then
        local x=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,x_len2=d:find("%-?%d+%.*%d*",i)
        i=x_len2+1
        local y=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,y_len2=d:find("%-?%d+%.*%d*",i)
        i=y_len2+1
        local controlX1, controlY1 = mirrorControlPoint(当前位置[1], 当前位置[2], 当前位置[1], 当前位置[2])
        path.quadTo(controlX1, controlY1, x, y)
        当前位置[1]=x
        当前位置[2]=y
       elseif o == "t" then
        local x=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,x_len2=d:find("%-?%d+%.*%d*",i)
        i=x_len2+1
        local y=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,y_len2=d:find("%-?%d+%.*%d*",i)
        i=y_len2+1
        local controlX1, controlY1 = mirrorControlPoint(当前位置[1], 当前位置[2], 当前位置[1], 当前位置[2])
        local currentX = 当前位置[1] + x
        local currentY = 当前位置[2] + y
        path.rQuadTo(controlX1 - currentX, controlY1 - currentY, x, y)

        当前位置[1]=当前位置[1]+x
        当前位置[2]=当前位置[2]+y
       elseif o=="A" then

       local currentX=当前位置[1]
       local currentY=当前位置[2]

        local rx=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,x_len2=d:find("%-?%d+%.*%d*",i)
        i=x_len2+1
        local ry=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,y_len2=d:find("%-?%d+%.*%d*",i)
        i=y_len2+1
        local xAxisRotation=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,x_len2=d:find("%-?%d+%.*%d*",i)
        i=x_len2+1
        local largeArcFlag=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,y_len2=d:find("%-?%d+%.*%d*",i)
        i=y_len2+1
        local sweepFlag=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,x_len2=d:find("%-?%d+%.*%d*",i)
        i=x_len2+1
        local y=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,y_len2=d:find("%-?%d+%.*%d*",i)
        i=y_len2+1
        local x=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
        local _,x_len2=d:find("%-?%d+%.*%d*",i)
        i=x_len2+1

        local isRelative = (o == "a")
        local startAngle = math.rad(currentAngle) -- 将角度转换为弧度
        local endAngle = math.rad(currentAngle + (isRelative and xAxisRotation or 0)) -- 计算结束角度

        -- 计算椭圆的中心和半径
        local cx = currentX + rx * math.cos(startAngle)
        local cy = currentY + ry * math.sin(startAngle)
        local radiusX = rx
        local radiusY = ry

        -- 计算起始点和终点的坐标
        local startX = currentX + radiusX * math.cos(startAngle)
        local startY = currentY + radiusY * math.sin(startAngle)
        local endX = currentX + radiusX * math.cos(endAngle)
        local endY = currentY + radiusY * math.sin(endAngle)

        -- 使用Path.arcTo绘制圆弧
        local rectF = RectF(cx - radiusX, cy - radiusY, cx + radiusX, cy + radiusY)
        path.arcTo(rectF, math.deg(startAngle), math.deg(endAngle - startAngle), false)

        当前位置[1]=x
        当前位置[2]=y



       elseif o=="Z"or o=="z" then
        path.close()

        --[[ elseif o=="S" then
      

      local x2=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
      local _,x_len2=d:find("%-?%d+%.*%d*",i)
      i=x_len2+1
      local y2=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
      local _,y_len2=d:find("%-?%d+%.*%d*",i)
      i=y_len2+1

      local x=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
      local _,x_len2=d:find("%-?%d+%.*%d*",i)
      i=x_len2+1
      local y=tonumber(d:match("%-?%d+%.*%d*",i))*缩放w
      local _,y_len2=d:find("%-?%d+%.*%d*",i)
      i=y_len2+1
      
      
      
      path.cubicTo(x2,y2,x2,y2,x,y)
      当前位置[1]=当前位置[1]
      当前位置[2]=当前位置[2]
      ]]
      end
    end
    table.insert(paths,{path,colors})
  end
end





function setSvg(ressvg)

svg2path(io.open(activity.getLuaDir(ressvg)):read("*a"))

local 图=LuaDrawable(--设置自绘制
function(画布,画笔,画板)--绘制函数=

  for k,v in pairs(paths) do
    画笔.setColor(v[2])--画笔颜色
    画笔.setStyle(画笔.Style.FILL)--设置画笔画出来的是线
    画笔.setStrokeWidth(30)--画笔宽度
    画笔.setDither(true)--渲染优化
    画笔.setAntiAlias(true)--渲染优化
    画布.drawPath(v[1],画笔)
  end
  画板.invalidateSelf()
end)
return 图

end