//
//  PiriSecondView.swift
//  MC2-Team3-Pilling
//
//  Created by ram on 5/21/24.
//

import SwiftUI

struct PiriSecondView: View {
    @State private var alarmTime: Date = Date()
    @State private var alarmToggle = false
    @Binding var pillInfo:PillInfo
    @Binding var intakeDay:Int
    @State var isActive = false
    
    
    var body: some View {
        VStack{
            Image("clock")
                .resizable()
                .frame(width: 240, height: 240)
            
            // Text
            HStack {
                VStack(alignment: .leading) {
                    // Text
                    Text("알람 받을 시간을 설정해주세요!")
                        .largeBold()
                        .padding(.bottom, 2)
                    
                    Text("설정은 추후에 변경 가능합니다.")
                        .secondaryRegular()
                }
                Spacer()
            }
            .padding()
            
            
            Button(action: {
            }, label: {
                
                ZStack{
                    HStack {
                        Image(systemName: "clock")
                        Text("복용 시간")
                            .secondaryTitle()
                        Spacer()
                        
                    }
                    DatePicker("", selection: $alarmTime, displayedComponents: .hourAndMinute)
                    
                }
                .padding([.leading, .trailing], 20)
                
            }
            )
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity)
            .background(.customGray02)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .foregroundColor(.secondary)
            .padding()
            
            
            VStack(alignment: .leading){
                Toggle("소리 알람여부추가", isOn: $alarmToggle)
                    .regular()
                    .padding(.bottom, 2)
                
                HStack {
                    Image(systemName: "info.circle.fill")
                    Text("소리를 OFF하면 라이브 액티비티로만 알려줘요!")
                        .font(.callout)
                }
                .foregroundStyle(.secondary)
            }
            .padding()
            
            Spacer()
            
            Button(action: {
                isActive = true
            }) {
                Text("설정완료!")
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.customGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .foregroundColor(.black)
                    .padding()
            }
            
            // NavigationLink with isActive binding
            NavigationLink(destination: MainView(), isActive: $isActive) {
                EmptyView()
            }
            
        }
    }
    func save(alarmTime:Date,pillInfo:PillInfo,curIntakeDay:Int) -> PeriodPill{
        
        let currentDate = Date()
        let calendar = Calendar.current
        let startDate = calendar.date(byAdding: .day, value: -curIntakeDay, to: currentDate)
        let startIntakeString = Config().DateToString(date: startDate ?? currentDate,format:dayformat) //디폴트값 수정해야함
        return PeriodPill(pillInfo: pillInfo, startIntake: startIntakeString)
        
    }
}

