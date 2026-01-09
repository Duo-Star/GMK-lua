mf={}
mf.info={
  WelcomeToMathForest=[[]],
  author={name="Duo",qq=113530014},
  version=2.5,
  date="2023.6.3",
  info="",
    history={
    ["1.0"]={"2022.12.23","初生; 分享_自用数学库，将嵌入Duo Nature,可能存在错误，欢迎大家指出。将持续更新(因为学业原因，更新周期较长为一个月左右)。包括函数，统计，解析几何等，自习课写的程序长达50页,之后将加入线段，向量，三角形，圆锥曲线等几何类型(本来在纸上写好了，每次回来时间不太够，慢慢码吧)。提供互相作用，例如，求公共点，求垂直，平分线，平行线，角分线，等等等等()在Duo Nature环境下，可以直观展示各个几何类型及相互作用"},
    ["2.0"]={"2023.3.05","基本初等函数，常数，统计，逻辑与判断"},
    ["2.1"]={"2023.4.03","点，直线，更普遍的加减乘除"},
    ["2.2"]={"2023.5.1","点，向量，直线，全部替换为二维和三维通用，新增平面，操作控制台输出，向量运算，空间直线的位置关系初步"},
    ["2.3"]={"2023.5.25","新增物理环境"},
    ["2.4"]={"2023.6","重写。。"},
    ["2.5"]={"2024.7.24",""},

  }
}

mf.Env={
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
Env=mf.Env

mf.src="model.MathForest"

require(mf.src..".Logic.main")

require(mf.src..".Algebra.main")

require(mf.src..".Geometry.main")

require(mf.src..".Physics.main")

require(mf.src..".Statistics.main")


return mf