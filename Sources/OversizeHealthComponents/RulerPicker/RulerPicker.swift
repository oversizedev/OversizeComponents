//
// Copyright © 2022 Alexander Romanov
// RulerPicker.swift
//

import OversizeUI
// import SlidingRuler
import SwiftUI

public struct RulerPicker: View {
    @Binding private var selection: Double

    private let minValue: Double

    private let maxValue: Double

    private let mark: Mark

    private let tick: Mark

    private let step: Double

    @Namespace private var animation

    public init(selection: Binding<Double>, minValue: Double = 10, step: Double = 1, maxValue: Double = 150, mark: Mark = .fraction, tick: Mark = .fraction) {
        _selection = selection
        self.minValue = minValue
        self.maxValue = maxValue
        self.step = step
        self.mark = mark
        self.tick = tick
    }

    private var formatter: NumberFormatter {
        let f: NumberFormatter = .init()
        f.numberStyle = .decimal
        f.maximumFractionDigits = 0
        return f
    }

    public var body: some View {
        VStack {
            Spacer()
            SlidingRuler(value: $selection,
                         in: minValue ... maxValue,
                         step: step,
                         snap: mark,
                         tick: tick,
                         formatter: formatter)
                .slidingRulerStyle(CenteredSlindingRulerStyle())
                .overlay(alignment: .top) {
                    Text(step < 10 ? selection.toStringWithoutPoint : String(format: "%.0f", selection))
                        .foregroundColor(.white)
                        .font(.title2.monospacedDigit())
                        .bold()
                        .background {
                            Circle()
                                .foregroundColor(Color.black)
                                .frame(width: 72, height: 72, alignment: .center)
                        }
                }
        }
        .background { Color.yellow.ignoresSafeArea() }
    }
}
