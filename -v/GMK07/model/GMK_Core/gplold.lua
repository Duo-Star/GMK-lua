function GPL() end
GPL={
  __call=function(_,str)
    return GPL.new(str)
  end,
  __index = {
    new=function(str)--新建 GPL
      local GPL={
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
      return setmetatable(GPL,GPL)
    end,
    sandbox=function(str,ENV_)
      local code2 = load(str, nil, nil, ENV_)
      return code2()
    end,
    run=function(GPL,n)
      GPL.N = n or GPL.N
      GPL.split=String(GPL.str).split("\n")
      for i=1,#GPL.split do
        local item = (GPL.split[i-1])-- str
        local head = string.sub(item,1,1)-- str 句首标识
        if head == ""
         else
          if head == "$"
            GPL.run_init(GPL, item)
           elseif head == "@"
            GPL.run_constraint(GPL, item)
           elseif head == "?"
            GPL.run_inspect(GPL, item)
           elseif head == "!"
            GPL.run_exclude(GPL, item)

          end
        end
      end


      for N=1,GPL.N do
        for i=1,#GPL.steps do
          GPL.steps[i](_ENV)
        end
        local exclude
        if GPL.exclude==nil then exclude=false
         else exclude=GPL.exclude(_ENV)
        end
        if exclude --出现被排除的情况
          GPL.exclude_n=GPL.exclude_n+1
         else--正常情况
          local bool=GPL.inspect(_ENV)
          if bool GPL.n=GPL.n+1 end
local lua=(GPL.str):match("<lua>" .. "(.-)</lua>") or ""
        GPL.sandbox(lua, _ENV)
        end
        --GPL.result[N]={ bool=bool, }
        

      end

      GPL.check_n=GPL.N-GPL.exclude_n--经过检验的个数
      GPL.error_n=GPL.check_n-GPL.n--检验的其中出错的个数
      GPL.phi=GPL.n/GPL.check_n--检验正确率
      GPL.bool=(GPL.phi>=GPL.critical_phi)
      return "对于命题: \n"..GPL.str.."\n我们建立了N="..GPL.N.."个随机模型，"..GPL.exclude_n.."个被排除。\n其余 "..GPL.check_n.."个中的 "..GPL.n.."个经过了检验，"..GPL.error_n.."个出错，正确率φ="..GPL.phi.."。\n由此认定，该命题是"..tostring(GPL.bool).."的。"
    end,
    run_init=function(GPL,item)
      local class=(item):match("$ " .. "(.-)".." ")
      local label=(item):match(class.." " .. "(.+)")
      if class=="Point" or class=="•"
        GPL.steps[#GPL.steps+1]=function(data)
          data[label]=Vector.random2d(GPL.random.x0,GPL.random.x1,GPL.random.s)
        end
       elseif class=="Circle" or class=="⊙"
        GPL.steps[#GPL.steps+1]=function(data)
          data[label]=Circle.random(GPL.random.x0,GPL.random.x1,GPL.random.s)
        end
       elseif class=="Line" or class=="－"
        GPL.steps[#GPL.steps+1]=function(data)
          data[label]=Line.random(GPL.random.x0,GPL.random.x1,GPL.random.s)
        end
       elseif class=="Triangle" or class=="△"
        GPL.steps[#GPL.steps+1]=function(data)
          data[label]=Triangle.random2d(GPL.random.x0,GPL.random.x1,GPL.random.s)
        end

      end
    end,
    run_constraint=function(GPL, item)
      if (item):find(" of ")==nil

        if (item):find(" is on")~=nil

          --语法 @ Point X is on X
          local class=(item):match("@ " .. "(.-)".." ")
          local label=(item):match(class.." " .. "(.-)".." is on")
          local parameter=(item):match("is on " .. "(.+)")--print(class,label,parameter)
          GPL.steps[#GPL.steps+1]=function(data) data[label]=Vector.randomOn(data[parameter]) end
         elseif (item):find(" is in")~=nil

          --语法 @ Point X is in X
          local class=(item):match("@ " .. "(.-)".." ")
          local label=(item):match(class.." " .. "(.-)".." is in")
          local parameter=(item):match("is in " .. "(.+)")--print(class,label,parameter)
          GPL.steps[#GPL.steps+1]=function(data) data[label]=Vector.randomIn(data[parameter]) end
         elseif (item):find(" is ")~=nil
          --语法: @ <类型> X is <方法名>
          local class=(item):match("@ " .. "(.-)".." ")
          local label=(item):match(class.." " .. "(.-)".." is")
          local method=(item):match("is " .. "(.+)")
          if class == "Triangle"
            if method == "Right"--建立随机的直角三角形
              GPL.steps[#GPL.steps+1]=function(data)
                data[label]=Triangle.randomRight2d(GPL.random.x0,GPL.random.x1,GPL.random.s)
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
            GPL.steps[#GPL.steps+1]=function(data) data[label]=Vector.mid(data[parameter_table[0]],data[parameter_table[1]]) end
           elseif method == "O"
            GPL.steps[#GPL.steps+1]=function(data) data[label]=Vector.getOOf(data[parameter]) end
           elseif method == "in"
            GPL.steps[#GPL.steps+1]=function(data) data[label]=Vector.randomIn(data[parameter]) end
           elseif method == "index"
            GPL.steps[#GPL.steps+1]=function(data) data[label]=Vector.indexByPS(data[parameter_table[0]],data[parameter_table[1]]) end
           elseif method == "insLL"
            GPL.steps[#GPL.steps+1]=function(data) data[label]=Vector.insOfLL2d(data[parameter_table[0]],data[parameter_table[1]]) end
           elseif method == "indexByOnSegment"
            GPL.steps[#GPL.steps+1]=function(data) data[label]=Vector.indexByOnSegment(data[parameter_table[0]],data[parameter_table[1]]) end
           elseif method == "move"--在线段上找点，使之等于另一个线段,参数一初始点,参数二射线,参数三目标长度线段
            GPL.steps[#GPL.steps+1]=function(data) data[label]=Vector.moveP(data[parameter_table[0]],data[parameter_table[1]].v,#data[parameter_table[2]]) end


          end

         elseif class=="Line" or class=="－"
          if method == "new"
            GPL.steps[#GPL.steps+1]=function(data) data[label]=Line.newFrom2Point(data[parameter_table[0]],data[parameter_table[1]]) end
           elseif method == "cross"
            GPL.steps[#GPL.steps+1]=function(data) data[label]=Line.randomCrossP2d(data[parameter],GPL.random.x0,GPL.random.x1,GPL.random.s) end
           elseif method == "angleBisector"
            GPL.steps[#GPL.steps+1]=function(data) data[label]=Line.getAngleBisector(data[parameter_table[0]],data[parameter_table[1]]) end






          end
         elseif class=="Points"
          if method == "insCL"
            --print(parameter_table[0],parameter_table[1])
            GPL.steps[#GPL.steps+1]=function(data) data[label]=Points.insOfCL2d(data[parameter_table[0]],data[parameter_table[1]]) end


          end
         elseif class=="Circle" or class=="⊙"
          if method == "newPRL"
            --print(parameter_table[0],parameter_table[1])
            GPL.steps[#GPL.steps+1]=function(data) data[label]=Circle.newOfPRL(data[parameter_table[0]],data[parameter_table[1]]) end
          end



        end
      end



    end,
    run_inspect=function(GPL, item)
      local inspect=(item):match("? " .. "(.+)")
      GPL.inspect=function(_ENV_)
        return GPL.sandbox("return "..inspect, _ENV_)
      end
    end,
    run_exclude=function(GPL, item)
      local exclude=(item):match("! " .. "(.+)")
      GPL.exclude=function(_ENV_)
        return GPL.sandbox("return "..exclude, _ENV_)
      end
    end,
    run_lua=function(GPL, item)
      local lua=(item):match("<lua>" .. "(.-)</lua>") or ""
      GPL.lua=function(_ENV_)
        return GPL.sandbox(lua, _ENV_)
      end
    end,


  }
}
setmetatable(GPL, GPL)