[返回](doc:GPL/main.md) | 当前位置[文档-GPL-Point]

# Line

> 直线，是一个点在平面或空间沿着一定方向和其相反方向运动的轨迹；不弯曲的线。[📡 Line](https://baike.sogou.com/m/fullLemma?key=直线)

### ▪在声明时使用
使用声明符号`$`作为行头标识，`Line`随其后，最后标注对象`标签`，不要忘记用空格隔开，这样一条直线就被创建完成了
下面是一个示范，在平面中创建l直线

```\n$ Line l
```

### ▪在约束时使用
使用简写形式
{`cross`}
```\n约束直线过一个点\n@ Line l is cross A
```

遵循约束的基本格式

```\n@ Line A is method of factors
```

如果想创建过两点的直线，像这样操作

```\n@ Line l is new of A,B
```

在这里`new`是Line的方法(method)，其他方法还有
`angleBisector`：角平分线
```\n@ Line l is mid of A,B,C```

---
