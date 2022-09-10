//
// Copyright © 2022 Alexander Romanov
// NativeCursorBody.swift
//

import SwiftUI

public struct NativeCursorBody: View {
    public var body: some View {
        Capsule()
            .foregroundColor(.red)
            .frame(width: UIScreen.main.scale == 3 ? 4 : 5, height: 74)
    }
}

struct CursorBody_Previews: PreviewProvider {
    static var previews: some View {
        NativeCursorBody()
    }
}
