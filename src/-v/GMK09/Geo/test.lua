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



--[[
btn2.onClick=function()
  local items={"清空画布","直线与圆","万花筒","包络线","疯狂的包络线","保存","读取"}
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
          gmt:addPoint("P_"..i,Vector.newUC(i*(2*pi/n)))
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
       elseif which==5
        GMK_File.set()
        GMK_File.save()
       elseif which==6
        GMK_File.read("test")




      end
    end
  })
  ad.setNegativeButton( "取消", nil)
  ad.create()
  ad.show()
end
--]]


--gmt:addPoint("A",Vector())
--gmt:addPoint("B",Vector(2))
--gmt:addPoint("C",Vector(1,2))
--o=Triangle(Vector(),Vector(2),Vector(1,2)):getO()
--gmt:addPoint("o",o)
--gmt:addCircleFrom3P("c","A","B","C")


--[[
gmt:addPoint("A",Vector())
gmt:addPoint("B",Vector(2))
gmt:addCircle("c","A","B")
gmt:addPoint("C",Vector(0,-1))
gmt:addPoint("D",Vector(4,2))
gmt:addLine("l","C","D")
--gmt:intersectOfCL("P","c","l",1)
--]]



--[[
c1=Circle(Vector(),1)
c2=Circle(Vector(2),2)
t=c1:getIntersectPointWithCircle_theta(c2)
p=c1:getIntersectPointWithCircle(c2)
--]]

--[[
gmt:addPoint("A",Vector())
gmt:addPoint("B",Vector(1))
gmt:addCircle("c1","A","B")

gmt:addPoint("C",Vector(2))
gmt:addPoint("D",Vector(4))
gmt:addCircle("c2","C","D")

gmt:intersectOfCC("p1","c1","c2",1)
--]]




btn2.onClick=function()
  local items={
    "动态",
    "¿"
  }
  local ad= AlertDialog.Builder(activity)
  ad.setTitle("测试控制台")
  ad.setItems(String(items),DialogInterface.OnClickListener{
    onClick=function(dialog,which)
      if which==0

        gmt:addPoint("O",Vector())
        gmt:addPoint("A",Vector(2))
        gmt:addCircle("c","O","A")
        gmt:index_Circle("P","c",1)

        Sliders.onTick=function()
          local value=Sliders.distribute(Sliders.t,{
            type="Sin",
            max=2,
            min=1,
            speed=3
          })
          gmt.P.factor[2]=value
        end

       elseif which==1

        cleanAll()

        gmt:addPoint("O",Vector())
        gmt:addPoint("A",Vector(2))
        gmt:addLine("l","O","A")
        gmt:addCircle("c","O","A")
        gmt:index_Circle("P","c",1)
        gmt:index_Line("Q","l",2)
        gmt:addSlider("a",{
          type="Sin",
          max=2,
            min=1,
            speed=3
          },{
          {name="P",wfac=2},
          {name="Q",wfac=2}
        })


        function loggg(e)
          写入文件("/storage/emulated/0/Duo/Forest/GMK/Logs/"
          .."Runtime_"..os.time()..".log",e)
        end

        loggg(dump(gmt))




       elseif which==2

      end
    end
  })
  ad.setNegativeButton( "取消", nil)
  ad.create()
  ad.show()
end



