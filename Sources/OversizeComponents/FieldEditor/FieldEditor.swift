//
// Copyright © 2022 Alexander Romanov
// FieldEditor.swift
//

import OversizeUI
import SwiftUI

public struct FieldEditor<Action: View>: View {
    public let label: String
    public var placeholder: String
    @Binding public var text: String
    @Binding public var helperText: String
    @Binding public var showHelper: Bool
    @FocusState private var isFocused: Bool

    public var leadingImage: Image?
    public var trailingImage: Image?

    @ViewBuilder private let action: Action

    @Environment(\.dismiss) var dismiss

    public init(
        _ label: String,
        placeholder: String,
        text: Binding<String>,
        helperText: Binding<String> = .constant(""),
        showHelper: Binding<Bool> = .constant(false),
        leadingImage: Image? = nil,
        trailingImage: Image? = nil,
        @ViewBuilder action: () -> Action,
    ) {
        self.label = label
        self.placeholder = placeholder
        _text = text
        _helperText = helperText
        _showHelper = showHelper
        self.leadingImage = leadingImage
        self.trailingImage = trailingImage
        self.action = action()
    }

    public var body: some View {
        VStack {
            HStack {
                if let leadingImage {
                    leadingImage
                }

                TextField(placeholder, text: $text)
                    .largeTitle()
                    .foregroundColor(.onSurfacePrimary)
                    .multilineTextAlignment(.center)
                    .focused($isFocused)

                if let trailingImage {
                    trailingImage
                }
            }
            .padding()

            if helperText != "" {
                Text(helperText)
                    .subheadline()
                    .foregroundColor(.onSurfaceSecondary)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .paddingContent()
        .safeAreaBarBottom {
            action
                .buttonStyle(.primary)
                .accent()
                .paddingContent()
                .disabled(text.isEmpty)
        }
        .navigationTitle(label)
        #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
        #endif
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close", systemImage: "xmark", role: .cancel) {
                        dismiss()
                    }
                    .labelStyle(.toolbar)
                    .buttonStyle(.toolbarSecondary)
                    #if !os(tvOS) && !os(watchOS)
                        .keyboardShortcut(.cancelAction)
                    #endif
                }
            }
            .onAppear {
                isFocused = true
            }
    }
}

#Preview {
    FieldEditor("Your name", placeholder: "Alexander", text: .constant("Alexander")) {
        Button("Save") {}
    }
}
