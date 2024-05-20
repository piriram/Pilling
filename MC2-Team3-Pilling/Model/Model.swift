//
//  Model.swift
//  MC2-Team3-Pilling
//
//  Created by ram on 5/20/24.
//

import Foundation
import SwiftData

@Model
class UserInfo:Identifiable{
    let id:UUID
    var scheduleTime:DateComponents
    var curPill:PeriodPill
    var historyPill:[PeriodPill]
    var isAlarm:Bool
    var isSiri:Bool
    
    init(scheduleTime: DateComponents, curPill: PeriodPill) {
        self.id = UUID()
        self.scheduleTime = scheduleTime
        self.curPill = curPill
        self.historyPill = []
        self.isAlarm = false
        self.isSiri = false
    }
      
}

@Model
class PeriodPill:Identifiable{
    let id:UUID
    var pillInfo:PillInfo
    var startIntake:DateComponents
    var finishIntake:DateComponents?
    var intakeCal:[Int]
    var missDay:Int
    
    init(pillInfo: PillInfo, startIntake: DateComponents, finishIntake: DateComponents? = nil, intakeCal: [Int], missDay: Int) {
        self.id = UUID()
        self.pillInfo = pillInfo
        self.startIntake = startIntake
        self.intakeCal = intakeCal
        self.missDay = 0
    }
    
}

@Model
class PillInfo:Identifiable{
    let id:UUID
    var pillName:String
    var intakeDay:Int
    var placeboDay:Int
    var wholeDay:Int
    
    init(pillName: String, intakeDay: Int, placeboDay: Int) {
        self.id = UUID()
        self.pillName = pillName
        self.intakeDay = intakeDay
        self.placeboDay = placeboDay
        self.wholeDay = intakeDay+placeboDay
    }
}

