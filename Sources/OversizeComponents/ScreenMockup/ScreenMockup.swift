//
// Copyright © 2022 Alexander Romanov
// ScreenMockup.swift
//

import CachedAsyncImage
import OversizeCore
import SwiftUI

public struct ScreenMockup: View {
    private let url: URL

    public init(url: URL) {
        self.url = url
    }

    public var body: some View {
        ZStack {
            CachedAsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .scaleEffect(0.89)
            } placeholder: {
                ZStack {
                    RoundedRectangle(cornerRadius: 28, style: .continuous)
                        .fillOnPrimaryDisabled()

                    ProgressView()
                }
            }

            CachedAsyncImage(url: URL(string: "https://cdn.oversize.design/assets/mocks/iphone13/iPhone13.png"), urlCache: .imageCache) { image in
                image
                    .resizable()
                    .scaledToFill()

            } placeholder: {
                RoundedRectangle(cornerRadius: 28, style: .continuous)
                    .fillOnPrimaryDisabled()
            }
        }
    }
}

struct ScreenMockup_Previews: PreviewProvider {
    static var previews: some View {
        ScreenMockup(url: URL(string: "https://cdn.oversize.design/assets/apps/dressweather/screenshots/1.png")!)
    }
}
