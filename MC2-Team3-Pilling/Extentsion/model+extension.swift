//
//  model+extension.swift
//  MC2-Team3-Pilling
//
//  Created by ram on 5/23/24.
//

import Foundation
import SwiftUI

extension Config{
    static let myArray: [Int] = [1, 2, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 3, 3, 3]
    static var colorArr: [Color] = [.customGray, .customGreen, .customGreen, .white]
    static let days = ["일", "월", "화", "수", "목", "금", "토"]
    static let dayformat = "yyyy-MM-dd"
    static let dayToHourformat = "yyyy-MM-dd HH:mm:ss"
    static let Hourformat = "HH:mm"
    
    
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
    
}
