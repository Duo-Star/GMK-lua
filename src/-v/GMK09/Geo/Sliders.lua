Sliders={}
Sliders.dt=0.01
Sliders.t=0
Sliders.onTick=function() end

Sliders.distribute=function(t,info)
  --@ info = {type, speed, max, min}
  if info.type=="Oscillating"
    --/\/\/
    local range=info.max-info.min
    local t0=range/info.speed
    if (0.5*t)%t0<range/4
      return (info.speed*t)%range+info.min
     else return (-info.speed*t)%range+info.min
    end
   elseif info.type=="Increasing"
    --///
    local range=info.max-info.min
    return (info.speed*t)%range+info.min
   elseif info.type=="Increasing_Once"
    --/-
    local range=info.max-info.min
    local v=info.speed*t+info.min
    if v<info.max return v
     else return info.max
    end
   elseif info.type=="Decreasing"
    --\
    local range=info.max-info.min
    return (-info.speed*t)%range+info.min
   elseif info.type=="Static"
    return info.min
   elseif info.type=="Sin"
    local range=info.max-info.min
    return (info.max+info.min)*0.5
    + range*0.5*mf.sin(info.speed*t)
   else
    return 0
  end
end









