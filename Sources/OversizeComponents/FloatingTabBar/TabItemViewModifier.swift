//
// Copyright © 2022 Alexander Romanov
// TabItemViewModifier.swift
//

import SwiftUI

struct TabItemViewModifier: ViewModifier {
    let tabBarItem: TabItem

    func body(content: Content) -> some View {
        content
            .preference(key: TabItemPreferenceKey.self, value: [tabBarItem])
    }
}

public extension View {
    func floatingTabItem(_ label: () -> TabItem) -> some View {
        modifier(TabItemViewModifier(tabBarItem: label()))
    }
}
