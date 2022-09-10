//
// Copyright © 2022 Alexander Romanov
// BinaryFloatingPointExtensionSM.swift
//

#if !os(macOS)
    import CoreGraphics
#else
    import Foundation
#endif

public extension BinaryFloatingPoint {
    /// Returns the exponentiation of `lhs` by `rhs`.
    /// - Parameter lhs: The value to exponentiate.
    /// - Parameter rhs: The exponent.
    @inlinable static func ** <T: BinaryInteger>(lhs: Self, rhs: T) -> Self {
        Self(pow(CGFloat(lhs), CGFloat(rhs)))
    }

    /// Returns the exponentiation of `lhs` by `rhs`.
    /// - Parameter lhs: The value to exponentiate.
    /// - Parameter rhs: The exponent.
    @inlinable static func ** <T: BinaryFloatingPoint>(lhs: Self, rhs: T) -> Self {
        Self(pow(CGFloat(lhs), CGFloat(rhs)))
    }
}
