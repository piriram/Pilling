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
    @Query var user:[UserInfo]
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            UserInfo.self,
            PeriodPill.self,
            DayData.self,
            PillInfo.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                SplashScreenView()
            }
            
        }
        .modelContainer(sharedModelContainer)
    }
}
