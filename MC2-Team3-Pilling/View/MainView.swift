//
//  MainView.swift
//  MC2-Team3-Pilling
//
//  Created by Groo on 5/15/24.
//

import SwiftUI
import SwiftData


struct MainView: View {
    @State private var showingPopover = false
    @State private var showingChooseStatus = false
    @State var startNum = 4
    @State var statusMessage: Config.StatusMessage = .plantGrass
    @State var isModal = false
    @State var userInfo:UserInfo = UserInfo(scheduleTime: "11:00", curPill: PeriodPill(pillInfo: Config.dummyPillInfos[0], startIntake: "2024-05-17 11:45:46"))
    @Environment(\.modelContext) private var modelContext
    @Query var user:[UserInfo]
    @State var time = Date()
    @State var week = 4
    @State var today = 1
    @State var isToday = false
    @State var isActive = false
    
    @State private var showingMedicineSheet = false
    @State private var selectedPill: PillInfo?
    @Query(sort:\DayData.num) var sortedDay:[DayData]
    @State var dayData = DayData(num: 1)
    var body: some View {
        
        
        NavigationStack {
            ZStack {
                GreenGradient()
                VStack(spacing: 20) {
                    // navigation icons
                    HStack {
                        Spacer()
                        Button(action: {
                            showingPopover = true
                        }, label: {
                            
                            Image(systemName: "info.circle.fill")
                                .Icon()
                        }
                        )
                        .popover(isPresented: $showingPopover, attachmentAnchor: .point(.bottom),
                                 arrowEdge: .top) {
                            PopoverView()
                                .padding()
                                .presentationCompactAdaptation(.popover)
                        }
                        NavigationLink(destination: SettingView(selectedPill: $selectedPill, showingMedicineSheet: $showingMedicineSheet), label: {
                            Image(systemName: "gearshape")
                                .Icon()
                        }
                        )
                    }
                    
                    // status header
                    HStack(alignment: .center) {
                        Image("1case")
                            .resizable()
                            .frame(width: 200, height: 200)
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text("\(today)일차")
                                    .largeTitle()
                                if let whole = user.first?.curPill?.pillInfo.wholeDay{
                                    Text("/\(String(describing: whole))")
                                        .secondaryTitle()
                                }
                                else{
                                    Text("")
                                }
                                
                            }
                            
                            if let intakeDay=user.first?.curPill?.pillInfo.intakeDay,let placeboday=user.first?.curPill?.pillInfo.placeboDay{
                                Label("\(String(describing: intakeDay))/\(String(describing: placeboday))", systemImage: "calendar")
                                    .secondaryRegular()
                            }else{
                                Label("", systemImage: "calendar")
                                    .secondaryRegular()
                            }
                            
                            Label(user.first?.scheduleTime ?? "00:00", systemImage: "clock.fill")
                                .secondaryRegular()
                            
                        }
                        Spacer()
                    }
                    
                    // now statement
                    HStack {
                        Image(systemName: "drop")
                            .foregroundColor(.customGreen)
                        Text(statusMessage.description)
                            .boldRegular()
                        Spacer()
                    }
                    .padding(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.customGray, lineWidth: 1)
                    )
                    
                    // calendar view
                    VStack(spacing: 10) {
                        HStack {
                            ForEach(startNum...(startNum+6),id:\.self){ num in
                                DayView(num: (num%7))
                            }
                            
                        }
                        .regular()
                        
                        ForEach(0..<week) { y in
                            HStack {
                                ForEach(0..<7) { x in
                                    let idx = y * 7 + x
                                    
                                    let status = sortedDay[idx].status
                                    let isToday = today-1 == idx
                                    
                                    
                                    
                                    switch status {
                                        case 3: // 위약
                                            PlaceboCell(isModal: $isModal, dayData: sortedDay[idx], backgroundColor: Color.white, isToday: isToday)
                                                .onTapGesture {
                                                    dayData = sortedDay[idx]
                                                    isModal = true
                                                    print(isModal)
                                                }
                                            
                                        case 0:
                                            if idx < today-1{
                                                ActivateCell(isModal: $isModal, backgroundColor: .customBrown,isToday:isToday)
                                                    .onTapGesture {
                                                        dayData = sortedDay[idx]
                                                        isModal = true
                                                        print(isModal)
                                                    }
                                            }
                                            else{
                                                ActivateCell(isModal: $isModal, backgroundColor: .customGray,isToday:isToday)
                                                    .onTapGesture {
                                                        dayData = sortedDay[idx]
                                                        isModal = true
                                                        print(isModal)
                                                    }
                                            }
                                            
                                        case 1:
                                            ActivateCell(isModal: $isModal, backgroundColor: .customGreen,isToday:isToday)
                                                .onTapGesture {
                                                    dayData = sortedDay[idx]
                                                    isModal = true
                                                    print(isModal)
                                                }
                                            
                                        case 2:
                                            ActivateCell(isModal: $isModal, backgroundColor: .customBrown,isToday:isToday)
                                                .onTapGesture {
                                                    dayData = sortedDay[idx]
                                                    isModal = true
                                                    print(isModal)
                                                }
                                            
                                        default:
                                            EmptyView()
                                    }
                                }
                            }
                        }
                    }
                    Spacer()
                    
                    // footer button
                    Button(action: {
                        sortedDay[today-1].status = 1
                        sortedDay[today-1].time = Config.DateToString(date: Date(), format: Config.dayToHourformat)
                        sortedDay[today-1].isRecord = true
                        
                        
                        
                    }, label: {
                        Text("잔디 심기")
                            .largeBold()
                    })
                    .padding(.vertical, 25)
                    .frame(maxWidth: .infinity)
                    .background(.customGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .foregroundColor(.black)
                }
                .padding()
                // 알람 시간(type: Date)을 alarmTime에 넘겨주세요
                // 중요! date: 오늘 날짜(시스템상), time: 알람 시간으로 넘겨주세요
                if let timeString = user.first?.scheduleTime {
                    LiveActivityView(alarmTime: Config.AlarmStringToDate(dateString: timeString)!)
                        .opacity(0.0)
                }
            }
            .sheet(isPresented: $isModal){
                ChooseStatusView(showingChooseStatus: $isModal, dayData: $dayData)
                    .presentationDetents([.medium])
            }
        }
        
        .onAppear {
            if let userFirst = user.first{
                if let curPill = userFirst.curPill{
                    week = curPill.pillInfo.wholeDay/7
                    let startDate = Config.StringToDate(dateString: curPill.startIntake, format: dayformat)
                    today = Config.daysFromStart(startDay: startDate!)
                    
                    print("today:\(today)")
                }
                
                var scheduleTime = userFirst.scheduleTime
                //                print(scheduleTime)
                time = Config.StringToDate(dateString: scheduleTime , format: Hourformat) ?? Date()
            }
            //            var changeUser = user.first?.curPill?.intakeCal[0]
            //            changeUser?.status = 0
            //            modelContext.update(changeUser)
            //            user.first?.curPill?.printAllDetails()
            for dayData in sortedDay {
                print("num : \(dayData.num)")
                print("status : \(dayData.status)")
            }
            print("----")
            
        }
        
    }
    
}


struct GreenGradient: View {
    var body: some View {
        LinearGradient(stops: [.init(color: .customGreen.opacity(0.3), location: 0), .init(color: .white, location: 0.15)], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

struct DayView: View {
    var num:Int
    var body: some View {
        Text(days[num])
            .frame(width: 45, height: 45)
    }
}



