//
// Copyright © 2022 Alexander Romanov
// FloatingPointExtension.swift
//

public extension FloatingPoint {
    /// Performs a nan-coalescing operation, returning the value of `FloatingPoint` instance or a default value.
    /// - Parameters:
    ///   - floatingPointValue: A floating point value.
    ///   - defaultValue: A value to use as a default. defaultValue and floatingPointValue have the same type.
    @inlinable static func ?? (floatingPointValue: Self, defaultValue: @autoclosure () throws -> Self) rethrows -> Self {
        floatingPointValue.isNaN ? try defaultValue() : floatingPointValue
    }
}
