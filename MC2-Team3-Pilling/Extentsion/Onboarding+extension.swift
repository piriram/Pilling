//
//  Onboarding+extension.swift
//  MC2-Team3-Pilling
//
//  Created by ram on 5/23/24.
//

import Foundation
import SwiftUI
import SwiftData

extension PiriSecondView{
    
    func findStartDay(pillInfo:PillInfo,curIntakeDay:Int) -> PeriodPill{
        
        let currentDate = Date()
        let calendar = Calendar.current
        let startDate = calendar.date(byAdding: .day, value: -curIntakeDay, to: currentDate)
        let startIntakeString = Config.DateToString(date: startDate ?? currentDate,format:dayformat) //디폴트값 수정해야함
        return PeriodPill(pillInfo: pillInfo, startIntake: startIntakeString)
        
    }
    
    
//    func save(){
//        let pillInfo = PillInfo(pillName: "야즈", intakeDay: 21, placeboDay: 4)
//        modelContext.insert(pillInfo)
//        //                pillInfo.printAllDetails()
//        
//        let dayData = DayData()
//        modelContext.insert(dayData) // 이거하니깐 오류안남 ㅠㅠㅠㅠㅠ
//        //                dayData.printAllDetails()
//        
//        let periodPill = PeriodPill(pillInfo: pillInfo, startIntake: "2024-05-13")
//        for _ in 0..<28 {
//            let dayData = DayData()
//            //                    dayData.periodPill = periodPill
//            modelContext.insert(dayData)
//            periodPill.intakeCal.append(dayData)
//        }
//        
//        modelContext.insert(periodPill)
//        periodPill.printAllDetails()
//        
//        
//        
//        let userInfo = UserInfo(scheduleTime: "17:00", curPill: periodPill)
//        print("--------")
//        //                print(userInfo.curPill.intakeCal.first?.status)
//        
//        modelContext.insert(userInfo)
//        
//        user.first?.curPill?.printAllDetails()
//        print(user.first?.curPill?.intakeCal.first?.status)
//        do {
//            try modelContext.save()
//            print("스데 저장 성공")
//        } catch {
//            print("Failed to save context: \(error.localizedDescription)")
//        }
//        isActive = true
//    }
}
