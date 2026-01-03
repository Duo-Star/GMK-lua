
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
    if not(Is.Zero(v))
      local a=math.sqrt(u^2+v^2)*mf.sgn(v)
      local p=math.atan(u/v)
      return Equation.solveSinForMainRoot(a,1,p,c)
     else
      return Equation.solveSinForMainRoot(u,1,math.pi/2,c)
    end
  end,--print(Equation.solveCosSinForMainRoot(2,3,1)[2])






}
