[返回](doc:GPL/main.md) | 当前位置[文档-GPL-Point]

# Point

> 在欧氏几何中，点是一个没有大小、只有位置的图形，是零维的对象。它是整个欧氏几何的基础，用于描述给定空间中的一种特别的对象。在现代数学中，点更普遍地指代某些称为空间的集合中的元素。[📡 Point](https://baike.sogou.com/m/fullLemma?lid=64606883)
### ▪在声明时使用
使用声明符号`$`作为行头标识，`Point`随其后，最后标注对象`标签`，不要忘记用空格隔开，这样一个点就被创建完成了
下面是一个示范，在平面中创建A点

```\n$ Point A
```

### ▪在约束时使用
使用简写形式
{`in`,`on`,`at`}
```\n创建对象上的点\n@ Point A is on g
创建对象内部的点\n@ Point A is in g
克隆一个点\n@ Point A is at B
```

遵循约束的基本格式

```\n@ Point A is method of factors
```

如果想创建一个已知坐标的点，像这样操作

```\n@ Point A is new of `Vector(x,y)`
```

在这里`new`是Point的方法(method)，其他方法还有
`mid`：中点
```\n@ Point P is mid of A,B```

---

`center`：中心
```\n@ Point P is center of c```

---

`index_Circle`：在圆上索引点
`index_Line`：在直线上索引点
`index_DPoint`：在骈点上索引点
```\n@ Point P is index_Circle of c,`1` ```
---

`insLL`：求得两条直线的交点
```\n@ Point P is insLL of l1,l2 ```

---

`move`：在线段上找点，使之等于另一个线段
```\n@ Point P is move of p,L,l_ ```
__注意参数__: 初始点,射线,目标长度线段


[OK](duo://api)