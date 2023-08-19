//
// Copyright © 2022 Alexander Romanov
// CardViewModel.swift
//

import SwiftUI

public class CardViewModel: ObservableObject {
    public var card: BankCard

    public var paymentSystemName: String {
        switch card.paymentSystem {
        case let .masterCard(style: style):
            return style.rawValue
        case let .visa(style: style):
            return style.rawValue
        case let .maestro(style: style):
            return style.rawValue
        case let .mir(style: style):
            return style.rawValue
        case let .americanExpress(style: style):
            return style.rawValue
        case let .dinersClub(style: style):
            return style.rawValue
        case let .discover(style: style):
            return style.rawValue
        case let .unionPay(style: style):
            return style.rawValue
        case let .jcb(style: style):
            return style.rawValue
        }
    }

    var bankFontSize: Int {
        switch card.bankSize {
        case .standart:
            return 16
        case let .custum(size: size):
            return size
        }
    }

    var bankColor: Color {
        switch card.bankColor {
        case .standart:
            return .white
        case let .custum(color: color):
            return color
        }
    }

    var numberFontSize: Int {
        switch card.numberSize {
        case .standart:
            return 16
        case let .custum(size: size):
            return size
        }
    }

    var numberColor: Color {
        switch card.numberColor {
        case .standart:
            return .white
        case let .custum(color: color):
            return color
        }
    }

    var dateFontSize: Int {
        switch card.dateSize {
        case .standart:
            return 16
        case let .custum(size: size):
            return size
        }
    }

    var dateColor: Color {
        switch card.dateColor {
        case .standart:
            return .white
        case let .custum(color: color):
            return color
        }
    }

    var cvvFontSize: Int {
        switch card.cvvSize {
        case .standart:
            return 16
        case let .custum(size: size):
            return size
        }
    }

    var cvvColor: Color {
        switch card.cvvColor {
        case .standart:
            return .white
        case let .custum(color: color):
            return color
        }
    }

    var holderFontSize: Int {
        switch card.holderSize {
        case .standart:
            return 16
        case let .custum(size: size):
            return size
        }
    }

    var holderColor: Color {
        switch card.holderColor {
        case .standart:
            return .white
        case let .custum(color: color):
            return color
        }
    }

    public init(card: BankCard) {
        self.card = card
    }
}
