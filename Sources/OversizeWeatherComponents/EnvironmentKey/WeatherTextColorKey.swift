//
// Copyright © 2022 Alexander Romanov
// WeatherTextColorKey.swift
//

import OversizeUI
import SwiftUI

struct WeatherTextColorKey: EnvironmentKey {
    public static var defaultValue: Color = .onSurfaceHighEmphasis
}

public extension EnvironmentValues {
    var weatherTextColor: Color {
        get { self[WeatherTextColorKey.self] }
        set { self[WeatherTextColorKey.self] = newValue }
    }
}

public extension View {
    func weatherTextColor(_ color: Color = .onSurfaceHighEmphasis) -> some View {
        environment(\.weatherTextColor, color)
    }
}
