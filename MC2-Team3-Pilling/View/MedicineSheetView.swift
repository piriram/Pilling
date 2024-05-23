
import SwiftUI

struct MedicineSheetView: View {
    @State private var searchText = ""

    @Binding var showingMedicineSheet: Bool

    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedPill: PillInfo?
    
    //    let BirthControlNames = [
    //        "쎄스콘정", "미뉴렛정", "에이리스정", "머시론정",
    //        "마이보라", "미니보라30","트리퀄라", "멜리안정",
    //        "센스리베정", "디어미정", "야스민정", "야즈정","클래라정"]
    
    var filteredBirthControl: [PillInfo] {
        if searchText.isEmpty {
            return Config.dummyPillInfos
        } else {
            return Config.dummyPillInfos.filter{ $0.pillName.localizedStandardContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List(filteredBirthControl) { pill in
                    Button(action: {
                        selectedPill = pill
                        print(pill.pillName)
                    }) {
                        HStack {
                            Text(pill.pillName)
                            Text("\(pill.intakeDay)" + "/" + "\(pill.placeboDay)")
                                .secondaryRegular()
                            Spacer()
                            if selectedPill == pill {
                                Image(systemName: "checkmark")
                                    .foregroundStyle(Color.blue)
                            }
                        }
                    }
                }
                .searchable(text: $searchText)
            } //리스트의 스타일 수정
            .listStyle(PlainListStyle())
        }
        
        // footer button
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            self.showingMedicineSheet = false
            
            
        }, label: {
            Text("설정완료!")
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



//캔버스 컨텐츠뷰
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//
//        MedicineSheetView(showingMedicineSheet: false)
////        MedicineSheetView()
//    }
//}


//화면 터치시 키보드 숨김
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

