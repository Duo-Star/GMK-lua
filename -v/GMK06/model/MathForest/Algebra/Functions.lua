mf.e=Env.e
mf.pi=Env.pi

--指,对数
mf.log=function(a,b) return mf.ln(b)/mf.ln(a) end--对数
mf.lg=math.log10
mf.ln=math.log
mf.exp=math.exp

--三角
mf.sin=math.sin
mf.cos=math.cos
mf.tan=math.tan
--三角补充
mf.sec=function(x) return 1/mf.cos(x) end
mf.cot=function(x) return 1/mf.tan(x) end

--双曲
mf.sinh=math.sinh
mf.cosh=math.cosh
mf.tanh=math.tanh
--反函数
mf.arcsin=math.asin
mf.arccos=math.acos
mf.arctan=math.atan
--其它
mf.abs=math.abs
mf.sqrt=math.sqrt
mf.int=math.floor
mf.floor=math.floor
mf.ceil=math.ceil
mf.deg=math.deg
mf.rad=math.rad
mf.max=math.max
mf.min=math.min
mf.mod=function(a,b) return a%b end
mf.atan2=math.atan2
mf.random=math.random
mf.random_=function(a,b,s)
  local s=s or 0.1
  return math.random(a/s,b/s)*s
end

mf.sinc=function(x)--信号分析
  if x==0 then return 1
   else return mf.sin(x)/x
  end
end

mf.sgn=function(x)--析离符号
  if x>0 return 1
   elseif x==0 return 0
   else return -1
  end
end

mf.key=function(x)--开关函数
  if x>0 return 1 else return 0 end
end
mf.key0=function(x)--自然单位阶跃函数
  return (mf.sgn(x)+1)/2
end
mf.key1=function(x)--经典单位阶跃函数
  if x>=0 return 1 else return 0 end
end
mf.root=function(x)--根函数
  if x==0 return 1 else return 0 end
end

--三角函数互转
mf.sin2cos=function (s,x) return mf.sqrt(1-(mf.sin(s))^2)*mf.sgn(x) end
mf.cos2sin=function (c,y) return mf.sqrt(1-(mf.cos(c))^2)*mf.sgn(y) end
mf.sin2tan=function (s,x) return (mf.sin(s)/mf.sqrt(1-(mf.sin(s))^2))*mf.sgn(x) end
mf.cos2tan=function (c,y) return (mf.sqrt(1-(mf.cos(c))^2)/mf.cos(c))*mf.sgn(y) end
mf.tan2sin=function (t,y) return mf.sqrt(1/(1+(1/(mf.tan(t))^2)))*mf.sgn(y) end
mf.tan2cos=function (t,x) return mf.sqrt(1/(1+((mf.tan(t))^2)))*mf.sgn(x) end

--三角函数转角
mf.sin2w=function (s,x) return mf.arcsin(s)+(1/2)*(1-mf.sgn(x))*(math.pi-2*mf.arcsin(s)) end
mf.cos2w=function (c,y) return mf.arccos(c)*mf.sgn(y) end
mf.tan2w=function (t,y) return mf.arctan(t)+(math.pi/2)*(1-mf.sgn(y)) end

--阶乘
mf.factorial=function(n)
  if n == 0 or n == 1 then
    return 1
   else
    return n * mf.factorial(n - 1)
  end
end


--归一化
mf.sigmoid=function(x)
  return 1/(1+mf.exp(-x))
end




e=mf.e
pi=mf.pi

log=mf.log
ln=mf.ln
lg=mf.lg
exp=mf.exp

sin=mf.sin
cos=mf.cos
tan=mf.tan

sec=mf.sec
cot=mf.cot

arcsin=mf.arcsin
arccos=mf.arccos
arctan=mf.arctan

sinh=mf.sinh
cosh=mf.cosh
tanh=mf.tanh

abs=mf.abs
sqrt=mf.sqrt
int=mf.int
floor=mf.floor
ceil=mf.ceil
deg=mf.deg
rad=mf.rad
max=mf.max
min=mf.min
mod=mf.mod
atan2=mf.atan2
random=mf.random

