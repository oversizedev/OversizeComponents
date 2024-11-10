//
// Copyright © 2022 Alexander Romanov
// BMIHelpView.swift
//

import OversizeUI
import SwiftUI

struct BMIHelpView: View {
    private var progress: Double {
        ((bmi * 0.01) * 2.0) + 0.15
    }

    private var state: Double {
        (progress * 0.6) + 0.3
    }

    private let bmi: Double

    private var degrees: Double {
        ((progress * 100) * (progress > 0.6 ? 2.18 : 2.19)) - 109
    }

    init(bmi: Double) {
        self.bmi = bmi
    }

    var body: some View {
        PageView("BMI") {
            VStack(spacing: .large) {
                bmiView
                    .frame(width: 270, height: 270)
                    .padding(.top, 24)
                    .padding(.bottom, -80)

                textInfoView
                    .paddingContent(.horizontal)

                infoListView
                    .paddingContent(.horizontal)
            }
        }
        .backgroundColor(.backgroundSecondary)
        .trailingBar(trailingBar: { BarButton(.close) })
    }

    var bmiView: some View {
        ZStack {
            Circle()
                .trim(from: 0.3, to: 0.9)
                .stroke(style: StrokeStyle(lineWidth: 44.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.surfacePrimary)
                .rotationEffect(.degrees(54.5))
                .shadow(color: .black.opacity(0.04), radius: 32, y: 10)
            // .shadowElevaton(.z3)

            Circle()
                .trim(from: 0.3, to: CGFloat(state))
                .stroke(style: StrokeStyle(lineWidth: 33, lineCap: .round, lineJoin: .round))
                .fill(
                    AngularGradient(gradient: Gradient(colors:
                        [.blue, .cyan, .mint, .green, .green, .yellow, .orange, .red]),
                    center: .center, startAngle: .degrees(100), endAngle: .degrees(320))
                )
                .rotationEffect(.degrees(54.5))

            VStack {
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 9.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.white)
                    .frame(width: 20, height: 20)
                    .offset(y: -10)

                Spacer()
            }
            .rotationEffect(.degrees(degrees))

            if progress < 0.2 || progress > 0.4 {
                VStack {
                    Circle()
                        .foregroundColor(.black.opacity(0.33))
                        .frame(width: 16, height: 16)
                        .offset(y: -8)

                    Spacer()
                }
                .rotationEffect(.degrees(-35.5))
            }

            if progress < 0.5 || progress > 0.7 {
                VStack {
                    Circle()
                        .foregroundColor(.black.opacity(0.33))
                        .frame(width: 16, height: 16)
                        .offset(y: -8)

                    Spacer()
                }
                .rotationEffect(.degrees(35.5))
            }
        }
        .overlay(alignment: .center) {
            textView
        }
    }

    var textView: some View {
        VStack(spacing: .xxSmall) {
            Text(bmi.toStringWithoutPoint)
                .font(.system(size: 70, weight: .heavy, design: .rounded))
                .foregroundColor(.onBackgroundPrimary)
        }
    }

    var textInfoView: some View {
        VStack(spacing: .xxSmall) {
            Text("Body mass index is a value\nderived from the mass and height")
                .headline()
                .foregroundColor(.onBackgroundSecondary)
                .multilineTextAlignment(.center)
        }
    }

    var infoListView: some View {
        VStack(spacing: 2) {
            bmiRow(value: "16.0", title: "Underweight", description: "Severe thinness", color: .blue, icon: IconDeprecated(.chevronLeft, color: .onPrimary))

            bmiRow(value: "16.0–16.9", title: "Underweight", description: "Moderate thinness", color: .cyan)

            bmiRow(value: "17.0–18.4", title: "Underweight", description: "Mild thinness", color: .mint)

            bmiRow(value: "18.5–24.9", title: "Normal range", description: "", color: .green)

            let mintColor = #colorLiteral(red: 0.6062837979, green: 0.7647058964, blue: 0.3193767038, alpha: 1)
            bmiRow(value: "25.0–29.9", title: "Overweight", description: "Pre-obese", color: Color(mintColor))

            bmiRow(value: "30.0–34.9", title: "Obese", description: "Class I", color: .yellow)

            bmiRow(value: "35.0–39.9", title: "Obese", description: "Class II", color: .orange)

            bmiRow(value: "40", title: "Obese", description: "Class III", color: .red, icon: IconDeprecated(.chevronRight, color: .onPrimary))
        }
    }

    func bmiRow(value: String, title: String, description: String, color: Color, icon: IconDeprecated? = nil) -> some View {
        HStack(spacing: 16) {
            HStack(spacing: 0) {
                if icon != nil {
                    icon
                }
                Text(value)
                    .foregroundColor(.onPrimary)
                    .font(.system(size: 17, weight: .bold, design: .rounded))
                    .padding(.vertical, .xSmall)
                    .padding(.trailing, icon != nil ? 8 : 0)
            }
            .frame(width: 110)
            .background {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(color)
            }

            VStack(alignment: .leading, spacing: .xxxSmall) {
                Text(title)
                    .callout(true)
                    .foregroundColor(.onSurfacePrimary)

                if !description.isEmpty {
                    Text(description)
                        .subheadline()
                        .foregroundColor(.onSurfaceSecondary)
                }
            }

            Spacer()
        }
        .padding(.all, .small)
        .background {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color.surfacePrimary)
        }
    }
}

struct BMIHelpView_Previews: PreviewProvider {
    static var previews: some View {
        BMIHelpView(bmi: 24)
    }
}
