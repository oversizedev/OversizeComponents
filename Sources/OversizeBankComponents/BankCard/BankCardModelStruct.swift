//
// Copyright © 2022 Alexander Romanov
// BankCardModelStruct.swift
//

// swiftlint:disable all

import SwiftUI

public enum CardFontSize: Equatable {
    case standart
    case custum(size: Int)
}

public enum CardFontColor: Equatable {
    case standart
    case custum(color: Color)
}

public enum CardTextureType: String, CaseIterable, Identifiable {
    case iridescent = "TextureIridescent"
    case metal = "TextureMetal"
    case noise = "TextureNoise"
    case paper = "TexturePaper"
    case waves = "TextureWaves"

    public var title: String {
        switch self {
        case .iridescent:
            return L10c.Card.textureIridescent
        case .metal:
            return L10c.Card.textureMetal
        case .noise:
            return L10c.Card.textureNoise
        case .paper:
            return L10c.Card.texturePaper
        case .waves:
            return L10c.Card.textureWaves
        }
    }

    public var id: String { rawValue }
}

public enum CardPayPassType: String, CaseIterable, Identifiable {
    case clay = "PaypassClay"
    case glass = "PaypassGlass"
    case solid = "PaypassSolid"

    public var id: String { rawValue }

    public var title: String {
        switch self {
        case .clay:
            return L10c.Card.materialClay
        case .glass:
            return L10c.Card.materialGlass
        case .solid:
            return L10c.Card.materialSolid
        }
    }
}

public enum CardChipType: String, CaseIterable, Identifiable {
    case clay = "ChipClay"
    case glass = "ChipGlass"
    case gold = "ChipGold"
    case silver = "ChipSilver"

    public var id: String { rawValue }

    public var title: String {
        switch self {
        case .clay:
            return L10c.Card.materialClay
        case .glass:
            return L10c.Card.materialGlass
        case .gold:
            return L10c.Card.materialGold
        case .silver:
            return L10c.Card.materialSilver
        }
    }
}

public enum CardPaymentSystemType {
    case masterCard(style: CardMasterCardStyleType)
    case visa(style: CardVisaStyleType)
    case maestro(style: CardMaestroStyleType)
    case mir(style: CardMirStyleType)
    case americanExpress(style: CardAmexStyleType)
    case dinersClub(style: CardDinersStyleType)
    case discover(style: CardDiscoverStyleType)
    case unionPay(style: CardUnionpayStyleType)
    case jcb(style: CardJCBStyleType)

    public static var allCases: [CardPaymentSystemType] = [
        .masterCard(style: .color),
        .visa(style: .color),
        .maestro(style: .color),
        .mir(style: .color),
        .americanExpress(style: .color),
        .dinersClub(style: .color),
        .discover(style: .color),
        .unionPay(style: .color),
        .jcb(style: .color),
        .mir(style: .color),
    ]

    public var title: String {
        switch self {
        case .masterCard:
            return L10c.Card.paymentTypeMasterCard
        case .visa:
            return L10c.Card.paymentTypeVisa
        case .maestro:
            return L10c.Card.paymentTypeMaestro
        case .mir:
            return L10c.Card.paymentTypeMIR
        case .americanExpress:
            return L10c.Card.paymentTypeAmericanExpress
        case .dinersClub:
            return L10c.Card.paymentTypeDinersClub
        case .discover:
            return L10c.Card.paymentTypeDiscover
        case .unionPay:
            return L10c.Card.paymentTypeUnionPay
        case .jcb:
            return L10c.Card.paymentTypeJcb
        }
    }

    public var image: Image {
        switch self {
        case let .masterCard(style):
            return Image(style.rawValue, bundle: .module)
        case let .visa(style):
            return Image(style.rawValue, bundle: .module)
        case let .maestro(style):
            return Image(style.rawValue, bundle: .module)
        case let .mir(style):
            return Image(style.rawValue, bundle: .module)
        case let .americanExpress(style):
            return Image(style.rawValue, bundle: .module)
        case let .dinersClub(style):
            return Image(style.rawValue, bundle: .module)
        case let .discover(style):
            return Image(style.rawValue, bundle: .module)
        case let .unionPay(style):
            return Image(style.rawValue, bundle: .module)
        case let .jcb(style):
            return Image(style.rawValue, bundle: .module)
        }
    }
}

extension CardPaymentSystemType: Equatable {
    public static func == (lhs: CardPaymentSystemType, rhs: CardPaymentSystemType) -> Bool {
        switch (lhs, rhs) {
        case (.masterCard, .masterCard):
            return true
        case (.visa, .visa):
            return true
        default:
            return false
        }
    }
}

// extension CardPaymentSystemType: Equatable {
//        public static func ==(lhs: CardPaymentSystemType, rhs: CardPaymentSystemType) -> Bool {
//            switch (lhs, rhs) {
//            case (.masterCard, .masterCard):
//                return true
//            case (.visa, .visa):
//                return true
//            default:
//                return false
//            }
//        }
// }

public enum CardMasterCardStyleType: String, CaseIterable, Identifiable {
    case color = "MastercardColor"
    case glass = "MastercardGlass"
    case grayscale = "MastercardGrayscale"
    case solidDark = "MastercardSolidDark"
    case solidLight = "MastercardSolidLight"
    case strokeMetal = "MastercardStrokeMetal"

    public var id: String { rawValue }

    public var title: String {
        switch self {
        case .color:
            return L10c.Card.materialColor
        case .glass:
            return L10c.Card.materialGlass
        case .grayscale:
            return L10c.Card.materialGrayscale
        case .solidDark:
            return L10c.Card.materialSolidDark
        case .solidLight:
            return L10c.Card.materialSolidLight
        case .strokeMetal:
            return L10c.Card.materialStrokeMetal
        }
    }

    // public static var allCases: [CardMasterCardStyleType] = [.color, ]
}

public enum CardVisaStyleType: String, CaseIterable, Identifiable {
    case color = "VisaColor"
    case solid = "VisaSolid"

    public var id: String { rawValue }

    public var title: String {
        switch self {
        case .color:
            return L10c.Card.materialColor
        case .solid:
            return L10c.Card.materialSolid
        }
    }
}

public enum CardAmexStyleType: String, CaseIterable, Identifiable {
    case color = "american-express-original"
    case solid = "american-express-inverted"

    public var id: String { rawValue }

    public var title: String {
        switch self {
        case .color:
            return L10c.Card.materialColor
        case .solid:
            return L10c.Card.materialSolid
        }
    }
}

public enum CardDinersStyleType: String, CaseIterable, Identifiable {
    case color = "diners-club-original"
    case solid = "diners-club-inverted"

    public var id: String { rawValue }

    public var title: String {
        switch self {
        case .color:
            return L10c.Card.materialColor
        case .solid:
            return L10c.Card.materialSolid
        }
    }
}

public enum CardDiscoverStyleType: String, CaseIterable, Identifiable {
    case color = "discover-original"
    case solid = "discover-inverted"

    public var id: String { rawValue }

    public var title: String {
        switch self {
        case .color:
            return L10c.Card.materialColor
        case .solid:
            return L10c.Card.materialSolid
        }
    }
}

public enum CardJCBStyleType: String, CaseIterable, Identifiable {
    case color = "jcb-original"
    case solid = "jcb-inverted"

    public var id: String { rawValue }

    public var title: String {
        switch self {
        case .color:
            return L10c.Card.materialColor
        case .solid:
            return L10c.Card.materialSolid
        }
    }
}

public enum CardMaestroStyleType: String, CaseIterable, Identifiable {
    case color = "maestro-original"
    case solid = "maestro-inverted"

    public var id: String { rawValue }

    public var title: String {
        switch self {
        case .color:
            return L10c.Card.materialColor
        case .solid:
            return L10c.Card.materialSolid
        }
    }
}

public enum CardMirStyleType: String, CaseIterable, Identifiable {
    case color = "mir-original"
    case solid = "mir-inverted"

    public var id: String { rawValue }

    public var title: String {
        switch self {
        case .color:
            return L10c.Card.materialColor
        case .solid:
            return L10c.Card.materialSolid
        }
    }
}

public enum CardUnionpayStyleType: String, CaseIterable, Identifiable {
    case color = "unionpay-original"
    case solid = "unionpay-inverted"

    public var id: String { rawValue }

    public var title: String {
        switch self {
        case .color:
            return L10c.Card.materialColor
        case .solid:
            return L10c.Card.materialSolid
        }
    }
}

public enum CardFontType: String, CaseIterable, Identifiable, Equatable {
    case `default`
    case sans
    case rounded
    case serif

    public var title: String {
        switch self {
        case .default:
            return L10c.Card.fontTypeDefault
        case .sans:
            return L10c.Card.fontTypeSans
        case .rounded:
            return L10c.Card.fontTypeRounded
        case .serif:
            return L10c.Card.fontTypeSerif
        }
    }

    public var id: String { rawValue }
}

public enum CardGradientSideType: String, CaseIterable, Identifiable {
    case horizontal
    case vertical
    case deiganal

    public var title: String {
        switch self {
        case .horizontal:
            return L10c.Card.gradientSideHorizontal
        case .vertical:
            return L10c.Card.gradientSideVertical
        case .deiganal:
            return L10c.Card.gradientSideDeiganal
        }
    }

    public var id: String { rawValue }
}

public enum CardBackgroundImageNames: String, CaseIterable, Identifiable {
    case background01 = "Background01"
    case background02 = "Background02"
    case background03 = "Background03"
    case background04 = "Background04"
    case background05 = "Background05"
    case background06 = "Background06"
    case background07 = "Background07"

    public var id: String { rawValue }
}

public enum CardShapeNames: String, CaseIterable, Identifiable {
    case shape01
    case shape02
    case shape03
    case shape04
    case shape05
    case shape06
    case shape07
    case shape08
    case shape09
    case shape10
    case shape11
    case shape12
    case shape13
    case shape14
    case shape15
    case shape16
    case shape17
    case shape18
    case shape19

    public var id: String { rawValue }
}

public enum CardTemplates: String, CaseIterable, Identifiable {
    case classic
    case minimal
    case typo
    // case verti

    public var id: String { rawValue }

    public var title: String {
        switch self {
        case .classic:
            return L10c.Card.templatesClassic
        case .minimal:
            return L10c.Card.templatesMinimal
        case .typo:
            return L10c.Card.templatesTypo
//        case .verti:
//            return L10c.Card.templatesVerti
        }
    }
}

public enum CardBackgroundType: Hashable, Identifiable {
    case shape(
        design: CardShapeNames,
        primaryColor: Color,
        secondaryColor: Color,
        tertiaryColor: Color,
        quaternaryColor: Color,
        fivefoldColor: Color
    )
    case image(
        image: CardBackgroundImageNames
    )
    case gradient(
        startColor: Color,
        endColor: Color,
        side: CardGradientSideType
    )

    public static var allCases: [CardBackgroundType] = [
        .shape(design: .shape01, primaryColor: .red, secondaryColor: .red, tertiaryColor: .red, quaternaryColor: .red, fivefoldColor: .red),
        .image(image: .background01),
        .gradient(startColor: .red, endColor: .red, side: .horizontal),
    ]

    public var title: String {
        switch self {
        case .shape:
            return L10c.Card.backgroundShape
        case .image:
            return L10c.Card.backgroundImage
        case .gradient:
            return L10c.Card.backgroundGradient
        }
    }

    public var id: String { title }
}

extension CardBackgroundType: Equatable {
    public static func == (lhs: CardBackgroundType, rhs: CardBackgroundType) -> Bool {
        switch (lhs, rhs) {
        case (.gradient, .gradient):
            return true
        case (.image, .image):
            return true
        case (.shape, .shape):
            return true
        default:
            return false
        }
    }
}
