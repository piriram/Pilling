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
    @Relationship var historyPill:[PeriodPill] = [PeriodPill]()
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
    @Relationship var pillInfo:PillInfo
    var startIntake:String
    var finishIntake:String? = nil
    var intakeCal:[Int]
    var intakeCalTime:[String]
    var missDay:Int
    
    init(pillInfo: PillInfo, startIntake: String) {
        self.id = UUID()
        self.pillInfo = pillInfo
        self.startIntake = startIntake
        self.intakeCal = []
        self.intakeCalTime = []
        self.missDay = 0
    }
    
}

@Model
final class PillInfo:Identifiable{
    @Attribute(.unique) let id:UUID
    var pillName:String
    var intakeDay:Int
    var placeboDay:Int
    var wholeDay:Int
    var descriptionInfo:String? = nil
    var type:String? = nil
    
    init(pillName: String, intakeDay: Int, placeboDay: Int) {
        self.id = UUID()
        self.pillName = pillName
        self.intakeDay = intakeDay
        self.placeboDay = placeboDay
        self.wholeDay = intakeDay+placeboDay
    }
    
}

