//
// Copyright © 2022 Alexander Romanov
// BinaryInteger+Extension.swift
//

import Foundation

extension BinaryInteger {
    @inlinable var isEven: Bool { isMultiple(of: 2) }

    @inlinable func nextOdd() -> Self { isEven ? self+ : self }
    @inlinable func previousOdd() -> Self { isEven ? self- : self }

    @inlinable func nextEven() -> Self { isEven ? self : self+ }
    @inlinable func previousEven() -> Self { isEven ? self : self- }
}