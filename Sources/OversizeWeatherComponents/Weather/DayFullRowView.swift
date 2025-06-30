//
// Copyright © 2022 Alexander Romanov
// DayFullRowView.swift
//

////
//// Copyright © 2022 Alexander Romanov
//// DayFullRowView.swift
////
//
// import OversizeCraft
// import OversizeUI
// import SwiftUI
//
// public struct DayFullRowView: View {
//    @Environment(\.weatherTextColor) private var textColor: Color
//    @Environment(\.colorScheme) private var colorSheme
//    @Environment(\.appSettings) var appSettings
//
//    private let icon: Image
//    private let day: String
//    private let dayDescription: String
//
//    private let morningTemperature: Double
//    private let morningTemperatureFeelLike: Double
//
//    private let dayTemperature: Double
//    private let dayTemperatureFeelsLike: Double
//
//    private let eveningTemperature: Double
//    private let eveningTemperatureFeelLike: Double
//
//    private let nightTemperature: Double
//    private let nightTemperatureFeelsLike: Double
//
//    private let humidity: Int
//    private let windSpeed: Double
//    private let uvIndex: Double
//
//    private let action: () -> Void
//
//    // swiftlint:disable line_length
//    public init(icon: Image, day: String, dayDescription: String, morningTemperature: Double, morningTemperatureFeelLike: Double, dayTemperature: Double, dayTemperatureFeelsLike: Double, eveningTemperature: Double, eveningTemperatureFeelLike: Double, nightTemperature: Double, nightTemperatureFeelsLike: Double, humidity: Int, windSpeed: Double, uvIndex: Double, action: @escaping () -> Void) {
//        self.icon = icon
//        self.day = day
//        self.dayDescription = dayDescription
//        self.morningTemperature = morningTemperature
//        self.morningTemperatureFeelLike = morningTemperatureFeelLike
//        self.dayTemperature = dayTemperature
//        self.dayTemperatureFeelsLike = dayTemperatureFeelsLike
//        self.eveningTemperature = eveningTemperature
//        self.eveningTemperatureFeelLike = eveningTemperatureFeelLike
//        self.nightTemperature = nightTemperature
//        self.nightTemperatureFeelsLike = nightTemperatureFeelsLike
//        self.humidity = humidity
//        self.windSpeed = windSpeed
//        self.uvIndex = uvIndex
//        self.action = action
//    }
//
//    public var body: some View {
//        MaterialSurface { action() } label: {
//            content
//        }
//        .surfaceStyle(colorSheme == .light ? .thick : .thin)
//        .controlPadding(.zero)
//        .controlRadius(.large)
//
////        if #available(iOS 15.0, *) {
////            VStack {
////                content
////            }.background(colorSheme == .light ? .thickMaterial : .thinMaterial, in: RoundedRectangle(cornerRadius: 20))
////        } else {
////            Surface {
////                content
////            }
////            .controlPadding(.zero)
////            .controlRadius(.large)
////        }
//    }
//
//    private var content: some View {
//        VStack(alignment: .leading, spacing: .zero) {
//            HStack(spacing: .zero) {
//                icon
//                    .resizable()
//                    .frame(width: 32, height: 32, alignment: .center)
//
//                Text(day)
//                    .fontStyle(.title3, color: textColor)
//                    .padding(.leading, .small)
//
//                Text(dayDescription)
//                    .fontStyle(.title3, color: textColor.opacity(0.7))
//                    .padding(.leading, 2)
//
//                Spacer()
//
//                Bage(color: .link) {
//                    Text(String(humidity) + "%")
//                }
//            }
//            .padding(.horizontal, .medium)
//            .padding(.vertical, .small)
//
//            Rectangle()
//                .frame(height: 0.5)
//                .foregroundColor(.border)
//                .padding(.horizontal, .xSmall)
//
//            VStack(alignment: .leading, spacing: .medium) {
//                HStack {
//                    Text("\(L10n.Common.morning) \(morningTemperature.toStringTemperature)")
//                        .fontStyle(.subtitle1, color: textColor)
//
//                    Text("\(L10n.Common.feelsLike.lowercased()) \(morningTemperatureFeelLike.toStringTemperature)")
//                        .font(.system(size: 16))
//                        .fontWeight(.regular)
//                        .foregroundColor(textColor.opacity(0.7))
//                }
//
//                HStack {
//                    Text("\(L10n.Common.day) \(dayTemperature.toStringTemperature)")
//                        .fontStyle(.subtitle1, color: textColor)
//
//                    Text("\(L10n.Common.feelsLike.lowercased()) \(dayTemperatureFeelsLike.toStringTemperature)")
//                        .font(.system(size: 16))
//                        .fontWeight(.regular)
//                        .foregroundColor(textColor.opacity(0.7))
//                }
//
//                HStack {
//                    Text("\(L10n.Common.evening) \(eveningTemperature.toStringTemperature)")
//                        .fontStyle(.subtitle1, color: textColor)
//
//                    Text("\(L10n.Common.feelsLike.lowercased()) \(eveningTemperatureFeelLike.toStringTemperature)")
//                        .font(.system(size: 16))
//                        .fontWeight(.regular)
//                        .foregroundColor(textColor.opacity(0.7))
//                }
//
//                HStack {
//                    Text("\(L10n.Common.night) \(nightTemperature.toStringTemperature)")
//                        .fontStyle(.subtitle1, color: textColor)
//
//                    Text("\(L10n.Common.feelsLike.lowercased()) \(nightTemperatureFeelsLike.toStringTemperature)")
//                        .font(.system(size: 16))
//                        .fontWeight(.regular)
//                        .foregroundColor(textColor.opacity(0.7))
//                }
//            }
//            .padding(.horizontal, .medium)
//            .padding(.vertical, 20)
//
//            Rectangle()
//                .frame(height: 0.5)
//                .foregroundColor(.border)
//                .padding(.horizontal, .xSmall)
//
//            VStack(alignment: .leading, spacing: .xxSmall) {
//                HStack(spacing: .xxxSmall) {
//                    Text(L10n.Common.uv)
//                        .fontStyle(.subtitle2, color: textColor)
//
//                    Text(uvIndex.toStringWithoutPoint + " " + descriptionText)
//                        .font(.system(size: 16))
//                        .fontWeight(.regular)
//                        .foregroundColor(textColor.opacity(0.7))
//
//                }
//
//                HStack(spacing: .xxxSmall) {
//                    Text(L10n.Common.wind) // \(uvIndex)")
//                        .fontStyle(.subtitle2, color: textColor)
//
//                    Text(windSpeed.toStringWithoutPoint + " " + (appSettings.units == .imperial ? L10n.Common.milesHour : L10n.Common.metereSec))
//                        .font(.system(size: 16))
//                        .fontWeight(.regular)
//                        .foregroundColor(textColor.opacity(0.7))
//                }
//            }
//            .padding(.horizontal, .medium)
//            .padding(.vertical, .small)
//        }
//    }
//
//    var descriptionText: String {
//        switch uvi {
//        case 0 ... 2:
//            return L10n.Common.low
//        case 2 ... 6:
//            return L10n.Common.moderate
//        case 6 ... 8:
//            return L10n.Common.high
//        case 8 ... 11:
//            return L10n.Common.veryHigh
//        case 11...:
//            return L10n.Common.extreme
//        default:
//            return "-"
//        }
//    }
// }
//
//// swiftlint:disable all
////
//// struct DayFullRowView_Previews: PreviewProvider {
////    static var previews: some View {
////        //Group {
////
////        DayFullRowView(icon: Image(""), day: "Monday", humidity: 12, dayTemperature: 32, nightTemperature: 20)
////                .previewLayout(.sizeThatFits)
////
//////            DayView(icon: Image(""), day: "Monday")
////////
//////            DayView(icon: Image(""), day: "Monday", humidity: 12)
////               // .loading(true)
////
////
////        //}
////
////        //.weatherTextColor(Color.onSurfacePrimary)
////    }
//// }
