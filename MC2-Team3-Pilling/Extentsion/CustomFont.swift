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
        self.modifier(CustomFontStyle(fontType: .title3, isBold: true, color: .black, kerning: -1.5))
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

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}

extension Color {
    static let lightGray = Color(hex: "e1e1e1")
}
