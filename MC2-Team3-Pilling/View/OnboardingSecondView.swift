//
//  PiriSecondView.swift
//  MC2-Team3-Pilling
//
//  Created by ram on 5/21/24.
//

import SwiftUI
import SwiftData
struct OnboardingSecondView: View {
    @State private var alarmTime: Date = Date()
    @State private var alarmToggle = false
    @Binding var pillInfo:PillInfo?
    @Binding var intakeDay:Int
    @State var isActive = false
    @Environment(\.modelContext) private var modelContext
    @Query var user:[UserInfo]
    
    
    
    
    var body: some View {
        VStack{
            Image("onboardingSecond")
                //.resizable()
                //.frame(width: 240, height: 240)
            
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
                    DatePicker("복용 시간", selection: $alarmTime, displayedComponents: .hourAndMinute)
                }
                .padding([.leading, .trailing], 15)
            }
            )
            .padding(.vertical, 15)
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
                dataSave()
            }) {
                Text("설정완료!")
                    .font(.title3)
                    .bold()
                    .padding(.vertical, 25)
                    .frame(maxWidth: .infinity)
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
        .onAppear{
            print(intakeDay)
        }
    }
    func dataSave(){
        if let selectePillInfo = pillInfo {
            modelContext.insert(selectePillInfo)
            
            let startIntake = Config.DateToString(date: Date(), format: Config.dayformat)
            
            let periodPill = PeriodPill(pillInfo: selectePillInfo, startIntake: startIntake)
            
            let startDate = Config.StringToDate(dateString: periodPill.startIntake, format: dayformat)
            let today = Config.daysFromStart(startDay: startDate!)
            
            let wholeDay = selectePillInfo.wholeDay
            for idx in 0..<wholeDay {
                let dayData = DayData(num: idx)
                //                    dayData.periodPill = periodPill
                modelContext.insert(dayData)
                periodPill.intakeCal.append(dayData)
            }
            
            //이미 지난 것은 복용 status=1로 변경
            if today>1{
                for idx in 0..<today{
                    periodPill.intakeCal[idx].status=1
                }
            }
            
            //위약 status 초기화
            for idx in pillInfo!.intakeDay..<wholeDay{
                periodPill.intakeCal[idx].status=3
            }
            
            modelContext.insert(periodPill)
            
            let scheduleTime = Config.DateToString(date: alarmTime, format: Config.Hourformat)
            let userInfo = UserInfo(scheduleTime: scheduleTime, curPill: periodPill)
            userInfo.isAlarm = alarmToggle
            
            modelContext.insert(userInfo)
            
            do {
                try modelContext.save()
                print("스데 저장 성공")
                isActive = true
            } catch {
                print("Failed to save context: \(error.localizedDescription)")
            }
            
        }
        else{
            
        }
    }
    
}

