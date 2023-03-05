//
// Copyright © 2022 Alexander Romanov
// WeightPicker.swift
//

import OversizeComponents
import OversizeUI
import SwiftUI
import UIKit

public struct WeightPicker: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.isPremium) var isPremium

    private let startWeight: Double

    @State private var value: Double = 0

    private let action: ((Double, UIImage) -> Void)?

    private let premiumAction: (() -> Void)?

    @State var isShowCamera = false

    @Namespace private var animation

    @State private var image = UIImage()

    private let unit: String

    public init(startWeight: Double, unit: String, action: ((Double, UIImage) -> Void)? = nil, premiumAction: (() -> Void)? = nil) {
        self.startWeight = startWeight
        _value = State(initialValue: startWeight)
        self.action = action
        self.premiumAction = premiumAction
        self.unit = unit
    }

    var weightChange: Double? {
        if startWeight == value {
            return nil
        } else if startWeight < value {
            return startWeight - value
        } else {
            return value - startWeight
        }
    }

    var symbolText: String {
        if startWeight == value {
            return ""
        } else if startWeight < value {
            return "+"
        } else {
            return "−"
        }
    }

    var commentText: String {
        if startWeight == value {
            return "Slide ruler"
        } else if startWeight < value {
            return "You gained weight"
        } else {
            return "You have lost weight on"
        }
    }

    var weightColor: Color {
        if startWeight == value {
            return .onSurfaceHighEmphasis
        } else if startWeight < value {
            return .error
        } else {
            return .success
        }
    }

    private var formatter: NumberFormatter {
        let f: NumberFormatter = .init()
        f.numberStyle = .decimal
        f.maximumFractionDigits = 0
        return f
    }

    public var body: some View {
        VStack(spacing: .zero) {
            topContent

            bottomContent
        }
        .background(Color.surfacePrimary)
    }

    var topContent: some View {
        VStack {
            Text("Choose your weight")
                .font(.subheadline)
                .bold()
                .foregroundColor(Color.black.opacity(0.6))
                .padding(.vertical, .xxSmall)
                .padding(.horizontal, .small)
                .background {
                    Capsule()
                        .foregroundColor(Color.black.opacity(0.04))
                }
                .padding(.top, .medium)
                .padding(.bottom, .large)

            SlidingRuler(value: $value,
                         in: 1 ... 350,
                         step: 1,
                         snap: .fraction,
                         tick: .fraction,
                         formatter: formatter)
                .slidingRulerStyle(CenteredSlindingRulerStyle())
                .overlay(alignment: .top) {
                    Text(value.toStringOnePoint)
                        .foregroundColor(.white)
                        .font(.title2.monospacedDigit())
                        .bold()
                        .background {
                            Circle()
                                .foregroundColor(Color.black)
                                .frame(width: 72, height: 72, alignment: .center)
                        }
                }
        }
        .background { Color.yellow.ignoresSafeArea() }
    }

    @ViewBuilder
    var bottomContent: some View {
        VStack(spacing: .zero) {
            Spacer()

            weightTextContent

            Spacer()

            VStack(spacing: .xSmall) {
                Button {
                    action?(value, image)
                    dismiss()
                } label: {
                    Text("Save weight")
                }
                .buttonStyle(.primary)
                .accent()
                .controlBorderShape(.roundedRectangle(radius: .large))
                .elevation(.z2)
                .foregroundColor(.onBackgroundDisabled)

                HStack {
                    if image != UIImage() {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .center)
                            .cornerRadius(.medium)

                        Button {
                            isShowCamera.toggle()
                            // cameraAction?()
                        } label: {
                            Text("Retake")
                        }
                        .buttonStyle(.tertiary)
                        .controlBorderShape(.roundedRectangle(radius: .large))
                        .sheet(isPresented: $isShowCamera) {
                            ImagePicker(sourceType: .camera, selectedImage: $image)
                                .ignoresSafeArea(.all)
                        }

                        Button {
                            image = UIImage()
                            // cameraAction?()
                        } label: {
                            Text("Remove")
                        }
                        .buttonStyle(.tertiary)
                        .controlBorderShape(.roundedRectangle(radius: .large))
                        .sheet(isPresented: $isShowCamera) {
                            ImagePicker(sourceType: .camera, selectedImage: $image)
                                .ignoresSafeArea(.all)
                        }

                    } else {
                        Button {
                            if isPremium {
                                isShowCamera.toggle()
                            } else {
                                premiumAction?()
                            }
                        } label: {
                            HStack {
                                Text("Attach a photo")

                                if !isPremium {
                                    PremiumLabel(size: .small)
                                }
                            }
                        }
                        .buttonStyle(.quaternary)
                        .controlBorderShape(.roundedRectangle(radius: .large))
                        .sheet(isPresented: $isShowCamera) {
                            ImagePicker(sourceType: .camera, selectedImage: $image)
                                .ignoresSafeArea(.all)
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom, .xxxSmall)
        }
    }

    @ViewBuilder
    var weightTextContent: some View {
        VStack(spacing: .xxSmall) {
            if weightChange == nil {
                Circle()
                    .fill(Color.surfaceSecondary)
                    .frame(width: 48, height: 48)
                    .overlay {
                        HStack(spacing: -4) {
                            Icon(.chevronLeft, color: .onSurfaceDisabled)

                            Icon(.chevronRight, color: .onSurfaceDisabled)
                        }
                    }
                    // .matchedGeometryEffect(id: "Weight", in: animation)
                    .animation(.default, value: weightChange)
            }

            Text(commentText)
                .subheadline(.bold)
                .foregroundColor(.onSurfaceDisabled)
                .frame(maxWidth: .infinity)

            if let valueText = weightChange {
                HStack(alignment: .firstTextBaseline, spacing: 2) {
                    Text(symbolText)
                        .font(.system(size: 40, design: .rounded).weight(.bold))
                        .monospacedDigit()

                    Text(valueText.toStringOnePoint.dropFirst())
                        .font(.system(size: 40, design: .rounded).weight(.bold))
                        .monospacedDigit()

                    Text(unit)
                        .font(.system(.title2, design: .rounded).weight(.semibold))
                        .foregroundColor(.onBackgroundDisabled)
                }
                .foregroundColor(weightColor)
                .frame(maxWidth: .infinity)
                // .matchedGeometryEffect(id: "Weight", in: animation)
                // .animation(.default, value: weightChange)
            }
        }
    }
}

struct WeightPicker_Previews: PreviewProvider {
    static var previews: some View {
        WeightPicker(startWeight: 80, unit: "kg")
    }
}
