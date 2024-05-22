//
//  LiveActivityTestView.swift
//  MC2-Team3-Pilling
//
//  Created by Groo on 5/22/24.
//

import SwiftUI
import ActivityKit

struct LiveActivityTestView: View {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy_HH:mm:ss"
        return formatter
    }()
    static let timeIntervalFormatter: DateComponentsFormatter = {
            let formatter = DateComponentsFormatter()
            return formatter
        }()
//    @State private var isTracking = false
    @State private var alarmTime = dateFormatter.date(from: "\(Date.now.formatted(date: .numeric, time: .omitted))_23:38:00")!
    @State private var currentDate = Date.now
    var restOfTime: TimeInterval {
        currentDate.timeIntervalSince(alarmTime)
    }
    var currentStep: Int {
        if restOfTime <= 10 { //  ~ 알람 시간 10초 이내
            return 1
        } else if restOfTime <= 20 { // ~ 알람 시간 20초 이내
            return 2
        } else { // ~
            return 3
        }
    }
    
    @State private var activity: Activity<LiveTimeAttributes>? = nil
    @State private var progressAmount = 0.0
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text("현재 단계: \(currentStep)")
            Text("남은/지난 시간: \(timeIntervalToString(time: restOfTime))")
            Text("알람 시간: \(alarmTime.formatted(date: .numeric, time: .standard))")
            Text("현재 시간: \(currentDate.formatted(date: .numeric, time: .standard))")
                .onReceive(timer) { input in
                    currentDate = input
                    // 전: 현재 시간이 설정한 알람 시간 전일 때
                    if currentDate < alarmTime {
                        print("전: 현재 시간이 설정한 알람 시간 전일 때")
                    }
                    // 시작: 현재 시간이 설정한 알람 시간일 때
                    else if currentDate.formatted(date: .numeric, time: .standard) == alarmTime.formatted(date: .numeric, time: .standard) {
                        // 라이브 액티비티 실행
                        print("시작: 현재 시간이 설정한 알람 시간일 때")
                        progressAmount += 1
                        let attributes = LiveTimeAttributes()
                        let state = LiveTimeAttributes.ContentState(restOfTime: "", progressAmount: progressAmount, step: 1)
                        let content = ActivityContent<LiveTimeAttributes.ContentState>(state: state, staleDate: nil)
                        activity = try? Activity<LiveTimeAttributes>.request(attributes: attributes, content: content, pushType: nil)
                    }
                    // step 1: 현재 시간이 지정한 알람 시간 이후 10초 이내일 때
                    else if currentDate > alarmTime && currentDate <= alarmTime.addingTimeInterval(10) {
                        print("step 1: 현재 시간이 지정한 알람 시간 이후 10초 이내일 때")
                        progressAmount += 1
                        let state = LiveTimeAttributes.ContentState(restOfTime: "", progressAmount: progressAmount, step: 1)
                        let content = ActivityContent<LiveTimeAttributes.ContentState>(state: state, staleDate: nil)
                        Task {
                            await activity?.update(content)
                        }
                    }
                    // step 2: 현재 시간이 지정한 알람 시간 이후 10초부터 20초 이내일 때
                    else if currentDate > alarmTime.addingTimeInterval(10) && currentDate <= alarmTime.addingTimeInterval(20) {
                        print("step 2: 현재 시간이 지정한 알람 시간 이후 10초부터 20초 이내일 때")
                        let state = LiveTimeAttributes.ContentState(restOfTime: "", progressAmount: progressAmount, step: 2)
                        let content = ActivityContent<LiveTimeAttributes.ContentState>(state: state, staleDate: nil)
                        Task {
                            await activity?.update(content)
                        }
                    }
                    // step 3: 현재 시간이 지정한 알람 시간 이후 20초부터 30초 이내일 때
                    else if currentDate > alarmTime.addingTimeInterval(20) && currentDate < alarmTime.addingTimeInterval(30) {
                        print("step 3: 현재 시간이 지정한 알람 시간 이후 20초부터 30초 이내일 때")
                        let state = LiveTimeAttributes.ContentState(restOfTime: "", progressAmount: progressAmount, step: 3)
                        let content = ActivityContent<LiveTimeAttributes.ContentState>(state: state, staleDate: nil)
                        Task {
                            await activity?.update(content)
                        }
                    }
                    // 종료: 현재 시간이 지정한 알람 시간 이후 30초 지났을 때
                    else if currentDate.formatted(date: .numeric, time: .standard) == alarmTime.addingTimeInterval(30).formatted(date: .numeric, time: .standard) {
                        // 라이브 액티비티 종료
                        print("종료: 현재 시간이 지정한 알람 시간 이후 30초 지났을 때")
                        let state = LiveTimeAttributes.ContentState(restOfTime: "", progressAmount: progressAmount, step: 3)
                        let content = ActivityContent<LiveTimeAttributes.ContentState>(state: state, staleDate: alarmTime.addingTimeInterval(60))
                        Task {
                            await activity?.end(content, dismissalPolicy:.immediate)
                        }
                    }
                    // 후: 라이브 액티비티가 종료된 후
                    else {
                        print("후: 라이브 액티비티가 종료된 후")
                    }
                }
//            Button(action: {
//                isTracking.toggle()
//                if isTracking {
//                    // start live activity
//                    progressAmount = 0.0
//                    let attributes = LiveTimeAttributes()
//                    let state = LiveTimeAttributes.ContentState(restOfTime: alarmTime, progressAmount: progressAmount, step: 1)
//                    let content = ActivityContent<LiveTimeAttributes.ContentState>(state: state, staleDate: nil)
//                    activity = try? Activity<LiveTimeAttributes>.request(attributes: attributes, content: content, pushType: nil)
//                } else {
//                    // end live activity
//                    let state = LiveTimeAttributes.ContentState(restOfTime: alarmTime, progressAmount: 600, step: 3)
//                    let content = ActivityContent<LiveTimeAttributes.ContentState>(state: state, staleDate: alarmTime.addingTimeInterval(600))
//                    Task {
//                        await activity?.end(content, dismissalPolicy:.immediate)
//                    }
//                }
//            }, label: {
//                Text(isTracking ? "end live activity" : "start live activity")
//            })
//            .buttonStyle(.bordered)
//            if isTracking {
//                Button(action: {
//                    progressAmount += 50
//                    let state = LiveTimeAttributes.ContentState(restOfTime: alarmTime, progressAmount: progressAmount, step: 3)
//                    let content = ActivityContent<LiveTimeAttributes.ContentState>(state: state, staleDate: nil)
//                    Task {
//                        await activity?.update(content)
//                    }
//                }, label: {
//                    Text("update live activity")
//                })
//                .buttonStyle(.bordered)
//            }
//            if isTracking {
//                HStack {
//                    Text("알람까지 남은 시간")
//                    Text(alarmTime, style: .relative)
//                }
//            }
        }
    }
    func timeIntervalToString(time: Double) -> String {
        if time < 0 {
            return "\(-Int(time)/60)분 \(-Int(time)%60)초"
        } else if time >= 0 && time < 60 * 60 {
            return "\(Int(time)/60)분 \(Int(time)%60)초"
        } else {
            return "\(Int(time)/(60*60))시 \(Int(time)/60%60)분"
        }
    }
}

#Preview {
    LiveActivityTestView()
}
