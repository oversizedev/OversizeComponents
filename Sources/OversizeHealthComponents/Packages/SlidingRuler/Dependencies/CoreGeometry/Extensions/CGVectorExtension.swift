//
// Copyright © 2022 Alexander Romanov
// CGVectorExtension.swift
//

import CoreGraphics

public extension CGVector {
    var horizontal: CGSize { CGSize(horizontal: dx) }
    var vertical: CGSize { CGSize(vertical: dy) }

    init(horizontal amount: CGFloat) {
        self.init(dx: amount, dy: .zero)
    }

    init(horizontal amount: Double) { self.init(horizontal: CGFloat(amount)) }
    init(horizontal amount: Int) { self.init(horizontal: CGFloat(amount)) }

    init(vertical amount: CGFloat) {
        self.init(dx: .zero, dy: amount)
    }

    init(vertical amount: Double) { self.init(vertical: CGFloat(amount)) }
    init(vertical amount: Int) { self.init(vertical: CGFloat(amount)) }
}

public extension CGVector {
    /// The vector magnitude.
    @inlinable
    var magnitude: CGFloat {
        sqrt(pow(dx, 2) + pow(dy, 2))
    }

    /// The vector direction.
    @inlinable
    var direction: CGFloat {
        CGFloat(atan2(dy, dx))
    }

    /// Returns a reversed copy of `self`.
    @inlinable
    func reversed() -> CGVector {
        CGVector(dx: -dx, dy: -dy)
    }

    /// Reverse `self`
    @inlinable
    mutating func reverse() {
        self = reversed()
    }
}

public extension CGVector {
    /// Multiplies a vector by the given value.
    ///
    /// - Parameters:
    ///   - lhs: The vector.
    ///   - rhs: The given value.
    /// - Returns: The resulting vector.
    @inlinable
    static func * (lhs: CGVector, rhs: some BinaryInteger) -> CGVector {
        lhs * CGFloat(rhs)
    }

    /// Multiplies a vector by the given value.
    ///
    /// - Parameters:
    ///   - lhs: The vector.
    ///   - rhs: The given value.
    /// - Returns: The resulting vector.
    @inlinable
    static func * (lhs: CGVector, rhs: some BinaryFloatingPoint) -> CGVector {
        lhs * CGFloat(rhs)
    }

    /// Multiplies a vector by the given value.
    ///
    /// - Parameters:
    ///   - lhs: The vector.
    ///   - rhs: The given value.
    /// - Returns: The resulting vector.
    @inlinable
    static func * (lhs: CGVector, rhs: CGFloat) -> CGVector {
        CGVector(dx: lhs.dx * rhs, dy: lhs.dy * rhs)
    }

    /// Divides a vector by the given value.
    ///
    /// - Parameters:
    ///   - lhs: The vector.
    ///   - rhs: The given value.
    /// - Returns: The resulting vector.
    @inlinable
    static func / (lhs: CGVector, rhs: some BinaryInteger) -> CGVector {
        lhs / CGFloat(rhs)
    }

    /// Divides a vector by the given value.
    ///
    /// - Parameters:
    ///   - lhs: The vector.
    ///   - rhs: The given value.
    /// - Returns: The resulting vector.
    @inlinable
    static func / (lhs: CGVector, rhs: some BinaryFloatingPoint) -> CGVector {
        lhs / CGFloat(rhs)
    }

    /// Divides a vector by the given value.
    ///
    /// - Parameters:
    ///   - lhs: The vector.
    ///   - rhs: The given value.
    /// - Returns: The resulting vector.
    @inlinable
    static func / (lhs: CGVector, rhs: CGFloat) -> CGVector {
        CGVector(dx: lhs.dx / rhs, dy: lhs.dy / rhs)
    }
}

extension CGVector: AdditiveArithmetic {
    @inlinable
    public static func + (lhs: CGVector, rhs: CGVector) -> CGVector {
        CGVector(dx: lhs.dx + rhs.dx, dy: lhs.dy + rhs.dy)
    }

    @inlinable
    public static func - (lhs: CGVector, rhs: CGVector) -> CGVector {
        CGVector(dx: lhs.dx - rhs.dx, dy: lhs.dy - rhs.dy)
    }
}
