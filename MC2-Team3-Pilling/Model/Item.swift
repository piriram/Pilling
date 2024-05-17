//
//  Item.swift
//  MC2-Team3-Pilling
//
//  Created by 이소현 on 5/14/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
