#/usr/bin/ruby
# encoding: utf-8

module Helper
    def self.parse(file, myclass, day_start, day_end)
        today_r = self.getToday
        today = today_r[0]
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
    def self.week(i)
        case i
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
    def self.weekNum(str)
        str0 = str.reverse
        str1 = str0.chop!
        wInt = str[0].to_i
        return [wInt, self.week(wInt), str1.reverse]
    end
    def self.getToday()
        t = Time.new
        d = t.strftime("%Y-%m-%d")
        w = t.wday
        return [d, w]
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
        return Array(self.calDay(_start)..self.calDay(_end))
    end
    def self.indexDay(_start_day, _end_day)
        _start_day_arr = _start_day.split("-")
        _end_day_arr = _end_day.split("-")
        startDay = Time.local(*_start_day_arr)
        endDay = Time.local(*_end_day_arr)
        return ((endDay - startDay) / 86400).to_i
    end
                
    # Added
    def self.top()
        week = Array(0..6)
        week.each do |w|
            self.buildBlock(w*150, 0, 150, 50, 1, self.week(w+1), 150/3 + w*150, 50/3, 13, 2)
        end
    end
    def self.buildBlock(rx, ry, rw, rh, ri, tc, tx, ty, ts, ti)
        Rectangle.new(
        x: rx, y: ry,
        width: rw, height: rh,
        color: 'random',
        z: ri
        )
        Text.new(
        tc,
        x: tx, y: ty,
        font: $fontFile,
        size: ts,
        color: '#FCFCFC',
        z: ti
        )
    end
    def self.getWeekCourse(_file, _whichWeek, _cl)
        gmu_arr = self.calWeek(_whichWeek)
        return self.parse(_file, _cl, gmu_arr[1], gmu_arr[2])
    end
    def self.sio2(init_type)
        fontName = 'C:\Windows\Fonts\simhei.ttf'
        $fontFile = File::exists?(fontName) ? fontName : nil
        self.top()
        week = Array(0..6)
        nW = 150
        nH = 50
        info = Array.new

        $courses.each do |course|
            info << self.parse_week(course)
        end
        info.each do |o|
            ol = o[1]
            l_raw = init_type == "w" ? o[3] : o[2]
            l_show = l_raw.length > 10 ? l_raw[0,10] : l_raw
            ol.each do |l|
                self.buildBlock((o[0] -1)*150, l*50, 150, 50, 1, l_show.center(16), (o[0] -1)*150, 50/3 + l*50, 12, 2)
            end
        end
    end
    def self.stone(whichWeek, cl, init_type=nil)
        file = File::expand_path("#{__FILE__}../../../../ext/less.xlsx")
        $courses = self.getWeekCourse(file, whichWeek, cl)
        self.sio2(init_type)
    end
    def self.softStone(file, whichWeek, cl, init_type=nil)
        $courses = self.getWeekCourse(file, whichWeek, cl)
        self.sio2(init_type)
    end
    def self.calWeek(i)
        t = Time.new
        tWeek = t.wday
        tWeek = 7 if tWeek == 0
        last = -1 * (tWeek - 1) + i * 7
        future = 7 - tWeek + i * 7
        return [tWeek, last, future]
    end

    def self.parse_week(course)
        #传入一天的course data
        #返回星期，课序，课程，地点。如1, [1,2], 课程, 地点
        _t =  course['C']
        lesson = course['D']
        arr = self.weekNum(_t)
        w = arr[0]
        t_raw = arr[2]
        t = self.tSplit(t_raw)
        wh = course['H']
        if wh.include?('实验室')
            wh.gsub!('实验室','')
            wh.gsub!(/（|）/, '')
        end
        return [w, t, lesson, wh]
    end
    def self.tSplit(str)
        # 传入Str，返回数组如第一第二节课(01020304)，返回[1,2]
        str_len = str.length
        b_num = str_len /2
        res_t = Array.new
        b_i = 0
        until b_i*4+3 >= str_len do
            l_t_str = "#{str[b_i*4+2]}#{str[b_i*4+3]}"
            l_t = l_t_str.to_i
            res_t << l_t/2
            b_i += 1
        end
        return res_t
    end
    def self.fOrNot(a, b, ele)
        arr = ele[1]
        return true if ele.include?(a) && arr.include?(b)
        return false
    end
    def self.flush(a, b, ele, m_down)
        t_raw = m_down % 2 == 0 ? ele[3] : ele[2]
        t_show = t_raw.length > 10 ? t_raw[0,10] : t_raw
        self.buildBlock((a -1)*150, b*50, 150, 50, 3 + m_down, t_show.center(16), (a -1)*150, 50/3 + b*50, 12, 4 + m_down)
    end
end