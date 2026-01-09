神兽保佑=[[
　　┏┓　　　┏┓+ +
　┏┛┻━━━┛┻┓ + +
　┃　　　　　　　┃ 　
　┃　　　━　　　┃ ++ + + +
 ████━████ ┃+
　┃　　　　　　　┃ +
　┃　　　┻　　　┃
　┃　　　　　　　┃ + +
　┗━┓　　　┏━┛
　　　┃　　　┃　　　　　　　　　　　
　　　┃　　　┃ + + + +
　　　┃　　　┃
　　　┃　　　┃ +  神兽保佑
　　　┃　　　┃    代码无bug　　
　　　┃　　　┃　　+　　　　　　　　　
　　　┃　 　　┗━━━┓ + +
　　　┃ 　　　　　　　┣┓
　　　┃ 　　　　　　　┏┛
　　　┗┓┓┏━┳┓┏┛ + + + +
　　　　┃┫┫　┃┫┫
　　　　┗┻┛　┗┻┛+ + + +]]




btn2.onClick=function()
  local items={"清空画布","直线与圆","万花筒","包络线","疯狂的包络线"}
  local ad= AlertDialog.Builder(activity)
  ad.setTitle("测试控制台-GMK 7.16测试版")
  ad.setItems(String(items),DialogInterface.OnClickListener{
    onClick=function(dialog,which)
      --print(items[which+1])
      if which==0 cleanAll() print("已清🙃")
       elseif which==1 cleanAll() print("只蓝色的点可以拖动")
        gmt:addPoint("A",Vector())
        gmt:addPoint("B",Vector(2))
        gmt:addCircle("c","A","B")
        gmt:addLine("l","A","B")
        gmt:index_Circle("C","c",1)
        gmt:index_Line("D","l",2)
        gmt:addCircle("c2","C","D")
       elseif which==2 cleanAll() print("尝试拖动中心点😘")
        gmt:addPoint("A",Vector())
        n=17
        for i=1,n do
          gmt:addPoint("P_"..i,Vector.new_angUnit(i*(2*pi/n)))
        end
        for i=1,n do
          gmt:addCircle("c"..i,"P_"..i,"A")
        end
       elseif which==3 cleanAll() print("拖动A,B,C观察变化")
        gmt:addPoint("A",Vector(-5,5))
        gmt:addPoint("B",Vector())
        gmt:addPoint("C",Vector(5,5))
        gmt:addLine("AB","A","B")
        gmt:addLine("BC","B","C")
        n=10
        for i=1,n-1 do
          gmt:index_Line("A"..i,"AB",(i/n))
          gmt:index_Line("C"..i,"BC",(i/n))
        end
        for i=1,n-1 do
          gmt:addLine("l"..i,"C"..i,"A"..i)
        end
       elseif which==4 cleanAll() print("祝你好运😋")
        gmt:addPoint("A",Vector(-5,5))
        gmt:addPoint("B",Vector())
        gmt:addPoint("C",Vector(5,5))
        gmt:addLine("AB","A","B")
        gmt:addLine("BC","B","C")
        n=100
        for i=1,n-1 do
          gmt:index_Line("A"..i,"AB",(i/n))
          gmt:index_Line("C"..i,"BC",(i/n))
        end
        for i=1,n-1 do
          gmt:addLine("l"..i,"C"..i,"A"..i)
        end

      end
    end
  })
  ad.setNegativeButton( "取消", nil)
  ad.create()
  ad.show()
end



gmt:addPoint("A",Vector())
gmt:addPoint("B",Vector(2))
gmt:addPoint("C",Vector(1,2))
--o=Triangle(Vector(),Vector(2),Vector(1,2)):getO()
--gmt:addPoint("o",o)
--gmt:addCircleFrom3P("c","A","B","C")

