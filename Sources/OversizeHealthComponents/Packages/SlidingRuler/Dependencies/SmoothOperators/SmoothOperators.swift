//
// Copyright © 2022 Alexander Romanov
// SmoothOperators.swift
//

import CoreGraphics

precedencegroup ExponentationPrecedence {
    associativity: left
    higherThan: MultiplicationPrecedence
    lowerThan: BitwiseShiftPrecedence
}

prefix operator ++
prefix operator --

prefix operator !!
prefix operator !!!

postfix operator ++
postfix operator --

postfix operator -
postfix operator +

postfix operator %

infix operator <-: AssignmentPrecedence
infix operator <-?: AssignmentPrecedence
infix operator ?=: AssignmentPrecedence
infix operator =?: AssignmentPrecedence

infix operator ||=: AssignmentPrecedence
infix operator &&=: AssignmentPrecedence

infix operator **: ExponentationPrecedence

infix operator <|: ComparisonPrecedence
infix operator |>: ComparisonPrecedence

infix operator <=|: ComparisonPrecedence
infix operator |>=: ComparisonPrecedence

infix operator >?: ComparisonPrecedence
infix operator >=?: ComparisonPrecedence

infix operator <?: ComparisonPrecedence
infix operator <=?: ComparisonPrecedence

infix operator ==?: ComparisonPrecedence
infix operator !=?: ComparisonPrecedence

infix operator =>: ComparisonPrecedence

/// Transforms `lhs` using `rhs` and stores it back in `lhs`.
/// - Parameters:
///   - lhs: A read write variable.
///   - rhs: A transforming closure.
@inlinable
public func <- <T>(lhs: inout T, rhs: (T) throws -> T) rethrows {
    lhs = try rhs(lhs)
}

/// Transforms Optional `lhs` using `rhs` and stores it in `lhs` if `lhs` is not `nil`.
/// - Parameters:
///   - lhs: A read write variable.
///   - rhs: A transforming closure.
@inlinable
public func <-? <T>(lhs: inout T?, rhs: (T) throws -> T?) rethrows {
    if let value = lhs { lhs = try rhs(value) }
}

/// Assigns `rhs` to `lhs` if rhs is not `nil`
/// - Parameters:
///   - lhs: A read write variable.
///   - rhs: An optional value.
@inlinable
public func ?= <T>(lhs: inout T, rhs: T?) {
    lhs = rhs ?? lhs
}

/// Assigns `rhs` to `lhs` if `lhs` is not equal to `rhs`.
/// - Parameters:
///   - lhs: A read write variable.
///   - rhs: A value.
@inlinable public func =? <T: Equatable>(lhs: inout T, rhs: T) {
    if lhs != rhs { lhs = rhs }
}

@inlinable
/// Returns `rhs` if `lhs` is `true`. Returns `nil` otherwise.
/// - Note: The resulting value is an `Optional<T>`.
public func => <T>(lhs: Bool, rhs: @autoclosure () throws -> T) rethrows -> T? {
    lhs ? try rhs() : nil
}

public postfix func % (_ lhs: some BinaryInteger) -> Double { Double(lhs) / 100.0 }

public postfix func % (_ lhs: some BinaryFloatingPoint) -> Double { Double(lhs) / 100.0 }

public postfix func % (_ lhs: some BinaryInteger) -> CGFloat { CGFloat(lhs) / 100.0 }

public postfix func % (_ lhs: some BinaryFloatingPoint) -> CGFloat { CGFloat(lhs) / 100.0 }

public postfix func % (_ lhs: some BinaryInteger) -> Float { Float(lhs) / 100.0 }

public postfix func % (_ lhs: some BinaryFloatingPoint) -> Float { Float(lhs) / 100.0 }
