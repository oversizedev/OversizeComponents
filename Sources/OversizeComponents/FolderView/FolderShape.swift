//
// Copyright © 2022 Alexander Romanov
// FolderShape.swift
//

import SwiftUI

public struct FolderShape: Shape {
    let folderTopInset: CGFloat

    let radius: CGFloat

    public init(folderTopInset: CGFloat, radius: CGFloat) {
        self.folderTopInset = folderTopInset
        self.radius = radius
    }

    public func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        path.move(to: CGPoint(x: 0, y: 0))

        path.addLine(to: CGPoint(x: (width / 2.5) - (folderTopInset * 1.5), y: 0))

        // Folder Bend
        path.addQuadCurve(
            to: CGPoint(x: (width / 2.5) - (folderTopInset / 2), y: folderTopInset / 2),
            control: CGPoint(x: (width / 2.5) - (folderTopInset / 1.5), y: 0)
        )

        path.addQuadCurve(
            to: CGPoint(x: (width / 2.5) + (folderTopInset / 2), y: folderTopInset),
            control: CGPoint(x: (width / 2.5) - (folderTopInset / 3), y: folderTopInset)
        )

        // Top trailing

        path.addLine(to: CGPoint(x: width - (radius * 1.2), y: folderTopInset))

        path.addQuadCurve(
            to: CGPoint(x: width, y: folderTopInset + (radius * 1.2)),
            control: CGPoint(x: width, y: folderTopInset)
        )

        path.addQuadCurve(
            to: CGPoint(x: width, y: height),
            control: CGPoint(x: width, y: height)
        )

        path.addQuadCurve(
            to: CGPoint(x: 0, y: height),
            control: CGPoint(x: 0, y: height)
        )

        path.closeSubpath()
        return path
    }
}
