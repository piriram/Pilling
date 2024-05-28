//
//  Config.swift
//  MC2-Team3-Pilling
//
//  Created by ram on 5/20/24.
//

import Foundation
import SwiftUI
import SwiftData

class Config{
    enum IntakeStatus: Int {
        case notYet = 0 // .customgray
        case onePill = 1 // .customgreen
        case twoPills = 2 // .customgreen
        case placebo = 3 // .white
        
        var color: Color {
            switch self {
                case .notYet:
                    return .customGray
                case .onePill, .twoPills:
                    return .customGreen
                case .placebo:
                    return .white
            }
        }
    }
    
    enum StatusMessage: Int, CustomStringConvertible { //문구 변경 예정
            case plantGrass = 1
        case grassGrowingWell = 2
        case plantTwoGrass = 6
        case husic = 3
        case okTwoGrass = 4
        case notRecording = 5
            case limitTwoHours = 7
            
            
            var description: String {
                switch self {
                    case .plantGrass:
                        return "잔디를 심어주세요"
                    case .limitTwoHours:
                        return "잔디는 2시간을 초과하지 않게 심어주세요!"
                    case .plantTwoGrass:
                        return "2개의 잔디를 심어주세요"
                    case .grassGrowingWell:
                        return "잔디가 잘 자라고 있어요!"
                    case .notRecording:
                        return "기록을 안하고 계신가요?"
                    case .husic:
                        return "오늘은 잔디도 휴식중"
                    case .okTwoGrass:
                        return "하루라도 빠지면 효과가 감소해요"
                }
            }
        }
        
    
    
    
    static func AlarmStringToDate(dateString: String) -> Date? {
        let format = "MM/dd/yyyy_HH:mm:ss"
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = format
        
        return dateFormatter.date(from: "\(Date.now.formatted(date: .numeric, time: .omitted))_\(dateString):00") // 오늘 날짜의 지정한 알람 시간으로 live activity에 전달
    }
    
    static let dummyPillInfos: [PillInfo] = [
        PillInfo(pillName: "야즈정", intakeDay: 24, placeboDay: 4),
        PillInfo(pillName: "머시론정", intakeDay: 21, placeboDay: 7),
        PillInfo(pillName: "마이보라", intakeDay: 21, placeboDay: 7),
        PillInfo(pillName: "클래라정", intakeDay: 26, placeboDay: 2),
        PillInfo(pillName: "쎄스콘정", intakeDay: 21, placeboDay: 7),
        PillInfo(pillName: "미뉴렛정", intakeDay: 21, placeboDay: 7),
        PillInfo(pillName: "에이리스정", intakeDay: 21, placeboDay: 7),
        PillInfo(pillName: "보니타정", intakeDay: 21, placeboDay: 7),
        PillInfo(pillName: "미니보라 30", intakeDay: 21, placeboDay: 7),
        PillInfo(pillName: "트리퀄라", intakeDay: 21, placeboDay: 7),
        PillInfo(pillName: "멜리안정", intakeDay: 21, placeboDay: 7),
        PillInfo(pillName: "센스베리정", intakeDay: 21, placeboDay: 7),
        PillInfo(pillName: "디어미정", intakeDay: 21, placeboDay: 7),
        PillInfo(pillName: "야스민정", intakeDay: 21, placeboDay: 7),
        
    ]
    
    static func findStartDay(curIntakeDay:Int) -> Date?{
        
        let currentDate = Date()
        let calendar = Calendar.current
        let startDate = calendar.date(byAdding: .day, value: -curIntakeDay, to: currentDate)
        
        return startDate
        
    }
    
    static func DateToString(date: Date,format:String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    static func StringToDate(dateString: String,format:String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = format
        
        return dateFormatter.date(from: dateString)
    }
    
    static func daysFromStart(startDay: Date) -> Int {
        let calendar = Calendar.current
        let today = Date()
        let components = calendar.dateComponents([.day], from: startDay, to: today)
        
        return (components.day ?? 0) + 1 //시작날짜를 1일로 친다면 +1을 더해줌
    }
    
    static func dayIndex(from date: Date) -> Int? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: date)
        
        guard let weekday = components.weekday else { return nil }
        
        // weekday는 1(일요일)부터 7(토요일)까지 반환하므로 1을 뺍니다.
        return weekday - 1
    }
    
    static let days = ["일", "월", "화", "수", "목", "금", "토"]
    static let dayformat = "yyyy-MM-dd"
    static let dayToHourformat = "yyyy-MM-dd HH:mm:ss"
    static let Hourformat = "HH:mm"
    
    
}
