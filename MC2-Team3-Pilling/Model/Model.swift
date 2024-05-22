//
//  Model.swift
//  MC2-Team3-Pilling
//
//  Created by ram on 5/20/24.
//

import Foundation
import SwiftData

@Model
final class UserInfo:Identifiable{
    @Attribute(.unique) var id:UUID
    var scheduleTime:String
    var curPill:PeriodPill
    var historyPill:[PeriodPill] = [PeriodPill]()
    var isAlarm:Bool
    var isSiri:Bool
    
    init(scheduleTime: String, curPill: PeriodPill) {
        self.id = UUID()
        self.scheduleTime = scheduleTime
        self.curPill = curPill
        self.historyPill = []
        self.isAlarm = false
        self.isSiri = false
        
    }
}

@Model
final class PeriodPill:Identifiable{
    @Attribute(.unique) let id:UUID
    var pillInfo:PillInfo
    var startIntake:String
    var finishIntake:String?
    var intakeCal:[DayData]
    var missDay:Int
    
    init(pillInfo: PillInfo, startIntake: String) {
        self.id = UUID()
        self.pillInfo = pillInfo
        self.startIntake = startIntake
        self.intakeCal = Array(repeating: DayData(), count: 30)
        self.missDay = 0
        self.finishIntake = nil
    }
    
}

@Model
final class DayData:Identifiable{
    @Attribute(.unique) let id:UUID
    var status:Int
    var time:String?
    var sideEffect:[Bool]
    var memo:String
    
    init() {
        self.id = UUID()
        self.status = 0
        self.sideEffect = [false,false,false]
        self.memo = ""
        self.time = nil
    }
    
    
}

@Model
final class PillInfo:Identifiable{
    @Attribute(.unique) let id:UUID
    var pillName:String
    var intakeDay:Int
    var placeboDay:Int
    var wholeDay:Int
    var descriptionInfo:String?
    var type:String?
    
    init(pillName: String, intakeDay: Int, placeboDay: Int) {
        self.id = UUID()
        self.pillName = pillName
        self.intakeDay = intakeDay
        self.placeboDay = placeboDay
        self.wholeDay = intakeDay+placeboDay
        self.descriptionInfo = nil
        self.type = nil
    }
    
}
