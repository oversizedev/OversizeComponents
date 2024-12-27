//
// Copyright © 2022 Alexander Romanov
// TabItem.swift
//

import SwiftUI

public struct TabItem: Identifiable, Equatable, Sendable {
    public var id = UUID()
    public var text: String?
    public var icon: Image

    public init(id: UUID = UUID(), text: String? = nil, icon: Image) {
        self.id = id
        self.text = text
        self.icon = icon
    }
}
