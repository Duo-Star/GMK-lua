
--#Number 数值类
Number={
  BooleanToNumber=function(b)
    if b then return 1 else return 0 end
  end,
  approximately=function(a,b)--约化
    return math.floor(a*10^-b)*10^b
  end
  --print(Number.approximately(pi,-3))-->3.141


}

return Number