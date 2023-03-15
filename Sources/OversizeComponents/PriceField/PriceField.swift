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
    @State private var textFieldHelper: FieldHelperStyle = .none
    @State var currency = "USD"

    public init(amount: Binding<Decimal>) {
        _amount = amount
    }

    public var body: some View {
        TextField(
            "Amount",
            value: $amount,
            format: .currency(code: currency)
        )
        .keyboardType(.numberPad)
        .textFieldStyle(.default)
    }
}
