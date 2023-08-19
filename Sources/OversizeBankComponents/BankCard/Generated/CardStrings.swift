//
// Copyright © 2022 Alexander Romanov
// CardStrings.swift
//

// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10c {
    public enum Card {
        /// Gradient
        public static let backgroundGradient = L10c.tr("Localizable", "card.backgroundGradient")
        /// Image
        public static let backgroundImage = L10c.tr("Localizable", "card.backgroundImage")
        /// Shape
        public static let backgroundShape = L10c.tr("Localizable", "card.backgroundShape")
        /// Default
        public static let fontTypeDefault = L10c.tr("Localizable", "card.fontTypeDefault")
        /// Round
        public static let fontTypeRounded = L10c.tr("Localizable", "card.fontTypeRounded")
        /// Sans
        public static let fontTypeSans = L10c.tr("Localizable", "card.fontTypeSans")
        /// Serif
        public static let fontTypeSerif = L10c.tr("Localizable", "card.fontTypeSerif")
        /// Deiganal
        public static let gradientSideDeiganal = L10c.tr("Localizable", "card.gradientSideDeiganal")
        /// Horizontal
        public static let gradientSideHorizontal = L10c.tr("Localizable", "card.gradientSideHorizontal")
        /// Vertical
        public static let gradientSideVertical = L10c.tr("Localizable", "card.gradientSideVertical")
        /// Clay
        public static let materialClay = L10c.tr("Localizable", "card.materialClay")
        /// Color
        public static let materialColor = L10c.tr("Localizable", "card.materialColor")
        /// Glass
        public static let materialGlass = L10c.tr("Localizable", "card.materialGlass")
        /// Gold
        public static let materialGold = L10c.tr("Localizable", "card.materialGold")
        /// Gray
        public static let materialGrayscale = L10c.tr("Localizable", "card.materialGrayscale")
        /// Silver
        public static let materialSilver = L10c.tr("Localizable", "card.materialSilver")
        /// Solid
        public static let materialSolid = L10c.tr("Localizable", "card.materialSolid")
        /// Dark
        public static let materialSolidDark = L10c.tr("Localizable", "card.materialSolidDark")
        /// Light
        public static let materialSolidLight = L10c.tr("Localizable", "card.materialSolidLight")
        /// Mtal
        public static let materialStrokeMetal = L10c.tr("Localizable", "card.materialStrokeMetal")
        /// AmericanExpress
        public static let paymentTypeAmericanExpress = L10c.tr("Localizable", "card.paymentTypeAmericanExpress")
        /// DinersClub
        public static let paymentTypeDinersClub = L10c.tr("Localizable", "card.paymentTypeDinersClub")
        /// Discover
        public static let paymentTypeDiscover = L10c.tr("Localizable", "card.paymentTypeDiscover")
        /// Elo
        public static let paymentTypeElo = L10c.tr("Localizable", "card.paymentTypeElo")
        /// Hiper
        public static let paymentTypeHiper = L10c.tr("Localizable", "card.paymentTypeHiper")
        /// Hipercard
        public static let paymentTypeHipercard = L10c.tr("Localizable", "card.paymentTypeHipercard")
        /// JCB
        public static let paymentTypeJcb = L10c.tr("Localizable", "card.paymentTypeJcb")
        /// Мaestro
        public static let paymentTypeMaestro = L10c.tr("Localizable", "card.paymentTypeMaestro")
        /// MasterCard
        public static let paymentTypeMasterCard = L10c.tr("Localizable", "card.paymentTypeMasterCard")
        /// MIR
        public static let paymentTypeMIR = L10c.tr("Localizable", "card.paymentTypeMIR")
        /// UnionPay
        public static let paymentTypeUnionPay = L10c.tr("Localizable", "card.paymentTypeUnionPay")
        /// Visa
        public static let paymentTypeVisa = L10c.tr("Localizable", "card.paymentTypeVisa")
        /// Classic
        public static let templatesClassic = L10c.tr("Localizable", "card.templatesClassic")
        /// Minimal
        public static let templatesMinimal = L10c.tr("Localizable", "card.templatesMinimal")
        /// Typo
        public static let templatesTypo = L10c.tr("Localizable", "card.templatesTypo")
        /// Verti
        public static let templatesVerti = L10c.tr("Localizable", "card.templatesVerti")
        /// Iridescent
        public static let textureIridescent = L10c.tr("Localizable", "card.textureIridescent")
        /// Metal
        public static let textureMetal = L10c.tr("Localizable", "card.textureMetal")
        /// Noise
        public static let textureNoise = L10c.tr("Localizable", "card.textureNoise")
        /// Paper
        public static let texturePaper = L10c.tr("Localizable", "card.texturePaper")
        /// Waves
        public static let textureWaves = L10c.tr("Localizable", "card.textureWaves")
    }
}

// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10c {
    private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
        let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
        return String(format: format, locale: Locale.current, arguments: args)
    }
}

// swiftlint:disable convenience_type
private final class BundleToken {
    static let bundle: Bundle = {
        #if SWIFT_PACKAGE
            return Bundle.module
        #else
            return Bundle(for: BundleToken.self)
        #endif
    }()
}

// swiftlint:enable convenience_type
