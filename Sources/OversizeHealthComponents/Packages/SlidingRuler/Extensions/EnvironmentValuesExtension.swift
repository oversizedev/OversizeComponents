//
// Copyright © 2022 Alexander Romanov
// EnvironmentValuesExtension.swift
//

import SwiftUI

enum StaticSlidingRulerStyleEnvironment {
    @Environment(\.slidingRulerStyle.cellWidth) static var cellWidth
    @Environment(\.slidingRulerStyle.cursorAlignment) static var alignment
    @Environment(\.slidingRulerStyle.hasMarks) static var hasMarks
}

struct SlidingRulerStyleEnvironmentKey: EnvironmentKey {
    static var defaultValue: AnySlidingRulerStyle { .init(style: PrimarySlidingRulerStyle()) }
}

struct SlideRulerCellOverflow: EnvironmentKey {
    static var defaultValue: Int { 3 }
}

extension EnvironmentValues {
    var slidingRulerStyle: AnySlidingRulerStyle {
        get { self[SlidingRulerStyleEnvironmentKey.self] }
        set { self[SlidingRulerStyleEnvironmentKey.self] = newValue }
    }

    var slidingRulerCellOverflow: Int {
        get { self[SlideRulerCellOverflow.self] }
        set { self[SlideRulerCellOverflow.self] = newValue }
    }
}
