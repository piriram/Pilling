//
//  SettingView.swift
//  PillingTest
//
//  Created by Groo on 5/9/24.
//

import SwiftUI
import SwiftData

struct SettingView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var user:[UserInfo]
    
    @State private var selectedAlarmTime = Date()
    @State private var isSoundOn = false
//    @State private var selectedPill = 0
    @Binding var selectedPill: PillInfo?
    @State private var isShowingPills = false
    @Binding var showingMedicineSheet: Bool

    
    var body: some View {
        NavigationStack {
            Form {
                Section("약 패키지") {
                    //                    Picker("Pill", selection: $selectedPill) {
                    //                        ForEach(Config.dummyPillInfos) { pill in
                    //                            HStack {
                    //                                Text(pill.pillName)
                    //                                    .bold()
                    //                                Text("\(pill.intakeDay)" + "\\" + "\(pill.placeboDay)")
                    //                                    .secondaryRegular()
                    //                            }
                    //                            .tag(pill)
                    //                        }
                    //                    }
                    //                    .pickerStyle(.navigationLink)
                    
                    NavigationLink(destination: MedicineSheetView(showingMedicineSheet: $showingMedicineSheet, selectedPill: $selectedPill)) {
                        HStack {
                            Text("약 선택")
                            Spacer()
                            if let pill = selectedPill {
                                Text(pill.pillName)
                                    .foregroundColor(.gray)
                            } else {
                                Text("None")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                
                Section("알림") {
                    DatePicker("시간", selection: $selectedAlarmTime, displayedComponents: .hourAndMinute)
                        .onChange(of: selectedAlarmTime) { oldValue, newValue in
                            let newValueToString = Config.DateToString(date: newValue, format: Hourformat)
                            user.first?.scheduleTime = newValueToString
                            print(newValueToString)
                        }
                    
                    Toggle("알람", isOn: $isSoundOn)
                        .onChange(of: isSoundOn) { oldValue, newValueAlarm in
                            user.first?.isAlarm = newValueAlarm
                        }
                    // Optional, unWrapped
                    
                }
            }
            .onAppear{
                if let userInfo = user.first {
                    selectedPill = userInfo.curPill?.pillInfo
                    selectedAlarmTime = Config.StringToDate(dateString: userInfo.scheduleTime, format: Hourformat)!
//                    selectedAlarmTime = Config.DateToString(date: selectedAlarmTime, format: Hourformat)
                    isSoundOn = userInfo.isAlarm
                }
                
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            //            .sheet(isPresented: $isShowingPills, content: {
            //                Text("Pills")
            //                    .presentationDetents([.height(300), .large])
            //            })
            
        }
    }
}

//#Preview {
//    MainView()
//}
