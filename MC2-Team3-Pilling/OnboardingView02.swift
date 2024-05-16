//
//  OnboardingView02.swift
//  MC2-Team3-Pilling
//
//  Created by 이소현 on 5/17/24.
//

import SwiftUI

struct OnboardingView02: View {
    @State var alarmTime: Date = Date()
    @State var alarmToggle = false
    
    var body: some View {
        Image("clock")
            .resizable()
            .frame(width: 300, height: 300)
        
        // Text
        VStack {
            // Text
            Text("알람 받을 시간을 설정해주세요!")
                .font(.title)
                .bold()
            
            Text("설정은 추후에 변경 가능합니다.")
                .font(.title3)
                .foregroundStyle(.secondary)
        }
        
        Button(action: {
            DatePicker("", selection: $alarmTime, displayedComponents: .hourAndMinute)
        }, label: {
            Image(systemName: "clock")
            Text("복용 시간")
                .font(.title3)
            Text("17:00")
        })
        .padding(.vertical, 20)
        .frame(maxWidth: .infinity)
        .background(.customGray)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .foregroundColor(.secondary)
        .padding()
        
        
        VStack{
            Toggle("소리 알람여부추가", isOn: $alarmToggle)
                .padding()
            
            HStack{
                Image(systemName: "info.circle.fill")
                Text("소리를 OFF하면 라이브 액티비티로만 알려줘요!")
            }
        }
        
        
        // footer button
        Button(action: {
//            OnboardingView02()
        }, label: {
            Text("설정완료!")
                .font(.title3)
                .bold()
        })
        .padding(.vertical, 30)
        .frame(maxWidth: .infinity)
        .background(.customGreen)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .foregroundColor(.black)
        .padding()

    }
}

#Preview {
    OnboardingView02()
}
