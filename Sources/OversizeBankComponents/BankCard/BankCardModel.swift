//
// Copyright © 2022 Alexander Romanov
// BankCardModel.swift
//

import SwiftUI

public protocol BankCard {
    var id: UUID { get set }
    var name: String { get set }
    var number: String { get set }
    var position: Int { get set }
    var bank: String? { get set }
    var holder: String? { get set }
    var pin: String { get set }
    var cvv: String { get set }
    var date: String { get set }
    var payPass: CardPayPassType { get set }
    var chip: CardChipType { get set }
    var paymentSystem: CardPaymentSystemType { get set }
    var bankColor: CardFontColor { get set }
    var bankSize: CardFontSize { get set }
    var bankFont: CardFontType { get set }
    var numberColor: CardFontColor { get set }
    var numberSize: CardFontSize { get set }
    var numberFont: CardFontType { get set }
    var dateColor: CardFontColor { get set }
    var dateSize: CardFontSize { get set }
    var dateFont: CardFontType { get set }
    var cvvColor: CardFontColor { get set }
    var cvvSize: CardFontSize { get set }
    var cvvFont: CardFontType { get set }
    var holderColor: CardFontColor { get set }
    var holderSize: CardFontSize { get set }
    var holderFont: CardFontType { get set }
    var texture: CardTextureType { get set }
    var background: CardBackgroundType { get set }
    var template: CardTemplates { get set }
    var isArchive: Bool { get set }
}

// swiftlint:disable line_length
public struct BankCardModel: Identifiable, BankCard {
    public init(id: UUID = UUID(), position: Int, number: String, name: String, bank: String?, holder: String?, pin: String, cvv: String, date: String, payPass: CardPayPassType, chip: CardChipType, paymentSystem: CardPaymentSystemType, bankColor: CardFontColor, bankSize: CardFontSize, bankFont: CardFontType, numberColor: CardFontColor, numberSize: CardFontSize, numberFont: CardFontType, dateColor: CardFontColor, dateSize: CardFontSize, dateFont: CardFontType, cvvColor: CardFontColor, cvvSize: CardFontSize, cvvFont: CardFontType, holderColor: CardFontColor, holderSize: CardFontSize, holderFont: CardFontType, texture: CardTextureType, background: CardBackgroundType, template: CardTemplates, isArchive: Bool = false) {
        self.id = id
        self.position = position
        self.number = number
        self.name = name
        self.bank = bank
        self.holder = holder
        self.pin = pin
        self.cvv = cvv
        self.date = date
        self.payPass = payPass
        self.chip = chip
        self.paymentSystem = paymentSystem
        self.bankColor = bankColor
        self.bankSize = bankSize
        self.bankFont = bankFont
        self.numberColor = numberColor
        self.numberSize = numberSize
        self.numberFont = numberFont
        self.dateColor = dateColor
        self.dateSize = dateSize
        self.dateFont = dateFont
        self.cvvColor = cvvColor
        self.cvvSize = cvvSize
        self.cvvFont = cvvFont
        self.holderColor = holderColor
        self.holderSize = holderSize
        self.holderFont = holderFont
        self.texture = texture
        self.background = background
        self.template = template
        self.isArchive = isArchive
    }

    public var id: UUID
    public var name: String
    public var number: String
    public var position: Int
    public var bank: String?
    public var holder: String?
    public var pin: String
    public var cvv: String
    public var date: String
    public var payPass: CardPayPassType
    public var chip: CardChipType
    public var paymentSystem: CardPaymentSystemType
    public var bankColor: CardFontColor
    public var bankSize: CardFontSize
    public var bankFont: CardFontType
    public var numberColor: CardFontColor
    public var numberSize: CardFontSize
    public var numberFont: CardFontType
    public var dateColor: CardFontColor
    public var dateSize: CardFontSize
    public var dateFont: CardFontType
    public var cvvColor: CardFontColor
    public var cvvSize: CardFontSize
    public var cvvFont: CardFontType
    public var holderColor: CardFontColor
    public var holderSize: CardFontSize
    public var holderFont: CardFontType
    public var texture: CardTextureType
    public var background: CardBackgroundType
    public var template: CardTemplates
    public var isArchive = false
}
