//
// Copyright © 2022 Alexander Romanov
// BoolAlgebraAssignment.swift
//

public extension Bool {
    /// Performs a logical OR operation on two `Bool` values and stores the result in the left-hand-side variable.
    @inlinable static func ||= (lhs: inout Self, rhs: Self) {
        lhs = lhs || rhs
    }

    /// Performs a logical AND operation on two `Bool` values and stores the result in the left-hand-side variable.
    @inlinable static func &&= (lhs: inout Self, rhs: Self) {
        lhs = lhs && rhs
    }
}
