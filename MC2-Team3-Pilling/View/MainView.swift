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
    @State var statusMessage = ""
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
//    @State var dosageType
    @State var imageNum = 0
    var body: some View {
        
        
        NavigationStack {
            ZStack {
                GreenGradient()
                VStack(spacing: 10) {
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
                        switch imageNum{
                            case 1:
                                Image("1case")
                                    .resizable()
                                    .frame(width: 200, height: 200)
                            case 2:
                                Image("taking")
                                    .resizable()
                                    .frame(width: 200, height: 200)
                            case 3:
                                Image("rest")
                                    .resizable()
                                    .frame(width: 200, height: 200)
                            case 4:
                                Image("2case")
                                    .resizable()
                                    .frame(width: 200, height: 200)
                            case 5:
                                Image("nottaking")
                                    .resizable()
                                    .frame(width: 200, height: 200)
                            default:
                                Image("1case")
                                    .resizable()
                                    .frame(width: 200, height: 200)
                        }
                        
                            
                            
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
                        if sortedDay[today-1].status == 0 && sortedDay[today-2].status==1{
                            imageNum = 1
                        } else if sortedDay[today-1].status == 1{
                            imageNum = 2
                        }
                        else if sortedDay[today-1].status == 3{
                            imageNum = 3
                        }
                        
                        
                        
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
                    
                }
                
                var scheduleTime = userFirst.scheduleTime
                //                print(scheduleTime)
                time = Config.StringToDate(dateString: scheduleTime , format: Hourformat) ?? Date()
            }
            
            if today == 1 && sortedDay[today-1].status == 0{ //첫째날 -> 약먹어야함
                imageNum = 1
            }
            else if sortedDay[today-1].status == 0 && sortedDay[today-2].status==1{ // 약먹어야함
                imageNum = 1
            } else if sortedDay[today-1].status == 1{ // 약먹음 -> 윙크
                imageNum = 2
            }
            else if sortedDay[today-1].status == 3{ // 위약
                imageNum = 3
            }
            else if sortedDay[today-1].status == 0 && sortedDay[today-2].status==0 { // 어제 안먹음
                imageNum = 4
            }
            else if today > 2 && sortedDay[today-1].status == 0 && sortedDay[today-2].status==0 && sortedDay[today-2].status==0{ // 이틀째 안먹음
                imageNum = 5
            }
            if let msg = Config.StatusMessage(rawValue: imageNum){
                statusMessage = msg.description
            }
            
            
            for dayData in sortedDay {
                print("num : \(dayData.num)")
                print("status : \(dayData.status)")
            }
            
            
            
            
        }
        
    }
    
}






