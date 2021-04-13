#/usr/bin/ruby
# encoding: utf-8

require 'creek'
require 'ruby2d'
require 'os'
require 'base64_string'
require_relative 'gmuday/helper'
include Ruby2D::DSL

module GmuDay

    def self.wind(init_num=0)
        # set class value
        mClass = "MTfkuLTmnKxbNy04XeePrQ==".decode64
        mClass = mClass.force_encoding("gb2312").force_encoding("utf-8")
        tArr = Helper.calWeek(init_num)
        apptitle = "开始于 [ %s ]   本周课表" % Helper.calDay(tArr[1])
        
        # set App title | 150*7 = 1050
        set title: apptitle, background: 'navy', width: 1050, height: 300
        Helper.stone(init_num, mClass)
        m_down = 0
        
        # flush on mouse click 
        on :mouse_down do |event|
            mx = event.x
            my = event.y
            course_arg0 = mx/150 +1
            course_arg1 = my/50
            $courses.each do |course|
                ele = Helper.parse_week(course)
                if Helper.fOrNot(course_arg0, course_arg1, ele)
                    Helper.flush(course_arg0, course_arg1, ele, m_down)
                    break
                end
            end
            m_down += 1
        end
        show
    end
end
