//
// Copyright © 2022 Alexander Romanov
// CGPointExtension.swift
//

import CoreGraphics

public extension CGPoint {
    /// Returns the vector that exists between `self` and `p2`.
    @inlinable
    func formVector(with p2: CGPoint) -> CGVector {
        CGVector(dx: p2.x - x, dy: p2.y - y)
    }

    /// Returns a copy of `self` translated along the given vector.
    @inlinable
    func translated(along vector: CGVector) -> CGPoint {
        CGPoint(x: x + vector.dx, y: y + vector.dy)
    }

    /// Returns a copy of `self` translated by `tx` on the X-axis and by `ty` on the Y-axis.
    @inlinable
    func translated<I: BinaryInteger>(tx: I, ty: I) -> CGPoint {
        CGPoint(x: x + CGFloat(tx), y: y + CGFloat(ty))
    }

    /// Returns a copy of `self` translated by `tx` on the X-axis and by `ty` on the Y-axis.
    @inlinable
    func translated<F: BinaryFloatingPoint>(tx: F, ty: F) -> CGPoint {
        CGPoint(x: x + CGFloat(tx), y: y + CGFloat(ty))
    }

    /// Returns a copy of `self` translated by `tx` on the X-axis and by `ty` on the Y-axis.
    @inlinable
    func translated(tx: CGFloat, ty: CGFloat) -> CGPoint {
        CGPoint(x: x + tx, y: y + ty)
    }

    /// Translates `self` along the given vector.
    @inlinable
    mutating func translate(by vector: CGVector) {
        self = translated(along: vector)
    }

    /// Translates `self` by `tx` on the X-axis and by `ty` on the Y-axis.
    @inlinable
    mutating func translate<I: BinaryInteger>(tx: I, ty: I) {
        self = translated(tx: tx, ty: ty)
    }

    /// Translates `self` by `tx` on the X-axis and by `ty` on the Y-axis.
    @inlinable
    mutating func translate<F: BinaryFloatingPoint>(tx: F, ty: F) {
        self = translated(tx: tx, ty: ty)
    }

    /// Translates `self` by `tx` on the X-axis and by `ty` on the Y-axis.
    @inlinable
    mutating func translate(tx: CGFloat, ty: CGFloat) {
        self = translated(tx: tx, ty: ty)
    }

    /// Returns a copy of `self` rotated around the given center by the given angle.
    ///
    /// - note: Rotates clockwise on iOS and counter-clockwise on OS X.
    @inlinable
    func rotated(relativeTo center: CGPoint, by angle: CGFloat) -> CGPoint {
        var transform = CGAffineTransform(translationX: center.x, y: center.y)
        transform = transform.rotated(by: angle)
        transform = transform.translatedBy(x: -center.x, y: -center.y)
        return applying(transform)
    }

    /// Rotates `self` around the givent center by the given angle.
    ///
    /// - note: Rotates clockwise on iOS and counter-clockwise on OS X.
    @inlinable
    mutating func rotate(relativeTo center: CGPoint, by angle: CGFloat) {
        self = rotated(relativeTo: center, by: angle)
    }
}

public extension CGPoint {
    /// Multiplies `x` and `y` by the given value and returns the resulting `CGPoint`.
    /// - Parameters:
    ///   - lhs: The point to multiply components.
    ///   - rhs: The value to multiply.
    @inlinable
    static func * <I: BinaryInteger>(lhs: CGPoint, rhs: I) -> CGPoint {
        lhs * CGFloat(rhs)
    }

    /// Multiplies `x` and `y` by the given value and returns the resulting `CGPoint`.
    /// - Parameters:
    ///   - lhs: The point to multiply components.
    ///   - rhs: The value to multiply.
    @inlinable
    static func * <F: BinaryFloatingPoint>(lhs: CGPoint, rhs: F) -> CGPoint {
        lhs * CGFloat(rhs)
    }

    /// Multiplies `x` and `y` by the given value and returns the resulting `CGPoint`.
    /// - Parameters:
    ///   - lhs: The point to multiply components.
    ///   - rhs: The value to multiply.
    @inlinable
    static func * (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
    }

    /// Multiplies a point's components by another one's and returns the resulting `CGPoint`.
    /// - Parameters:
    ///   - lhs: A point to multiply.
    ///   - rhs: Another point the multiply.
    @inlinable
    static func * (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x * rhs.x, y: lhs.y * rhs.y)
    }

    /// Divides `x` and `y` by the given value and returns the resulting `CGPoint`.
    /// - Parameters:
    ///   - lhs: The point to divide components.
    ///   - rhs: The value to devide by.
    @inlinable
    static func / <I: BinaryInteger>(lhs: CGPoint, rhs: I) -> CGPoint {
        lhs / CGFloat(rhs)
    }

    /// Divides `x` and `y` by the given value and returns the resulting `CGPoint`.
    /// - Parameters:
    ///   - lhs: The point to divide components.
    ///   - rhs: The value to devide by.
    @inlinable
    static func / <F: BinaryFloatingPoint>(lhs: CGPoint, rhs: F) -> CGPoint {
        lhs / CGFloat(rhs)
    }

    /// Divides `x` and `y` by the given value and returns the resulting `CGPoint`.
    /// - Parameters:
    ///   - lhs: The point to divide components.
    ///   - rhs: The value to devide by.
    @inlinable
    static func / (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        CGPoint(x: lhs.x / rhs, y: lhs.y / rhs)
    }

    /// Divides a point's components by another one's and returns the resulting `CGPoint`.
    /// - Parameters:
    ///   - lhs: A point to devide.
    ///   - rhs: Another point the devide.
    @inlinable
    static func / (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x / rhs.x, y: lhs.y / rhs.y)
    }
}

extension CGPoint: AdditiveArithmetic {
    @inlinable
    public static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    @inlinable
    public static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}
