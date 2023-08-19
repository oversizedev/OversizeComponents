//
// Copyright © 2022 Alexander Romanov
// CardViewTypography.swift
//

import SwiftUI

public struct CardTypography: ViewModifier {
    public var style: CardFontType

    public var size: Int

    public func body(content: Content) -> some View {
        switch style {
        case .default:
            return content.font(Font.custom("OCRAExtended", size: CGFloat(size)))
        case .sans:
            return content.font(Font.custom("Montserrat-SemiBold", size: CGFloat(size)))
        case .rounded:
            return content.font(.system(size: CGFloat(size), weight: .bold, design: .rounded))
        case .serif:
            return content.font(.system(size: CGFloat(size), weight: .bold, design: .serif))
        }
    }
}

public extension View {
    func cardFontStyle(_ style: CardFontType, color: Color, size: Int) -> some View {
        modifier(CardTypography(style: style, size: size))
            .foregroundColor(color)
    }
}
