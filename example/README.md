# 案例
示例`app.rb`
```
require 'gmuday'

today_a = GmuDay.getToday
cDate = today_a[0]
cWeek = GmuDay.week(today_a[1])
apptitle = "本周课表 #{cDate} #{cWeek}"

# 150*7 = 1050
set title: apptitle, background: 'navy', width: 1050, height: 300

GmuDay.show("test.xlsx", 0, "19 xx [1-2]班")

# 此处往下为鼠标点击显示地点支持
m_down = 0
on :mouse_down do |event|
  # x and y coordinates of the mouse button event
    mx = event.x
    my = event.y
    
    course_arg0 = mx/150 +1
    course_arg1 = my/50
    $courses.each do |course|
        ele = GmuDay.parse_week(course)
        if GmuDay.fOrNot(course_arg0, course_arg1, ele)
            GmuDay.flush(course_arg0, course_arg1, ele, m_down)
            break
        end
    end
    m_down += 1
end

show
```

上述通过获取鼠标相对窗口位置，计算得到坐标，使用`GmuDay.fOrNot`判断是否进行flush方块的操作，条件为真时使用`GmuDay.flush`刷新坐标位置的块。但不添加功能也能看课表，只是无法看到上课地点，可通过`GmuDay.course`终端查看。此处为功能扩展

扩展示例 *参数传递*`app.rb`
```
# 增加myArg()方法获取终端参数
def myArg()
g_arr = Array.new
g_arr = ARGV
g_ok = g_arr[0].to_i
return g_arr.empty? ? 0 : g_ok
end

# 相应第二个参数改为myArg()
GmuDay.show("test.xlsx", myArg(), "19 xx [1-2]班")
```
这样就可以从终端传递参数获取某一周的课表如`ruby app.rb 0`表示本周课表而`1`为下周

> 解析  
> GmuDay.flush(arg0, arg1, arg2, arg3)：前两位表示坐标点，arg2表示解析得到周课表的信息，arg3则进行奇偶控制，使多次点击能切换看到课程、上课地点信息
