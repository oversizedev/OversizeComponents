//
// Copyright © 2022 Alexander Romanov
// AsyncIconView.swift
//

import SDWebImageSwiftUI
import SwiftUI

public enum AsyncIconViewPlaceholderType {
    case circle, rectangle, roundedRectangle
}

public struct AsyncIconView: View {
    #if os(iOS) || os(macOS)
        @Environment(\.controlSize) var controlSize: ControlSize
    #endif

    let path: String

    var placeholderType: AsyncIconViewPlaceholderType = .roundedRectangle

    public init(_ path: String) {
        self.path = path
    }

    public var body: some View {
        let url = URL(string: "https://cdn.oversize.design/assets/icons/\(path)")

        WebImage(url: url, context: [.imageThumbnailPixelSize: CGSize(width: iconSize, height: iconSize)])
            .resizable()
            .placeholder {
                shape.foregroundColor(.surfaceTertiary)
            }
            .renderingMode(.template)
            // .indicator(.activity)
            .transition(.fade(duration: 0.3))
            .scaledToFit()
            .frame(width: iconSize, height: iconSize, alignment: .center)
    }

    var iconSize: CGFloat {
        #if os(iOS) || os(macOS)
            switch controlSize {
            case .mini:
                return 16
            case .small:
                return 24
            case .regular:
                return 32
            case .large:
                return 48
            @unknown default:
                return 24
            }
        #else
            return 24
        #endif
    }

    @ViewBuilder
    var shape: some View {
        switch placeholderType {
        case .circle:
            Circle()
        case .rectangle:
            Rectangle()
        case .roundedRectangle:
            RoundedRectangle(cornerRadius: iconSize / 4)
        }
    }

    public func placeholder(_ type: AsyncIconViewPlaceholderType) -> AsyncIconView {
        var control = self
        control.placeholderType = type
        return control
    }
}
