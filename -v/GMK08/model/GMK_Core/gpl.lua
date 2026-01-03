function GPL() end
GPL={
  __call=function(_,str)
    return GPL.new(str)
  end,
  __index = {
    new=function(str)
      return setmetatable({
        str=str,
        split={},
        gmt=GMT.newNone(),
        randomMaster=RandomMaster.new("uniform",{from=-10,to=10,step=1e-5}),

        N=1000,--验证总量
        n=0,--验证通过总量
        check_n=0,
        error_n=0,
        exclude_n=0,
        phi=0,--正确率
        critical_phi=0.9,--验证临界
        bool=false,--命题真假
        result={},--结果
        log={},

      },GPL)
    end,
    toGMT=function(gpl)
      return (gpl:compile()).gmt
    end,
    compile=function(gpl)
      gpl.split=String(gpl.str).split("\n")
      for i=1,#gpl.split do
        local item = (gpl.split[i-1])-- str
        local head = string.sub(item,1,1)-- str 句首标识
        if head == "$"
          GPL._init(gpl, item)
         elseif head == "@"
          GPL._constraint(gpl, item)
         elseif head == "?"
          GPL._inspect(gpl, item)
         elseif head == "!"
          GPL._exclude(gpl, item)
        end
      end
      return gpl
    end,
    _init=function(gpl,item)
      local class=(item):match("$ " .. "(.-)".." ")
      local label=(item):match(class.." " .. "(.+)")
      gpl.gmt.step[#gpl.gmt.step+1]=label
      gpl.gmt:add(label,{
        name=label,
        class=class,
        method="random",
        factor={gpl.randomMaster},
        free=true, g="none",
      })
    end,
    _constraint=function(gpl, item)
      if (item):find(" of ")==nil
        if (item):find(" is on")~=nil
          --语法 @ Point X is on X
          local class=(item):match("@ " .. "(.-)".." ")
          local label=(item):match(class.." " .. "(.-)".." is on")
          local parameter=(item):match("is on " .. "(.+)")--print(class,label,parameter)
          gpl.gmt.step[#gpl.gmt.step+1]=label
          gpl.gmt:add(label,{
            name=label,
            class="Point",
            method="randomOn",
            factor={parameter,gpl.randomMaster},
            free=true, g="none",
          })

         elseif (item):find(" is in")~=nil
          --语法 @ Point X is in X
          local class=(item):match("@ " .. "(.-)".." ")
          local label=(item):match(class.." " .. "(.-)".." is in")
          local parameter=(item):match("is in " .. "(.+)")--print(class,label,parameter)
          gpl.gmt.step[#gpl.gmt.step+1]=label
          gpl.gmt:add(label,{
            name=label,
            class="Point",
            method="randomIn",
            factor={parameter,gpl.randomMaster},
            free=true, g="none",
          })
          elseif (item):find(" is at")~=nil
          --语法 @ Point X is in X
          local class=(item):match("@ " .. "(.-)".." ")
          local label=(item):match(class.." " .. "(.-)".." is at")
          local parameter=(item):match("is at " .. "(.+)")--print(class,label,parameter)
          gpl.gmt.step[#gpl.gmt.step+1]=label
          gpl.gmt:add(label,{
            name=label,
            class="Point",
            method="at",
            factor={parameter},
            free=true, g="none",
          })
         elseif (item):find(" is cross")~=nil
          --语法 @ Line X is cross X
          local class=(item):match("@ " .. "(.-)".." ")
          local label=(item):match(class.." " .. "(.-)".." is cross")
          local parameter=(item):match("is cross " .. "(.+)")
          gpl.gmt.step[#gpl.gmt.step+1]=label
          gpl.gmt:add(label,{
            name=label,
            class="Line",
            method="cross",
            factor={parameter,gpl.randomMaster},
            free=true, g="none",
          })

         elseif (item):find(" is ")~=nil
          --语法: @ <类型> X is <方法名>
          local class=(item):match("@ " .. "(.-)".." ")
          local label=(item):match(class.." " .. "(.-)".." is")
          local method=(item):match("is " .. "(.+)")
          
          if class == "Triangle"
            if method == "Right"--建立随机的直角三角形
              gpl.gmt.step[#gpl.gmt.step+1]=label
              gpl.gmt:add(label,{
                name=label,
                class="Triangle",
                method="newRandomRight",
                factor={gpl.randomMaster},
                free=true, g="none",
              })

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
        local factor={}
        for i=0,#parameter_table-1 do
          local item=parameter_table[i]
          if (item):find("`")~=nil then
            item=GPL.sandbox("return "..(item):match("`" .. "(.-)".."`"),_ENV)
          end
          factor[i+1]=item
        end
        gpl.gmt.step[#gpl.gmt.step+1]=label
        gpl.gmt:add(label,{
          name=label,
          class=class,
          method=method,
          factor=factor,
          free=true, g="none",
        })
      end
    end,
    _inspect=function(gpl, item)
      local inspect=(item):match("? " .. "(.+)")
      gpl.gmt.step[#gpl.gmt.step+1]="_inspect"
      gpl.gmt:add("_inspect",{
        name="_inspect",
        class="Bool",
        method="new_lua",
        factor={inspect},
        free=true, g="none",
      })
    end,
    _exclude=function(gpl, item)
      local inspect=(item):match("! " .. "(.+)")
      gpl.gmt.step[#gpl.gmt.step+1]="_exclude"
      gpl.gmt:add("_exclude",{
        name="_exclude",
        class="Bool",
        method="new_lua",
        factor={inspect},
        free=true, g="none",
      })
    end,
    sandbox=function(str,ENV_)
      local code2 = load(str, nil, nil, ENV_)
      return code2()
    end,
    run=function(gpl,env)
      gpl:addLog("命题:\n" ..gpl.str)
      gpl:compile()
      gpl:addLog("编译完成")
      local gmt=gpl.gmt
      local data=env
      local startTime = os.clock()
      for N=1,gpl.N do
        gmt:run(data)
        if data._exclude then --出现被排除的情况
          gpl.exclude_n=gpl.exclude_n+1
         else--正常情况
          if data._inspect then
            gpl.n=gpl.n+1
          end
        end
      end
      local endTime = os.clock()
      gpl:addLog("循环["..gpl.N.."]完成, 时长: " .. (endTime - startTime) .. "s.")
      gpl.check_n=gpl.N-gpl.exclude_n--经过检验的个数
      gpl.error_n=gpl.check_n-gpl.n--检验的其中出错的个数
      gpl.phi=gpl.n/gpl.check_n--检验正确率
      gpl.bool=(gpl.phi>=gpl.critical_phi)
      gpl:addLog("对于命题: \n"..gpl.str..
      "\n我们建立了N="..gpl.N.."个随机模型，"
      ..gpl.exclude_n.."个被排除。"..
      "\n其余 "..gpl.check_n.."个中的 "..gpl.n.."个经过了检验，"
      ..gpl.error_n.."个出错，正确率φ="..gpl.phi.."(临界φ="..gpl.critical_phi..")"..
      "。\n由此认定，该命题是"..tostring(gpl.bool).."的。")
      gpl:addLog("结论: ".. (function(b) if b then return "正确" else return "错误" end end)(gpl.bool) )
      return gpl
    end,
    addLog=function(gpl,str)
      gpl.log[#gpl.log+1]=str
    end,


  }
}
setmetatable(GPL, GPL)

