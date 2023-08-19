//
// Copyright © 2022 Alexander Romanov
// CardCompactViewTypography..swift
//

import SwiftUI

// MARK: - Text

public struct CardCompactViewTypography: View {
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
        templateClassic
    }

    var templateClassic: some View {
        ZStack {
            HStack(alignment: .center) {
                Spacer()

                // Pyment system
                Image(viewModel.paymentSystemName, bundle: .module)
                    .resizable()
                    .scaledToFit()
                    .frame(width: Constans.paymentSystemImageWidth)
                    .padding(.horizontal, 8)
            }

            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 16) {
                    // Bank
                    Text(viewModel.card.bank ?? "")
                        .cardFontStyle(viewModel.card.bankFont,
                                       color: viewModel.bankColor,
                                       size: 24) // viewModel.bankFontSize)

                    Text(format(cardNumber: viewModel.card.number))
                        .cardFontStyle(viewModel.card.numberFont,
                                       color: viewModel.numberColor,
                                       size: 16) // viewModel.numberFontSize)
                }
                .padding(.bottom, 4)

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
