//
//  ContentView.swift
//  MC2-Team3-Pilling
//
//  Created by 이소현 on 5/14/24.
//

import SwiftUI
import SwiftData
struct ContentView: View {
    var body: some View {
        VStack {
            Text("1분마다 알림 설정")
                .padding()
            
            Button(action: {
                NotificationManager.scheduleOneMinuteIntervalNotification()
            }) {
                Text("알림 시작")
            }
            .padding()
        }
    }
}
