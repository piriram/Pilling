
import SwiftUI

struct OnboardingFirstView: View {
    @State private var showingMedicineSheet = false
    @State private var selectedPill: PillInfo?
    
    @State private var selectedTakingDays: Int = 0
    
    
    
    var body: some View {
        Image("making-plan")
            .resizable()
            .frame(width: 240, height: 240)
        
        // Text
        HStack {
            VStack(alignment: .leading) {
                Text("복용하고 계신 약을 알려주세요!")
                    .largeBold()
                    .padding(.bottom, 2)
                
                Text("설정은 추후에 변경 가능합니다.")
                    .secondaryRegular()
            }
            Spacer()
        }
        .padding()
        
        
        // Selecting box
        VStack {
            Button(action: {
                self.showingMedicineSheet = true
            }, label: {
                // sfSymbol 부재 : medicine-bottle-one
                HStack {
                    Image(systemName: "pill.circle.fill")
                    Text("약 종류")
                        .secondaryRegular()
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
            .padding([.leading, .trailing], 16)
            .sheet(isPresented: $showingMedicineSheet){
                MedicineSheetView(showingMedicineSheet: $showingMedicineSheet, selectedPill: $selectedPill)
                //                MedicineSheetView(showingMedicineSheet: $showingMedicineSheet, selectedPill: $selectedPill)
                    .presentationDetents([.medium])
            }
            
            
            Button(action: {}, label: {
                // sfSymbol 부재 : uis-calender
                
                HStack {
                    Image(systemName: "note")
                    Text("현재 복용 일수")
                        .secondaryRegular()
                    Spacer()
                    
                    // Picker
                    Picker("", selection: $selectedTakingDays) {
                        ForEach(1 ..< 28) { num in
                            Text("\(num)")
                        }
                    }
                    .pickerStyle(.menu)
                    .padding(-10)
                    .accentColor(Color.secondary)
                    
                    Text("일 차")
                    
                }
                .padding([.leading, .trailing], 25)
            })
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity)
            .background(.customGray02)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .foregroundColor(.secondary)
            .padding([.leading, .trailing], 16)
            
        }
        
        Spacer()
        
        // footer button
        Button(action: {
            //            OnboardingView02()
            
        }, label: {
            Text("다음으로")
                .largeBold()
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
    OnboardingFirstView()
}
