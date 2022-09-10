//
// Copyright © 2022 Alexander Romanov
// NumericOperators.swift
//

import Foundation

public extension Strideable {
    // MARK: - Operator ++

    /// Increments the given value by one unit and returns it.
    @discardableResult @inlinable static prefix func ++ (rhs: inout Self) -> Self {
        rhs = rhs.advanced(by: 1)
        return rhs
    }

    /// Returns the given value and increments it by one unit.
    @discardableResult @inlinable static postfix func ++ (lhs: inout Self) -> Self {
        defer { lhs = lhs.advanced(by: 1) }
        return lhs
    }

    // MARK: - Operator --

    /// Decrements the given value by one unit and returns it.
    @discardableResult @inlinable static prefix func -- (rhs: inout Self) -> Self {
        rhs = rhs.advanced(by: -1)
        return rhs
    }

    /// Returns the given value and decrements it by one unit.
    @discardableResult @inlinable static postfix func -- (lhs: inout Self) -> Self {
        defer { lhs = lhs.advanced(by: -1) }
        return lhs
    }

    // MARK: -

    /// Returns the given value incremented by one unit.
    @inlinable static postfix func + (lhs: Self) -> Self {
        lhs.advanced(by: 1)
    }

    /// Returns the given value decremented by one unit.
    @inlinable static postfix func - (lhs: Self) -> Self {
        lhs.advanced(by: -1)
    }
}
