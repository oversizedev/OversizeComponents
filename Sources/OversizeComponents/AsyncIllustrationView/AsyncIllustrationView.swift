//
// Copyright © 2022 Alexander Romanov
// AsyncIllustrationView.swift
//

import CachedAsyncImage
import OversizeCore
import OversizeUI
import SwiftUI

public struct AsyncIllustrationView: View {
    #if os(iOS) || os(macOS)
    @Environment(\.controlSize) var controlSize: ControlSize
    #endif

    #if os(iOS)
    let scale = UIScreen.main.scale
    #else
    let scale: CGFloat = 2
    #endif

    let path: String

    public init(_ path: String) {
        self.path = path
    }

    public var body: some View {
        let url = URL(string: "https://cdn.oversize.design/assets/illustrations/\(path)")

        CachedAsyncImage(url: url, urlCache: .imageCache, scale: scale) {
            $0
                .resizable()
                .scaledToFit()
        } placeholder: {
            Circle()
                .fillSurfaceTertiary()
        }
    }

    var scaleLabel: String {
        if scale == 3 {
            "@\(String(format: "%.0f", scale))x"
        } else {
            ""
        }
    }

    var illustrationSize: CGFloat {
        #if os(iOS) || os(macOS)
        switch controlSize {
        case .mini:
            return 16
        case .small:
            return 24
        case .regular:
            return 32
        case .large, .extraLarge:
            return 48
        @unknown default:
            return 24
        }
        #else
        return 24
        #endif
    }
}
