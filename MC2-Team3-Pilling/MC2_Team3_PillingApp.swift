//
//  MC2_Team3_PillingApp.swift
//  MC2-Team3-Pilling
//
//  Created by 이소현 on 5/14/24.
//

import SwiftUI
import SwiftData

@main
struct MC2_Team3_PillingApp: App {
    

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for:UserInfo.self)
    }
}
