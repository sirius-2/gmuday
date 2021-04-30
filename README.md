# gmuday
ruby 语言编写的赣南某学院课表解析工具(Published)

## 用法
首先使用`sudo gem install gmuday-0.2.0.gem`安装此库
```
require 'gmuday'
GmuDay.wind()
```
即可轻松显示课表。可使用0表示本周课表，下周为1
![周课表](./example/course.png)

<details>
<summary>高级用法</summary>
<h3><a>GmuDay.stone</a></h3>
<pre>
require 'gmuday'
GmuDay.stone(0, "19 xx [1-2]班", "")

show
</pre>
三个参数分别表示*本周*，*班级*，*初始值*。看下周课表，第二个参数为1；看上周课表，则为-1。以此类推
初始值可以不写，但为"w"时表示课表初始页显示上课地点(where)  

如果你想增加点击查看上课地点， [请看这里](example/README.md)

<h3><a>GmuDay.parse</a></h3>
返回包含某些天课表的数组(Array)
<pre>
GmuDay.parse("example.xlsx", "19 xx [1-2]班”, 1, 7)
</pre>
解析不用高亮输出，参数为四个
</details>

# Requirements
+ ruby2d
+ creek
+ base64_string
+ os

>  **测试通过** 
