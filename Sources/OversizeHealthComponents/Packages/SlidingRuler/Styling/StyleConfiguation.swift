//
// Copyright © 2022 Alexander Romanov
// StyleConfiguation.swift
//

import CoreGraphics
import Foundation

public struct SlidingRulerStyleConfiguation {
    let mark: CGFloat
    let bounds: ClosedRange<CGFloat>
    let step: CGFloat
    let formatter: NumberFormatter?
}
