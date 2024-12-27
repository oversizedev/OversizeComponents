//
// Copyright © 2022 Alexander Romanov
// TabItemPreferenceKey.swift
//

import SwiftUI

struct TabItemPreferenceKey: PreferenceKey, Sendable {
    static var defaultValue: [TabItem] {
        []
    }

    static func reduce(value: inout [TabItem], nextValue: () -> [TabItem]) {
        value += nextValue()
    }
}
