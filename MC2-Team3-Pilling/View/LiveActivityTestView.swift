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
    @State private var isTracking = false
    @State private var alarmTime = dateFormatter.date(from: "\(Date.now.formatted(date: .numeric, time: .omitted))_23:00:00")!
    @State private var activity: Activity<LiveTimeAttributes>? = nil
    @State private var progressAmount = 0.0
    var body: some View {
        VStack {
            Button(action: {
                    isTracking.toggle()
                    if isTracking {
                        // start live activity
                        progressAmount = 0.0
                        let attributes = LiveTimeAttributes()
                        let state = LiveTimeAttributes.ContentState(restOfTime: alarmTime, progressAmount: progressAmount, step: 1)
                        let content = ActivityContent<LiveTimeAttributes.ContentState>(state: state, staleDate: nil)
                        activity = try? Activity<LiveTimeAttributes>.request(attributes: attributes, content: content, pushType: nil)
                    } else {
                        // end live activity
                        let state = LiveTimeAttributes.ContentState(restOfTime: alarmTime, progressAmount: 600, step: 3)
                        let content = ActivityContent<LiveTimeAttributes.ContentState>(state: state, staleDate: alarmTime.addingTimeInterval(600))
                        Task {
                            await activity?.end(content, dismissalPolicy:.immediate)
                        }
                    }
            }, label: {
                Text(isTracking ? "end live activity" : "start live activity")
            })
            .buttonStyle(.bordered)
            if isTracking {
                Button(action: {
                    progressAmount += 50
                    let state = LiveTimeAttributes.ContentState(restOfTime: alarmTime, progressAmount: progressAmount, step: 3)
                    let content = ActivityContent<LiveTimeAttributes.ContentState>(state: state, staleDate: nil)
                    Task {
                        await activity?.update(content)
                    }
                }, label: {
                    Text("update live activity")
                })
                .buttonStyle(.bordered)
            }
            if isTracking {
                HStack {
                    Text("알람까지 남은 시간")
                    Text(alarmTime, style: .relative)
                }
            }
        }
    }
}

#Preview {
    LiveActivityTestView()
}
