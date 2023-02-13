//
// Copyright © 2023 Alexander Romanov
// URLField.swift
//

import OversizeCore
import OversizeUI
import SwiftUI

public struct URLField: View {
    @Binding private var url: URL?
    @State private var urlString: String = ""

    @State private var textFieldHelper: TextFieldHelperStyle = .none

    public init(url: Binding<URL?>) {
        _url = url
    }

    public var body: some View {
        TextField("URL", text: $urlString, onEditingChanged: { _ in
            textFieldHelper = .none
        }) {
            if let url = urlString.url {
                self.url = url
                textFieldHelper = .none
            } else if !urlString.isEmpty {
                textFieldHelper = .errorText
            } else {
                textFieldHelper = .none
            }
        }
        .keyboardType(.URL)
        .textInputAutocapitalization(.never)
        .helper(.constant("Invalid URL"), style: $textFieldHelper)
    }
}
