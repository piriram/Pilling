//
//  CustomFont.swift
//  PillingTest
//
//  Created by Groo on 5/16/24.
//

import SwiftUI

extension View {
    func largeTitle() -> some View {
        self.modifier(CustomFontStyle(fontType: .largeTitle, isBold: true, color: .black, kerning: -1.5))
    }
    func secondaryTitle() -> some View {
        self.modifier(CustomFontStyle(fontType: .title2, isBold: false, color: .secondary, kerning: -1.5))
    }
    func secondaryRegular() -> some View {
        self.modifier(CustomFontStyle(fontType: .body, isBold: false, color: .secondary, kerning: -1.5))
    }
    func boldRegular() -> some View {
        self.modifier(CustomFontStyle(fontType: .body, isBold: true, color: .black, kerning: -1.5))
    }
    func largeBold() -> some View {
        self.modifier(CustomFontStyle(fontType: .title2, isBold: true, color: .black, kerning: -1.5))
    }
    func regular() -> some View {
        self.modifier(CustomFontStyle(fontType: .body, isBold: false, color: .black, kerning: -1.5))
    }
    func Icon() -> some View {
        self.modifier(CustomFontStyle(fontType: .title, isBold: false, color: .secondary, kerning: -1.5))
    }
}

struct CustomFontStyle: ViewModifier {
    var fontType: Font
    var isBold : Bool
    var color: Color
    var kerning: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(fontType)
            .fontWeight(isBold ? .bold : .regular)
            .foregroundColor(color)
    }
}
