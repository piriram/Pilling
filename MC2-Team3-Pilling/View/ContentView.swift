//
//  ContentView.swift
//  MC2-Team3-Pilling
//
//  Created by 이소현 on 5/14/24.
//

import SwiftUI
import SwiftData
import ActivityKit

struct ContentView: View {
    static let dateFormatter: DateFormatter = {
           let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yyyy_HH:mm:ss"
            return formatter
        }()
    @Environment(\.modelContext) private var modelContext

    @State private var isTracking = false
    @State private var alarmTime = dateFormatter.date(from: "\(Date.now.formatted(date: .numeric, time: .omitted))_12:00:00")!
    @State private var activity: Activity<LiveTimeAttributes>? = nil

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
              
            }
            

            Button(action: {
                    isTracking.toggle()
                    if isTracking {
                        // start live activity
                        let attributes = LiveTimeAttributes()
                        let state = LiveTimeAttributes.ContentState(restOfTime: alarmTime)
                        let content = ActivityContent<LiveTimeAttributes.ContentState>(state: state, staleDate: alarmTime.addingTimeInterval(600))
                        activity = try? Activity<LiveTimeAttributes>.request(attributes: attributes, content: content, pushType: nil)
                    } else {
                        // end live activity
                        let state = LiveTimeAttributes.ContentState(restOfTime: alarmTime)
                        let content = ActivityContent<LiveTimeAttributes.ContentState>(state: state, staleDate: alarmTime.addingTimeInterval(600))
                        Task {
                            await activity?.end(content, dismissalPolicy:.immediate)
                        }
                    }
            }, label: {
                Text(isTracking ? "end live activity" : "start live activity")
            })
            .buttonStyle(.bordered)
            if isTracking {
                HStack {
                    Text("알람까지 남은 시간")
                    Text(alarmTime, style: .relative)
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
