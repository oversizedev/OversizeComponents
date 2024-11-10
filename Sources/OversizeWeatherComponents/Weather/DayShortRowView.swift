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

    private let mornTemperature: Double
    private let mornTemperatureFeelLike: Double

    private let dayTemperature: Double
    private let dayTemperatureFeelLike: Double

    private let eveTemperature: Double
    private let eveTemperatureFeelLike: Double

    private let nightTemperature: Double
    private let nightTemperatureFeelLike: Double

    @State var isShowDetail = false

    let action: () -> Void

    public init(icon: Image,
                day: String,
                humidity: Int = 0,
                mornTemperature: Double,
                mornTemperatureFeelLike: Double,
                dayTemperature: Double,
                dayTemperatureFeelLike: Double,
                eveTemperature: Double,
                eveTemperatureFeelLike: Double,
                nightTemperature: Double,
                nightTemperatureFeelLike: Double,
                action: @escaping () -> Void)
    {
        self.icon = icon
        self.day = day
        self.humidity = humidity

        self.mornTemperature = mornTemperature
        self.mornTemperatureFeelLike = mornTemperatureFeelLike
        self.dayTemperature = dayTemperature
        self.dayTemperatureFeelLike = dayTemperatureFeelLike
        self.eveTemperature = eveTemperature
        self.eveTemperatureFeelLike = eveTemperatureFeelLike
        self.nightTemperature = nightTemperature
        self.nightTemperatureFeelLike = nightTemperatureFeelLike
        self.action = action
    }

    public var body: some View {
        Surface { withAnimation {
            isShowDetail.toggle()
        } } label: {
            VStack(alignment: .leading, spacing: .zero) {
                if isShowDetail == false {
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(.border)
                }

                // header
                HStack(spacing: .zero) {
                    icon
                        .resizable()
                        .frame(width: 32, height: 32, alignment: .center)

                    Text(day)
                        .font(.headline)
                        .foregroundStyle(textColor.opacity(0.7))
                        .padding(.leading, .medium)

                    Spacer()

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
                        IconDeprecated(.chevronUp)
                    }
                }
                .padding(.vertical, .small)
                .paddingContent(.horizontal)

                if isShowDetail {
//                    Button {
//                        print("action")
//                    } label: {
                    VStack(alignment: .leading, spacing: .medium) {
                        Rectangle()
                            .frame(height: 0.5)
                            .foregroundColor(.border)

                        HStack {
                            Text("\(L10n.Common.morning) \(mornTemperature.toStringTemperature)")
                                .font(.headline)
                                .foregroundStyle(textColor.opacity(0.7))

                            Text("\(L10n.Common.feelsLike.lowercased()) \(mornTemperatureFeelLike.toStringTemperature)")
                                .font(.system(size: 16))
                                .fontWeight(.regular)
                                .foregroundColor(textColor.opacity(0.7))
                        }

                        HStack {
                            Text("\(L10n.Common.day) \(dayTemperature.toStringTemperature)")
                                .font(.headline)
                                .foregroundStyle(textColor)

                            Text("\(L10n.Common.feelsLike.lowercased()) \(dayTemperatureFeelLike.toStringTemperature)")
                                .font(.system(size: 16))
                                .fontWeight(.regular)
                                .foregroundColor(textColor.opacity(0.7))
                        }

                        HStack {
                            Text("\(L10n.Common.evening) \(eveTemperature.toStringTemperature)")
                                .font(.headline)
                                .foregroundStyle(textColor)

                            Text("\(L10n.Common.feelsLike.lowercased()) \(eveTemperatureFeelLike.toStringTemperature)")
                                .font(.system(size: 16))
                                .fontWeight(.regular)
                                .foregroundColor(textColor.opacity(0.7))
                        }

                        HStack {
                            Text("\(L10n.Common.night) \(nightTemperature.toStringTemperature)")
                                .font(.headline)
                                .foregroundStyle(textColor)

                            // swiftlint:disable line_length
                            Text("\(L10n.Common.feelsLike.lowercased()) \(nightTemperatureFeelLike.toStringTemperature)")
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
        .surfaceStyle(isShowDetail ? .primary : .clear)
        .controlMargin(.zero)
        .controlRadius(.large)
        .elevation(isShowDetail ? .z0 : .z3)
    }
}

// .shadowElevaton(isShowDetail ? .z0 : .z3 )
