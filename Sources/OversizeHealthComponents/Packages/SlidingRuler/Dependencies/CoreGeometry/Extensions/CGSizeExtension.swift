//
// Copyright © 2022 Alexander Romanov
// CGSizeExtension.swift
//

import CoreGraphics

public extension CGSize {
    /// Inits a size of `(amount,amount)`.
    @inlinable
    init(square amount: Int) {
        self.init(width: amount, height: amount)
    }

    /// Inits a size of `(amount,amount)`.
    @inlinable
    init(square amount: Double) {
        self.init(width: amount, height: amount)
    }

    /// Inits a size of `(amount,amount)`.
    @inlinable
    init(square amount: CGFloat) {
        self.init(width: amount, height: amount)
    }
}

public extension CGSize {
    var horizontal: CGSize { CGSize(horizontal: width) }
    var vertical: CGSize { CGSize(vertical: height) }

    init(horizontal amount: CGFloat) {
        self.init(width: amount, height: .zero)
    }

    init(horizontal amount: Double) { self.init(horizontal: CGFloat(amount)) }
    init(horizontal amount: Int) { self.init(horizontal: CGFloat(amount)) }

    init(vertical amount: CGFloat) {
        self.init(width: .zero, height: amount)
    }

    init(vertical amount: Double) { self.init(vertical: CGFloat(amount)) }
    init(vertical amount: Int) { self.init(vertical: CGFloat(amount)) }
}

public extension CGSize {
    /// Multiplies `width` and `height` by the given value and returns the resulting `CGSize`.
    /// - Parameters:
    ///   - lhs: The point to multiply components.
    ///   - rhs: The value to multiply.
    @inlinable
    static func * (lhs: CGSize, rhs: some BinaryInteger) -> CGSize {
        lhs * CGFloat(rhs)
    }

    /// Multiplies `width` and `height` by the given value and returns the resulting `CGSize`.
    /// - Parameters:
    ///   - lhs: The point to multiply components.
    ///   - rhs: The value to multiply.
    @inlinable
    static func * (lhs: CGSize, rhs: some BinaryFloatingPoint) -> CGSize {
        lhs * CGFloat(rhs)
    }

    /// Multiplies `width` and `height` by the given value and returns the resulting `CGSize`.
    /// - Parameters:
    ///   - lhs: The point to multiply components.
    ///   - rhs: The value to multiply.
    @inlinable
    static func * (lhs: CGSize, rhs: CGFloat) -> CGSize {
        CGSize(width: lhs.width * rhs, height: lhs.height * rhs)
    }

    @inlinable
    static func * (lhs: CGSize, rhs: CGSize) -> CGSize {
        CGSize(width: lhs.width * rhs.width, height: lhs.height * rhs.height)
    }

    /// Divides `width` and `height` by the given value and returns the resulting `CGSize`.
    /// - Parameters:
    ///   - lhs: The point to devide components.
    ///   - rhs: The value to devide.
    @inlinable
    static func / (lhs: CGSize, rhs: some BinaryInteger) -> CGSize {
        lhs / CGFloat(rhs)
    }

    /// Divides `width` and `height` by the given value and returns the resulting `CGSize`.
    /// - Parameters:
    ///   - lhs: The point to devide components.
    ///   - rhs: The value to devide.
    @inlinable
    static func / (lhs: CGSize, rhs: some BinaryFloatingPoint) -> CGSize {
        lhs / CGFloat(rhs)
    }

    /// Divides `width` and `height` by the given value and returns the resulting `CGSize`.
    /// - Parameters:
    ///   - lhs: The point to devide components.
    ///   - rhs: The value to devide.
    @inlinable
    static func / (lhs: CGSize, rhs: CGFloat) -> CGSize {
        CGSize(width: lhs.width / rhs, height: lhs.height / rhs)
    }

    @inlinable
    static func / (lhs: CGSize, rhs: CGSize) -> CGSize {
        CGSize(width: lhs.width / rhs.width, height: lhs.height / rhs.height)
    }
}

extension CGSize: AdditiveArithmetic {
    public static func - (lhs: CGSize, rhs: CGSize) -> CGSize {
        CGSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
    }

    public static func + (lhs: CGSize, rhs: CGSize) -> CGSize {
        CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
}
