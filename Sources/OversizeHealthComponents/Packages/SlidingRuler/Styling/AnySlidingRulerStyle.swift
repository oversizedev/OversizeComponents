//
// Copyright © 2022 Alexander Romanov
// AnySlidingRulerStyle.swift
//

import SwiftUI

struct AnySlidingRulerStyle: SlidingRulerStyle {
    private let cellProvider: (SlidingRulerStyleConfiguation) -> AnyFractionableView
    private let cursorProvider: () -> AnyView

    let fractions: Int
    let cellWidth: CGFloat
    let cursorAlignment: VerticalAlignment
    let hasMarks: Bool

    init<T: SlidingRulerStyle>(style: T) {
        cellProvider = { (configuration: SlidingRulerStyleConfiguation) -> AnyFractionableView in
            AnyFractionableView(style.makeCellBody(configuration: configuration))
        }
        cursorProvider = {
            AnyView(style.makeCursorBody())
        }
        fractions = style.fractions
        cellWidth = style.cellWidth
        cursorAlignment = style.cursorAlignment
        hasMarks = style.hasMarks
    }

    func makeCellBody(configuration: SlidingRulerStyleConfiguation) -> some FractionableView {
        cellProvider(configuration)
    }

    func makeCursorBody() -> some View {
        cursorProvider()
    }
}
