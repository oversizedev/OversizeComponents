//
// Copyright © 2023 Alexander Romanov
// SorticngPicker.swift
//

import OversizeUI
import SwiftUI

@available(iOS 15.0, macOS 14, tvOS 15.0, watchOS 9.0, *)
public struct SortingPicker<Element, Content>: View
    where
    Content: View,
    Element: Equatable
{
    @Environment(\.theme) private var theme: ThemeSettings
    @Environment(\.dismiss) var dismiss

    public typealias Data = [Element]

    @Binding private var selection: Data.Element
    @Binding private var ascending: Bool
    private let data: Data
    private let label: Text
    private let content: (Data.Element, Bool) -> Content
    @State private var selectedIndex: Data.Index? = 0
    @State private var showModal = false
    @State private var isSelected = false
    private let action: ((Data.Element) -> Void)?

    public init(
        _ label: Text,
        _ data: Data,
        selection: Binding<Data.Element>,
        ascending: Binding<Bool>,
        @ViewBuilder content: @escaping (Data.Element, Bool) -> Content,
        action: ((Data.Element) -> Void)? = nil
    ) {
        self.label = label
        self.data = data
        _ascending = ascending
        self.content = content
        _selection = selection
        self.action = action
    }

    public var body: some View {
        PageView("Sort by") {
            VStack(spacing: .zero) {
                sortView
                ascendingView
            }
            .surfaceContentRowMargins()
        }
        .leadingBar {
            BarButton(.close)
        }
        .backgroundSecondary()
        .disableScrollShadow()
        .onAppear {
            selectedIndex = data.firstIndex(where: { $0 == selection })
        }
    }

    private var sortView: some View {
        SectionView {
            VStack(spacing: .zero) {
                ForEach(data.indices, id: \.self) { index in
                    Button {
                        selectedIndex = index
                        selection = data[index]
                        isSelected = true
                        action?(data[index])
                    } label: {
                        content(data[index], selectedIndex == index)
                    }
                    .buttonStyle(.row)
                }
            }
        }
    }

    private var ascendingView: some View {
        SectionView {
            VStack(spacing: .zero) {
                Radio("Ascending", isOn: ascending == true) {
                    ascending = true
                }

                Radio("Descending", isOn: ascending == false) {
                    ascending = false
                }
            }
        }
    }
}
