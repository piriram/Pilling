//
//  ChooseStatusView.swift
//  MC2-Team3-Pilling
//
//  Created by 이소현 on 5/21/24.
//

import SwiftUI

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
//    @State private var selectedNum = 0
    @State private var takeMedicineTime: Date = Date()
    
    // 부작용 섹션 vars
    @State private var irrBleedingToggle = false
    @State private var nauseaToggle = false
    @State private var swellingToggle = false
    @State var sideEffectMemo: String = ""
    
    @State private var dosageType: DosageType = .notYet
    
//    @Binding var showingChooseStatus: Bool
//    
    
    var body: some View {
        VStack {
            // 현재일 / 전체복용일수
            HStack {
                Text("4일차")
                    .largeTitle()
                Text("/28")
                    .secondaryTitle()
                
                Spacer()
            }
            
            ScrollView() {
                // 약 복용 여부 확인
                Picker("selection", selection: $dosageType) {
                    ForEach(DosageType.allCases) { dosageType in
                        Text("\(dosageType.takingType)").tag(dosageType.rawValue)
                    }
                }

                .pickerStyle(.segmented)
                .padding(.vertical, 15)
                // selection Print 되는 값 확인
                //            .onChange(of: selectedNum) { newValue in
                //                print("Selected number: \(newValue)")
                //            }

                
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
                    }
                    .padding([.leading, .trailing], 20)
                })
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .background(.customGray02)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .foregroundColor(.secondary)
                
                
                
                // 부작용 섹션
                VStack {
                    Toggle("부정출혈", isOn: $irrBleedingToggle)
                    
                    Toggle("구역질", isOn: $nauseaToggle)
                    
                    Toggle("붓기", isOn: $swellingToggle)
                    
                    
                    HStack {
                        Text("메모")
                            .padding(.trailing, 10)
                        TextField("", text: $sideEffectMemo)
                            .padding(5)
                            .background(Color(uiColor: .secondarySystemBackground))
                    }
                }
                .padding([.top, .bottom], 15)
                .padding([.leading, .trailing], 10)
                
            }
            
            // footer button
            Button(action: {
//                self.showingChooseStatus = false
            }, label: {
                Text("수정")
                    .font(.title3)
                    .bold()
            })
            .padding(.vertical, 30)
            .frame(maxWidth: .infinity)
            .background(.customGreen)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .foregroundColor(.black)
            
        }
            
        .padding(25)
        
    }
}

#Preview {
//    ChooseStatusView()
    MainView()
}
