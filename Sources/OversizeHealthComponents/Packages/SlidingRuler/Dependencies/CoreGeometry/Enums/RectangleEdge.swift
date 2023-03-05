//
// Copyright © 2022 Alexander Romanov
// RectangleEdge.swift
//

import CoreGraphics

public struct RectangleEdge: OptionSet {
    public let rawValue: Int

    @usableFromInline
    var cgRectEdges: [CGRectEdge] {
        [Self.minXEdge, .minYEdge, .maxXEdge, .maxYEdge].lazy.compactMap {
            contains($0) ? UInt32(log2(Double($0.rawValue))) : nil
        }.compactMap {
            CGRectEdge(rawValue: $0)
        }
    }

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public static let minXEdge: RectangleEdge = .init(rawValue: 1 << 0)
    public static let minYEdge: RectangleEdge = .init(rawValue: 1 << 1)
    public static let maxXEdge: RectangleEdge = .init(rawValue: 1 << 2)
    public static let maxYEdge: RectangleEdge = .init(rawValue: 1 << 3)

    public static let all: RectangleEdge = [.minXEdge, .minYEdge, .maxXEdge, .maxYEdge]
    public static let horizontal: RectangleEdge = [.minXEdge, .maxXEdge]
    public static let vertical: RectangleEdge = [.minYEdge, .maxYEdge]
}
