#/usr/bin/ruby
# -*- coding: utf-8 -*-
#

require 'creek'

module GmuDay

   def self.parse(file, myclass, day_start, day_end)
      today = self.getToday
      creek = Creek::Book.new "#{file}"
      @sheet = creek.sheets[0]

      days = self.getDays(day_start, day_end)
      lineDay = Array.new

      @sheet.simple_rows.each do |row|
          break if "#{row['A']}" == self.calDay(days[-1], 1)
          _class = row['G']
          _day = row['A']
         if addOrNot(myclass, _class, days, _day)
             lineDay << row
         end
      end
      return lineDay
   end
   def self.addOrNot(_myclass, _class, _days, _day)
      if _myclass.is_a? Array
         return false unless _myclass.include?(_class) && _days.include?(_day)
         return true
      elsif _myclass.is_a? String
         return false unless _class == _myclass && _days.include?(_day)
         return true
      else
         return false
      end
   end

   def self.course(_file, _myclass, hi_class=[], _day_start, _day_end)
       lessons = self.parse(_file, _myclass, _day_start, _day_end)

       puts "#{'节数'.rjust(28)} #{'课程'.rjust(13)} #{'班级'.rjust(34)} #{'教室'.rjust(12)}"
       lessons.each do |lesson|
           _week_raw = "#{lesson['C']}"
           _week = self.week(_week_raw[0].to_i)
           _ltime = _week_raw.reverse
           _ltime.chop!
           ltime = _ltime.reverse
           _lesson_raw = "#{lesson['F']}"
           _lesson = _lesson_raw.gsub(/\s+/, '')
           _class = "#{lesson['G']}"
           _classroom = lesson['H']
           msg = "[ #{lesson['A']} ]   #{_week}   #{ltime.ljust(9)} #{_lesson.ljust(20, "一")} #{_class.ljust(12)} #{_classroom.ljust(16)}"
           puts classInc(hi_class, _class) ? "\033[1;32m%s\033[0m" % msg : msg
       end
   end
   def self.classInc(_hi_class, _class)
       if _hi_class.is_a? Array
          return false unless _hi_class.include?(_class)
          return true
       elsif _hi_class.is_a? String
          return false unless _class == _hi_class
          return true
       else
          return false
       end
   end
   #private :classInc
   def self.week(str)
      case str
      when 1
         return "星期一"
      when 2
         return "星期二"
      when 3
         return "星期三"
      when 4
         return "星期四"
      when 5
         return "星期五"
      when 6
         return "星期六"
      when 7
         return "星期天"
      end
   end
   def self.getToday()
      t = Time.new
      return t.strftime("%Y-%m-%d")
   end
   def self.calDay(init_day=nil, int_num)
       if init_day.is_a? NilClass
           initDay = Time.new
       else
           init_day_arr = init_day.split("-")
           initDay = Time.local(*init_day_arr)
       end
       past_future = initDay + 86400 * (int_num)
       return past_future.strftime("%Y-%m-%d")
   end
   def self.getDays(_start=0, _end)
      raise "ensure start < end" if _start > _end
      return Array(GmuDay.calDay(_start)..GmuDay.calDay(_end))
   end
   def self.indexDay(_start_day, _end_day)
       _start_day_arr = _start_day.split("-")
       _end_day_arr = _end_day.split("-")
       startDay = Time.local(*_start_day_arr)
       endDay = Time.local(*_end_day_arr)
       return ((endDay - startDay) / 86400).to_i
   end
end
