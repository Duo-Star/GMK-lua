require "import"
import "model.util"
import "model.class"
import "model.MaterialChip"
import "android.graphics.*"

import "geo.lay"--框架及布局
import "model.n.nature"--数学库
import "model.paint"--画笔
import "geo.gmt"--GMT编译器


data={}--准备一张表，存放几何对象
gmt=GMT.new()--创建几何环境
import "geo.test"--加载测试程序

import "geo.graphLib"--绘图库
import "geo.tool"--工具
import "geo.touch"--处理触摸事件😋