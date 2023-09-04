//
// Copyright © 2022 Alexander Romanov
// OptionalExtension.swift
//

public extension Optional {
    /// Returns `true` if `rhs` is not nil. `false` otherwise.
    /// - Parameter rhs: The value to test against nil.
    @inlinable static prefix func !! (rhs: Self) -> Bool {
        rhs != nil
    }

    /// Returns `true` if `rhs` is nil. `false` otherwise.
    /// - Parameter rhs: The value to test against nil.
    @inlinable static prefix func !!! (rhs: Self) -> Bool {
        rhs == nil
    }

    /// Assigns the result of `rhs` to `lhs` if `lhs` is `nil`.
    @inlinable static func ?= (lhs: inout Self, rhs: @autoclosure () throws -> Wrapped) rethrows {
        guard lhs == nil else { return }
        lhs = try rhs()
    }
}

public extension Bool? {
    /// Returns the wrapped `Bool` value if not `nil`. `false` otherwise.
    /// - Parameter rhs: The value to test against nil.
    @inlinable static prefix func !! (rhs: Self) -> Bool {
        rhs ?? false
    }

    /// Returns the wrapped `Bool` value if not `nil`. `false` otherwise.
    /// - Parameter rhs: The value to test against nil.
    @inlinable static prefix func !!! (rhs: Self) -> Bool {
        !(rhs ?? false)
    }
}
