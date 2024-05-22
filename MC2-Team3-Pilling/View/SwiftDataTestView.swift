//
//  SwiftDataTestView.swift
//  MC2-Team3-Pilling
//
//  Created by ram on 5/20/24.
//

import SwiftUI
import SwiftData

struct SwiftDataTestView: View {
    @Environment(\.modelContext) private var modelContext
    @State var txt = ""
    @Query var user: [UserInfo]
    
    
    var body: some View {
        VStack {
            TextField("테스트 글을 적어주세요.", text:$txt)
            Button(action:{
                modelContext.insert(UserInfo(scheduleTime: "", curPill: PeriodPill(pillInfo: PillInfo(pillName: txt, intakeDay: 24, placeboDay: 4), startIntake: "")))
                do {
                    try modelContext.save()
                    print("스데 저장 성공")
                } catch {
                    print("Failed to save context: \(error.localizedDescription)")
                }
                
            }
                   , label: {
                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
            })
            withAnimation{
                Text(user.first?.curPill?.pillInfo.pillName ?? "없음")
            }
            
        }
        .padding()
        
        
        
    }
}

#Preview {
    SwiftDataTestView()
}
