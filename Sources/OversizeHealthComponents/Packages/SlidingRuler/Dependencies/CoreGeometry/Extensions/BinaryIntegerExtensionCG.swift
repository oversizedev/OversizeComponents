//
// Copyright © 2022 Alexander Romanov
// BinaryIntegerExtensionCG.swift
//

import Foundation

public extension BinaryInteger {
    /// The numerical value considered as expressed in radians converted in degrees.
    @inlinable
    var degree: CGFloat {
        CGFloat(self) * degreeFactor
    }

    /// The numerical value considered as expressed in degrees converted in radians.
    @inlinable
    var radian: CGFloat {
        CGFloat(self) * radianFactor
    }

    /// Considers a value as an angle expressed in degrees and returns the corresponding angle in radians.
    ///
    /// - note: _x_`º` is equivalent to _x_`.degree`.
    /// - Parameter lhs: The angle value expressed in degrees.
    /// - Returns: The angle value expressed in radians.
    @inlinable
    static postfix func ° (lhs: Self) -> CGFloat {
        lhs.radian
    }
}
