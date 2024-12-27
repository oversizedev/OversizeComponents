//
// Copyright © 2023 Alexander Romanov
// AvatarPickerView.swift
//

import OversizeUI
import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

#if os(iOS)
public struct AvatarPickerView: View {
    @Binding private var avatar: UIImage?
    @State var isShowPicker: Bool = false

    public init(avatar: Binding<UIImage?>) {
        _avatar = avatar
    }

    public var body: some View {
        Button {
            isShowPicker.toggle()
        } label: {
            avatarLabel
        }
        .buttonStyle(.scale)
        .sheet(isPresented: $isShowPicker) {
            GellaryPhotoPickerView(selection: $avatar)
        }
    }

    @ViewBuilder
    private var avatarLabel: some View {
        if let avatar {
            Avatar(avatar: Image(uiImage: avatar))
                .controlSize(.large)
        } else {
            ZStack {
                Circle()
                    .fill(Color.surfaceSecondary)
                    .frame(width: Space.xxxLarge.rawValue, height: Space.xxxLarge.rawValue)

                Image.Base.Camera.fill
                    .renderingMode(.template)
                    .resizable()
                    .foregroundColor(Color.onSurfaceSecondary)
                    .frame(width: 48, height: 48)
            }
        }
    }
}

// struct AvatarPickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        AvatarPickerView()
//    }
// }
#endif
