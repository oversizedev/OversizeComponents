//
// Copyright © 2022 Alexander Romanov
// BinaryFloatingPointExtensionCG.swift
//

import Foundation

public extension BinaryFloatingPoint {
    /// The numerical value considered as expressed in radians converted in degrees.
    @inlinable
    var degree: CGFloat {
        CGFloat(self) * degreeFactor
    }

    /// The value considered as expressed in degrees converted in radians.
    @inlinable
    var radian: CGFloat {
        CGFloat(self) * radianFactor
    }

    /// The `sin` of the value considered as expressed in radians.
    @inlinable
    var sin: CGFloat {
        CoreGraphics.sin(CGFloat(self))
    }

    /// The `asin` of the value considered as expressed in radians.
    @inlinable
    var asin: CGFloat {
        CoreGraphics.asin(CGFloat(self))
    }

    /// The `cos` of the value considered as expressed in radians.
    @inlinable
    var cos: CGFloat {
        CoreGraphics.cos(CGFloat(self))
    }

    /// The `acos` of the value considered as expressed in radians.
    @inlinable
    var acos: CGFloat {
        CoreGraphics.acos(CGFloat(self))
    }

    /// The `tan` of the value considered as expressed in radians.
    @inlinable
    var tan: CGFloat {
        CoreGraphics.tan(CGFloat(self))
    }

    /// The `atan` of the value considered as expressed in radians.
    @inlinable
    var atan: CGFloat {
        CoreGraphics.atan(CGFloat(self))
    }

    /// Considers the value as an angle expressed in radians and constrains it to the range `[0..2π]`.
    ///
    /// - Returns: The constrained angle expressed in radians.
    @inlinable
    func normalized() -> CGFloat {
        let r = CGFloat.pi * 2
        return (r + CGFloat(self).truncatingRemainder(dividingBy: r)).truncatingRemainder(dividingBy: r)
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
