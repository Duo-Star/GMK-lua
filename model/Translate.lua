Translate={}
Translate.language=sharedData.Language or "zh"
Translate.data={
  ["探索神圣几何的城堡"]={
    zh="探索神圣几何的城堡",
    en="Explore the Castle of Sacred Geometry"
  },
  ["借助您面前这台机器的计算能力，以及MathForest引擎，让我们开始吧!"]={
    en="With the computing power of the machine in front of you and the MathForest engine, let’s get started!"
  },
  ["> 交互式几何工具"]={
    en="> Interactive geometry tools"
  },
  ["> 几何证明"]={
    en="> Geometry Proof"
  },
  ["> 编码"]={
    en="> Code"
  },
  ["Duo: \n注意，您目前看到的是GMK 1.0.3\n欢迎捉虫子！"]={
    en="Duo: \nNote that you are currently viewing GMK 1.0.3\nWelcome to find bugs!"
  },
  ["ok,开捉!"]={
    en="Ok, start catching!"
  },
  ["正所谓孤木不成林，很高兴与独一无二的你交流互鉴！我们的APP也将在这里发布更新"]={
    en="As the saying goes, a single tree cannot make a forest. I am glad to communicate and learn from you, the one and only one! Our APP will also be updated here."
  },
  ["> 加入QQ群组"]={
    en="> Join QQ Group"
  },
  ["关于GeoMKY"]={
    en="About GeoMKY"
  },
  [([[精心打造的几何软件，全称Geometry Monkey。旨在利用现代计算机的强大计算能力，帮助我们直观，便捷地探索几何世界。
几何是广泛的，它总会出现在生活的各个角落。它是美丽的，总是用最简洁的元素组成令人惊叹的结构。
如果你使用过GeoGebra,Desmos，你会发现，虽然它们都具有强大的计算与作图能力，但他们对于编程的支持并不突出。GeoMKY开放了以Lua为语言的编程接口，通过MathForest内置的数学计算api控制几何元素的呈现。
当然，你也可以使用我们的绘图库实现动画演示，简单游戏开发，等等更精彩的想法！
让我们开启几何之旅吧 (๑>؂<๑）[Duo 2024.7.31] ]])]={
    en=[[A well-crafted geometry software, the full name is Geometry Monkey. It aims to use the powerful computing power of modern computers to help us explore the geometric world intuitively and conveniently.
Geometry is extensive and it always appears in every corner of life. It is beautiful and always uses the simplest elements to form amazing structures.
If you have used GeoGebra and Desmos, you will find that although they both have powerful computing and drawing capabilities, their support for programming is not outstanding. GeoMKY has opened a programming interface with Lua as the language, and controls the presentation of geometric elements through the built-in mathematical calculation API of MathForest.
Of course, you can also use our drawing library to realize animation demonstrations, simple game development, and more exciting ideas!
Let's start the geometry journey (๑>؂<๑) [Duo 2024.7.31] ]]
  },
  ["文件夹"]={
    en="Folder"
  },
  ["图形"]={
    en="Graph"
  },
  ["证明"]={
    en="Prove"
  },
  ["程序"]={
    en="Program"
  },
  ["API 文档"]={
    en="API Documentation"
  },
  ["关于GMK的任何问题，请看这里"]={
    en="For any questions about GMK, please look here"
  },
  ["运行"]={
    en="Run"
  },
  ["导出"]={
    en="Export"
  },
  ["导入"]={
    en="Import"
  },
  ["API"]={
    en="API"
  },
  ["保存"]={
    en="Save"
  },
  ["清空画布"]={
    en="Clean Canvas"
  },
  ["加载"]={
    en="Load"
  },
  ["新建"]={
    en="New"
  },
  ["官方Demo"]={
    en="Official Demo"
  },
  ["属性"]={
    en="Stats"
  },
  ["关于GeoMKY"]={
    en="About"
  },
  ["关于GeoMKY"]={
    en="About"
  },
  ["关于GeoMKY"]={
    en="About"
  },
  ["关于GeoMKY"]={
    en="About"
  },
  ["关于GeoMKY"]={
    en="About"
  },
  ["关于GeoMKY"]={
    en="About"
  },
  ["关于GeoMKY"]={
    en="About"
  },
  ["关于GeoMKY"]={
    en="About"
  },


}

Translate.translate=function(str)
  return Translate.data[str][Translate.language] or str
end

return Translate