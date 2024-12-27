//
// Copyright © 2022 Alexander Romanov
// FieldScreenView.swift
//

import OversizeCore
import OversizeUI
import SwiftUI

public struct FieldScreenView: View {
    public let label: String
    public var placeholder: String
    @Binding public var text: String
    @Binding public var helperText: String
    @Binding public var showHelper: Bool
    @State var offset = CGPoint(x: 0, y: 0)
    @FocusState private var isFocused: Bool

    public var leadingImage: IconsNames
    public var trallingImage: IconsNames

    public var buttonText: String
    public var action: () -> Void

    @Environment(\.dismiss) var dismiss

    public init(
        _ label: String,
        placeholder: String,
        text: Binding<String>,
        helperText: Binding<String> = .constant(""),
        showHelper: Binding<Bool> = .constant(false),
        leadingImage: IconsNames = .none,
        trallingImage: IconsNames = .none,
        buttonText: String = "Save",
        buttonAction: @escaping () -> Void
    ) {
        self.label = label
        self.placeholder = placeholder
        _text = text
        _helperText = helperText
        _showHelper = showHelper
        self.leadingImage = leadingImage
        self.trallingImage = trallingImage
        self.buttonText = buttonText
        action = buttonAction
    }

    public var body: some View {
        VStack(alignment: .center) {
            Spacer()

            VStack(spacing: 0) {
                HStack {
                    if leadingImage != .none {
                        IconDeprecated(leadingImage)
                    }

                    TextField(placeholder, text: $text)
                        .largeTitle()
                        .foregroundColor(.onSurfacePrimary)
                        .multilineTextAlignment(.center)
                        .focused($isFocused)

                    if trallingImage != .none {
                        IconDeprecated(trallingImage)
                    }
                }

            }.padding()

            if helperText != "" {
                Text(helperText)
                    .subheadline()
                    .foregroundColor(.onSurfaceSecondary)
            }

            Spacer()

            Button(action: buttonAction, label: {
                Text(buttonText)
            })
            .buttonStyle(.primary)
            .paddingContent()
            .disabled(text.isEmpty)
        }
        .navigationBar(label, style: .fixed($offset)) {
            BarButton(.close)
        } trailingBar: {} bottomBar: {}
        .onAppear {
            isFocused = true
        }
    }

    func buttonAction() {
        action()
        dismiss()
        isFocused = false
    }
}

struct FieldScreenView_Previews: PreviewProvider {
    static var previews: some View {
        FieldScreenView("Your name", placeholder: "Alexander", text: .constant("Alexander"), buttonText: "Save", buttonAction: {})
    }
}
