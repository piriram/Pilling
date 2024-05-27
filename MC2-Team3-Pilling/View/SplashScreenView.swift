
import SwiftUI
import SwiftData

struct SplashScreenView: View {
    @State var isSplash = false
    @Query var user:[UserInfo]
    @State var isMain = false
    var body: some View {
        if isSplash {
            if user.first != nil{
                NavigationStack{
                    MainView()
                }
            }
            else{
                OnboardingFirstView(isMain: $isMain)
            }
        } else {
            VStack {
                Image("Splash")
                    .resizable()
                    .ignoresSafeArea()
                
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation {
                        self.isSplash = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
