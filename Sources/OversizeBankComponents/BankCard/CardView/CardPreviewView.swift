//
// Copyright © 2022 Alexander Romanov
// CardPreviewView.swift
//

import OversizeUI
import SwiftUI

// swiftlint:disable all
public struct CardPreviewView: View {
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
        CardBackgroundView(viewModel: viewModel)
    }
}

// MARK: - Preview

struct CardPreviewView_Previews: PreviewProvider {
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

//            CardView(viewModel: CardViewModel(card: BankCardModel(
//                                                position: 0,
//                                                number: 234385874545438,
//                                                name: "Зарплатная",
//                                                bank: "Tinkoff",
//                                                holder: "Alexander romanov",
//                                                pin: 1234,
//                                                date: Date(),
//                                                payPass: CardPayPassType.glass,
//                                                chip: CardChipType.clay,
//                                                paymentSystem: CardPaymentSystemType.masterCard(style: CardMasterCardStyleType.glass),
//                                                bankColor: CardFontColor.standart,
//                                                bankSize: CardFontSize.standart,
//                                                bankFont: CardFontType.neo,
//                                                numberColor: CardFontColor.standart,
//                                                numberSize: CardFontSize.standart,
//                                                numberFont: CardFontType.apple,
//                                                dateColor: CardFontColor.standart,
//                                                dateSize: CardFontSize.standart,
//                                                dateFont: CardFontType.neo,
//                                                cvvColor: CardFontColor.standart,
//                                                cvvSize: CardFontSize.standart,
//                                                cvvFont: CardFontType.apple,
//                                                holderColor: CardFontColor.standart,
//                                                holderSize: CardFontSize.standart,
//                                                holderFont: CardFontType.apple,
//                                                texture: CardTextureType.paper,
//                                                background: CardBackgroundType.shape(design: CardShapeNames.shape08, color: [Color.black, Color.blue, Color.orange, Color.red]),
//                                                isArchive: false))
//
//
//
//
//
//
//            ).padding()
//
//            CardView(viewModel: CardViewModel(card: BankCardModel(
//                                                position: 0,
//                                                number: 234385874545438,
//                                                name: "Зарплатная",
//                                                bank: "Tinkoff",
//                                                holder: "Alexander romanov",
//                                                pin: 1234,
//                                                date: Date(),
//                                                payPass: CardPayPassType.glass,
//                                                chip: CardChipType.clay,
//                                                paymentSystem: CardPaymentSystemType.masterCard(style: CardMasterCardStyleType.glass),
//                                                bankColor: CardFontColor.standart,
//                                                bankSize: CardFontSize.standart,
//                                                bankFont: CardFontType.neo,
//                                                numberColor: CardFontColor.standart,
//                                                numberSize: CardFontSize.standart,
//                                                numberFont: CardFontType.apple,
//                                                dateColor: CardFontColor.standart,
//                                                dateSize: CardFontSize.standart,
//                                                dateFont: CardFontType.neo,
//                                                cvvColor: CardFontColor.standart,
//                                                cvvSize: CardFontSize.standart,
//                                                cvvFont: CardFontType.apple,
//                                                holderColor: CardFontColor.standart,
//                                                holderSize: CardFontSize.standart,
//                                                holderFont: CardFontType.apple,
//                                                texture: CardTextureType.noise,
//                                                background: CardBackgroundType.shape(design: CardShapeNames.shape01, color: [Color.yellow, Color.blue, .green, Color.black]),
//                                                isArchive: false))
//
//
//
//
//
//
//            ).padding()
//
//
//            CardView(viewModel: CardViewModel(card: BankCardModel(
//                                                position: 0,
//                                                number: 234385874545438,
//                                                name: "Зарплатная",
//                                                bank: "Tinkoff",
//                                                holder: "Alexander romanov",
//                                                pin: 1234,
//                                                date: Date(),
//                                                payPass: CardPayPassType.glass,
//                                                chip: CardChipType.clay,
//                                                paymentSystem: CardPaymentSystemType.masterCard(style: CardMasterCardStyleType.glass),
//                                                bankColor: CardFontColor.custum(color: Color.white),
//                                                bankSize: CardFontSize.custum(size: 32),
//                                                bankFont: CardFontType.stanart,
//                                                numberColor: CardFontColor.custum(color: Color.yellow),
//                                                numberSize: CardFontSize.custum(size: 24),
//                                                numberFont: CardFontType.apple,
//                                                dateColor: CardFontColor.custum(color: Color.blue),
//                                                dateSize: CardFontSize.custum(size: 22),
//                                                dateFont: CardFontType.neo,
//                                                cvvColor: CardFontColor.custum(color: Color.black),
//                                                cvvSize: CardFontSize.custum(size: 21),
//                                                cvvFont: CardFontType.apple,
//                                                holderColor: CardFontColor.custum(color: Color.black),
//                                                holderSize: CardFontSize.custum(size: 21),
//                                                holderFont: CardFontType.apple,
//                                                texture: CardTextureType.paper,
//                                                background: CardBackgroundType.gradient(startColor: Color.red, endColor: Color.blue, side: .horizontal),
//                                                isArchive: false))
//
//
//
//
//
//
//            ).padding()
//
//            CardView(viewModel: CardViewModel(card: BankCardModel(
//                                                position: 0,
//                                                number: 234385874545438,
//                                                name: "Зарплатная",
//                                                bank: "Tinkoff",
//                                                holder: "Alexander romanov",
//                                                pin: 1234,
//                                                date: Date(),
//                                                payPass: CardPayPassType.glass,
//                                                chip: CardChipType.clay,
//                                                paymentSystem: CardPaymentSystemType.masterCard(style: CardMasterCardStyleType.glass),
//                                                bankColor: CardFontColor.standart,
//                                                bankSize: CardFontSize.standart,
//                                                bankFont: CardFontType.neo,
//                                                numberColor: CardFontColor.standart,
//                                                numberSize: CardFontSize.standart,
//                                                numberFont: CardFontType.apple,
//                                                dateColor: CardFontColor.standart,
//                                                dateSize: CardFontSize.standart,
//                                                dateFont: CardFontType.neo,
//                                                cvvColor: CardFontColor.standart,
//                                                cvvSize: CardFontSize.standart,
//                                                cvvFont: CardFontType.apple,
//                                                holderColor: CardFontColor.standart,
//                                                holderSize: CardFontSize.standart,
//                                                holderFont: CardFontType.apple,
//                                                texture: CardTextureType.iridescent,
//                                                background: CardBackgroundType.image(image: CardBackgroundImageNames.background01),
//                                                isArchive: false))
//
//
//
//
//
//
//            ).padding()

        }.previewLayout(.fixed(width: 375, height: 250))
    }
}
