//
// Copyright © 2022 Alexander Romanov
// AsyncIconNamePicker.swift
//

import OversizeUI
import SDWebImageSwiftUI
import SwiftUI
import OversizeLocalizable

#if os(iOS)
    public struct AsyncIconNamePicker: View {
        @Environment(\.theme) private var theme: ThemeSettings
        @Environment(\.colorScheme) var colorScheme
        @Environment(\.horizontalSizeClass) var horizontalSizeClass

        private let label: String
        private let icons: [String]
        @Binding private var selection: String?
        @State private var showModal = false
        @State private var isSelected = false

        @State private var selectedIndex: Int?

        @State var offset = CGPoint(x: 0, y: 0)

        private var gridPadding: CGFloat {
            guard let sizeClass = horizontalSizeClass else { return 40 }
            switch sizeClass {
            case .compact:
                return 60
            default:
                return 72
            }
        }

        public init(_ label: String,
                    _ icons: [String],
                    selection: Binding<String?>)
        {
            self.label = label
            self.icons = icons
            _selection = selection
        }

        public var body: some View {
            Button {
                self.showModal.toggle()
            } label: {
                HStack(spacing: .xxSmall) {
                    Text(label)
                        .headline()
                        .foregroundColor(.onSurfaceHighEmphasis)
                }
                Spacer()
                if let imageName = selection {
                    AsyncIconView(imageName)
                        .foregroundColor(Color.onSurfaceHighEmphasis)
                }
                OversizeUI.Icon(.chevronDown, color: .onSurfaceHighEmphasis)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: Radius.medium.rawValue,
                                 style: .continuous)
                    .fill(Color.surfaceSecondary)
                    .overlay(
                        RoundedRectangle(cornerRadius: Radius.medium.rawValue,
                                         style: .continuous)
                            .stroke(theme.borderTextFields
                                ? Color.border
                                : Color.surfaceSecondary, lineWidth: CGFloat(theme.borderSize))
                    )
            )
            .sheet(isPresented: $showModal) {
                modal
                    .colorScheme(colorScheme)
            }
        }

        private var modal: some View {
            PageView(label) {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: gridPadding))]) {
                        ForEach(icons.indices, id: \.self) { index in
                            Button(action: {
                                       selectedIndex = index
                                   },
                                   label: {
                                       if index == selectedIndex {
                                           AsyncIconView(icons[index])

                                               .overlay(
                                                   RoundedRectangle(cornerRadius: Radius.medium.rawValue, style: .continuous)
                                                       .strokeBorder(Color.border, lineWidth: 1)
                                                       .frame(width: 48, height: 48, alignment: .center)
                                               )

                                       } else {
                                           AsyncIconView(icons[index])
                                       }
                                   })
                                   .foregroundColor(Color.onSurfaceHighEmphasis)
                                   .padding(.vertical, horizontalSizeClass == .compact ? 12 : 20)
                        }
                    }
                    .padding(.top, .medium)
                    .paddingContent(.horizontal)
                    .paddingContent(.bottom)
                }
            }
            .leadingBar {
                BarButton(type: .close)
            }
            .trailingBar {
                BarButton(type: .secondary(L10n.Button.save, action: {
                    selection = icons[selectedIndex ?? 0]
                    isSelected = true
                    showModal.toggle()
                }))
            }
        }
    }
#endif
