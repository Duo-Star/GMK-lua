--#Vector 向量
function Vector() end
Vector={
  __call=function(_,x,y,z)
    return Vector.new(x,y,z)
  end,
  __add=function(m,n)
    return Vector.add(m,n)
  end,
  __sub=function(m,n)
    return Vector.sub(m,n)
  end,
  __mul=function(m,n)
    if Is.Vector(m) and Is.Vector(n) return Vector.dot(m,n)
     elseif (Is.Number(m) and Is.Vector(n)) return Vector.scale(n,m)
     elseif (Is.Number(n) and Is.Vector(m)) return Vector.scale(m,n)
    end
  end,
  __div=function(m,n)
    return Vector.div(m,n)
  end,
  __len=function(m)
    return Vector.len(m)
  end,
  __unm = function(m)
    return Vector.unm(m)
  end,
  __shr = function(m,n)-->>
    return Vector.projectV(m,n)
  end,
  __index={
    new=function(a,b,c)
      return setmetatable({x=a or 0.0,y=b or 0.0,z=c or 0.0 },Vector)
    end,
    newFromAL=function(theta,phi,l)
      local theta=theta or 0
      local phi=phi or 0
      local l=l or 1
      local x=cos(theta)*cos(phi)*l
      local y=sin(theta)*cos(phi)*l
      local z=sin(phi)*l
      return setmetatable({x=x,y=y,z=z },Vector)
    end,
    newFromAL2d=function(theta,l)
      local l=l or 1
      local x=cos(theta)*l
      local y=sin(theta)*l
      local z=0
      return setmetatable({x=x,y=y,z=z },Vector)
    end,
    newUC=function(theta,l)
      local x=cos(theta)
      local y=sin(theta)
      return setmetatable({x=x,y=y,z=0 },Vector)
    end,
    newNan=function()
      return Vector(Env.nan,Env.nan,Env.nan)
    end,
    isThis=function(data)
      return getmetatable(data) == Vector
    end,
    isZero=function(data)
      return Is.Zero(data.x) and Is.Zero(data.y) and Is.Zero(data.z)
    end,
    isVi=function(data)
      return data.x==1 and data.y==0 and data.z==0
    end,
    isVj=function(data)
      return data.x==0 and data.y==1 and data.z==0
    end,
    isVk=function(data)
      return data.x==0 and data.y==0 and data.z==1
    end,
    isParallel=function(a,b)
      return Vector.isZero(Vector.cross(a,b))
    end,
    isVertical=function(a,b)
      return Is.Zero(Vector.dot(a,b))
    end,
    toComplex=function(data)
      return Complex(data.x, data.y)
    end,
    add=function(m,n)
      return Vector(m.x+n.x, m.y+n.y, m.z+n.z)
    end,
    sub=function(m,n)
      return Vector(m.x-n.x, m.y-n.y, m.z-n.z)
    end,
    div=function(m,n)
      return Vector(m.x/n.x, m.y/n.y, m.z/n.z)
    end,
    dot=function(m,n)--点积
      return m.x*n.x + m.y*n.y + m.z*n.z
    end,
    mul=function(m,n)--向量中每个元素乘
      return Vector(m.x*n.x, m.y*n.y, m.z*n.z)
    end,
    scale=function(n,m)--Vector, lambda
      return Vector(m*n.x,m*n.y,m*n.z)
    end,
    unm = function(m)--计算相反向量
      return Vector(-m.x,-m.y,-m.z)
    end,
    len=function(m)--计算向量长度
      return math.sqrt(m.x^2 + m.y^2 + m.z^2)
    end,
    pow2=function(m)--计算向量模长平方
      return m.x^2 + m.y^2 + m.z^2
    end,
    cosAngle=function(m,n)--计算两向量夹角余弦值
      return Vector.dot(m,n)/(Vector.len(m)*Vector.len(n))
    end,
    angle=function(m,n)--使用两个向量,计算它们之间的几何角,这个角度不包含方向,范围是0到180
      return math.acos(Vector.dot(m,n)/(Vector.len(m)*Vector.len(n)))
    end,
    clone=function(m)--克隆某向量
      return Vector(m.x, m.y, m.z)
    end,
    unit=function(m)--将向量转为单位向量
      return Vector.scale(m,1/Vector.len(m))
    end,
    getAngle2d=function(v)--计算它们的平面角
      return math.atan2(v.y,v.x)
    end,
    square=function(m)--与pow2作用相同
      return m.x^2 + m.y^2 + m.z^2
    end,
    projectV=function(m,n)
      return (Vector.dot(m,n)/(Vector.len(n)))*Vector.unit(n)
    end,
    project=function(m,n)
      return Vector.dot(m,n)/(Vector.len(n))
    end,
    cross = function(v, u)--叉积(向量积也叫外积)
      local out = Vector()
      local a, b, c = v.x, v.y, v.z
      out.x = b * u.z - c * u.y
      out.y = c * u.x - a * u.z
      out.z = a * u.y - b * u.x
      return out
    end,
    roll2d_90=function(v)--将平面向量旋转90度
      return Vector(-v.y,v.x,0.0)
    end,
    roll=function(v,u,w)--将向量在空间中旋转
      return v:scale(cos(w)) + (u:cross(v)):scale(sin(w)) + u:scale( (u:dot(v)) * (1-cos(w)) )
    end,
    roll2d=function(v,w)--将向量在平面中旋转
      return v:roll(Vector(0,0,1),w)
    end,
    roll2dAT=function(p,o,w)--将平面上的点绕某一旋转中心旋转
      return o+(p-o):roll2d(w)
    end,
    roll2d_90AT=function(p,o,w)--将平面上的点绕某一旋转中心旋转90度
      return o+(p-o):roll2d_90(w)
    end,
    rollAT=function(p,o,u,w)--将空间上的点让某一旋转中心旋转
      return o+(p-o):roll(u,w)
    end,
    change=function(A,p,ang)--空间坐标转平面坐标
      --<vector 目标向量>, <vector 观察者位矢>, <angle 视线向角>
      local px, py, pz, new_x, new_y
      local a,b = ang.theta,ang.phi
      local p_=A-p
      px=Vector(cos(a),sin(a),0)
      py=Vector(-sin(a)*cos(b),cos(a)*cos(b),sin(b))
      pz=Vector(sin(a)*sin(b),-cos(a)*sin(b),cos(b))
      new_x=Vector.dot(p_,px)--/(#(A-p))
      new_y=Vector.dot(p_,pz)--/(#(A-p))
      return Vector(new_x,new_y)
    end,
    mid=function(a,b)--计算两点中点
      return Vector((a.x+b.x)/2,(a.y+b.y)/2,(a.z+b.z)/2)
    end,
    tp2d = function(p,u,v,a)--在平面中实行虚拟坐标系转换为主坐标系
      return p + a.x*u + a.y*v
    end,
    tp = function(p,u,v,n,a)--实行虚拟坐标系转换为主坐标系
      return p + a.x*u + a.y*v + a.z*n
    end,
    ang2d=function(p)--
      return math.atan2(p.y,p.x)
    end,
    floor=function(v)--将向量每一个参数[地板化]
      return Vector(math.floor(v.x),math.floor(v.y),math.floor(v.z))
    end,
    random=function(x0,x1,s)
      return Vector(random(x0,x1,s),
      random(x0,x1,s),
      random(x0,x1,s))
    end,
    random2d=function(x0,x1,s)
      return Vector(random(x0,x1,s),
      random(x0,x1,s),
      0)
    end,
    randomOn=function(geo)--在几何对象上，随机产生点
      local class=getmetatable(geo)
      if class==Circle then
        return geo:indexPoint(random(0,314,0.01))
       elseif class==Line then
        return geo:indexPoint(random(0,1,0.1))


      end
    end,
    randomIn=function(geo)--在几何对象上，随机产生点
      local class=getmetatable(geo)
      if class==Circle then
        return geo:randomInP()

      end
    end,
    randomIn__=function(geo)--在几何对象上，随机产生点
      local class=getmetatable(geo)
      if class==Circle then
        return geo:randomInP__()

      end
    end,
    getOOf=function(geo)--获取某个几何对象的中心点
      local class=getmetatable(geo)
      if class==Circle then
        return geo.p
       elseif class==Line then
        return geo.p


      end
    end,
    is3PCollinear=function(a,b,c)--检验三点共线
      return Is.Zero( (b.x - a.x) * (c.y - b.y) - (b.y - a.y) * (c.x - b.x))
    end,
    indexByPS=function(ps,n)
      return ps[n]
    end,
    -- ????????????????
    indexByOnSegment=function(ps,l)
      local b1=l:isPOnSegment(ps[1])
      local b2=l:isPOnSegment(ps[2])
      if b1 return ps[1]
       elseif b2 return ps[2]
       else return Vector.new_nan()
      end
    end,
    insOfLL2d=function(l1,l2)
      return l1:getIntersectPoint2d(l2)
    end,
    moveP=function(p0,v,l)
      return p0+v:unit():scale(l)
    end,
    perpendicularBisector2d=function(A,B)
      return Line(A:mid(B),(A-B):roll2d_90())
    end,
    translate=function(v)--空间向量翻译为字符串
      return "("..v.x..","..v.y..","..v.z..")"
    end,
    translate2d=function(v)--平面向量翻译为字符串
      return "("..v.x..","..v.y..")"
    end,
    translate2d_simple=function(v)--先约化再翻译
      return "("..(math.floor(v.x*100)*0.01)..","..(math.floor(v.y*100)*0.01)..")"
    end,

    faster=function()--快捷访问
      v_project=Vector.project
      v_cross=Vector.cross v_unit=Vector.unit
      v_sub=Vector.sub v_add=Vector.add
      v_dot=Vector.dot v_len=Vector.len
      v_abs=Vector.len v_scale=Vector.scale
      --中文支持
      转为单位向量=Vector.unit 向量加=Vector.add
      向量减=Vector.sub 向量数乘=Vector.scale
      向量数量积=Vector.dot 向量模=Vector.len
    end,
  }
}
setmetatable(Vector, Vector)

--三方向默认向量
Vector.i=Vector(1)
Vector.j=Vector(0,1)
Vector.k=Vector(0,0,1)
--以及这个小可爱
Vector.o=Vector()

return Vector