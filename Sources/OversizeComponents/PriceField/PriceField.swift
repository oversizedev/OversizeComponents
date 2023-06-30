//
// Copyright © 2023 Alexander Romanov
// PriceField.swift
//

import Foundation
import OversizeCore
import OversizeUI
import SwiftUI

public struct PriceField: View {
    @Binding private var amount: Decimal
    private let currency = "USD"

    public init(amount: Binding<Decimal>) {
        _amount = amount
    }

    public var body: some View {
        #if os(iOS)
        TextField(
            "0",
            value: $amount,
            format: .currency(code: currency)
        )
        .keyboardType(.decimalPad)
        .textFieldStyle(.default)
        #else
        TextField(
            "0",
            value: $amount,
            format: .currency(code: currency)
        )
        .textFieldStyle(.default)
        #endif
    }
}
