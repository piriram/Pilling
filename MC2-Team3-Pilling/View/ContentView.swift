//
//  ContentView.swift
//  MC2-Team3-Pilling
//
//  Created by 이소현 on 5/14/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query private var user: [UserInfo] // 하나만 쓰고싶다면?
    
    var body: some View {
        NavigationStack{
            VStack(spacing:20){
                NavigationLink(destination: MainView()){
                    Text("MainView")
                }
                
                NavigationLink(destination: OnboardingFirstView()){
                    Text("OnboardingFirstView")
                }
                
                NavigationLink(destination: SwiftDataTestView()){
                    Text("SwiftDataTestView")
                }
                NavigationLink(destination: SplashScreenView()){
                    Text("SplashScreenView")
                }
                
                //                NavigationLink(destination: ChooseStatusView()){
                //                    Text("ChooseStatusView")
                //                }
                NavigationLink(destination: OnboardingFirstView()){
                    Text("PiriView")
                }
            }
        }
        
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
