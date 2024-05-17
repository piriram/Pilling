//
//  CustomFont.swift
//  PillingTest
//
//  Created by Groo on 5/16/24.
//

import SwiftUI

extension View {
    func largeTitle() -> some View {
        self.modifier(CustomFontStyle(fontType: .largeTitle, isBold: true, color: .black))
    }
    func secondaryRegular() -> some View {
        self.modifier(CustomFontStyle(fontType: .body, isBold: false, color: .secondary))
    }
    func boldRegular() -> some View {
        self.modifier(CustomFontStyle(fontType: .body, isBold: true, color: .black))
    }
    func largeBold() -> some View {
        self.modifier(CustomFontStyle(fontType: .title3, isBold: true, color: .black))
    }
    func regular() -> some View {
        self.modifier(CustomFontStyle(fontType: .body, isBold: false, color: .black))
    }
    func Icon() -> some View {
        self.modifier(CustomFontStyle(fontType: .title, isBold: false, color: .secondary))
    }
}

struct CustomFontStyle: ViewModifier {
    var fontType: Font
    var isBold : Bool
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .font(fontType)
            .fontWeight(isBold ? .bold : .regular)
            .foregroundColor(color)
    }
}
