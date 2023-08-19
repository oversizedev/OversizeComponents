//
// Copyright © 2022 Alexander Romanov
// CardViewCompact.swift
//

import OversizeUI
import SwiftUI

// swiftlint:disable all
public struct CardViewCompact: View {
    @ObservedObject var viewModel: CardViewModel

    public init(viewModel: CardViewModel) {
        self.viewModel = viewModel
    }

    var radius: Radius = .xLarge

    public init(viewModel: CardViewModel,
                radius: Radius = .xLarge)
    {
        self.viewModel = viewModel
        self.radius = radius
    }

    enum Constans {
        static var paymentSystemImageWidth: CGFloat = 48
    }

    public var body: some View {
        content()
            .clipShape(RoundedRectangle(cornerRadius: radius.rawValue, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: radius.rawValue)
                .stroke(Color.black.opacity(0.1), lineWidth: 1))
    }

    @ViewBuilder
    func content() -> some View {
        ZStack {
            CardTextureView(viewModel: viewModel)

            CardLightView()

            CardCompactViewTypography(viewModel: viewModel)
        }
        .background(
            CardBackgroundView(viewModel: viewModel)
                .aspectRatio(1.59, contentMode: .fill)
        )
        .frame(height: 112)
    }
}

// MARK: - Preview

struct CardViewCompact_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CardView(viewModel: CardViewModel(card: BankCardModel(
                position: 0,
                number: "234385874545438",
                name: "Зарплатная",
                bank: "Tinkoff",
                holder: "Alexander romanov",
                pin: "1234",
                cvv: "123",
                date: "22/14",
                payPass: CardPayPassType.glass,
                chip: CardChipType.clay,
                paymentSystem: CardPaymentSystemType.masterCard(style: CardMasterCardStyleType.glass),
                bankColor: CardFontColor.standart,
                bankSize: CardFontSize.standart,
                bankFont: CardFontType.sans,
                numberColor: CardFontColor.standart,
                numberSize: CardFontSize.standart,
                numberFont: CardFontType.rounded,
                dateColor: CardFontColor.standart,
                dateSize: CardFontSize.standart,
                dateFont: CardFontType.sans,
                cvvColor: CardFontColor.standart,
                cvvSize: CardFontSize.standart,
                cvvFont: CardFontType.rounded,
                holderColor: CardFontColor.standart,
                holderSize: CardFontSize.standart,
                holderFont: CardFontType.rounded,
                texture: CardTextureType.metal,
                background: CardBackgroundType.shape(design: .shape03, primaryColor: .red, secondaryColor: .blue, tertiaryColor: .green, quaternaryColor: .blue, fivefoldColor: .link),
                template: CardTemplates.classic, isArchive: false
            ))

            ).padding()
        }.previewLayout(.fixed(width: 375, height: 250))
    }
}
