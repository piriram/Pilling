//
//  model+extension.swift
//  MC2-Team3-Pilling
//
//  Created by ram on 5/23/24.
//

import Foundation
import SwiftUI

extension MainView{
    func updateStatusNum(today: Int, sortedDay: [DayData]) -> Int {
        var statusNum = 0
        print("today-1:\(sortedDay[today-1].status)")
        if today == 1 && sortedDay[today - 1].status == 0 { // 첫째날 -> 약먹어야함
            statusNum = 1
        } else if sortedDay[today - 1].status == 2{
            statusNum = 4
        } else if sortedDay[today - 1].status == 0 && sortedDay[today - 2].status == 1 { // 약먹어야함
            statusNum = 1
        } else if sortedDay[today - 1].status == 1 && sortedDay[today - 2].status == 0 { // 약먹음 -> 윙크
            statusNum = 6
        }
        else if sortedDay[today - 1].status == 1 { // 약먹음 -> 윙크
            statusNum = 2
        } else if sortedDay[today - 1].status == 3 { // 위약
            statusNum = 3
        } else if today > 2 && sortedDay[today - 1].status == 0 && sortedDay[today - 2].status == 0 && sortedDay[today - 3].status == 0 { // 이틀째 안먹음
            statusNum = 5
        } else if sortedDay[today - 1].status == 0 && sortedDay[today - 2].status == 0 { // 어제 안먹음
            statusNum = 6
        }
        else {
            statusNum = 0
        }
        
        return statusNum
    }
    
    func updateStatusMessage(statusNum: Int) -> String {
        if let msg = Config.StatusMessage(rawValue: statusNum) {
            return msg.description
        } else {
            return ""
        }
    }
    
    func refreshData(today: Int, sortedDay: [DayData]) {
        statusNum = updateStatusNum(today: today, sortedDay: sortedDay)
        statusMessage = updateStatusMessage(statusNum: statusNum)
        
    }
    func calculateData() {
        if let userFirst = user.first{
            if let curPill = userFirst.curPill{
                week = curPill.pillInfo.wholeDay/7 // 주차 계산
                let startDate = Config.StringToDate(dateString: curPill.startIntake, format: Config.dayformat) // 시작 날짜를 계산해서
                today = Config.daysFromStart(startDay: startDate!) // 오늘이 몇일차인지 구함
                if let startDate = startDate{
                    startWeekNum = Config.dayIndex(from: startDate)!
                }
            }
            
            let scheduleTime = userFirst.scheduleTime
            time = Config.StringToDate(dateString: scheduleTime , format: Config.Hourformat)!
        }
    }
    func printData() {
        for dayData in sortedDay {
            print("num : \(dayData.num)")
            print("status : \(dayData.status)")
        }
    }
    @ViewBuilder
    var gradientView: some View {
        if statusNum == 5 {
            BrownGradient()
        } else {
            GreenGradient()
        }
    }
    
    struct CustomButtonStyle: ButtonStyle {
        var isDisabled: Bool
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .background(isDisabled ? .customGray : .customGreen)
                .opacity(configuration.isPressed ? 0.8 : 1.0)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
    
    
}

import SwiftUI

struct StatusHeaderView: View {
    @Binding var statusNum: Int
    @Binding var today: Int
    @Binding var user: [UserInfo]
    
    var body: some View {
        HStack(alignment: .center) {
            statusImage(for: statusNum)
                .resizable()
                .frame(width: 200, height: 200)
            
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("\(today)일차")
                        .largeTitle()
                    if let whole = user.first?.curPill?.pillInfo.wholeDay {
                        Text("/\(String(describing: whole))")
                            .secondaryTitle()
                    } else {
                        Text("")
                    }
                }
                
                if let intakeDay = user.first?.curPill?.pillInfo.intakeDay,
                   let placeboDay = user.first?.curPill?.pillInfo.placeboDay {
                    Label("\(String(describing: intakeDay))/\(String(describing: placeboDay))", systemImage: "calendar")
                        .secondaryRegular()
                } else {
                    Label("", systemImage: "calendar")
                        .secondaryRegular()
                }
                
                Label(user.first?.scheduleTime ?? "00:00", systemImage: "clock.fill")
                    .secondaryRegular()
            }
            Spacer()
        }
    }
    
    private func statusImage(for status: Int) -> Image {
        switch status {
            case 1:
                return Image("1case")
            case 2:
                return Image("taking")
            case 3:
                return Image("rest")
            case 4:
                return Image("2case")
            case 5:
                return Image("notaking")
            default:
                return Image("1case")
        }
    }
}
