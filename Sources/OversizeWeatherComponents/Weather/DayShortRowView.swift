//
// Copyright © 2022 Alexander Romanov
// DayShortRowView.swift
//

import OversizeLocalizable
import OversizeUI
import SwiftUI

public struct DayShortRowView: View {
    @Environment(\.weatherTextColor) private var textColor: Color

    private let icon: Image
    private let day: String
    private let humidity: Int

    private let morningTemperature: Double
    private let morningTemperatureFeelLike: Double

    private let dayTemperature: Double
    private let dayTemperatureFeelsLike: Double

    private let eveningTemperature: Double
    private let eveningTemperatureFeelLike: Double

    private let nightTemperature: Double
    private let nightTemperatureFeelsLike: Double

    @State var isShowDetail = false

    let action: () -> Void

    public init(
        icon: Image,
        day: String,
        humidity: Int = 0,
        morningTemperature: Double,
        morningTemperatureFeelLike: Double,
        dayTemperature: Double,
        dayTemperatureFeelsLike: Double,
        eveningTemperature: Double,
        eveningTemperatureFeelLike: Double,
        nightTemperature: Double,
        nightTemperatureFeelsLike: Double,
        action: @escaping () -> Void,
    ) {
        self.icon = icon
        self.day = day
        self.humidity = humidity

        self.morningTemperature = morningTemperature
        self.morningTemperatureFeelLike = morningTemperatureFeelLike
        self.dayTemperature = dayTemperature
        self.dayTemperatureFeelsLike = dayTemperatureFeelsLike
        self.eveningTemperature = eveningTemperature
        self.eveningTemperatureFeelLike = eveningTemperatureFeelLike
        self.nightTemperature = nightTemperature
        self.nightTemperatureFeelsLike = nightTemperatureFeelsLike
        self.action = action
    }

    public var body: some View {
        Button {
            isShowDetail.toggle()

        } label: {
            VStack(alignment: .leading, spacing: .zero) {
                HStack(spacing: .zero) {
                    icon
                        .resizable()
                        .frame(width: 32, height: 32, alignment: .center)

                    Text(day)
                        .font(.headline)
                        .foregroundStyle(textColor.opacity(0.7))
                        .padding(.leading, .medium)
                        .hLeading()

                    if isShowDetail == false {
                        Bage(color: .link) {
                            Text(String(humidity) + "%")
                        }
                        .padding(.horizontal, .small)

                        Text(dayTemperature.toStringTemperature)
                            .font(.headline)
                            .foregroundStyle(textColor.opacity(0.7))
                            .frame(minWidth: 44)
                            .multilineTextAlignment(.center)

                        Text(nightTemperature.toStringTemperature)
                            .font(.headline)
                            .foregroundStyle(textColor.opacity(0.7))
                            .frame(minWidth: 44)
                            .multilineTextAlignment(.center)

                    } else {
                        Icon(Image.Base.chevronUp)
                    }
                }
                .padding(.vertical, .regular)
                .paddingContent(.horizontal)

                if isShowDetail {
                    VStack(alignment: .leading, spacing: .medium) {
                        Separator()

                        HStack {
                            Text("\(L10n.Common.morning) \(morningTemperature.toStringTemperature)")
                                .font(.headline)
                                .foregroundStyle(textColor.opacity(0.7))

                            Text("\(L10n.Common.feelsLike.lowercased()) \(morningTemperatureFeelLike.toStringTemperature)")
                                .font(.system(size: 16))
                                .fontWeight(.regular)
                                .foregroundColor(textColor.opacity(0.7))
                        }

                        HStack {
                            Text("\(L10n.Common.day) \(dayTemperature.toStringTemperature)")
                                .font(.headline)
                                .foregroundStyle(textColor)

                            Text("\(L10n.Common.feelsLike.lowercased()) \(dayTemperatureFeelsLike.toStringTemperature)")
                                .font(.system(size: 16))
                                .fontWeight(.regular)
                                .foregroundColor(textColor.opacity(0.7))
                        }

                        HStack {
                            Text("\(L10n.Common.evening) \(eveningTemperature.toStringTemperature)")
                                .font(.headline)
                                .foregroundStyle(textColor)

                            Text("\(L10n.Common.feelsLike.lowercased()) \(eveningTemperatureFeelLike.toStringTemperature)")
                                .font(.system(size: 16))
                                .fontWeight(.regular)
                                .foregroundColor(textColor.opacity(0.7))
                        }

                        HStack {
                            Text("\(L10n.Common.night) \(nightTemperature.toStringTemperature)")
                                .font(.headline)
                                .foregroundStyle(textColor)

                            // swiftlint:disable line_length
                            Text("\(L10n.Common.feelsLike.lowercased()) \(nightTemperatureFeelsLike.toStringTemperature)")
                                .font(.system(size: 16))
                                .fontWeight(.regular)
                                .foregroundColor(textColor.opacity(0.7))
                        }

                        Button {
                            action()
                        } label: {
                            Text(L10n.Button.details)
                        }
                        .buttonStyle(.secondary)

                        // }
                    }
                    .padding(.horizontal, .medium)
                    .padding(.bottom, 28)
                }
            }
        }
        .listRowInsets(.init(horizontal: .zero, vertical: .zero))
        #if !os(watchOS) && !os(tvOS)
            .alignmentGuide(.listRowSeparatorLeading) { _ in .zero }
            .alignmentGuide(.listRowSeparatorTrailing) { d in d.width }
            .listRowSeparatorTint(Color.border)
            .listRowSeparator(.visible, edges: .all)
        #endif
        #if !os(watchOS)
            .listRowBackground(Color.surfacePrimary.opacity(isShowDetail ? 1 : 0))
        #endif
    }
}

// .shadowElevation(isShowDetail ? .z0 : .z3 )
