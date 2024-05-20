//
//  Config.swift
//  MC2-Team3-Pilling
//
//  Created by ram on 5/20/24.
//

import Foundation

class Config{
    enum IntakeStatus: Int {
        case notYet = 0
        case onePill = 1
        case twoPills = 2
        case placebo = 3
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
    
    
    
}
