
function Sun() end
Sun={
  __call=function(_,str)
    return Sun.new(str)
  end,
  __index = {
    new=function(str)
      return setmetatable({
        str=str,
        isFunc=false,
        isNil=true,
        name="",
        var=nil,
        see=""
      },Sun)
    end,
    run=function(sun)



    end,
    isFuncc=function(sun)
      local str=tostring(sun.str)
      return str:find(")=")~=nil and str:find("==")==nil
    end,
    getName=function(sun)--获取变量名
      local str=sun.str
      local name
      if sun:isFuncc()
        -------------------------
        local varName = ""
        name=(str):match("" .. "(.-)".."(")
       else
        -------------------------
        local varName = ""
        for i = 1, #str do
          if string.sub(str, i, i) == "=" then
            name = varName
           else
            varName = varName .. string.sub(str, i, i)
          end
        end
        -------------------------
      end
      return name
    end


  }
}


setmetatable(Sun,Sun)


return Sun