//
// Copyright © 2022 Alexander Romanov
// CollectionExtension.swift
//

import Foundation

public extension Collection {
    /// Performs a empty-coalescing operation, returning the given collection if it's not empty or a default collection otherwise.
    /// - Parameters:
    ///   - lhs: The collection to test for emptyness.
    ///   - rhs: The default collection to return if the collection is empty.
    @inlinable static func ?? (lhs: Self, rhs: @autoclosure () throws -> Self) rethrows -> Self {
        lhs.isEmpty ? try rhs() : lhs
    }
}
