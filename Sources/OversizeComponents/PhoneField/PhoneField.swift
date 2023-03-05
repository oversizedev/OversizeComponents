//
// Copyright © 2023 Alexander Romanov
// PhoneField.swift
//

import OversizeCore
import OversizeUI
import SwiftUI

public struct PhoneField: View {
    @Binding private var phone: String
    // @State private var phoneString: String = ""

    @State private var textFieldHelper: FieldHelperStyle = .none

    public init(phone: Binding<String>) {
        _phone = phone
    }

    public var body: some View {
        TextField("+1 (000) 000 0000", text: $phone, onEditingChanged: { _ in
            textFieldHelper = .none
        }) {
//            if let phone = phoneString.isEmail {
//                self.phone = phone
//                textFieldHelper = .none
//            } else if !phoneString.isEmpty {
//                textFieldHelper = .errorText
//            } else {
//                textFieldHelper = .none
//            }
        }
        .keyboardType(.phonePad)
        .fieldHelper(.constant("Invalid Phone"), style: $textFieldHelper)
    }
}
