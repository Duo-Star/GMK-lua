RandomMaster={
  __call=function(_,type_,data)
    return RandomMaster.new(type_,data)
  end,
  __index = {
    new=function(type_,data)
      data.type_=type_
      return setmetatable(data,RandomMaster)
    end,
    random_=function(a,b,s)
      local s=s or 0.1
      return math.random(mf.int(a/s),mf.int(b/s))*s
    end,
    rand=function()
      return RandomMaster.random_(0,1,1e-10)
    end,
    compute=function(rm)
      if rm.type_=="uniform" then
        return RandomMaster.random_(rm.from,rm.to,rm.step)
       elseif rm.type_=="normal_unit" then
        local U1=RandomMaster.rand()
        local U2=RandomMaster.rand()
        local Z0 = mf.sqrt(-2 * mf.ln(U1)) * mf.cos(2 * mf.pi * U2)
        --local Z1 = mf.sqrt(-2 * mf.ln(U1)) * mf.sin(2 * mf.pi * U2)
        return Z0
       elseif rm.type_=="normal" then
        local U1=RandomMaster.rand()
        local U2=RandomMaster.rand()
        local Z0 = mf.sqrt(-2 * mf.ln(U1)) * mf.cos(2 * mf.pi * U2)
        --local Z1 = mf.sqrt(-2 * mf.ln(U1)) * mf.sin(2 * mf.pi * U2)
        return Z0*(rm.stddev)+(rm.mean)

      end
    end,
  }
}
setmetatable(RandomMaster,RandomMaster)



--numpy.random.normal(loc=0.0, scale=1.0, size=None)


--print(RandomMaster.new("normal",{stddev=1,mean=0}):compute())

--print(RandomMaster.new("uniform",{from=-10,to=10,step=1e-5}):compute())
