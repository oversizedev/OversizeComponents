//
// Copyright © 2022 Alexander Romanov
// DatePicker.swift
//

import OversizeUI
import SwiftUI

public struct DatePickerSheet: View {
    @Environment(\.screenSize) var screenSize
    @Environment(\.dismiss) var dismiss

    @Binding private var selection: Date
    @State private var date: Date

    private let title: String
    private var minimumDate: Date?

    public init(title: String, date: Binding<Date>) {
        self.title = title
        _selection = date
        _date = State(wrappedValue: date.wrappedValue)
    }

    public var body: some View {
        PageView(title) {
            SectionView {
                VStack {
                    if let minimumDate {
                        DatePicker("", selection: $date, in: minimumDate...)
                            .datePickerStyle(.graphical)
                            .labelsHidden()
                    } else {
                        DatePicker("", selection: $date)
                            .datePickerStyle(.graphical)
                            .labelsHidden()
                    }
                }
                .padding(.horizontal, .small)
                .padding(.vertical, .xxxSmall)
            }
        }
        .backgroundSecondary()
        .leadingBar {
            BarButton(type: .close)
        }
        .trailingBar {
            BarButton(type: .accent("Done", action: {
                selection = date
                dismiss()
            }))
        }
    }

    public func datePickerMinimumDate(_ date: Date) -> DatePickerSheet {
        var control = self
        control.minimumDate = date
        return control
    }
}
