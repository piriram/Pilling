//
//  SettingView.swift
//  PillingTest
//
//  Created by Groo on 5/9/24.
//

import SwiftUI

struct SettingView: View {
    @State private var selectedAlarmTime = Date.now
    @State private var isSoundOn = false
    @State private var selectedPill = 0
    @State private var isShowingPills = false
    let pills = [(name: "야즈", type: "24일/4일"), (name: "머쉬론", type: "21일/7일")]
    var body: some View {
        NavigationStack {
            Form {
                Section("약 패키지") {
                    Button(action: {
                        isShowingPills = true
                    }, label: {
                        HStack {
                            Text(pills[selectedPill].name)
                            Text(pills[selectedPill].type)
                        }
                    })
                    Picker("Pill", selection: $selectedPill) {
                        ForEach(0..<2) { index in
                            HStack {                                Text(pills[index].name)
                                    .bold()
                                Text(pills[index].type)
                                    .font(.subheadline)
                            }
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section("알림") {
                    DatePicker("시간", selection: $selectedAlarmTime, displayedComponents: .hourAndMinute)
                        
                    Toggle("알람", isOn: $isSoundOn)
                    
                }
            }
            .navigationTitle("Settings")
            .sheet(isPresented: $isShowingPills, content: {
                Text("Pills")
                    .presentationDetents([.height(300), .large])
            })
            .background(Color.white)
            .scrollContentBackground(.hidden)
        }
    }
}

#Preview {
    SettingView()
}
