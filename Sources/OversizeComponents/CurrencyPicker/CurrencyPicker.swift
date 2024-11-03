//
// Copyright © 2023 Alexander Romanov
// CurrencyPicker.swift, created on 14.07.2023
//

import OversizeCore
import OversizeUI
import SwiftUI

@available(macOS 14, iOS 16, tvOS 16, watchOS 9, *)
public struct CurrencyPicker: View {
    @Environment(\.theme) private var theme: ThemeSettings
    @Binding private var selection: Locale.Currency
    private let label: String
    private let currencies: [Locale.Currency]
    @State private var showModal = false

    public init(
        _ sheetTitle: String = "Currency",
        currencies: [Locale.Currency] = Locale.Currency.countryCurrencies,
        selection: Binding<Locale.Currency>
    ) {
        label = sheetTitle
        _selection = selection
        self.currencies = currencies
    }

    public var body: some View {
        Select(label, currencies, selection: $selection) { element, _ in
            Row(element.dispalyName ?? element.identifier) {
                ZStack {
                    RoundedRectangle(cornerRadius: .small, style: .continuous)
                        .fill(Color.surfaceSecondary)
                        .frame(width: 52, height: 36)
                    Text(element.dispalySymbol ?? element.identifier)
                }
            }
        } selectionView: { element in
            Text(element.dispalyName ?? label)
        }
    }
}

@available(macOS 14, iOS 16, tvOS 16, watchOS 9, *)
struct CurrencyPicker_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyPicker(selection: .constant("USD"))
    }
}
