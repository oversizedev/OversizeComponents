//
// Copyright © 2022 Alexander Romanov
// WeatherBackgroundView.swift
//

import SwiftUI

public enum WeatherBackgroundViewType {
    case fullScreen, widgetSmall, widgetBig
}

public struct WeatherBackgroundView: View {
    private let topLeadingColor: Color
    private let topTrallingColor: Color
    private let centerColor: Color
    private let backgroundColor: Color
    private let type: WeatherBackgroundViewType

    public init(
        topLeadingColor: Color,
        topTrallingColor: Color,
        centerColor: Color,
        backgroundColor: Color,
        type: WeatherBackgroundViewType
    ) {
        self.topLeadingColor = topLeadingColor
        self.topTrallingColor = topTrallingColor
        self.centerColor = centerColor
        self.backgroundColor = backgroundColor
        self.type = type
    }

    public var body: some View {
        ZStack {
            Rectangle().foregroundColor(backgroundColor)

            RadialGradient(
                gradient: Gradient(colors: [topTrallingColor, topTrallingColor.opacity(0)]),
                center: .topTrailing,
                startRadius: 1,
                endRadius: type == .fullScreen ? 600 : type == .widgetBig ? 300 : 110,
            )

            RadialGradient(
                gradient: Gradient(colors: [centerColor, centerColor.opacity(0)]),
                center: .center,
                startRadius: 1,
                endRadius: type == .fullScreen ? 300 : type == .widgetBig ? 200 : 60,
            )

            RadialGradient(
                gradient: Gradient(colors: [topLeadingColor, topLeadingColor.opacity(0)]),
                center: .topLeading,
                startRadius: 0,
                endRadius: type == .fullScreen ? 600 : type == .widgetBig ? 300 : 110,
            )
        }
    }
}
