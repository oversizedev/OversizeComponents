//
// Copyright © 2022 Alexander Romanov
// CardViewLight.swift
//

//
//  File.swift
//
//
//  Created by alexander on 05.02.2022.
//
import SwiftUI

// swiftlint:disable all
public struct CardLightView: View {
    public init() {}

    public var body: some View {
        LinearGradient(gradient: Gradient(colors: [.white, Color.black.opacity(0)]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .blendMode(.overlay)
    }
}
