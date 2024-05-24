//
//  ChooseStatusView.swift
//  MC2-Team3-Pilling
//
//  Created by 이소현 on 5/21/24.
//

import SwiftUI
import SwiftData
// 복용 여부 enum
enum DosageType: Int, CaseIterable, Identifiable {
    case notYet = 0
    case onePill = 1
    case twoPills = 2
    
    var id: Self { self }
    
    var takingType: String {
        switch self {
        case .notYet:
            "미복용"
        case .onePill:
            "복용"
        case .twoPills:
            "2알 복용"
        }
    }
}

struct ChooseStatusView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var user:[UserInfo]
    
    @State private var takeMedicineTime: Date = Date()
    
    // 부작용 섹션 vars
    @State private var irrBleedingToggle = false
    @State private var nauseaToggle = false
    @State private var swellingToggle = false
    @State var sideEffectMemo: String = ""
    
    @State private var dosageType: DosageType = .notYet
    
    @Binding var showingChooseStatus: Bool
    @Binding var dayData: DayData
    
    
    var body: some View {
        VStack(spacing:20) {
            // 현재일 / 전체복용일수
            HStack {
                Text("\(dayData.num+1)일차")
                    .largeTitle()
                Text("/\(String(describing: user.first?.curPill?.pillInfo.wholeDay ?? 40))")
                    .secondaryTitle()
                
                Spacer()
            }
            
            ScrollView() {
                // 약 복용 여부 확인
                Picker("selection", selection: $dosageType) {
                    ForEach(DosageType.allCases) { dosageType in
                        Text("\(dosageType.takingType)")
                            .tag(dosageType.rawValue)
                        
                    }
                }
                .pickerStyle(.segmented)
                .padding(.vertical, 10)
                .onChange(of: dosageType) { oldValue, newValue in
                    dayData.status = newValue.rawValue
                }
                
                
                // 복용시간 버튼
                Button(action: {
                    
                }, label: {
                    ZStack{
                        HStack {
                            Image(systemName: "clock")
                            Text("복용 시간")
                                .secondaryRegular()
                            Spacer()
                            
                        }
                        DatePicker("", selection: $takeMedicineTime, displayedComponents: .hourAndMinute)
                            .onChange(of: takeMedicineTime) { oldValue, newValue in
                                let newTakeMedicTimeToString = Config.DateToString(date: newValue, format: Hourformat)
                                dayData.time = newTakeMedicTimeToString
                            }
                        
                    }
                    .padding([.leading, .trailing], 20)
                })
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
                .background(.customGray02)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .foregroundColor(.secondary)
                
                
                
                // 부작용 섹션
                VStack(spacing: 16) {
                    
                    Toggle("부정출혈", isOn: $irrBleedingToggle)
                    
                    Toggle("구역질", isOn: $nauseaToggle)
                    
                    Toggle("붓기", isOn: $swellingToggle)
                    
                    
                    HStack {
                        TextField("관련 사항 메모", text: $sideEffectMemo)
                            .padding(10)
                            .background(Color(uiColor: .secondarySystemBackground))
                            .cornerRadius(10)
                    }
                }
                .padding([.top, .bottom], 15)
                .padding([.leading, .trailing], 10)
                
            }
            
            // footer button
            Button(action: {
                self.showingChooseStatus = false
            }, label: {
                Text("수정")
                    .font(.title3)
                    .bold()
            })
            .padding(.vertical, 25)
            .frame(maxWidth: .infinity)
            .background(.customGreen)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .foregroundColor(.black)
            
        }
        .padding(25)
        .onAppear {
            takeMedicineTime = Config.StringToDate(dateString: dayData.time!, format: Hourformat)!
        }
    }
}

//#Preview {
//    @State private var showingMedicineSheet = false
////    ChooseStatusView()
//    MainView(showingMedicineSheet: $showingMedicineSheet)
//}
