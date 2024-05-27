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
    @Binding var isMain:Bool
    @Binding var pillInfo: PillInfo?
    @Binding var intakeDay: Int
    @State var isActive = false
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Query var user: [UserInfo]
    @Query(sort: \DayData.num) var sortedDay: [DayData]
    

    var body: some View {
        VStack {
            if !isActive {
                VStack {
                    Image("onboardingSecond")

                    HStack {
                        VStack(alignment: .leading) {
                            Text("알람 받을 시간을 설정해주세요!")
                                .largeBold()
                                .padding(.bottom, 2)

                            Text("설정은 추후에 변경 가능합니다.")
                                .secondaryRegular()
                        }
                        Spacer()
                    }
                    .padding()

                    Button(action: {}, label: {
                        ZStack {
                            DatePicker("복용 시간", selection: $alarmTime, displayedComponents: .hourAndMinute)
                        }
                        .padding([.leading, .trailing], 15)
                    })
                    .padding(.vertical, 15)
                    .frame(maxWidth: .infinity)
                    .background(.customGray02)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundColor(.secondary)
                    .padding()

                    VStack(alignment: .leading) {
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

                }
            } else {
                MainView()
            }
        }
        .onAppear {
            print(intakeDay)
        }
    }

    func dataSave() {
        if user.isEmpty {
            if let selectedPillInfo = pillInfo {
                modelContext.insert(selectedPillInfo)

                let startIntake = Config.findStartDay(curIntakeDay: intakeDay)
                let startIntakeToString = Config.DateToString(date: startIntake!, format: Config.dayformat)
                let periodPill = PeriodPill(pillInfo: selectedPillInfo, startIntake: startIntakeToString)

                let startDate = Config.StringToDate(dateString: periodPill.startIntake, format: Config.dayformat)
                let today = Config.daysFromStart(startDay: startDate!)

                let wholeDay = selectedPillInfo.wholeDay

                for idx in 0..<wholeDay {
                    let dayData = DayData(num: idx)
                    modelContext.insert(dayData)
                    periodPill.intakeCal.append(dayData)
                }
                print("온보딩today: \(today)")
                
                if today > 1 {
                    for idx in 0..<today - 1 {
                        sortedDay[idx].status = 1
                    }
                }

                for idx in pillInfo!.intakeDay..<wholeDay {
                    sortedDay[idx].status = 3
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
                    isMain = true

                } catch {
                    print("Failed to save context: \(error.localizedDescription)")
                }
            }
        } else {
            // 사용자 데이터가 이미 있는 경우의 처리 로직 (필요한 경우 추가)
        }
    }
}
