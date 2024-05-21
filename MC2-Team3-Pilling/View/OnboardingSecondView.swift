//
//  OnboardingView02.swift
//  MC2-Team3-Pilling
//
//  Created by 이소현 on 5/17/24.
//

import SwiftUI

struct OnboardingSecondView: View {
    @State private var alarmTime: Date = Date()
    @State private var alarmToggle = false
    
    var body: some View {
        VStack{
            Image("clock")
                .resizable()
                .frame(width: 240, height: 240)
            
            // Text
            HStack {
                VStack(alignment: .leading) {
                    // Text
                    Text("알람 받을 시간을 설정해주세요!")
                        .largeBold()                    .padding(.bottom, 2)
                    
                    Text("설정은 추후에 변경 가능합니다.")
                        .secondaryRegular()
                }
                Spacer()
            }
            .padding()
            
            
            Button(action: {
                DatePicker("", selection: $alarmTime, displayedComponents: .hourAndMinute)
            }, label: {

                ZStack{
                    HStack {
                        Image(systemName: "clock")
                        Text("복용 시간")
                            .secondaryTitle()
                        Spacer()

                    }
                    DatePicker("", selection: $alarmTime, displayedComponents: .hourAndMinute)

                }
                .padding([.leading, .trailing], 20)
                
            })
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity)
            .background(.customGray02)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .foregroundColor(.secondary)
            .padding()
            
            
            VStack(alignment: .leading){
                Toggle("소리 알람여부추가", isOn: $alarmToggle)
                    .regular()
                    .padding(.bottom, 2)
                    
                
                
                HStack {
                    Image(systemName: "info.circle.fill")
                    Text("소리를 OFF하면 라이브 액티비티로만 알려줘요!")
                        .font(.callout)
                }
                .foregroundStyle(.secondary)
            }
            .padding()
            
            Spacer()
            
            // footer button
            Button(action: {}, label: {
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
}

#Preview {
    OnboardingSecondView()
}
