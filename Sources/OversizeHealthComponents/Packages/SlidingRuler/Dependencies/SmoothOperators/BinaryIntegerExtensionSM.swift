//
// Copyright © 2022 Alexander Romanov
// BinaryIntegerExtensionSM.swift
//

#if !os(macOS)
    import CoreGraphics
#else
    import Foundation
#endif

public extension BinaryInteger {
    /// Returns the exponentiation of `lhs` by `rhs`.
    /// - Parameter lhs: The value to exponentiate.
    /// - Parameter rhs: The exponent.
    @inlinable static func ** (lhs: Self, rhs: some BinaryInteger) -> Self {
        Self(pow(CGFloat(lhs), CGFloat(rhs)))
    }

    /// Returns the exponentiation of `lhs` by `rhs`.
    /// - Parameter lhs: The value to exponentiate.
    /// - Parameter rhs: The exponent.
    @inlinable static func ** (lhs: Self, rhs: some BinaryFloatingPoint) -> Self {
        Self(pow(CGFloat(lhs), CGFloat(rhs)))
    }

    /// Returns `true` if `lhs` is equal to `rhs - 1`. `false` otherwise.
    @inlinable static func <| (lhs: Self, rhs: Self) -> Bool {
        rhs - lhs == 1
    }

    /// Returns `true` if `lhs` is equal to `rhs + 1`. `false` otherwise.
    @inlinable static func |> (lhs: Self, rhs: Self) -> Bool {
        lhs - rhs == 1
    }

    /// Returns `true` if `lhs` is equal to `rhs` or `rhs - 1`. `false` otherwise.
    @inlinable static func <=| (lhs: Self, rhs: Self) -> Bool {
        lhs == rhs || rhs - lhs == 1
    }

    /// Returns `true` if `lhs` is equal to `rhs` or `rhs + 1`. `false` otherwise.
    @inlinable static func |>= (lhs: Self, rhs: Self) -> Bool {
        lhs == rhs || lhs - rhs == 1
    }
}
