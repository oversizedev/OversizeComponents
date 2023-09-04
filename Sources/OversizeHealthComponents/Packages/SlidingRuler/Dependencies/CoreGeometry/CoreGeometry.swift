//
// Copyright © 2022 Alexander Romanov
// CoreGeometry.swift
//

@_exported import CoreGraphics
import Foundation

postfix operator °

@usableFromInline let degreeFactor = 180 / CGFloat.pi
@usableFromInline let radianFactor = 1 / degreeFactor
