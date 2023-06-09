//
//  Date+Extension.swift
//  Calendar
//
//  Created by wangxu on 2023/3/30.
//

import UIKit

extension Date{
    
    static var currentComponets: DateComponents{
        return Calendar.current.dateComponents([.year, .month, .day, .weekday, .hour, .minute, .second], from: Date())
    }
    static var currentYear: Int{
        return Calendar.current.component(.year, from: Date())
    }
    static var currentMonth: Int{
        return Calendar.current.component(.month, from: Date())
    }
    static var currentDay: Int{
        return Calendar.current.component(.day, from: Date())
    }
    static var currentHour: Int{
        return Calendar.current.component(.hour, from: Date())
    }
    static var currentMinute: Int{
        return Calendar.current.component(.minute, from: Date())
    }
    static var currentSecond: Int{
        return Calendar.current.component(.second, from: Date())
    }
    static func dateWithyyyyMMdd(str: String) -> Date? {
        let dateFmt = DateFormatter()
        dateFmt.dateFormat = "yyyy-MM-dd"
        let tempDate = dateFmt.date(from: str) ?? Date()
        let interval = Int(tempDate.timeIntervalSince1970) + 8*60*60
        let date = Date.init(timeIntervalSince1970: TimeInterval(interval))
//        print(date.toyyyy_MM_dd_HH_mm_ss)
        return date
        
    }
    static func dateWithyyyyMMddHHmmss(str: String) -> Date? {
        let dateFmt = DateFormatter()
        dateFmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let tempDate = dateFmt.date(from: str) ?? Date()
        let interval = Int(tempDate.timeIntervalSince1970) + 8*60*60
        let date = Date.init(timeIntervalSince1970: TimeInterval(interval))
//        print(date.toyyyy_MM_dd_HH_mm_ss)
        return date
    }
    static func dateWith(year: Int, month: Int, day: Int) -> Date?{
        let monthStr = month < 10 ? "0\(month)" : "\(month)"
        let dayStr = day < 10 ? "0\(day)" : "\(day)"
        let time = "\(year)-\(monthStr)-\(dayStr)"
        return dateWithyyyyMMdd(str: time)
    }
    static func dateWith(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) -> Date?{
        let monthStr = month < 10 ? "0\(month)" : "\(month)"
        let dayStr = day < 10 ? "0\(day)" : "\(day)"
        let hourStr = hour < 10 ? "0\(hour)" : "\(hour)"
        let minuteStr = minute < 10 ? "0\(minute)" : "\(minute)"
        let secondStr = second < 10 ? "0\(second)" : "\(second)"
        let time = "\(year)-\(monthStr)-\(dayStr) \(hourStr):\(minuteStr):\(secondStr)"
        return dateWithyyyyMMddHHmmss(str: time)
    }
    static func dateWith(_ dateString: String?, withFormat format: String) -> Date? {
        if dateString == nil {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: dateString!)
    }
}
extension Date{
    
    
    func getWeekDay()->Int{
//        let dateFmt = NSDateFormatter()
//        dateFmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        let date = dateFmt.dateFromString(dateTime)
        let interval = Int(self.timeIntervalSince1970) + NSTimeZone.local.secondsFromGMT()
        let days = Int(interval/(24*60*60))
        let weekday = ((days + 4)%7+7)%7
        
        return weekday == 0 ? 7 : weekday
    }
    func getWeekDayChinese()->String{
        var arr = ["一", "二", "三", "四", "五", "六", "日"]
        return arr[getWeekDay()-1]
    }
    func getFirstDayWeekDay() -> Int{
        let year = self.year() ?? 1
        let month = self.month() ?? 1
        let date = Date.dateWith(year: year, month: month, day: 1)
        
        let interval = Int(date!.timeIntervalSince1970)
        let days = Int(interval/(24*60*60))
        let weekday = ((days + 4)%7+7)%7
        
        return weekday == 0 ? 7 : weekday
    }
    func getComponets()->DateComponents{
        return Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second, .weekday], from: self)
    }
    func year() -> Int?{
        self.getComponets().year
    }
    func month() -> Int?{
        self.getComponets().month
    }
    func day() -> Int?{
        self.getComponets().day
    }
    func hour() -> Int?{
        self.getComponets().hour
    }
    func minute() -> Int?{
        self.getComponets().minute
    }
    func weekDay() -> Int?{//星期天是1 星期一是2...
        self.getComponets().weekday
    }
    //获取某月的天数
    func getMonthDaysCount() -> Int{
        var count = 0
//        let year = Calendar.current.component(.year, from: self)
        let month = Calendar.current.component(.month, from: self)
        if month == 2{
            count = self.isLeapYear() ? 29 : 28
        }else if month == 4 || month == 6 || month == 9 || month == 11{
            count = 30
        }else{
            count = 31
        }
        return count
    }
    //判断某年是不是闰月
    func isLeapYear() -> Bool{
        let year = Calendar.current.component(.year, from: self)
        if (year % 4 == 0 && year % 100 != 0) || year % 400 == 0{
            return true
        }else{
            return false
        }
    }
    
    func toStringWithFormat(_ format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    var toyyyy_MM_dd_HH_mm_ss: String {
        return toStringWithFormat("yyyy-MM-dd HH:mm:ss")
    }
    var toyyyyMMddHHmmss: String {
        return toStringWithFormat("yyyyMMddHHmmss")
    }
    var toyyyy_MM_dd: String{
        return toStringWithFormat("yyyy-MM-dd")
    }
    var toyyyy_MM_dd_HH: String{
        return toStringWithFormat("yyyy-MM-dd HH")
    }
    var toyyyy_MM_dd_HH_mm: String {
        return toStringWithFormat("yyyy-MM-dd HH:mm")
    }
    //下个月的这一天
    func getDateWithAfterMonth() -> Date?{
        var year = self.year()!
        var month = self.month()!
        if month == 12{
            year += 1
            month = 1
        }else{
            month += 1
        }
        let tempD = Date.dateWith(year: year, month: month, day: 1)
        let daysCount = tempD?.getMonthDaysCount() ?? 0
        
        if self.day()! > daysCount{
            print("目标月份天数不够")
            return nil
        }
        
        var interval = self.timeIntervalSince1970
        interval = interval + Double(daysCount) * 24 * 60 * 60
        let date = Date.init(timeIntervalSince1970: interval)
        return date
    }
    //上个月的这一天
    func getDateWithBeforeMonth() -> Date?{
        
        var year = self.year()!
        var month = self.month()!
        if month == 1{
            year -= 1
            month = 12
        }else{
            month -= 1
        }
        let tempD = Date.dateWith(year: year, month: month, day: 1)
        let daysCount = tempD?.getMonthDaysCount() ?? 0
        
        if self.day()! > daysCount{
            print("目标月份天数不够")
            return nil
        }
        
        var interval = self.timeIntervalSince1970
        interval = interval - Double(daysCount) * 24 * 60 * 60
        let date = Date.init(timeIntervalSince1970: interval)
        return date
    }
    //下个月的 (第一天)
    func getDateWithAfterMonthFirstDay() -> Date{
        var year = self.year()!
        var month = self.month()!
        if month == 12{
            year += 1
            month = 1
        }else{
            month += 1
        }
        let date = Date.dateWith(year: year, month: month, day: 1)
        
        return date!
    }
    //上个月的 (第一天)
    func getDateWithBeforeMonthFirstDay() -> Date{
        
        var year = self.year()!
        var month = self.month()!
        if month == 1{
            year -= 1
            month = 12
        }else{
            month -= 1
        }
        let date = Date.dateWith(year: year, month: month, day: 1)
        return date!
    }
    func getDateWithAfterDay(day: Int) -> Date{
        var interval = self.timeIntervalSince1970
        interval = interval + Double(day)*24*60*60
        let date = Date.init(timeIntervalSince1970: interval)
        return date
    }
    func getDateWithBeforeDay(day: Int) -> Date{
        var interval = self.timeIntervalSince1970
        interval = interval - Double(day)*24*60*60
        let date = Date.init(timeIntervalSince1970: interval)
        return date
    }
    
    /// 获取时间间隔天数
    /// - Returns: <#description#>
    func getIntervalDaysCount(targetTime: Date)->Int{
        let start = self.timeIntervalSince1970
        let target = targetTime.timeIntervalSince1970
        let count = ceil((target - start)/(24*60*60))//向上取整
        return Int(count)
    }
}

/// 假期扩展 2023年
extension Date{
    
    func getHoliDay() -> WXHoliDay{
        
        var isWork: Bool?
        var name: String?
        
        if self.year() == 2022{
            if self.month() == 12, self.day() == 31{
                isWork = false
            }
        }else if self.year() == 2023{
            switch self.month() {
            case 1:
                if self.day() == 1{
                    isWork = false
                    name = "元旦"
                }
                if self.day() == 2{
                    isWork = false
                }
                
            case 4:
                if self.day() == 5{
                    isWork = false
                    name = "清明"
                }
                if self.day() == 23{
                    isWork = true
                }
                if self.day() == 29{
                    isWork = false
                }
            case 5:
                if self.day() == 1{
                    isWork = false
                    name = "劳动节"
                }else if self.day() == 2 || self.day() == 3{
                    isWork = false
                }else if self.day() == 6{
                    isWork = true
                }
            case 6:
                if self.day() == 22{
                    isWork = false
                    name = "端午"
                }else if self.day() == 23 || self.day() == 24{
                    isWork = false
                }else if self.day() == 25{
                    isWork = true
                }
            case 9:
                if self.day() == 29{
                    isWork = false
                    name = "中秋"
                }else if self.day() == 30{
                    isWork = false
                }
            case 10:
                if self.day() == 1 {
                    isWork = false
                    name = "国庆"
                }else if self.day() == 2 || self.day() == 3 || self.day() == 4 || self.day() == 5 || self.day() == 6{
                    isWork = false
                }else if self.day() == 7 || self.day() == 8{
                    isWork = true
                }
            default:
                break
            }
        }
        let holiday = WXHoliDay.init(isWork: isWork, name: name)
        return holiday
    }
}

struct WXHoliDay{
    var isWork: Bool?
    var name: String?
    
    init(isWork: Bool? = nil, name: String? = nil) {
        self.isWork = isWork
        self.name = name
    }
}
