//
// Copyright © 2022 Alexander Romanov
// WeatherTextColorKey.swift
//

import OversizeUI
import SwiftUI

struct WeatherTextColorKey: EnvironmentKey {
    public static let defaultValue: Color = .onSurfacePrimary
}

public extension EnvironmentValues {
    var weatherTextColor: Color {
        get { self[WeatherTextColorKey.self] }
        set { self[WeatherTextColorKey.self] = newValue }
    }
}

public extension View {
    func weatherTextColor(_ color: Color = .onSurfacePrimary) -> some View {
        environment(\.weatherTextColor, color)
    }
}
