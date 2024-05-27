//
//  model+extension.swift
//  MC2-Team3-Pilling
//
//  Created by ram on 5/23/24.
//

import Foundation
import SwiftUI

extension MainView{
    func refreshData() {
        if today == 1 && sortedDay[today-1].status == 0{ //첫째날 -> 약먹어야함
            imageNum = 1
        }
        else if sortedDay[today-1].status == 0 && sortedDay[today-2].status==1{ // 약먹어야함
            imageNum = 1
        } else if sortedDay[today-1].status == 1{ // 약먹음 -> 윙크
            imageNum = 2
        }
        else if sortedDay[today-1].status == 3{ // 위약
            imageNum = 3
        }
        else if today > 2 && sortedDay[today-1].status == 0 && sortedDay[today-2].status==0 && sortedDay[today-3].status==0{ // 이틀째 안먹음
            imageNum = 5
        }
        else if sortedDay[today-1].status == 0 && sortedDay[today-2].status==0 { // 어제 안먹음
            imageNum = 4
        }
        else{
            imageNum = 0
        }
        
        if let msg = Config.StatusMessage(rawValue: imageNum){
            statusMessage = msg.description
        }
    }
}
