//
// Copyright © 2022 Alexander Romanov
// StickyMark.swift
//

public enum StickyMark {
    public enum Bound { case any, unit, half, tenth }

    case none, nearest, lower(Bound), upper(Bound)

    var bound: Bound {
        switch self {
        case .none, .nearest:
            return .any
        case let .lower(b), let .upper(b):
            return b
        }
    }
}
