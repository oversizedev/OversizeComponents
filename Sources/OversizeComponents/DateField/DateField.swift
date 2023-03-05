//
// Copyright © 2023 Alexander Romanov
// DateField.swift
//

import OversizeCore
import OversizeUI
import SwiftUI

public struct DateField: View {
    @Environment(\.theme) private var theme: ThemeSettings
    @Binding private var selection: Date
    @Binding private var optionalSelection: Date?
    private let label: String
    @State private var showModal = false

    let isOptionalSelection: Bool

    public init(
        _ sheetTitle: String = "Date",
        selection: Binding<Date>
    ) {
        label = sheetTitle
        _selection = selection
        _optionalSelection = .constant(nil)
        isOptionalSelection = false
    }

    public init(
        _ label: String = "Date",
        selection: Binding<Date?>
    ) {
        self.label = label
        _selection = .constant(Date())
        _optionalSelection = selection
        isOptionalSelection = true
    }

    public var body: some View {
        Button {
            showModal.toggle()
        } label: {
            HStack {
                if isOptionalSelection, let optionalSelection {
                    Text(optionalSelection.formatted(date: .long, time: .shortened))
                } else if isOptionalSelection {
                    Text(label)
                } else {
                    Text(selection.formatted(date: .long, time: .shortened))
                }
                Spacer()
                Icon(.calendar, color: .onSurfaceHighEmphasis)
            }
        }
        .buttonStyle(.field)
        .sheet(isPresented: $showModal) {
            if isOptionalSelection {
                DatePickerSheet(title: label, selection: $optionalSelection)
                    .presentationDetents([.height(500)])
                    .presentationDragIndicator(.hidden)
            } else {
                DatePickerSheet(title: label, selection: $selection)
                    .presentationDetents([.height(500)])
                    .presentationDragIndicator(.hidden)
            }
        }
    }
}
