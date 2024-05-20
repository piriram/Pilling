//
//  ContentView.swift
//  MC2-Team3-Pilling
//
//  Created by 이소현 on 5/14/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    static let dateFormatter: DateFormatter = {
           let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yyyy_HH:mm:ss"
            return formatter
        }()
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var isTracking = false
    @State private var alarmTime = dateFormatter.date(from: "\(Date.now.formatted(date: .numeric, time: .omitted))_22:00:00")!

    var body: some View {
        NavigationStack{
            NavigationLink(destination: MainView()){
                Text("MainView")
            }
            NavigationLink(destination: OnboardingFirstView()){
                Text("OnboardingView")
            }
            Button(isTracking ? "end live activity" : "start live activity") {
                isTracking.toggle()
                if isTracking {
                    
                } else {
                    
                }
            }
            .buttonStyle(.bordered)
            if isTracking {
                Text(alarmTime, style: .relative)
            }
        }
        
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
