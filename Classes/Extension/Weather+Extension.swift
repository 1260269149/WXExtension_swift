//
//  Weather+Extension.swift
//  Calendar
//
//  Created by wangxu on 2023/4/3.
//

import UIKit
import WeatherKit

extension Weather{
    
    
    
}

extension CurrentWeather{
    func getTemperatureDes() -> String{
        var des = ""
        let cha = self.temperature.value - self.apparentTemperature.value
        if cha < -2{
            des = "比实际温度偏热"
        }else if cha < 2{
            des = "与实际温度相似"
        }else{
            des = "比实际温度偏冷"
        }
        return des
    }
}
extension PressureTrend{
    func getPressureDes()->String{
        var str = ""
        switch self {
        case .falling:
            str = "气压正在下降"
        case .rising:
            str = "气压正在上升"
        case .steady:
            str = "气压保持不变"
        default:
            str = ""
        }
        return str
    }
}
extension Measurement<UnitLength>{
    func getVisibilityDes() -> String{
        /*
         1.能见度20-30公里 能见度极好 视野清晰
         2.能见度15-25公里 能见度好 视野较清晰
         3.能见度10-20公里 能见度一般
         4.能见度5-15公里 能见度较差 视野不清晰
         5.能见度1-10公里 轻雾 能见度差 视野不清晰
         6.能见度0.3-1公里 大雾 能见度很差
         7.能见度小于0.3公里 重雾 能见度极差
         8.能见度小于0.1公里 浓雾 能见度极差
         9 能见度不足100米通常被认为为零
         */
        
        var str = ""
        if self.value >= 20{
            str = "能见度极好 视野清晰"
        }else if self.value >= 10{
            str = "能见度好 视野较清晰"
        }else if self.value >= 5{
            str = "能见度一般 视野不太清晰"
        }else if self.value >= 1{
            str = "轻雾 能见度差 视野不清晰"
        }else if self.value >= 0.3{
            str = "大雾 能见度差"
        }else if self.value >= 0.1{
            str = "重雾 能见度很差"
        }else{
            str = "浓雾 能见度极差"
        }
        
        return str
    }
}
extension WeatherCondition{
    func getChaniesDes() -> String{
        var str = ""
        switch self {
            
        case .blizzard:
            str = "暴雪"
        case .blowingDust:
            str = "沙尘暴"
        case .blowingSnow:
            str = "小雪"
        case .breezy:
            str = "微风"
        case .clear:
            str = "晴"
        case .cloudy:
            str = "多云"
        case .drizzle:
            str = "小雨"
        case .flurries:
            str = "小雪"
        case .foggy:
            str = "雾"
        case .freezingDrizzle:
            str = "冷雨"
        case .freezingRain:
            str = "冻雨"
        case .frigid:
            str = "结冰"
        case .hail:
            str = "冰雹"
        case .haze:
            str = "雾霾"
        case .heavyRain:
            str = "大雨"
        case .heavySnow:
            str = "大雪"
        case .hot:
            str = "高温"
        case .hurricane:
            str = "飓风"
        case .isolatedThunderstorms:
            str = "小部分雷暴"
        case .mostlyClear:
            str = "晴"
        case .mostlyCloudy:
            str = "多云"
        case .partlyCloudy:
            str = "局部多云"
        case .rain:
            str = "雨"
        /// Numerous thunderstorms spread across up to 50% of the forecast area.
        case .scatteredThunderstorms:
            str = "局部雷暴"
        case .sleet:
            str = "雨夹雪"
        case .smoky:
            str = "雾"
        case .snow:
            str = "雪"
        /// Notably strong thunderstorms.
        case .strongStorms:
            str = "强雷暴"
        case .sunFlurries:
            str = "太阳雪"
        case .sunShowers:
            str = "太阳雨"
        case .thunderstorms:
            str = "雷雨"
        case .tropicalStorm:
            str = "热带风暴"
        case .windy:
            str = "大风"
        case .wintryMix:
            str = "寒冷混合"
        default:
            break
        }
        return str
    }
}
extension Wind{
    
    /// 通过风速换算风级
    /// - Returns: 级别
    func getWindRank()->Int{
        
        let speed = self.speed.value * 1000 / 3600 //换算为m/s
        var rank: Int = 12
        if speed < 0.3{
            rank = 0
        }else if speed < 1.6{
            rank = 1
        }else if speed < 3.4{
            rank = 2
        }else if speed < 5.5{
            rank = 3
        }else if speed < 8.0{
            rank = 4
        }else if speed < 10.8{
            rank = 5
        }else if speed < 13.9{
            rank = 6
        }else if speed < 17.2{
            rank = 7
        }else if speed < 20.8{
            rank = 8
        }else if speed < 24.5{
            rank = 9
        }else if speed < 28.5{
            rank = 10
        }else if speed < 32.5{
            rank = 11
        }
        return rank
    }
    
    /// 获取风向
    /// - Returns: 风向（中文）
    func getWindDirection() -> String{
        var str = ""
        switch self.compassDirection {
        case .east:
            str = "东风"
        case .eastNortheast:
            str = "东北风"
        case .eastSoutheast:
            str = "东南风"
        case .north:
            str = "北风"
        case .northNortheast:
            str = "东北风"
        case .northNorthwest:
            str = "西北风"
        case .northeast:
            str = "东北风"
        case .northwest:
            str = "西北风"
        case .south:
            str = "南风"
        case .southSoutheast:
            str = "东南风"
        case .southSouthwest:
            str = "西南风"
        case .southeast:
            str = "东南风"
        case .southwest:
            str = "西南风"
        case .west:
            str = "西风"
        case .westNorthwest:
            str = "西北风"
        case .westSouthwest:
            str = "西南风"
        default:
            break
        }
        return str
    }
}
extension UVIndex{
    func getExposureCategoryDes() -> String{
        var str = ""
        switch self.category {
        case .low:
            str = "最弱"
        case .moderate:
            str = "弱"
        case .high:
            str = "中等"
        case .veryHigh:
            str = "强"
        case .extreme:
            str = "极强"
        default:
            break
        }
        return str
    }
    
    /// 获取提示语
    /// - Returns: <#description#>
    func getExposureCategoryHintString() -> String{
        var str = ""
        switch self.category {
        case .low:
            str = "不需采取防护措施"
        case .moderate:
            str = "对人体影响不大,可适当采取防护措施"
        case .high:
            str = "外出应采取防护措施,要用遮阳伞、遮阳衣帽、太阳镜等,涂擦防晒霜等"
        case .veryHigh:
            str = "外出应特别注意防护,中午前后宜减少外出"
        case .extreme:
            str = "尽可能避免外出,如要外出需采取严格的防晒措施。"
        default:
            break
        }
        return str
    }
    
}
