//
//  LiveTimeAttributes.swift
//  MC2-Team3-Pilling
//
//  Created by Groo on 5/20/24.
//

import Foundation
import ActivityKit

struct LiveTimeAttributes: ActivityAttributes {
    public typealias TimeStatus = ContentState
    
    public struct ContentState: Codable, Hashable {
        var restOfTime: Date
        var progressAmount: Double
    }
}
