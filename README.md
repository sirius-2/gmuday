# gmuday
> [中文](./README.md) | [English](README_en.md) ruby 语言编写的赣南某学院课表解析工具(Published)

## 用法
首先使用`sudo gem install gmuday -s https://rubygems.org/`安装此库
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

<h3><a>GmuDay.course</a></h3>
命令格式化打印课表，参数如下
<pre>
GmuDay.course("example.xlsx", ["19 xx [1-2]班", "19 xx [3-4]班",],["19 xx [1-2]班",], 1, 7)
</pre>
参数解析：  </br>
<code>arg0</code>：课表路径，可能支持url  </br>
<code>arg1</code>: 班级名称。介绍与下方类似  </br>
<code>arg2</code>: 高亮输出指定班级课程，未指定则为普通色。指定多个班级用<code>Array</code>，单个班级<code>String</code>或<code>Array</code> </br>
<code>arg3 、arg4</code>： 0,0表示当前一天， 1,1表示明天，-1,3表示过去一天到未来三天，1,7表示明天开始的未来7天，以此类推  
<img src="./example/cli.png" alt="案例" style="max-width:100%;">
</details>

# Requirements
+ ruby2d
+ creek
+ base64_string
+ os

>  **测试通过** 由于未知的问题不能得到Windows下可执行文件，该版本可能后续不会推出
