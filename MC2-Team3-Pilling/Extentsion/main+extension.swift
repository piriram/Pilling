//
//  model+extension.swift
//  MC2-Team3-Pilling
//
//  Created by ram on 5/23/24.
//

import Foundation
import SwiftUI

extension MainView{
    func updateStatusNum(today: Int, sortedDay: [DayData]) -> Int {
        var statusNum = 0

        if today == 1 && sortedDay[today - 1].status == 0 { // 첫째날 -> 약먹어야함
            statusNum = 1
        } else if sortedDay[today - 1].status == 0 && sortedDay[today - 2].status == 1 { // 약먹어야함
            statusNum = 1
        } else if sortedDay[today - 1].status == 1 { // 약먹음 -> 윙크
            statusNum = 2
        } else if sortedDay[today - 1].status == 3 { // 위약
            statusNum = 3
        } else if today > 2 && sortedDay[today - 1].status == 0 && sortedDay[today - 2].status == 0 && sortedDay[today - 3].status == 0 { // 이틀째 안먹음
            statusNum = 5
        } else if sortedDay[today - 1].status == 0 && sortedDay[today - 2].status == 0 { // 어제 안먹음
            statusNum = 4
        } else {
            statusNum = 0
        }

        return statusNum
    }

    func updateStatusMessage(statusNum: Int) -> String {
        if let msg = Config.StatusMessage(rawValue: statusNum) {
            return msg.description
        } else {
            return ""
        }
    }

    func refreshData(today: Int, sortedDay: [DayData]) {
        statusNum = updateStatusNum(today: today, sortedDay: sortedDay)
        statusMessage = updateStatusMessage(statusNum: statusNum)
        
    }


}
