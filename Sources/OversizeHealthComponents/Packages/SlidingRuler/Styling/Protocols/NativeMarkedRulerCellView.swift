//
// Copyright © 2022 Alexander Romanov
// NativeMarkedRulerCellView.swift
//

import SwiftUI

protocol NativeMarkedRulerCellView: MarkedRulerCellView {}
extension NativeMarkedRulerCellView {
    var markColor: Color {
        bounds.contains(mark) ? .init(.label) : .init(.tertiaryLabel)
    }

    var displayMark: String { numberFormatter?.string(for: mark) ?? "\(mark.approximated())" }

    var body: some View {
        VStack {
            Text(verbatim: displayMark)
                .font(.system(size: 22).monospacedDigit())
                .bold()
                .foregroundColor(markColor)
                .lineLimit(1)
            Spacer()
            cell.equatable()
        }
        .fixedSize()
    }
}
