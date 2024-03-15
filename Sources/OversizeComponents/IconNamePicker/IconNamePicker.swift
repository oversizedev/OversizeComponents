//
// Copyright © 2022 Alexander Romanov
// IconNamePicker.swift
//

import OversizeLocalizable
import OversizeUI
import SwiftUI

#if os(iOS)
    public struct IconNamePicker: View {
        @Environment(\.theme) private var theme: ThemeSettings
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
                showModal.toggle()
            } label: {
                HStack(spacing: .xxSmall) {
                    Text(label)
                        .headline()
                        .foregroundColor(.onSurfaceHighEmphasis)
                }
                Spacer()
                if let imageName = selection {
                    Image(imageName, bundle: .main)
                }
                OversizeUI.IconDeprecated(.chevronDown, color: .onSurfaceHighEmphasis)
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
                                           Group {
                                               Image(icons[index], bundle: .main)
                                                   .resizable()
                                                   .frame(width: 24, height: 24, alignment: .center)
                                           }
                                           .overlay(
                                               RoundedRectangle(cornerRadius: Radius.medium.rawValue, style: .continuous)
                                                   .strokeBorder(Color.border, lineWidth: 1)
                                                   .frame(width: 48, height: 48, alignment: .center)
                                           )

                                       } else {
                                           Image(icons[index], bundle: .main)
                                               .resizable()
                                               .frame(width: 24, height: 24, alignment: .center)
                                       }
                                   })
                                   .padding(.vertical, horizontalSizeClass == .compact ? 12 : 20)
                        }
                    }
                    .padding(.top, .medium)
                    .paddingContent(.horizontal)
                    .paddingContent(.bottom)
                }
            }
            .leadingBar {
                BarButton(.close)
            }
            .trailingBar {
                BarButton(.secondary(L10n.Button.save, action: {
                    selection = icons[selectedIndex ?? 0]
                    isSelected = true
                    showModal.toggle()
                }))
            }
        }
    }
#endif
