//
//  MedicineSheetView.swift
//  MC2-Team3-Pilling
//
//  Created by 이소현 on 5/17/24.
//

import SwiftUI

struct MedicineSheetView: View {
    let array = [
        "김서근", "포뇨", "하울", "소피아", "캐시퍼", "소스케",
        "치히로", "하쿠", "가오나시", "제니바", "카브", "마르클",
        "토토로", "사츠키", "지브리", "스튜디오", "캐릭터"
    ]
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                
                List {
                    ForEach(array.filter{$0.hasPrefix(searchText) || searchText == ""}, id:\.self) {
                        searchText in Text(searchText)
                    }
                } //리스트의 스타일 수정
                .listStyle(PlainListStyle())
                //화면 터치시 키보드 숨김
                .onTapGesture {
                    hideKeyboard()
                }
            }
            //            .navigationBarTitle("검색기능")
            .navigationBarItems(trailing:
                                    HStack{
                Button(action: {
                }) {
                    //                                            HStack {
                    //                                                Text("서근")
                    //                                                    .foregroundColor(.black)
                    //                                                Image(systemName: "folder.fill")
                    //                                            }
                }
            }
            )
        }
    }
}


//캔버스 컨텐츠뷰
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MedicineSheetView()
    }
}


//화면 터치시 키보드 숨김
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif





#Preview {
    MedicineSheetView()
}
