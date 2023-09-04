//
// Copyright © 2022 Alexander Romanov
// CenteredScaleView.swift
//

import SwiftUI

struct CenteredScaleView: ScaleView {
    struct ScaleShape: Shape {
        fileprivate var unitMarkSize: CGSize { .init(width: 2.0, height: 44.0 * 2) }
        fileprivate var halfMarkSize: CGSize { .init(width: UIScreen.main.scale == 3 ? 1.8 : 2.0, height: 28.0 * 2) }
        fileprivate var fractionMarkSize: CGSize { .init(width: 2.0, height: 16.0 * 2) }

        func path(in rect: CGRect) -> Path {
            let centerX = rect.center.x
            let centerY = rect.center.y
            // let minY = rect.minY
            var p = Path()

            p.addRoundedRect(in: unitRect(x: centerX, y: centerY + centerY), cornerSize: .init(square: unitMarkSize.width / 2))
            p.addRoundedRect(in: halfRect(x: 0, y: centerY + centerY), cornerSize: .init(square: halfMarkSize.width / 2))
            p.addRoundedRect(in: halfRect(x: rect.maxX, y: centerY + centerY), cornerSize: .init(square: halfMarkSize.width / 2))

            let tenth = rect.width / 10
            for i in 1 ... 4 {
                p.addRoundedRect(in: tenthRect(x: centerX + CGFloat(i) * tenth, y: centerY + centerY), cornerSize: .init(square: fractionMarkSize.width / 2))
                p.addRoundedRect(in: tenthRect(x: centerX - CGFloat(i) * tenth, y: centerY + centerY), cornerSize: .init(square: fractionMarkSize.width / 2))
            }

            return p
        }

        private func unitRect(x: CGFloat, y: CGFloat) -> CGRect { .init(center: .init(x: x, y: y), size: unitMarkSize) }
        private func halfRect(x: CGFloat, y: CGFloat) -> CGRect { .init(center: .init(x: x, y: y), size: halfMarkSize) }
        private func tenthRect(x: CGFloat, y: CGFloat) -> CGRect { .init(center: .init(x: x, y: y), size: fractionMarkSize) }
    }

    let width: CGFloat
    let height: CGFloat
    var shape: ScaleShape { .init() }

    var unitMarkWidth: CGFloat { shape.unitMarkSize.width }
    var halfMarkWidth: CGFloat { shape.halfMarkSize.width }
    var fractionMarkWidth: CGFloat { shape.fractionMarkSize.width }

    init(width: CGFloat, height: CGFloat = 90) {
        self.width = width
        self.height = height
    }
}
