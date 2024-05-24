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
        case plantGrass = 0
        case limitTwoHours = 6
        case plantTwoGrass = 4
        case grassGrowingWell = 2
        case notRecording = 5
        
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
    
//    static func AlarmStringToDate(dateString: String) -> Date? {
//        let format = "HH:mm"
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone.current
//        dateFormatter.dateFormat = format
//
//        return dateFormatter.date(from: dateString)
//    }
//    func AlarmDateToString(date: Date) -> String {
//        let format = "HH:mm"
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone.current
//        dateFormatter.dateFormat = format
//        return dateFormatter.string(from: date)
//    }
//    func AlarmStringToDate(dateString: String) -> Date? {
//        let format = "HH:mm"
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone.current
//        dateFormatter.dateFormat = format
//        return dateFormatter.date(from: dateString)
//    }
     
    static let dummyPillInfos: [PillInfo] = [
        PillInfo(pillName: "쎄스콘정", intakeDay: 21, placeboDay: 7),
        PillInfo(pillName: "미뉴렛정", intakeDay: 21, placeboDay: 7),
        PillInfo(pillName: "에이리스정", intakeDay: 21, placeboDay: 7),
        PillInfo(pillName: "머시론정", intakeDay: 21, placeboDay: 7),
        PillInfo(pillName: "보니타정", intakeDay: 21, placeboDay: 7),
        PillInfo(pillName: "마이보라", intakeDay: 21, placeboDay: 7),
        PillInfo(pillName: "미니보라30", intakeDay: 21, placeboDay: 7),
        PillInfo(pillName: "트리퀄라", intakeDay: 21, placeboDay: 7),
        PillInfo(pillName: "멜리안정", intakeDay: 21, placeboDay: 7),
        PillInfo(pillName: "센스베리정", intakeDay: 21, placeboDay: 7),
        PillInfo(pillName: "디어미정", intakeDay: 21, placeboDay: 7),
        PillInfo(pillName: "야스민정", intakeDay: 21, placeboDay: 7),
        PillInfo(pillName: "야즈정", intakeDay: 24, placeboDay: 4),
        PillInfo(pillName: "클래라정", intakeDay: 26, placeboDay: 2)
    ]
    
    static func findStartDay(curIntakeDay:Int) -> Date?{
        
        let currentDate = Date()
        let calendar = Calendar.current
        let startDate = calendar.date(byAdding: .day, value: -curIntakeDay, to: currentDate)
        
        return startDate
        
    }
    
//    static var fetchDescriptor: FetchDescriptor<DayData>
    
 
}
let myArray: [Int] = [1, 2 , 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 3, 3, 3]
var colorArr:[Color] = [.customGray,.customGreen,.customGreen,.white]
let days = ["일", "월", "화", "수", "목", "금", "토"]
let dayformat = "yyyy-MM-dd"
let dayToHourformat = "yyyy-MM-dd HH:mm:ss"
let Hourformat = "HH:mm"

