//
// Copyright © 2022 Alexander Romanov
// Tick.swift
//

public enum Mark {
    case none, unit, half, fraction
}

public enum Tick {
    case none, unit, half, tenth

    var coeff: Double {
        switch self {
        case .none: return .nan
        case .unit: return 1
        case .half: return 0.5
        case .tenth: return 0.1
        }
    }
}
