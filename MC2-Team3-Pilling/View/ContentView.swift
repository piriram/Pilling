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
                NavigationLink(destination: OnboardingSecondView()){
                    Text("OnboardingSecondView")
                }
                NavigationLink(destination: SwiftDataTestView()){
                    Text("SwiftDataTestView")
                }
                NavigationLink(destination: SplashScreenView()){
                    Text("SplashScreenView")
                }

                NavigationLink(destination: ChooseStatusView()){
                    Text("ChooseStatusView")
                }
                NavigationLink(destination: PiriFirstView()){
                    Text("PiriView")
                }
                NavigationLink(destination: LiveActivityTestView()){
                    Text("LiveActivityTestView")
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
    
    //    private func deleteItems(offsets: IndexSet) {
    //        withAnimation {
    //            for index in offsets {
    //                modelContext.delete(items[index])
    //            }
    //        }
    //    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
