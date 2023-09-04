//
// Copyright © 2022 Alexander Romanov
// DecimalExtension.swift
//

import Foundation

public extension Decimal {
    /// Performs a nan-coalescing operation, returning the value of `Decimal` instance or a default value.
    /// - Parameters:
    ///   - decimalValue: A decimal value.
    ///   - defaultValue: A value to use as a default. defaultValue and floatingPointValue have the same type.
    @inlinable static func ?? (decimalValue: Self, defaultValue: @autoclosure () throws -> Self) rethrows -> Self {
        decimalValue.isNaN ? try defaultValue() : decimalValue
    }
}
