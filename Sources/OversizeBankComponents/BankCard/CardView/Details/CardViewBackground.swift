//
// Copyright © 2022 Alexander Romanov
// CardViewBackground.swift
//

import SwiftUI

// MARK: - Background

// swiftlint:disable all
public struct CardBackgroundView: View {
    var viewModel: CardViewModel

    public init(viewModel: CardViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        backgroundView()
    }

    @ViewBuilder
    func backgroundView() -> some View {
        switch viewModel.card.background {
        case let .gradient(startColor: startColor, endColor: endColor, side: side):

            let gradient = Gradient(colors: [startColor, endColor])

            switch side {
            case .horizontal:
                Rectangle()
                    .fill(LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .trailing))

            case .vertical:
                Rectangle()
                    .fill(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))

            case .deiganal:
                Rectangle()
                    .fill(LinearGradient(gradient: gradient, startPoint: .topLeading, endPoint: .bottomTrailing))
            }

        case let .image(image: image): Image(image.rawValue, bundle: .module)
            .resizable()
            .scaleEffect(1.01)

        case let .shape(design: design,
                        primaryColor: primaryColor,
                        secondaryColor: secondaryColor,
                        tertiaryColor: tertiaryColor,
                        quaternaryColor: quaternaryColor,
                        fivefoldColor: fivefoldColor):
            getCardSapeDesign(design: design,
                              primaryColor: primaryColor,
                              secondaryColor: secondaryColor,
                              tertiaryColor: tertiaryColor,
                              quaternaryColor: quaternaryColor,
                              fivefoldColor: fivefoldColor)
        }
    }

    @ViewBuilder
    func getCardSapeDesign(
        design: CardShapeNames,
        primaryColor: Color,
        secondaryColor: Color,
        tertiaryColor: Color,
        quaternaryColor: Color,
        fivefoldColor _: Color
    ) -> some View {
        ZStack {
            Rectangle()
                .fill(primaryColor)

            Rectangle()
                .fill(quaternaryColor)
                .mask(Image(design.rawValue + "3", bundle: .module)
                    .resizable()
                )

            Rectangle()
                .fill(tertiaryColor)
                .mask(Image(design.rawValue + "2", bundle: .module)
                    .resizable()
                )

            Rectangle()
                .fill(secondaryColor)
                .mask(Image(design.rawValue + "1", bundle: .module)
                    .resizable()
                )
        }
    }
}
