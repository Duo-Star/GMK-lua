

local a="f(x)=x"
local b="duo=1"
local c="duo"


sun={}

sun.is_mathfun=function(str)
  local str=tostring(str)
  if str:find(")=")~=nil and str:find("==")==nil then
    return true
   else return false
  end
end

sun.get_varname0=function(str)--获取变量名(<文本表达式>)
  local varName = ""
  for i = 1, #str do
    if string.sub(str, i, i) == "=" then
      return varName
     else
      varName = varName .. string.sub(str, i, i)
    end
  end
end

sun.have_var=function(str)
  if sun.is_mathfun(str) then
    return true
   else
    if sun.get_varname0(str) then
      return true
     else return false
    end
  end
end

sun.no_var=function(str)
  return not(sun.have_var(str))
end


sun.tonormalfun=function(str)
  return "function "..tostring(str):gsub("=","\n  return ").."\nend"
end

sun.get_fun_name=function(str)--获取变量名(<文本表达式>)
  local varName = ""
  for i = 1, #str do
    if string.sub(str, i, i) == "(" then
      return (varName.."love"):match("function (.-)love")
     else
      varName = varName .. string.sub(str, i, i)
    end
  end
end

--print(sun.get_fun_name(sun.tonormalfun(a)))

sun.get_varname=function(str)
  if sun.have_var(str) then
    if sun.is_mathfun(str) then
      return sun.get_fun_name(sun.tonormalfun(a))
     else
      return sun.get_varname0(str)
    end
   else
    return ""
  end
end

sun.getvar=function(str)
  Result_= "!"
  if sun.have_var(str) then
    if sun.is_mathfun(str) then
      pcall(function() assert(loadstring("function "..tostring(s):gsub("=","\n  return ").."\nend"))() end)
      pcall(function() assert(loadstring(sun.tonormalfun(str)))() end)
      pcall(function()
        Result_= load("return "..tostring(sun.get_varname(str)),nil, nil,_ENV)()
      end)
      return Result_ or "!"
     else
      if tostring(s):find("y=")~=nil or tostring(s):find("x=")~=nil or tostring(s):find("ρ=")~=nil then
        local s=string.gsub(tostring(s),"y=","f(x)=")
        pcall(function() assert(loadstring("function "..tostring(s):gsub("=","\n  return ").."\nend"))() end)
        pcall(function() assert(loadstring(sun.tonormalfun(str)))() end)
        pcall(function()
          Result_= load("return "..tostring(sun.get_varname(str)),nil, nil,_ENV)()
        end)
        return Result_ or "!"
       else
        pcall(function() assert(loadstring(str))() end)
        pcall(function()
          Result_= load("return "..tostring(sun.get_varname(str)),nil, nil,_ENV)()
        end)
        return Result_ or "!"
      end
    end
   else
    pcall(function()
      Result_=load("return "..tostring(str),nil, nil,_ENV)() or nil
    end)
    return Result_ or "!"
  end
end


--print(sun.get_varname(a))


--print((sun.getvar(a)(2)))
--print(sun.getvar(b))
--print(sun.getvar(c))


--pcall(function() assert(loadstring("function f(x) return x end"))() end)
function see_list(data)
  to="list: ("
  for n=1,#data do
    if n~=#data then
      to=to..(data[n])..","
     else
      to=to..(data[n])..")"
    end
  end
  return to
end



sun.type=function()
  local metatable= getmetatable(data)
  if metatable==nil then
    return type(data)
   else
    switch metatable
     case point return 'point'
     case Vector return 'vector'
     case Complex return 'complex'
     case Circle return 'circle'
     case Conic0 return 'conic'
     case vecline return 'vecline'
     case Line return "line"
     case linese return "linese"
     case object return "object"



    end
  end

end


function sun.toseeable(data)
  -- print(get.type(data))
  local mt=getmetatable(data)
  if mt
    switch mt
     case "point"
      if data.x~=nil and data.y~=nil and data.z~=nil then
        local str="("..data.x..","..data.y..","..data.z..")"
        return str
       else
        return "$point"
      end
     case "angle"
      return "angle{θ="..theta..",Φ="..phi.."}"
     case Vector
      if data.x~=nil and data.y~=nil and data.z~=nil then
        local str="("..data.x..","..data.y..","..data.z..")"
        return str
       else
        return "$vector"
      end
     case Complex return data.x.."+"..data.y.."i"
     case Line
      return "("..data["A"]["x"]..","..data["A"]["y"]..","..data["A"]["z"]..")+λ("..data["v"]["x"]..","..data["v"]["y"]..","..data["v"]["z"]..")"
     case Plane
      return ""..data["A"].."*x+"..data["B"].."*y+"..data["C"].."*z+"..data["D"].."=0"
     case List
      return see_list(data)

     default return dump(data)
    end
   else
    return dump(data)


  end

end

保留小数位数=0.000000001
是否四舍五入=1


return sun

