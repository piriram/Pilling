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
    @Query var user:[UserInfo]
    @State var time = Date()
    
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
                        })
                        .popover(isPresented: $showingPopover, attachmentAnchor: .point(.bottom),
                                 arrowEdge: .top) {
                            PopoverView()
                                .padding()
                                .presentationCompactAdaptation(.popover)
                        }
                        NavigationLink(destination: SettingView(), label: {
                            Image(systemName: "gearshape")
                                .Icon()
                        })
                    }
                    
                    // status header
                    HStack(alignment: .center) {
                        Image("1case")
                            .resizable()
                            .frame(width: 200, height: 200)
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text("4일차")
                                    .largeTitle()
                                if let whole = user.first?.curPill.pillInfo.wholeDay{
                                    Text("/\(String(describing: whole))")
                                        .secondaryTitle()
                                }
                                else{
                                    Text("")
                                }
                                
                            }
                            if let intakeDay=user.first?.curPill.pillInfo.intakeDay,let placeboday=user.first?.curPill.pillInfo.placeboDay{
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
                        ForEach(0..<(user.first?.curPill.pillInfo.wholeDay ?? 28)/7) { y in
                            HStack {
                                ForEach(0..<7) { x in
                                    if x==3 && y==0{
                                        TwoCell(isModal: $isModal, backgroundColor: .customGreen)
                                    }
                                    else if x==1 && y==0 {
                                        ActivateCell(isModal: $isModal, backgroundColor: .customBrown)
                                    }
                                    else if x==0 && y == 0{
                                        TodayCell(isModal: $isModal, backgroundColor: colorArr[myArray[y*7+x]])
                                    }
                                    else if x>=3 && y == 3{
                                        PlaceboCell(isModal: $isModal, backgroundColor: Color.white)
                                    }
                                    else{
                                        ActivateCell(isModal: $isModal, backgroundColor: colorArr[myArray[y*7+x]])
                                    }
                                    
                                    
                                    
                                    
                                }
                            }
                        }
                    }
                    Spacer()
                    
                    // footer button
                    Button(action: {}, label: {
                        Text("잔디 심기")
                            .largeBold()
                    })
                    .padding(.vertical, 30)
                    .frame(maxWidth: .infinity)
                    .background(.customGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .foregroundColor(.black)
                }
                .padding()
            }
            .sheet(isPresented: $isModal){
                ChooseStatusView(showingChooseStatus: $isModal)
                    .presentationDetents([.medium])
            }
        }
        .onAppear {
            var scheduleTime = user.first?.scheduleTime
            print(scheduleTime)
            time = Config().StringToDate(dateString: scheduleTime ?? "2024-05-21 15:14:27", format: Hourformat) ?? Date()
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

struct ActivateCell: View {
    @Binding var isModal:Bool
    var backgroundColor: Color
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 45, height: 45)
            .foregroundColor(backgroundColor)
            .onTapGesture {
                isModal = true
                print(isModal)
            }
    }
    
}
struct PlaceboCell: View {
    @Binding var isModal:Bool
    var backgroundColor: Color
    var body: some View {
        Rectangle()
            .foregroundColor(.clear)
            .frame(width: 45, height: 45)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .inset(by: 0.5)
                    .stroke(Color(red: 0.91, green: 0.91, blue: 0.92), lineWidth: 1)
            )
            .onTapGesture {
                isModal = true
                print(isModal)
            }
    }
    
}
struct TodayCell: View {
    @Binding var isModal:Bool
    var backgroundColor: Color
    var body: some View {
        Rectangle()
            .foregroundColor(.clear)
            .frame(width: 45, height: 45)
            .background(.clear)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .inset(by: 1)
                    .stroke(Color.green,lineWidth: 3)
                
            )
    }
    
}
struct TwoCell: View {
    @Binding var isModal:Bool
    var backgroundColor: Color
    var body: some View {
        HStack(spacing: 5){
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 20, height: 45)
                .background(.customGreen)
                .cornerRadius(10)
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 20, height: 45)
                .background(Color(red: 0.5, green: 0.87, blue: 0.11))
                .cornerRadius(10)
            
            
        }
        .frame(width: 45, height: 45)
        
        
    }
    
}
