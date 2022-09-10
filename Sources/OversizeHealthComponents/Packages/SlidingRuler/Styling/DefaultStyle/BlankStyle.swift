//
// Copyright © 2022 Alexander Romanov
// BlankStyle.swift
//

import SwiftUI

public struct BlankSlidingRulerStyle: SlidingRulerStyle {
    public let cursorAlignment: VerticalAlignment = .bottom

    public func makeCellBody(configuration: SlidingRulerStyleConfiguation) -> some FractionableView {
        BlankCellBody(mark: configuration.mark,
                      bounds: configuration.bounds,
                      step: configuration.step,
                      cellWidth: cellWidth)
    }

    public func makeCursorBody() -> some View {
        NativeCursorBody()
    }
}
