function Interaction() end
Interaction={
  __call=function(_,data)
    return Interaction.new(data)
  end,
  __index = {
    None="None",--空白
    Gravity="Gravity",--万有引力

    new=function(data)--新建 相互作用
      data.type=data.type or Interaction.None
      return setmetatable(data,Interaction)
    end,


    getForce=function(a, inter, b)
      local F
      if inter.type=="None" then
        F=Vector()
       elseif inter.type=="Gravity" then
        local dx = a.x - b.x
        local len = (dx):len()
        F=dx:scale((inter.G*a.m*b.m)/(len^3))
       else
        F=Vector()
      end
      return F
    end,
  },
}
setmetatable(Interaction, Interaction)

return Interaction
