function GPL() end
GPL={
  __call=function(_,str)
    return GPL.new(str)
  end,
  __index = {
    new=function(str)
      setmetatable({
        str=str,
        split={},
        gmt=GMT.newNone(),
        randomMaster={},
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
      if class=="Point" or class=="•" then
        gpl.gmt:add(label,{
          name=label,
          class="Point",
          method="random",
          factor={gpl.randomMaster},
          free=true, g=GMT.Pg
        })


      end
    end,

  }
}
setmetatable(GPL, GPL)


GPL[[

]]

