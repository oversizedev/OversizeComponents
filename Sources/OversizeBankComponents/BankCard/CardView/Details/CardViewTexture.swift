//
// Copyright © 2022 Alexander Romanov
// CardViewTexture.swift
//

import SwiftUI

// MARK: - Texture and Light

// swiftlint:disable all
public struct CardTextureView: View {
    var viewModel: CardViewModel

    public init(viewModel: CardViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        Image(viewModel.card.texture.rawValue, bundle: .module)
            .resizable()
            .opacity(0.3)
    }
}
