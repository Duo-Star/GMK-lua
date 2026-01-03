--nature


info={
  author="Duo",
  version=5.02,
  date="2023.6.3",
  info=[[分享_自用数学库，将嵌入Duo Nature,可能存在错误，欢迎大家指出。将持续更新(因为学业原因，更新周期较长为一个月左右)。包括函数，统计，解析几何等，自习课写的程序长达50页,之后将加入线段，向量，三角形，圆锥曲线等几何类型(本来在纸上写好了，每次回来时间不太够，慢慢码吧)。提供互相作用，例如，求公共点，求垂直，平分线，平行线，角分线，等等等等()在Duo Nature环境下，可以直观展示各个几何类型及相互作用]],
  history={
    v1={"2023.3.05","基本初等函数，常数，统计，逻辑与判断"},
    v2={"2023.4.03","点，直线，更普遍的加减乘除"},
    v3={"2023.5.1","点，向量，直线，全部替换为二维和三维通用，新增平面，操作控制台输出，向量运算，空间直线的位置关系初步"},
    v4={"2023.5.25","新增物理环境"},
    v5={"2023.6","重写"},

  },
}

Env={
  e=math.exp(1),
  pi=math.pi,
  huge=math.huge,
  inf=math.huge,
  nan=0/0,
  phi=(math.sqrt(5)-1)/2,
  t=0,
  dt=0.01,
  dx=0.001,
  d=1e-6,
  g=-10,
}

e=Env.e
pi=Env.pi

--指,对数
function log(a,b) return math.log10(b)/math.log10(a) end--对数
function lg(a) return math.log10(a) end--常用对数
function ln(a) return math.log(a) end--自然对数
function exp(a) return math.exp(a) end--自然指数函数
--三角
function sin(a) return math.sin(a) end--一般
function cos(a) return math.cos(a) end
function tan(a) return math.tan(a) end
function sinh(a) return math.sinh(a) end--双曲
function cosh(a) return math.cosh(a) end
function tanh(a) return math.tanh(a) end
function arcsin(a) return math.asin(a) end--反
function arccos(a) return math.acos(a) end
function arctan(a) return math.atan(a) end
--其它
function abs(a) return math.abs(a) end
function floor(a) return math.floor(a) end--向下取整
function ceil(a) return math.ceil(a) end--向上取整
function deg(a) return math.deg(a) end--角度转换
function rad(a) return math.rad(a) end
function max(...) return math.max(...) end--值
function min(...) return math.min(...) end
function mod(a,b) return a%b end
function atan2(a,b) return math.atan2(a,b) end--坐标转换
function random(a,b,s)
  local s=s or 0.1
  return math.random(a/s,b/s)*s
end
function sqrt(a) return math.sqrt(a) end
function sinc(x)--信号分析
  if x==0 then return 1
   else return sin(x)/x
  end
end
function sgn(x)--析离符号
  if x>0 return 1
   elseif x==0 return 0
   else return -1
  end
end
function key(x)--开关函数
  if x>0 return 1 else return 0 end
end
function key0(x)--自然单位阶跃函数
  return (sgn(x)+1)/2
end
function key1(x)--经典单位阶跃函数
  if x>=0 return 1 else return 0 end
end
function root(x)--根函数
  if x==0 return 1 else return 0 end
end
--三角函数互转
function sin2cos(s,x) return sqrt(1-(sin(s))^2)*sgn(x) end
function cos2sin(c,y) return sqrt(1-(cos(c))^2)*sgn(y) end
function sin2tan(s,x) return (sin(s)/sqrt(1-(sin(s))^2))*sgn(x) end
function cos2tan(c,y) return (sqrt(1-(cos(c))^2)/cos(c))*sgn(y) end
function tan2sin(t,y) return sqrt(1/(1+(1/(tan(t))^2)))*sgn(y) end
function tan2cos(t,x) return sqrt(1/(1+((tan(t))^2)))*sgn(x) end
--三角函数转角
function sin2w(s,x) return arcsin(s)+(1/2)*(1-sgn(x))*(math.pi-2*arcsin(s)) end
function cos2w(c,y) return arccos(c)*sgn(y) end
function tan2w(t,y) return arctan(t)+(math.pi/2)*(1-sgn(y)) end
--阶乘
function factorial(n)
  if n == 0 or n == 1 then
    return 1
   else
    return n * factorial(n - 1)
  end
end
--归一化
function sigmoid(x)
  return 1/(1+math.exp(-x))
end



--#Number 数值类
Number={
  BooleanToNumber=function(b)
    if b then return 1 else return 0 end
  end,



}




--#Equation 方程
function Equation() end
Equation={
  solve2x2LinearSystem=function(a1, b1, c1, a2, b2, c2)
    --[[a1 x + b1 y = c1, a2 x + b2 y = c2 ]]
    local D = a1 * b2 - a2 * b1-- 计算行列式D
    if D == 0 then-- 检查行列式是否为零
      return nil,nil, "error: 行列式为零，方程组无解或有无穷多解"
     else-- 计算x和y的值
      local x = (c1 * b2 - c2 * b1) / D
      local y = (a1 * c2 - a2 * c1) / D
      return x, y
    end
  end,
  solveSinForMainRoot=function(a,w,p,c)--计算三角方程的主解 a sin(w t+p)+c=0
    local u=math.asin(-c/a)
    return {(u-p)/w,(math.pi-u-p)/w}
  end,--print(Equation.solveSinForMainRoot(2,3,4,-1)[2])
  solveCosSinForMainRoot=function(u,v,c)--计算三角方程的主解 u cos(t)+v sin(t)+c=0
    local a=math.sqrt(u^2+v^2)*sgn(v)
    local p=math.atan(u/v)
    return Equation.solveSinForMainRoot(a,1,p,c)
  end,--print(Equation.solveCosSinForMainRoot(2,3,1)[2])






}






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
    if x==floor(x) then
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
    return math.abs(data)<=Env.d
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


require "model.n.Vector"

Point=Vector

--#Points
function Points() end
Points={
  __call=function(_,data)
    return Points.new(data)
  end,
  __index = {
    new=function(data)--新建 Points
      return setmetatable(data,Points)
    end,
    insOfCL2d=function(c,l)
      return c:getIntersectPointWithLine2d(l)
    end,


  }
}
setmetatable(Points, Points)


require "model.n.Line"

--#Plane 平面
function Plane() end
Plane={
  __call=function(_,p,u,v)
    return Plane.new(p,u,v)
  end,
  __index = {
    new=function(p,v)--新建 平面
      return setmetatable({p=p or Vector(),u=u or Vector(1),v=v or Vector(0,1) },Plane)
    end,
    loadTest=function()--加载测试
      return Plane(Vector(1),Vector(0,1),Vector(0,0,1))
    end,

  }
}
setmetatable(Plane, Plane)



--#Circle 圆2d
function Circle() end
Circle={
  __call=function(_,p,r)
    return Circle.new(p,r)
  end,
  __index = {
    new=function(p,r)--新建 圆
      return setmetatable({p=p or Vector(),r=r or 1 },Circle)
    end,
    newOfPRL=function(p,rl)--从圆心和半径线段创建
      return Circle(p,#rl)
    end,
    newOfOA=function(p,A)--从圆心和圆上一点创建
      return Circle(p,#(A-p))
    end,
    newFrom3P=function(p1,p2,p3)
      return Circle.newOfOA(Triangle(p1,p2,p3):getO(),p1)
    end,
    loadTest=function()--加载测试
      return Circle(Vector(),1)
    end,
    indexPoint=function(c,theta)--根据theta索引点
      return c.p + Vector(c.r*math.cos(theta),c.r*math.sin(theta))
    end,
    random=function(x0,x1,s)
      return Circle(Vector.random2d(x0,x1,s),
      random(s,x1,s))
    end,
    randomInP=function(c)
      return c.p + Vector(c.r*math.cos(random(0,314,0.01)),c.r*math.sin(random(0,314,0.01))):scale(random(0,1,0.01))
    end,
    randomInP__=function(c)
      return c.p + Vector(c.r*math.cos(random(0,314,0.01)),c.r*math.sin(random(0,314,0.01))):scale(random(0.2,0.8,0.01))
    end,
    getProjectPoint=function(c,p)
      local dp=p-c.p
      local theta=math.atan2(dp.y,dp.x)
      return c:indexPoint(theta)
    end,
    getIntersectPointWithLine2d=function(c,l)
      local lams={Env.nan,Env.nan}
      if l.v.x==0 then--排除分母为零的情况
        lams=Equation.solveCosSinForMainRoot(c.r, 0, c.p.x-l.p.x)
       else--下面屎山不要动
        lams=Equation.solveCosSinForMainRoot(0-(c.r*l.v.y)/l.v.x,
        c.r,
        c.p.y-((c.p.x-l.p.x)*l.v.y)/l.v.x-l.p.y)
      end
      return {c:indexPoint(lams[1]),c:indexPoint(lams[2])}
    end,

  }
}
setmetatable(Circle, Circle)

require "model.n.Conic0"

--#Curve 曲线
function Curve() end
Curve={
  __call=function(_,func,range)
    return Curve.new(func,range)
  end,
  __index = {
    new=function(f,range)--新建 曲线
      return setmetatable({f=f or function(t) return Vector(t,t^2) end,range=range or {-1,1} },Curve)
    end,
    loadTest=function()--加载测试
      return Curve(function(t) return Vector(t,t^2) end,{-1,1})
    end,
    indexPoint=function(c,t)
      return c.f(t)
    end,


  }
}
setmetatable(Curve, Curve)


require "model.n.Triangle"


function Polygon() end
Polygon={
  __call=function(_,ps)
    return Polygon.new(ps)
  end,
  __index = {
    new=function(ps)--新建 曲线
      return setmetatable({ps=ps or {Vector(1,1),Vector(2,2),Vector(3,2)} },Polygon)
    end,
    loadTest=function()--加载测试
      return Polygon()
    end,


  }
}
setmetatable(Polygon, Polygon)





--#Complex 复数
function Complex() end
Complex={
  __call=function(_,x,y) return Complex.new(x,y) end,
  __add=function(m,n) return Complex.add(m,n) end,
  __sub=function(m,n) return Complex.sub(m,n) end,
  __mul=function(m,n) return Complex.mul(m,n) end,
  __div=function(m,n) return Complex.div(m,n) end,
  __len=function(m,n) return Complex.len(m,n) end,
  __unm = function(m) return Complex.mul(m,-1) end,
  __index = {
    new=function(x,y)
      return setmetatable({x=x or 0,y=y or 0 },Complex)
    end,
    is={
      this=function(_,data)
        return getmetatable(data) == Complex
      end,
      zero=function(data)
        return data.x==0 and data.y==0
      end
    },
    add=function(m,n)
      if not(Complex.is.this(m)) and type(m)=="number" then
        m=Complex(m)
      end
      if not(Complex.is.this(n)) and type(n)=="number" then
        n=Complex(n)
      end
      return Complex.new(m.x+n.x,m.y+n.y)
    end,
    sub=function(m,n)
      if not(Complex.is.this(m)) and type(m)=="number" then
        m=Complex(m)
      end
      if not(Complex.is.this(n)) and type(n)=="number" then
        n=Complex(n)
      end
      return Complex.new(m.x-n.x,m.y-n.y)
    end,
    mul=function(m,n)
      if not(Complex.is.this(m)) and type(m)=="number" then
        m=Complex(m)
      end
      if not(Complex.is.this(n)) and type(n)=="number" then
        n=Complex(n)
      end
      return Complex.new(m.x*n.x - m.y*n.y , m.x*n.y + m.y*n.x)
    end,
    div=function(m,n)
      local a,b=m.x,m.y
      local c,d=n.x,n.y
      return Complex.new( (a*c+b*d)/(c^2+d^2), (b*c-a*d)/(c^2+d^2) )
    end,
    len=function(m)
      return math.sqrt(m.x^2+m.y^2)
    end,
    real=function(m)
      return m.x
    end,
    imagine=function(m)
      return m.y
    end,
    Complex_unit=function()
      return Complex(0,1)
    end,
  }
}
setmetatable(Complex, Complex)
i=Complex.Complex_unit()
Env.i=Complex.Complex_unit()







--#Statistics 统计
function Statistics() end
Statistics={
  __call=function(_,data)
    return Statistics.new(data)
  end,
  __index = {
    new=function(data)--新建 样本数据
      return setmetatable({data=data,type="Sample"},Statistics)
    end,
    newDistributed=function(data)--新建 分布列
      return setmetatable({data=data,type="Distributed"},Statistics)
    end,
    correlation=function(data)
      --{{1,2},{2,3}}
      local ax,ay,n=0,0,#data
      for i=1,n do
        ax=ax+data[i][1]/n
        ay=ay+data[i][2]/n
      end
      local a,b={},{}
      for i=1,n do
        a[i]=data[i][1]-ax
        b[i]=data[i][2]-ay
      end
      local va,vb=NVector(a),NVector(b)
      return NVector.dot(a,b)/(a:len()*b:len())
    end,
    A=function(n,m)
      return factorial(n)/factorial(n-m)
    end,
    C=function(n,m)
      return Statistics.A(n,m)/factorial(m)
    end,
    sort=function(data)--排序
      local uu=1
      for m=1,#data-1 do
        for n=m+1,#data do
          if data[m]>data[n] then
            local center=data[m]
            data[m]=data[n]
            data[n]=center
          end
        end
      end
      return data
    end,
    reverse=function(data)--倒序
      local to={}
      local m=1
      for n=#data,1,-1 do
        to[m]=data[n]
        m=m+1
      end
      return to
    end,
    exist= function (a,data)--存在
      local num=false
      for n=1,#data do
        if data[n]==a then
          num=n
        end
      end
      return num --返回false或者该元素在集合中排第几个
    end,
    summation=function (data)--求和
      local w=0
      for n=1,#data do w=w+data[n] end
      return w
    end,
    quadrature=function (data)--求积
      local w=1
      for n=1,#data do w=w*data[n] end
      return w
    end,
    disruption= function (data)--打乱
      for n=1,#data do
        m=math.random(1,#data)
        n=math.random(1,#data)
        local center=data[m]
        data[m]=data[n]
        data[n]=center
      end
      return data
    end,
    average= function (data)--平均数
      return List.summation(data)/#data
    end,
    median= function (data)--中位数
      local data=List.sort(data)
      local len=#data
      if is.oddnumber(len) then --print(1+(floor(len/2)))
        return data[1+(floor(len/2))]
       else
        return List.average({data[len/2],data[1+(len/2)]})
      end
    end,
    variance= function (data)--方差
      local center=List.average(data)
      local each_={}
      local num=#data
      for n=1,num do
        each_[n]=((data[n]-center)^2)/num
      end
      return List.summation(each_)
    end,
    standard_deviation=function (data)--标准差
      return math.sqrt(List.variance(data))
    end,
    range=function (data)--极差
      local a=List.sort(data)
      return a[#a]-a[1]
    end,
    rantake=function (data)--任取
      return data[random(1,#data)]
    end,


  }
}
setmetatable(Statistics, Statistics)


require "model.n.Physics"
