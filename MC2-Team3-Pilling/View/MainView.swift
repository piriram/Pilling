import SwiftUI
import SwiftData

struct MainView: View {
    @State private var showingPopover = false
    @State private var showingChooseStatus = false
    @State private var startNum = 4
    @State private var statusMessage = ""
    @State private var isModal = false
    @State private var userInfo: UserInfo = UserInfo(scheduleTime: "11:00", curPill: PeriodPill(pillInfo: Config.dummyPillInfos[0], startIntake: "2024-05-17 11:45:46"))
    @Environment(\.modelContext) private var modelContext
    @Query var user: [UserInfo]
    @State private var time = Date()
    @State private var week = 4
    @State private var today = 1
    @State private var isToday = false
    @State private var isActive = false
    @State private var showingMedicineSheet = false
    @State private var selectedPill: PillInfo?
    @Query(sort: \DayData.num) var sortedDay: [DayData]
    @State private var dayData = DayData(num: 1)
    @State private var imageNum = 0

    var body: some View {
        NavigationStack {
            ZStack {
                GreenGradient()
                VStack(spacing: 10) {
                    HeaderView(showingPopover: $showingPopover, selectedPill: $selectedPill, showingMedicineSheet: $showingMedicineSheet)
                    
                    StatusHeaderView(imageNum: $imageNum, today: $today, user: user)
                    
                    StatusMessageView(statusMessage: $statusMessage)
                    
                    CalendarView(startNum: $startNum, week: $week, today: $today,isModal: $isModal, dayData: $dayData)
                    
                    Spacer()
                    
                    FooterButtonView(today: $today, imageNum: $imageNum)
                }
                .padding()
                
                if let timeString = user.first?.scheduleTime {
                    LiveActivityView(alarmTime: Config.AlarmStringToDate(dateString: timeString)!)
                        .opacity(0.0)
                }
            }
            .sheet(isPresented: $isModal) {
                ChooseStatusView(showingChooseStatus: $isModal, dayData: $dayData)
                    .presentationDetents([.medium])
            }
        }
        .onAppear(perform: onAppear)
    }
    
    private func onAppear() {
        if let userFirst = user.first, let curPill = userFirst.curPill {
            week = curPill.pillInfo.wholeDay / 7
            let startDate = Config.StringToDate(dateString: curPill.startIntake, format: dayformat)
            today = Config.daysFromStart(startDay: startDate!)
            time = Config.StringToDate(dateString: userFirst.scheduleTime, format: Hourformat) ?? Date()
        }
        
        updateImageNum()
        if let msg = Config.StatusMessage(rawValue: imageNum) {
            statusMessage = msg.description
        }
    }
    
    private func updateImageNum() {
        if today == 1 && sortedDay[today - 1].status == 0 {
            imageNum = 1
        } else if sortedDay[today - 1].status == 0 && sortedDay[today - 2].status == 1 {
            imageNum = 1
        } else if sortedDay[today - 1].status == 1 {
            imageNum = 2
        } else if sortedDay[today - 1].status == 3 {
            imageNum = 3
        } else if sortedDay[today - 1].status == 0 && sortedDay[today - 2].status == 0 {
            imageNum = 4
        } else if today > 2 && sortedDay[today - 1].status == 0 && sortedDay[today - 2].status == 0 && sortedDay[today - 3].status == 0 {
            imageNum = 5
        }
    }
}

struct HeaderView: View {
    @Binding var showingPopover: Bool
    @Binding var selectedPill: PillInfo?
    @Binding var showingMedicineSheet: Bool

    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                showingPopover = true
            }, label: {
                Image(systemName: "info.circle.fill").Icon()
            })
            .popover(isPresented: $showingPopover, attachmentAnchor: .point(.bottom), arrowEdge: .top) {
                PopoverView()
                    .padding()
                    .presentationCompactAdaptation(.popover)
            }
            NavigationLink(destination: SettingView(selectedPill: $selectedPill, showingMedicineSheet: $showingMedicineSheet), label: {
                Image(systemName: "gearshape").Icon()
            })
        }
    }
}

struct StatusHeaderView: View {
    @Binding var imageNum: Int
    @Binding var today: Int
    var user: [UserInfo]

    var body: some View {
        HStack(alignment: .center) {
            StatusImageView(imageNum: $imageNum)
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("\(today)일차").largeTitle()
                    if let whole = user.first?.curPill?.pillInfo.wholeDay {
                        Text("/\(String(describing: whole))").secondaryTitle()
                    } else {
                        Text("")
                    }
                }
                if let intakeDay = user.first?.curPill?.pillInfo.intakeDay, let placeboDay = user.first?.curPill?.pillInfo.placeboDay {
                    Label("\(String(describing: intakeDay))/\(String(describing: placeboDay))", systemImage: "calendar").secondaryRegular()
                } else {
                    Label("", systemImage: "calendar").secondaryRegular()
                }
                Label(user.first?.scheduleTime ?? "00:00", systemImage: "clock.fill").secondaryRegular()
            }
            Spacer()
        }
    }
}

struct StatusImageView: View {
    @Binding var imageNum: Int

    var body: some View {
        switch imageNum {
            case 1:
                Image("1case").resizable().frame(width: 200, height: 200)
            case 2:
                Image("taking").resizable().frame(width: 200, height: 200)
            case 3:
                Image("rest").resizable().frame(width: 200, height: 200)
            case 4:
                Image("2case").resizable().frame(width: 200, height: 200)
            case 5:
                Image("nottaking").resizable().frame(width: 200, height: 200)
            default:
                Image("1case").resizable().frame(width: 200, height: 200)
        }
    }
}

struct StatusMessageView: View {
    @Binding var statusMessage: String

    var body: some View {
        HStack {
            Image(systemName: "drop").foregroundColor(.customGreen)
            Text(statusMessage.description).boldRegular()
            Spacer()
        }
        .padding(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.customGray, lineWidth: 1)
        )
    }
}

struct CalendarView: View {
    @Binding var startNum: Int
    @Binding var week: Int
    @Binding var today: Int
    @Query(sort: \DayData.num) var sortedDay: [DayData]
    @Binding var isModal: Bool
    @Binding var dayData: DayData

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                ForEach(startNum...(startNum + 6), id: \.self) { num in
                    DayView(num: (num % 7))
                }
            }
            .regular()
            ForEach(0..<week) { y in
                HStack {
                    ForEach(0..<7) { x in
                        let idx = y * 7 + x
                        let status = sortedDay[idx].status
                        let isToday = today - 1 == idx
                        DayCell(status: status, isModal: $isModal, dayData: sortedDay[idx], isToday: isToday)
                    }
                }
            }
        }
    }
}

struct DayCell: View {
    var status: Int
    @Binding var isModal: Bool
    var dayData: DayData
    var isToday: Bool

    var body: some View {
        Group {
            if status == 3 {
                PlaceboCell(isModal: $isModal, dayData: dayData, isToday: isToday)
            } else {
                ActivateCell(status: status, isModal: $isModal, dayData: dayData, isToday: isToday)
            }
        }
    }
}

struct ActivateCell: View {
    var status: Int
    @Binding var isModal: Bool
    var dayData: DayData
    var isToday: Bool

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 45, height: 45)
            .foregroundColor(cellColor)
            .overlay(isToday ? RoundedRectangle(cornerRadius: 10).stroke(Color(hex: "#507E20"), lineWidth: 4) : nil)
            .onTapGesture {
                isModal = true
            }
    }

    private var cellColor: Color {
        switch status {
            case 0:
                return .customGray
            case 1:
                return .customGreen
            case 2:
                return .customBrown
            default:
                return .clear
        }
    }
}

struct PlaceboCell: View {
    @Binding var isModal: Bool
    var dayData: DayData
    var isToday: Bool

    var body: some View {
        Rectangle()
            .foregroundColor(.white)
            .frame(width: 45, height: 45)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .inset(by: 0.5)
                    .stroke(isToday ? Color.green : Color(red: 0.91, green: 0.91, blue: 0.92), lineWidth: isToday ? 4 : 1)
            )
            .onTapGesture {
                isModal = true
            }
    }
}

struct FooterButtonView: View {
    @Binding var today: Int
    @Binding var imageNum: Int
    @Query(sort: \DayData.num) var sortedDay: [DayData]
    

    var body: some View {
        Button(action: updateStatus, label: {
            Text("잔디 심기").largeBold()
        })
        .padding(.vertical, 25)
        .frame(maxWidth: .infinity)
        .background(.customGreen)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .foregroundColor(.black)
    }

    private func updateStatus() {
        sortedDay[today - 1].status = 1
        sortedDay[today - 1].time = Config.DateToString(date: Date(), format: Config.dayToHourformat)
        sortedDay[today - 1].isRecord = true
        imageNum = determineImageNum()
    }

    private func determineImageNum() -> Int {
        if sortedDay[today - 1].status == 0 && sortedDay[today - 2].status == 1 {
            return 1
        } else if sortedDay[today - 1].status == 1 {
            return 2
        } else if sortedDay[today - 1].status == 3 {
            return 3
        }
        return 0
    }
}


