
import SwiftUI

struct PopoverView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "book.fill")
                    .foregroundColor(.customGray)
                    .font(.title)
                
                Text("필링 가이드")
                    .largeBold()
                    .padding(.bottom, 3)
            }
            Text("피임약 복용 상태를 잔디로 알려줘요!")
                .secondaryRegular()
            
            Divider()
                .padding(.vertical, 8)
            
            HStack{
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 45, height: 45)
                    .foregroundStyle(.customGreen)
                
                Text("피임약 복용")
                    .regular()
            }
            .padding(.bottom)
            
            HStack{
                HStack(spacing: 5){
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 20, height: 45)
                        .background(.customGreen)
                        .cornerRadius(10)
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 20, height: 45)
                        .background(Color(red: 0.5, green: 0.87, blue: 0.11))
                        .cornerRadius(10)
                    
                    
                }
                .frame(width: 45, height: 45)
                
                Text("피임약 2알 복용")
                    .regular()
            }
            .padding(.bottom)
            
            HStack{
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 45, height: 45)
                    .foregroundStyle(.customBrown)
                
                Text("미복용")
                    .regular()
                
            }
            .padding(.bottom)
            
            HStack{
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 45, height: 45)
                    .background(.customGray)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .inset(by: 1)
                            .stroke(Color.green,lineWidth: 3)
                        
                    )
                
                Text("오늘")
                    .regular()
            }
            .padding(.bottom)
            
            HStack{
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 45, height: 45)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .inset(by: 0.5)
                            .stroke(Color(red: 0.91, green: 0.91, blue: 0.92), lineWidth: 2)
                        
                    )
                
                Text("위약/휴약")
                    .regular()
            }
        }
    }
}

#Preview {
    PopoverView()
}
