//
// Copyright © 2022 Alexander Romanov
// CardViewText.swift
//

import SwiftUI

// MARK: - Text

public struct CardTextView: View {
    var viewModel: CardViewModel

    public init(viewModel: CardViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        templateView()
    }

    enum Constans {
        static var paymentSystemImageWidth: CGFloat = 48
    }

    @ViewBuilder
    func templateView() -> some View {
        switch viewModel.card.template {
        case .classic:
            templateClassic
        case .minimal:
            templateMinimal
        case .typo:
            templateTypo
//        case .verti:
//            templateVerti
        }
    }

    var templateVerti: some View {
        ZStack {
            HStack(alignment: .bottom, spacing: 0) {
                // Bank
                Text(viewModel.card.bank ?? "")
                    .cardFontStyle(viewModel.card.bankFont,
                                   color: viewModel.bankColor,
                                   size: viewModel.bankFontSize)
                    .rotationEffect(Angle(degrees: -90 * 3), anchor: .bottomTrailing)

                Spacer()
                    .frame(height: 24)

                Spacer()

                VStack {
                    // PayPass
                    Image(viewModel.card.payPass.rawValue, bundle: .module)
                        .resizable()
                        .frame(width: 26, height: 26)

                    Spacer()

                    // Pyment system
                    Image(viewModel.paymentSystemName, bundle: .module)
                        .resizable()
                        .scaledToFit()
                        .frame(width: Constans.paymentSystemImageWidth)
                    // .rotationEffect(.degrees(-90)
                }
                .padding(.trailing, 32)
            }
        }
        .padding(.all, 24)
    }

    var templateMinimal: some View {
        ZStack {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    // Chip
                    Image(viewModel.card.chip.rawValue, bundle: .module)
                        .resizable()
                        .frame(width: 40, height: 28)

                    Spacer()

                    // Bank
                    Text(viewModel.card.bank ?? "")
                        .cardFontStyle(viewModel.card.bankFont,
                                       color: viewModel.bankColor,
                                       size: viewModel.bankFontSize)
                }
                Spacer()
            }

            VStack(alignment: .trailing) {
                HStack(alignment: .top) {
                    Spacer()

                    // Card holder
                    Text(viewModel.card.holder?.uppercased() ?? "")
                        .cardFontStyle(viewModel.card.holderFont,
                                       color: viewModel.holderColor,
                                       size: viewModel.holderFontSize)

                    // Date
                    Text(format(date: viewModel.card.date))
                        .cardFontStyle(viewModel.card.dateFont,
                                       color: viewModel.dateColor,
                                       size: viewModel.dateFontSize)

                }.padding(.top, 4)

                Spacer()
            }
        }
        .padding(.all, 24)
    }

    var templateTypo: some View {
        ZStack {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    // Bank
                    Text(viewModel.card.bank ?? "")
                        .cardFontStyle(viewModel.card.bankFont,
                                       color: viewModel.bankColor,
                                       size: viewModel.bankFontSize)

                    Spacer()
                        .frame(height: 24)

                    VStack(alignment: .leading, spacing: 8) {
                        // Card holder
                        Text(viewModel.card.holder?.uppercased() ?? "")
                            .cardFontStyle(viewModel.card.holderFont,
                                           color: viewModel.holderColor,
                                           size: viewModel.holderFontSize)

                        // Date
                        Text(format(date: viewModel.card.date))
                            .cardFontStyle(viewModel.card.dateFont,
                                           color: viewModel.dateColor,
                                           size: viewModel.dateFontSize)
                    }

                    Spacer()

                    // PayPass
                    Image(viewModel.card.payPass.rawValue, bundle: .module)
                        .resizable()
                        .frame(width: 26, height: 26)
                }
                Spacer()
            }
        }
        .padding(.all, 24)
    }

    var templateClassic: some View {
        ZStack {
            VStack(alignment: .trailing) {
                Spacer()
                HStack(alignment: .bottom) {
                    Spacer()

                    ZStack {
                        // Pyment system
                        Image(viewModel.paymentSystemName, bundle: .module)
                            .resizable()
                            .scaledToFit()
                            .frame(width: Constans.paymentSystemImageWidth)
                    }
                }
            }

            VStack(alignment: .trailing) {
                HStack(alignment: .top) {
                    Spacer()

                    // PayPass
                    Image(viewModel.card.payPass.rawValue, bundle: .module)
                        .resizable()
                        .frame(width: 26, height: 26)
                }
                Spacer()
            }

            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    // Bank
                    Text(viewModel.card.bank ?? "")
                        .cardFontStyle(viewModel.card.bankFont,
                                       color: viewModel.bankColor,
                                       size: viewModel.bankFontSize)
                    Spacer()

                    // Chip
                    Image(viewModel.card.chip.rawValue, bundle: .module)
                        .resizable()
                        .frame(width: 40, height: 28)

                    Spacer()

                    VStack(alignment: .leading, spacing: 8) {
                        Text(format(cardNumber: viewModel.card.number))
                            .cardFontStyle(viewModel.card.numberFont,
                                           color: viewModel.numberColor,
                                           size: viewModel.numberFontSize)

                        // Date
                        Text(format(date: viewModel.card.date))
                            .cardFontStyle(viewModel.card.dateFont,
                                           color: viewModel.dateColor,
                                           size: viewModel.dateFontSize)

                        // Card holder
                        Text(viewModel.card.holder?.uppercased() ?? "")
                            .cardFontStyle(viewModel.card.holderFont,
                                           color: viewModel.holderColor,
                                           size: viewModel.holderFontSize)
                    }
                }
                Spacer()
            }
        }
        .padding(.all, 24)
    }

//    func format(cardNumber: String) -> String {
//        var formatedCardNumber = ""
//        var i: Int = 0
//        //loop for every character
//        for character in cardNumber.characters {
//            //in case you want to replace some digits in the middle with * for security
//            if(i < 6 || i >= cardNumber.characters.count - 4) {
//                formatedCardNumber = formatedCardNumber + String(character)
//            }else{
//                formatedCardNumber = formatedCardNumber + "*"
//            }
//            //insert separators every 4 spaces(magic number)
//            if(i == 3 || i == 7 || i == 11 || (i == 15 && cardNumber.characters.count > 16 )){
//                formatedCardNumber = formatedCardNumber + "-"
//                // could use just " " for spaces
//            }
//
//            i = i + 1
//        }
//        return formatedCardNumber
//    }

    func format(cardNumber: String) -> String {
        let trimmedString = cardNumber.components(separatedBy: .whitespaces).joined()

        let arrOfCharacters = Array(trimmedString)
        var modifiedCreditCardString = ""

        if arrOfCharacters.count > 0 {
            for i in 0 ... arrOfCharacters.count - 1 {
                modifiedCreditCardString.append(arrOfCharacters[i])
                if (i + 1) % 4 == 0, i + 1 != arrOfCharacters.count {
                    modifiedCreditCardString.append(" ")
                }
            }
        }
        return modifiedCreditCardString
    }

    func format(date: String) -> String {
        let trimmedString = date.components(separatedBy: .whitespaces).joined()

        let arrOfCharacters = Array(trimmedString)
        var modifiedCreditCardString = ""

        if arrOfCharacters.count > 0 {
            for i in 0 ... arrOfCharacters.count - 1 {
                modifiedCreditCardString.append(arrOfCharacters[i])
                if (i + 1) % 2 == 0, i + 1 != arrOfCharacters.count {
                    modifiedCreditCardString.append("/")
                }
            }
        }
        return modifiedCreditCardString
    }
}
