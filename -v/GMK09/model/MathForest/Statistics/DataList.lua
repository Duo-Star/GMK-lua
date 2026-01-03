--#DataList
function DataList() end
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

