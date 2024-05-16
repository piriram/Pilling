
import SwiftUI

struct OnboardingView01: View {
    var body: some View {
        Image("making-plan")
            .resizable()
            .frame(width: 300, height: 300)
        
        // Text
        VStack {
            // Text
                Text("플랜을 설정해주세요!")
                    .font(.title)
                    .bold()
            
                Text("설정은 추후에 변경 가능합니다.")
                    .font(.title3)
                    .foregroundStyle(.secondary)

            }
        
        //        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        //        .background(Color.red)
        
        // Selecting box
        VStack {
            Button(action: {}, label: {
                // sfSymbol 부재 : medicine-bottle-one
                Image(systemName: "pill.circle.fill")
                                    Text("약 종류")
                    .font(.title3)
            })
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity)
            .background(.customGray)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .foregroundColor(.secondary)
            .padding()
            
            Button(action: {}, label: {
                // sfSymbol 부재 : uis-calender
                Image(systemName: "note")
                Text("현재 복용 일수")
                    .font(.title3)
            })
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity)
            .background(.customGray)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .foregroundColor(.secondary)
            .padding()

        }
        
        
        // footer button
        Button(action: {}, label: {
            Text("다음으로")
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
    OnboardingView01()
}
