//
// Copyright © 2022 Alexander Romanov
// AnyFractionableView.swift
//

import SwiftUI

struct AnyFractionableView: FractionableView {
    static var fractions: Int { 0 }
    private let view: AnyView
    var body: some View { view }
    init<V: View>(_ view: V) { self.view = AnyView(view) }
}
