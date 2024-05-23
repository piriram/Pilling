
import SwiftUI
import SwiftData

struct SplashScreenView: View {
    @State var isActive: Bool = false
    @Query var user:[UserInfo]
    var body: some View {
        if isActive {
            if user.first != nil{
                NavigationStack{
                    MainView()
                }
            }
            else{
                OnboardingFirstView()
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
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
