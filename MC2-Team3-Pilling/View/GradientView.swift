//
//  GradiantView.swift
//  MC2-Team3-Pilling
//
//  Created by ram on 5/24/24.
//

import SwiftUI

struct GreenGradient: View {
    var body: some View {
        LinearGradient(stops: [.init(color: .customGreen.opacity(0.3), location: 0), .init(color: .white, location: 0.15)], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

#Preview {
    GreenGradient()
}
