//
// Copyright © 2022 Alexander Romanov
// Alignment.swift
//

import Foundation

/// Represents an axis alignment constraint.
///
/// - none: No constraint.
/// - mid: Mid axis' value constraint.
/// - max: Max axis' value constraint.
/// - min: Min axis' value constraint.
public enum Alignment {
    case none
    case mid
    case max
    case min
}
