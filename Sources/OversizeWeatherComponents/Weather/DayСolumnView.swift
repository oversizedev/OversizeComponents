//
// Copyright © 2022 Alexander Romanov
// DayСolumnView.swift
//

import OversizeCore
import OversizeLocalizable
import OversizeUI
import SwiftUI

public struct DayСolumnView: View {
    @Environment(\.weatherTextColor) var textColor
    private let day: String
    private let dayDescription: String
    private let dayIcon: Image
    private let dayTemperature: Double

    private let nightIcon: Image?
    private let nightTemperature: Double

    private let windSpeed: Double
    private let windDegrees: Int

    public init(
        day: String,
        dayDescription: String,
        dayIcon: Image,
        dayTemperature: Double = 0,
        nightIcon: Image?,
        nightTemperature: Double = 0,
        windSpeed: Double = 0,
        windDegrees: Int = 0
    ) {
        self.day = day
        self.dayDescription = dayDescription
        self.dayIcon = dayIcon
        self.dayTemperature = dayTemperature
        self.nightIcon = nightIcon
        self.nightTemperature = nightTemperature
        self.windSpeed = windSpeed
        self.windDegrees = windDegrees
    }

    public var body: some View {
        VStack(spacing: .zero) {
            Text(day)
                .padding(.top, .small)
                .font(.headline)
                .foregroundStyle(textColor)
                .multilineTextAlignment(.center)

            Text(dayDescription)
                .padding(.top, .xxxSmall)
                .font(.subheadline)
                .foregroundStyle(textColor.opacity(0.7))
                .multilineTextAlignment(.center)

            dayIcon
                .resizable()
                .frame(width: 32, height: 32, alignment: .center)
                .padding(.top, 18)

            Text(dayTemperature.toStringTemperature)
                .padding(.top, 20)
                .font(.subheadline)
                .foregroundStyle(textColor.opacity(0.7))
                .multilineTextAlignment(.center)

            Spacer()

            Text(nightTemperature.toStringTemperature)
                .font(.subheadline)
                .foregroundStyle(textColor.opacity(0.7))
                .multilineTextAlignment(.center)
                .padding(.bottom, .medium)

            // nightIcon

            Image.Base.nearMe
                .resizable()
                .renderingMode(.template)
                .foregroundColor(textColor.opacity(0.7))
                .frame(width: 16, height: 16)
                .rotationEffect(Angle(degrees: Double(windDegrees + 180)))

            // IconDeprecated(.arrowUp, size: .small, color: textColor.opacity(0.7))

            Text(L10n.Common.wind)
                .padding(.top, .xSmall)
                .font(.caption)
                .foregroundStyle(textColor.opacity(0.7))
                .multilineTextAlignment(.center)

            Text(String(format: "%.0f", windSpeed) + " " + L10n.Common.metereSec)
                .padding(.top, .xxxSmall)
                .font(.caption)
                .foregroundStyle(textColor)
                .multilineTextAlignment(.center)
        }
    }
}

struct DayСolumnView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DayСolumnView(
                day: "Sn",
                dayDescription: "Today",
                dayIcon: Image(""),
                dayTemperature: 31,
                nightIcon: Image(""),
                nightTemperature: 27,
                windSpeed: 20,
                windDegrees: 0
            )

            DayСolumnView(
                day: "Sn",
                dayDescription: "Today",
                dayIcon: Image(""),
                dayTemperature: 31,
                nightIcon: Image(""),
                nightTemperature: 27,
                windSpeed: 20,
                windDegrees: 0
            )
            .loading(true)
            // .environment(\.weatherTextColor, Color.onSurfacePrimary)
            // .weatherTextColor()
        }
        // .previewLayout(.sizeThatFits)
    }
}
