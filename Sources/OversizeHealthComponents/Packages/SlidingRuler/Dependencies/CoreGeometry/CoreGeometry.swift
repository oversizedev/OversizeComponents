//
// Copyright © 2022 Alexander Romanov
// CoreGeometry.swift
//

@_exported import CoreGraphics
import Foundation

postfix operator °

@usableFromInline internal let degreeFactor = 180 / CGFloat.pi
@usableFromInline internal let radianFactor = 1 / degreeFactor
