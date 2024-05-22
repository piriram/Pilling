//
//  PiriSecondView.swift
//  MC2-Team3-Pilling
//
//  Created by ram on 5/21/24.
//

import SwiftUI
import SwiftData
struct PiriSecondView: View {
    @State private var alarmTime: Date = Date()
    @State private var alarmToggle = false
    @Binding var pillInfo:PillInfo
    @Binding var intakeDay:Int
    @State var isActive = false
    @Environment(\.modelContext) private var modelContext
    @Query var user:[UserInfo]
    
    
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

                    DatePicker("복용 시간", selection: $alarmTime, displayedComponents: .hourAndMinute)
                    
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
//                print(alarmTime)
                var scheduleTime = Config().DateToString(date: alarmTime, format: Hourformat)
                print(scheduleTime)
                var periodPill = findStartDay(pillInfo: pillInfo, curIntakeDay: intakeDay)
                
                print(periodPill)
                print("periodPillInfo:\(periodPill.startIntake)")
                var userInfo = UserInfo(scheduleTime: scheduleTime, curPill: periodPill)
                userInfo.curPill.intakeCal=Array(repeating: DayData(), count: 30)
                print("userInfo:\(userInfo.curPill.intakeCal[0])")
                var pillInfo = user.first?.curPill

                modelContext.insert(userInfo)
                do {
                    try modelContext.save()
                    print("스데 저장 성공")
                } catch {
                    print("Failed to save context: \(error.localizedDescription)")
                }
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
        .onAppear{
            print(intakeDay)
        }
    }
    func findStartDay(pillInfo:PillInfo,curIntakeDay:Int) -> PeriodPill{
        
        let currentDate = Date()
        let calendar = Calendar.current
        let startDate = calendar.date(byAdding: .day, value: -curIntakeDay, to: currentDate)
        let startIntakeString = Config().DateToString(date: startDate ?? currentDate,format:dayformat) //디폴트값 수정해야함
        return PeriodPill(pillInfo: pillInfo, startIntake: startIntakeString)
        
    }
}

