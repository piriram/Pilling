//
//  Config.swift
//  MC2-Team3-Pilling
//
//  Created by ram on 5/20/24.
//

import Foundation
import SwiftUI

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
        case limitTwoHours = 1
        case plantTwoGrass = 2
        case grassGrowingWell = 3
        case notRecording = 4
        
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
    
    
    func DateToString(date: Date,format:String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    func StringToDate(dateString: String,format:String) -> Date? {
           
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = format

            return dateFormatter.date(from: dateString)
        }
    
    func AlarmStringToDate(dateString: String) -> Date? {
        let format = "HH:mm"
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = format

        return dateFormatter.date(from: dateString)
    }
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
 
}
let myArray: [Int] = [1, 2 , 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 3, 3, 3]
var colorArr:[Color] = [.customGray,.customGreen,.customGreen,.white]
let days = ["일", "월", "화", "수", "목", "금", "토"]
let dayformat = "yyyy-MM-dd"
let dayToHourformat = "yyyy-MM-dd HH:mm:ss"
let Hourformat = "HH:mm"

