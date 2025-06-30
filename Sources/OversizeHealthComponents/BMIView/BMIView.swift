//
// Copyright © 2022 Alexander Romanov
// BMIView.swift
//

import OversizeCore
import OversizeUI
import SwiftUI

public struct BMIView: View {
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

    public init(bmi: Double) {
        self.bmi = bmi
    }

    @State var isShowHelp = false

    public var body: some View {
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
                    AngularGradient(
                        gradient: Gradient(colors:
                            [.blue, .cyan, .mint, .green, .green, .yellow, .orange, .red]),
                        center: .center,
                        startAngle: .degrees(100),
                        endAngle: .degrees(320),
                    ),
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
            // .padding(.top, .xLarge)
        }
        .onTapGesture {
            isShowHelp.toggle()
        }
        .sheet(isPresented: $isShowHelp) {
            BMIHelpView(bmi: bmi)
        }
    }

    var textView: some View {
        VStack(spacing: .xxSmall) {
            Text(bmi.toStringWithoutPoint)
                .font(.system(size: 70, weight: .heavy, design: .rounded))
                .foregroundColor(.onBackgroundPrimary)

            HStack(spacing: .xxxSmall) {
                Text("Body mass index")
                    .headline()
                    .foregroundColor(.onBackgroundSecondary)

                Button { isShowHelp.toggle() } label: {
                    IconDeprecated(.helpCircle, size: .medium, color: .onBackgroundTertiary)
                }
            }
            .unredacted()
        }
    }
}

//
// struct Previews_BMIView_Previews: PreviewProvider {
//    static var previews: some View {
//
//        Group {
//
//            BMIView(progress: .constant(1))
//
//            BMIView(progress: .constant(0.7))
//
//            BMIView(progress: .constant(0.5))
//
//            BMIView(progress: .constant(0.3))
//
//            BMIView(progress: .constant(0.0))
//
//        }
//        .padding(56)
//        .offset(y: 36)
//        .background(Color.gray)
//        .previewLayout(.fixed(width: 375, height: 375))
//    }
// }
