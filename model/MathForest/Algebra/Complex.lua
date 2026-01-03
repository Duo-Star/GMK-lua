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
    tocomplex=function(a)
      if type(a)=="number"
        return Complex.new(a,0)
       else
        return a
      end
    end,
    isThis=function(_,data)
      return getmetatable(data) == Complex
    end,
    isZero=function(data)
      return data.x==0 and data.y==0
    end,
    add=function(m,n)
      if not(Complex.isThis(m)) and type(m)=="number" then
        m=Complex(m)
      end
      if not(Complex.isThis(n)) and type(n)=="number" then
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
    abs=function(m)
      return math.sqrt(m.x^2+m.y^2)
    end,
    real=function(m)
      return m.x
    end,
    imagine=function(m)
      return m.y
    end,
    Re=function(m)--实
      return m.x
    end,
    Im=function(m)--虚
      return m.y
    end,
    Phi=function(m)--计算辐角
      local r,x,y,phi=m:len(),m:Re(),m:Im(),nil
      if y>=0 and r~=0 phi=math.acos(x/r)else
        if y<0 phi=-math.acos(x/r) else
          phi=0/0
        end
      end
      return phi
    end,
    salvage=function(m)--分解
      return m.x,m.y
    end,
    ln=function(m)--计算复数的自然对数
      local x=math.log(m:abs())
      local y=math.atan(m.y/m.x)
      return complex.new(x,y)
    end,
    pow=function(m,n)--m^n
      local z=m:ln():mul(n)
      return z:exp()
    end,
    exp=function(m)--e^(a+bi)
      local x=math.cos(m.y)*math.exp(m.x)
      local y=math.sin(m.y)*math.exp(m.x)
      return complex.new(x,y)
    end,
    I=function()--虚数单位
      return Complex(0,1)
    end,


  }
}
setmetatable(Complex, Complex)
i=Complex.I()