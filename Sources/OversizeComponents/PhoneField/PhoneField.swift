//
// Copyright © 2023 Alexander Romanov
// PhoneField.swift
//

import OversizeCore
import OversizeUI
import SwiftUI

#if os(iOS)
    @available(iOS 15.0, *)
    @available(macOS, unavailable)
    @available(watchOS, unavailable)
    @available(tvOS, unavailable)
    public struct PhoneField: View {
        @Binding private var phone: String

        @State private var textFieldHelper: FieldHelperStyle = .none

        public init(_ phone: Binding<String>) {
            _phone = phone
        }

        public var body: some View {
            TextField("+1 (000) 000 0000", text: $phone, onEditingChanged: { _ in
                textFieldHelper = .none
            }) {}
                .keyboardType(.phonePad)
                .textContentType(.nickname)
                .fieldHelper(.constant("Invalid Phone"), style: $textFieldHelper)
        }
    }
#endif
