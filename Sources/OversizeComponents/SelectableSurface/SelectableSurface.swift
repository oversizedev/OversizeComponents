//
// Copyright © 2023 Alexander Romanov
// SelectableSurface.swift
//

import OversizeUI
import SwiftUI

public struct SelectableSurface<SelectedContnet: View, UnselectedContnet: View>: View {
    private let selectedContnet: SelectedContnet
    private let unselectedContnet: UnselectedContnet

    @Binding var isSelected: Bool

    public init(
        isSelected: Binding<Bool>,
        @ViewBuilder selectedContnet: () -> SelectedContnet,
        @ViewBuilder unselectedContnet: () -> UnselectedContnet
    ) {
        self.selectedContnet = selectedContnet()
        self.unselectedContnet = unselectedContnet()
        _isSelected = isSelected
    }

    public var body: some View {
        Surface {
            Group {
                if isSelected {
                    selectedContnet
                } else {
                    unselectedContnet
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                isSelected.toggle()
                            }
                        }
                }
            }
        }
        .elevation(.z2)
        .surfaceRadius(.xLarge)
        .padding(.horizontal, isSelected ? .zero : .xxSmall)
        .surfaceContentMargins(.zero)
    }
}
