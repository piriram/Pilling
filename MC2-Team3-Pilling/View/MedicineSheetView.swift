
import SwiftUI
import SwiftData

struct MedicineSheetView: View {
    @State private var searchText = ""
    
    @Binding var showingMedicineSheet: Bool
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedPill: PillInfo?
    @Query var userOne:[UserInfo]
    
    
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
                        
                        if selectedPill == pill {
                            userOne.first?.curPill?.pillInfo=selectedPill!
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        
                    }) {
                        HStack {
                            Text(pill.pillName)
                            Text("\(pill.intakeDay)" + "/" + "\(pill.placeboDay)")
                                .secondaryRegular()
                            Spacer()
                            if selectedPill == pill {
                                Image(systemName: "checkmark")
                                    .foregroundStyle(.customGreen)
                            }
                        }
                    }
                }
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            } //리스트의 스타일 수정
            .listStyle(PlainListStyle())
            .navigationTitle("💊")
            .navigationBarTitleDisplayMode(.inline)
        }
        
        
        
    }
}

