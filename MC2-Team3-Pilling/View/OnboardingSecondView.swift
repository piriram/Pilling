
import SwiftUI

struct OnboardingSecondView: View {
    @State var alarmTime: Date = Date()
    @State var alarmToggle = false
    
    var body: some View {

        Image("clock")
            .resizable()
            .frame(width: 240, height: 240)
        
        // Text
        VStack(alignment: .leading) {
            // Text
            Text("알람 받을 시간을 설정해주세요!")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.bottom, 2)

            
            // Text
            HStack {
                VStack(alignment: .leading) {
                    // Text
                    Text("알람 받을 시간을 설정해주세요!")
                        .largeTitle()
                        .padding(.bottom, 2)
                    
                    Text("설정은 추후에 변경 가능합니다.")
                        .secondaryRegular()
                }
                Spacer()
            }
            
            
            Button(action: {
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
                .padding([.leading, .trailing], 25)
            })
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity)
            .background(.customGray02)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .secondaryRegular()
            
            
            VStack{
                Toggle("소리 알람여부추가", isOn: $alarmToggle)
                
                HStack{
                    Image(systemName: "info.circle.fill")
                    Text("소리를 OFF하면 라이브 액티비티로만 알려줘요!")
                    Spacer()
                }
                .secondaryRegular()
            }
            
            Spacer()
            
            // footer button
            Button(action: {}, label: {
                Text("설정완료!")
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
}

#Preview {
    OnboardingSecondView()
}
