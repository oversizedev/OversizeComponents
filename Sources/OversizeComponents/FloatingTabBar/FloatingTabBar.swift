//
// Copyright © 2022 Alexander Romanov
// FloatingTabBar.swift
//

import OversizeUI
import SwiftUI

public struct FloatingTabBar<Content: View>: View {
    @Environment(\.screenSize) var screenSize

    @Binding private var selection: Int

    @Namespace private var tabBarItem

    @State private var tabs: [TabItem] = []

    private let plusAction: (() -> Void)?

    private var content: Content

    public init(selection: Binding<Int>, plusAction: (() -> Void)? = nil, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.plusAction = plusAction
        _selection = selection
    }

    public var body: some View {
        ZStack(alignment: .bottom) {
            content

            HStack(spacing: 30) {
                tabsView
            }
            .padding(.horizontal, 28)
            .padding(.vertical, 14)
            .frame(height: 60)
            .background {
                Capsule()
                    .foregroundColor(Color.surfacePrimary)
            }
            .shadowElevaton(.z2)
            .padding(.bottom, screenSize.safeAreaBottom)
        }
        .ignoresSafeArea()
        .onPreferenceChange(TabItemPreferenceKey.self) { value in
            self.tabs = value
        }
    }

    private var tabsView: some View {
        ForEach(Array(tabs.enumerated()), id: \.offset) { index, element in
            tabItem(tabItem: element, index: index)
        }
    }

    private func tabItem(tabItem: TabItem, index: Int) -> some View {
        Group {
            if plusAction != nil, let number = tabs.count % 2, number == index {
                Group {
                    tabItem.icon

                    Button {
                        plusAction?()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(Color.white)
                            .font(.system(size: 16, weight: .heavy))
                            .background {
                                Circle()
                                    .frame(width: 32, height: 32, alignment: .center)
                            }
                    }
                }

            } else {
                tabItem.icon
            }
        }
        .onTapGesture {
            withAnimation {
                selection = index
            }
        }
    }
}

struct FloatingTabBarExample: View {
    @State var selection = 0

    var body: some View {
        FloatingTabBar(selection: $selection, plusAction: { print("plus") }) {
            Color.gray
                .floatingTabItem {
                    TabItem(icon: Image(systemName: "star"))
                }
                .opacity(selection == 0 ? 1 : 0)

            Color.blue
                .floatingTabItem {
                    TabItem(icon: Image(systemName: "plus"))
                }
                .opacity(selection == 1 ? 1 : 0)
        }
    }
}

struct FloatingTabBar_Previews: PreviewProvider {
    static var previews: some View {
        FloatingTabBarExample()
    }
}
