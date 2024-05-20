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
    
    let days = ["일", "월", "화", "수", "목", "금", "토"]
    func DayDateToString(date: Date) -> String {
        let format = "yyyy-MM-dd HH:mm:ss"
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    func DayStringToDate(dateString: String) -> Date? {
        let format = "yyyy-MM-dd HH:mm:ss"
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: dateString)
    }
    func AlarmDateToString(date: Date) -> String {
        let format = "HH:mm"
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    func AlarmStringToDate(dateString: String) -> Date? {
        let format = "HH:mm"
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current 
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: dateString)
    }
    
    
    
}
let myArray: [Int] = [1, 2 , 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 3, 3, 3]
var colorArr:[Color] = [.customGray,.customGreen,.customGreen,.white]

