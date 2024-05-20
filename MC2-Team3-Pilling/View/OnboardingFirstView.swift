
import SwiftUI

struct OnboardingFirstView: View {
    @State private var showingMedicineSheet = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("making-plan")
                    .resizable()
                    .frame(width: 240, height: 240)
                
                // Text
                HStack {
                    VStack(alignment: .leading) {
                        Text("복용하고 계신 약을 알려주세요!")
                            .largeTitle()
                            .padding(.bottom, 2)
                        
                        Text("설정은 추후에 변경 가능합니다.")
                            .secondaryRegular()
                    }
                    Spacer()
                }
                
                
                // Selecting box
                VStack {
                    Button(action: {
                        self.showingMedicineSheet = true
                    }, label: {
                        // sfSymbol 부재 : medicine-bottle-one
                        HStack {
                            Image(systemName: "pill.circle.fill")
                            Text("약 종류")
                                .secondaryTitle()
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .padding([.leading, .trailing], 25)
                    })
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity)
                    .background(.customGray02)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundColor(.secondary)
                    .sheet(isPresented: $showingMedicineSheet){
                        MedicineSheetView()
                            .presentationDetents([.medium])
                    }
                    
                    
                    
                    Button(action: {}, label: {
                        // sfSymbol 부재 : uis-calender
                        HStack {
                            Image(systemName: "note")
                            Text("현재 복용 일수")
                                .secondaryTitle()
                            Spacer()
                        }
                        .padding([.leading, .trailing], 25)
                    })
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity)
                    .background(.customGray02)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundColor(.secondary)
                    
                    
                }
                
                Spacer()
                
                // footer button
                NavigationLink(destination: OnboardingSecondView()) {
                    Text("다음으로")
                        .largeBold()
                }
                .padding(.vertical, 30)
                .frame(maxWidth: .infinity)
                .background(.customGreen)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .foregroundColor(.black)
            }
            .padding()
        }
    }
}

#Preview {
    OnboardingFirstView()
}
