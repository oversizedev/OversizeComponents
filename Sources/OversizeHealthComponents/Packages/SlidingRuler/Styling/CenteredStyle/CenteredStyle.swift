//
// Copyright © 2022 Alexander Romanov
// CenteredStyle.swift
//

import SwiftUI

public struct CenteredSlindingRulerStyle: SlidingRulerStyle {
    public init() {}
    public var cursorAlignment: VerticalAlignment = .bottom

    public func makeCellBody(configuration: SlidingRulerStyleConfiguation) -> some FractionableView {
        CenteredCellBody(mark: configuration.mark,
                         bounds: configuration.bounds,
                         step: configuration.step,
                         cellWidth: cellWidth,
                         numberFormatter: configuration.formatter)
    }

    public func makeCursorBody() -> some View {
        NativeCursorBody()
    }
}
