require "model.util"
import "model.GMK_Core.main"

code=[[
$ Circle c
@ Point A is on c
@ Point B is on c

//@ Point M is midP of A,B

//@ Class name is method of factor,`114514`,`Vector()`

? Is.Equal( #(A-c.p) , #(B-c.p) )
]]



print("code:\n"..code)

gp=GPL(code):compile()

print("gp:\n"..dump(gp))


gmt=gp.gmt

--print("gmt:\n"..dump(gmt))

data=mf

startTime = os.clock()

gmt:run(data)

endTime = os.clock()

print("Function took " .. (endTime - startTime) .. " seconds.")

print("data:\n"..dump(data))

print(data._inspect)
