//
//  PiriView.swift
//  MC2-Team3-Pilling
//
//  Created by ram on 5/21/24.
//


import SwiftUI

struct PiriView: View {
    @State private var showingMedicineSheet = false
    @State var isActive = false
    
    var body: some View {
        Image("making-plan")
            .resizable()
            .frame(width: 240, height: 240)
        
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
                //                MedicineSheetView(showingMedicineSheet: true)
                MedicineSheetView(showingMedicineSheet: $showingMedicineSheet)
                    .presentationDetents([.medium])
            }
            
            
            
            Button(action: {}, label: {
                // sfSymbol 부재 : uis-calender
                HStack {
                    Image(systemName: "note")
                    Text("현재 복용 일수")
                        .secondaryRegular()
                    Spacer()
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
                save()
                isActive = true // 네비게이션 링크를 활성화
            }, label: {
                Text("다음으로")
                    .largeBold()
            })
            .padding(.vertical, 30)
            .frame(maxWidth: .infinity)
            .background(Color.customGreen)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .foregroundColor(.black)
            .padding()
            //            NavigationLink(isPresented:isActive, destination: PiriSecondView()){
            //                EmptyView()
            //            }
            // 버튼과 네비게이션링크를 같이 띄우는 방법?
            NavigationLink(
                destination: PiriSecondView(),
                isActive: $isActive,
                label: {
                    EmptyView() // 보이지 않게 설정
                }
            )
        }
        
        
    }
    func save() -> PeriodPill{
        let pillInfo = Config().dummyPillInfos[0]
        let curIntakeDay = 5
        let currentDate = Date()
        let calendar = Calendar.current
        let startDate = calendar.date(byAdding: .day, value: -curIntakeDay, to: currentDate)
        let startIntakeString = Config().DateToString(date: startDate ?? currentDate,format:dayformat) //디폴트값 수정해야함
        return PeriodPill(pillInfo: pillInfo, startIntake: startIntakeString)
        
    }
    
}

#Preview {
    PiriView()
}
