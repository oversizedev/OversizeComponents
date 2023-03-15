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
    let title: String

    @State private var textFieldHelper: FieldHelperStyle = .none

    public init(_ title: String = "https://example.com", url: Binding<URL?>) {
        self.title = title
        _url = url
    }

    public var body: some View {
        if #available(iOS 16.0, *) {
            TextField(title, value: $url, format: .url)
                .keyboardType(.URL)
                .textContentType(.URL)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
        } else {
            TextField(title, text: $urlString, onEditingChanged: { _ in
                validField()
            }) {
                validField()
            }
            .keyboardType(.URL)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .fieldHelper(.constant("Invalid URL"), style: $textFieldHelper)
        }
    }

    private func validField() {
        if urlString.isURL {
            url = url
            textFieldHelper = .none
        } else if !urlString.isEmpty {
            textFieldHelper = .errorText
        } else {
            textFieldHelper = .none
        }
    }
}
