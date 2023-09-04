//
// Copyright © 2022 Alexander Romanov
// ClosedRange+Extension.swift
//

import Foundation

extension ClosedRange {
    func contains(_ range: Self) -> Bool {
        contains(range.lowerBound) && contains(range.upperBound)
    }
}
