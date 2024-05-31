//
//  NotificationManager.swift
//  MC2-Team3-Pilling
//
//  Created by ram on 5/31/24.
//

import UserNotifications

class NotificationManager {
    static let notiName = "1분알림"
    static let triggerCountKey = "triggerCountKey"
    
    static func scheduleOneMinuteIntervalNotification() {
        // 기존 알림 취소
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notiName])
        
        let content = UNMutableNotificationContent()
        content.title = "1분 알림"
        content.body = "1분이 지났습니다."
        content.sound = UNNotificationSound.default
        
        // 1분마다 반복되는 트리거 설정
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        
        let request = UNNotificationRequest(identifier: notiName, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error adding notification: \(error.localizedDescription)")
            }
        }
        
        // 초기 트리거 횟수를 0으로 설정
        UserDefaults.standard.set(0, forKey: triggerCountKey)
    }
    
    static func handleNotificationResponse() {
        // 현재 트리거 횟수 가져오기
        var triggerCount = UserDefaults.standard.integer(forKey: triggerCountKey)
        
        // 트리거 횟수 증가
        triggerCount += 1
        
        // 트리거 횟수 저장
        UserDefaults.standard.set(triggerCount, forKey: triggerCountKey)
        
        if triggerCount >= 3 {
            // 3번 트리거된 후 알림 취소
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notiName])
        }
    }
}
