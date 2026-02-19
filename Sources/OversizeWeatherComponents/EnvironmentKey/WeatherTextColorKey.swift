//
// Copyright © 2022 Alexander Romanov
// WeatherTextColorKey.swift
//

import OversizeUI
import SwiftUI

public extension EnvironmentValues {
    @Entry var weatherTextColor: Color = .onSurfacePrimary
}

public extension View {
    func weatherTextColor(_ color: Color = .onSurfacePrimary) -> some View {
        environment(\.weatherTextColor, color)
    }
}
