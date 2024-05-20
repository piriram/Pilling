
import SwiftUI

struct PopoverView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("필링 가이드")
                .largeBold()
                .padding(.bottom, 3)
            Text("피임약 복용 상태를 잔디로 알려줘요!")
                .secondaryRegular()
                .padding(.bottom)
            
            HStack{
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 45, height: 45)
                    .foregroundStyle(.customGreen)
                
                Text("피임약 복용")
            }
            .padding(.bottom)
            
            HStack{
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 45, height: 45)
                    .foregroundStyle(.customGreen)
                
                Text("피임약 2알 복용")
            }
            .padding(.bottom)
            
            HStack{
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 45, height: 45)
                    .foregroundStyle(.customBrown)
                
                Text("미복용")
            }
            .padding(.bottom)
            
            HStack{
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 45, height: 45)
                    .foregroundStyle(.customGreen)
                
                Text("현재")
            }
        }
    }
}

#Preview {
    PopoverView()
}
