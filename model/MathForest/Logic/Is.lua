--#Is 判断类
function Is() end
Is={
  Oddnumber=function(x)--判断奇数
    if Is.integer(x) and not(Is.evennumber(x)) then
      return true
     else return false
    end
  end,
  Integer=function(x)--判断整数
    if x==mf.floor(x) then
      return true
     else return false
    end
  end,
  Evennumber=function(x)--判断偶数
    if Is.integer(x) and x%2==0 then
      return true
     else return false
    end
  end,
  Zero=function(data)--判断一个: 整数等于零 or 浮点数接近零
    return math.abs(data)<=mf.Env.d
  end,
  Equal=function(a,b)--判断一个: 整数相等 or 浮点数接近
    return Is.Zero(a-b)
  end,
  Vector=function(data)--判断是否为向量
    return getmetatable(data) == Vector
  end,
  Number=function(data)--判断是否为数字
    return type(data)=='number'
  end,
  Table=function(data)--判断是否为数组
    return type(data)=='table'
  end,


}
return Is