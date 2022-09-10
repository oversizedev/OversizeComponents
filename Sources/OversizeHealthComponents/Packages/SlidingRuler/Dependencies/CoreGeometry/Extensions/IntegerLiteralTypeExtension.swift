//
// Copyright © 2022 Alexander Romanov
// IntegerLiteralTypeExtension.swift
//

import Foundation

public extension IntegerLiteralType {
    /// Considers a value as an angle expressed in degrees and returns the corresponding angle in radians.
    ///
    /// - note: _x_`°` is equivalent to _x_`.degree`.
    /// - Parameter lhs: The angle value expressed in degrees.
    /// - Returns: The angle value expressed in radians.
    @inlinable
    static postfix func ° (lhs: Int) -> CGFloat {
        lhs.radian
    }
}
