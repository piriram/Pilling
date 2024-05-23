//
//  PiriView.swift
//  MC2-Team3-Pilling
//
//  Created by ram on 5/21/24.
//


import SwiftUI

struct OnboardingFirstView: View {
    @State private var showingMedicineSheet = false
    @State private var selectedPill: PillInfo?
    @State var isActive = false
    @State var pillInfo = PillInfo(pillName: "야즈", intakeDay: 24, placeboDay: 4)
    @State var selectedTakingDays = 4
    
    var body: some View {
        VStack{
            Rectangle()
                .background(Color.white)
                .frame(height: 30)
                .foregroundColor(.white)
            Image("onboardingFirst")
            
            
            // Text
            HStack {
                VStack(alignment: .leading) {
                    Text("복용하고 계신 약을 알려주세요!")
                        .largeBold()
                        .padding(.bottom, 2)
                    
                    Text("설정은 추후에 변경 가능합니다.")
                        .secondaryRegular()
                }
                Spacer()
            }
            .padding()
            
            
            // Selecting box
            VStack {
                Button(action: {
                    self.showingMedicineSheet = true
                }, label: {
                    // sfSymbol 부재 : medicine-bottle-one
                    HStack {
                        Image(systemName: "pill.circle.fill")
                        Text("약 종류")
                            .secondaryRegular()
                        Spacer()
                        
                        // Optional 해결방법
                        if let selectedPill = selectedPill{
                            Text(selectedPill.pillName)
                        }
                        
                        Image(systemName: "chevron.right")
                    }
                    .padding([.leading, .trailing], 25)
                })
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .background(.customGray02)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .foregroundColor(.secondary)
                .padding([.leading, .trailing], 16)
                .sheet(isPresented: $showingMedicineSheet){
                    MedicineSheetView(showingMedicineSheet: $showingMedicineSheet, selectedPill: $selectedPill)
                        .presentationDetents([.medium])
                }
                
                
                
                Button(action: {}, label: {
                    // sfSymbol 부재 : uis-calender
                    
                    HStack {
                        Image(systemName: "note")
                        Text("현재 복용 일수")
                            .secondaryRegular()
                        Spacer()
                        
                        // Picker
                        Picker("", selection: $selectedTakingDays) {
                            ForEach(1 ..< 28) { num in
                                Text("\(num)")
                            }
                        }
                        .pickerStyle(.menu)
                        .padding(-10)
                        .accentColor(Color.secondary)
                        
                        Text("일 차")
                        
                    }
                    .padding([.leading, .trailing], 25)
                })
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .background(.customGray02)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .foregroundColor(.secondary)
                .padding([.leading, .trailing], 16)
                
            }
            
            Spacer()
            
            VStack {
                // footer button
                Button(action: {
                    pillInfo = Config.dummyPillInfos[1]
                    print("pillInfo.pillName:\(pillInfo.placeboDay)")
                    selectedTakingDays = 5
                    isActive = true // 네비게이션 링크를 활성화
                    
                }, label: {
                    Text("다음으로")
                        .largeBold()
                })
                .padding(.vertical, 25)
                .frame(maxWidth: .infinity)
                .background(selectedPill == nil ? Color.customGray : Color.customGreen)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .foregroundColor(.black)
                .padding()
                .disabled(selectedPill == nil)
                
                // 버튼과 네비게이션링크를 같이 띄우는 방법?
                
                NavigationLink(
                    destination: OnboardingSecondView(pillInfo: $selectedPill, intakeDay: $selectedTakingDays),
                    isActive: $isActive,
                    label: {
                        EmptyView() // 보이지 않게 설정
                    }
                )
            }
        }
    }
}
