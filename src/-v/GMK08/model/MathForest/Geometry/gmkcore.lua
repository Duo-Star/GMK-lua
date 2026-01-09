function GMK() end
GMK={
  __call=function(_,str)
    return GMK.new(str)
  end,
  __index = {
    new=function(str)--新建 GMK
      local gmk={
        str=str or [[ξ测试句首标识 <!>\n! true\n? math.random(1,100)<=50]],
        split={},--按行分割
        steps={},--步骤函数
        random={x0=-10,x1=10,s=.05},--随机体
        N=1000,--验证总量
        n=0,--验证通过总量
        phi=0,--正确率
        critical_phi=0.9,--验证临界
        bool=false,--命题真假
        result={},--结果
        exclude_n=0,--排除的数量
      }
      return setmetatable(gmk,GMK)
    end,
    sandbox=function(str,ENV_)
      local code2 = load(str, nil, nil, ENV_)
      return code2()
    end,
    run=function(gmk,n)
      gmk.N = n or gmk.N
      gmk.split=String(gmk.str).split("\n")
      for i=1,#gmk.split do
        local item = (gmk.split[i-1])-- str
        local head = string.sub(item,1,1)-- str 句首标识
        if head == ""
         else
          if head == "$"
            GMK.run_init(gmk, item)
           elseif head == "@"
            GMK.run_constraint(gmk, item)
           elseif head == "?"
            GMK.run_inspect(gmk, item)
           elseif head == "!"
            GMK.run_exclude(gmk, item)

          end
        end
      end


      for N=1,gmk.N do
        for i=1,#gmk.steps do
          gmk.steps[i](_ENV)
        end
        local exclude
        if gmk.exclude==nil then exclude=false
         else exclude=gmk.exclude(_ENV)
        end
        if exclude --出现被排除的情况
          gmk.exclude_n=gmk.exclude_n+1
         else--正常情况
          local bool=gmk.inspect(_ENV)
          if bool gmk.n=gmk.n+1 end
local lua=(gmk.str):match("<lua>" .. "(.-)</lua>") or ""
        GMK.sandbox(lua, _ENV)
        end
        --gmk.result[N]={ bool=bool, }
        

      end

      gmk.check_n=gmk.N-gmk.exclude_n--经过检验的个数
      gmk.error_n=gmk.check_n-gmk.n--检验的其中出错的个数
      gmk.phi=gmk.n/gmk.check_n--检验正确率
      gmk.bool=(gmk.phi>=gmk.critical_phi)
      return "对于命题: \n"..gmk.str.."\n我们建立了N="..gmk.N.."个随机模型，"..gmk.exclude_n.."个被排除。\n其余 "..gmk.check_n.."个中的 "..gmk.n.."个经过了检验，"..gmk.error_n.."个出错，正确率φ="..gmk.phi.."。\n由此认定，该命题是"..tostring(gmk.bool).."的。"
    end,
    run_init=function(gmk,item)
      local class=(item):match("$ " .. "(.-)".." ")
      local label=(item):match(class.." " .. "(.+)")
      if class=="Point" or class=="•"
        gmk.steps[#gmk.steps+1]=function(data)
          data[label]=Vector.random2d(gmk.random.x0,gmk.random.x1,gmk.random.s)
        end
       elseif class=="Circle" or class=="⊙"
        gmk.steps[#gmk.steps+1]=function(data)
          data[label]=Circle.random(gmk.random.x0,gmk.random.x1,gmk.random.s)
        end
       elseif class=="Line" or class=="－"
        gmk.steps[#gmk.steps+1]=function(data)
          data[label]=Line.random(gmk.random.x0,gmk.random.x1,gmk.random.s)
        end
       elseif class=="Triangle" or class=="△"
        gmk.steps[#gmk.steps+1]=function(data)
          data[label]=Triangle.random2d(gmk.random.x0,gmk.random.x1,gmk.random.s)
        end

      end
    end,
    run_constraint=function(gmk, item)
      if (item):find(" of ")==nil

        if (item):find(" is on")~=nil

          --语法 @ Point X is on X
          local class=(item):match("@ " .. "(.-)".." ")
          local label=(item):match(class.." " .. "(.-)".." is on")
          local parameter=(item):match("is on " .. "(.+)")--print(class,label,parameter)
          gmk.steps[#gmk.steps+1]=function(data) data[label]=Vector.randomOn(data[parameter]) end
         elseif (item):find(" is in")~=nil

          --语法 @ Point X is in X
          local class=(item):match("@ " .. "(.-)".." ")
          local label=(item):match(class.." " .. "(.-)".." is in")
          local parameter=(item):match("is in " .. "(.+)")--print(class,label,parameter)
          gmk.steps[#gmk.steps+1]=function(data) data[label]=Vector.randomIn(data[parameter]) end
         elseif (item):find(" is ")~=nil
          --语法: @ <类型> X is <方法名>
          local class=(item):match("@ " .. "(.-)".." ")
          local label=(item):match(class.." " .. "(.-)".." is")
          local method=(item):match("is " .. "(.+)")
          if class == "Triangle"
            if method == "Right"--建立随机的直角三角形
              gmk.steps[#gmk.steps+1]=function(data)
                data[label]=Triangle.randomRight2d(gmk.random.x0,gmk.random.x1,gmk.random.s)
              end

            end
          end
        end

       else
        --语法: @ <类型> X is <方法名> of <参数& 参数组>
        local class=(item):match("@ " .. "(.-)".." ")
        local label=(item):match(class.." " .. "(.-)".." is")
        local method=(item):match("is " .. "(.-)".." of")
        local parameter=(item):match("of " .. "(.+)")--print(class,label,method,parameter)
        local parameter_table=String(parameter).split(",")
        if class=="Point" or class=="•"
          if method == "mid"
            gmk.steps[#gmk.steps+1]=function(data) data[label]=Vector.mid(data[parameter_table[0]],data[parameter_table[1]]) end
           elseif method == "O"
            gmk.steps[#gmk.steps+1]=function(data) data[label]=Vector.getOOf(data[parameter]) end
           elseif method == "in"
            gmk.steps[#gmk.steps+1]=function(data) data[label]=Vector.randomIn(data[parameter]) end
           elseif method == "index"
            gmk.steps[#gmk.steps+1]=function(data) data[label]=Vector.indexByPS(data[parameter_table[0]],data[parameter_table[1]]) end
           elseif method == "insLL"
            gmk.steps[#gmk.steps+1]=function(data) data[label]=Vector.insOfLL2d(data[parameter_table[0]],data[parameter_table[1]]) end
           elseif method == "indexByOnSegment"
            gmk.steps[#gmk.steps+1]=function(data) data[label]=Vector.indexByOnSegment(data[parameter_table[0]],data[parameter_table[1]]) end
           elseif method == "move"--在线段上找点，使之等于另一个线段,参数一初始点,参数二射线,参数三目标长度线段
            gmk.steps[#gmk.steps+1]=function(data) data[label]=Vector.moveP(data[parameter_table[0]],data[parameter_table[1]].v,#data[parameter_table[2]]) end


          end

         elseif class=="Line" or class=="－"
          if method == "new"
            gmk.steps[#gmk.steps+1]=function(data) data[label]=Line.newFrom2Point(data[parameter_table[0]],data[parameter_table[1]]) end
           elseif method == "cross"
            gmk.steps[#gmk.steps+1]=function(data) data[label]=Line.randomCrossP2d(data[parameter],gmk.random.x0,gmk.random.x1,gmk.random.s) end
           elseif method == "angleBisector"
            gmk.steps[#gmk.steps+1]=function(data) data[label]=Line.getAngleBisector(data[parameter_table[0]],data[parameter_table[1]]) end






          end
         elseif class=="Points"
          if method == "insCL"
            --print(parameter_table[0],parameter_table[1])
            gmk.steps[#gmk.steps+1]=function(data) data[label]=Points.insOfCL2d(data[parameter_table[0]],data[parameter_table[1]]) end


          end
         elseif class=="Circle" or class=="⊙"
          if method == "newPRL"
            --print(parameter_table[0],parameter_table[1])
            gmk.steps[#gmk.steps+1]=function(data) data[label]=Circle.newOfPRL(data[parameter_table[0]],data[parameter_table[1]]) end
          end



        end
      end



    end,
    run_inspect=function(gmk, item)
      local inspect=(item):match("? " .. "(.+)")
      gmk.inspect=function(_ENV_)
        return GMK.sandbox("return "..inspect, _ENV_)
      end
    end,
    run_exclude=function(gmk, item)
      local exclude=(item):match("! " .. "(.+)")
      gmk.exclude=function(_ENV_)
        return GMK.sandbox("return "..exclude, _ENV_)
      end
    end,
    run_lua=function(gmk, item)
      local lua=(item):match("<lua>" .. "(.-)</lua>") or ""
      gmk.lua=function(_ENV_)
        return GMK.sandbox(lua, _ENV_)
      end
    end,


  }
}
setmetatable(GMK, GMK)