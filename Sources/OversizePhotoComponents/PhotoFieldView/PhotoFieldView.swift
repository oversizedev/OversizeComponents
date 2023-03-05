//
// Copyright © 2023 Alexander Romanov
// PhotoFieldView.swift
//

import OversizeLocalizable
import OversizeResources
import OversizeUI
import SwiftUI

public struct PhotoFieldView: View {
    @Binding var selection: [UIImage]
    @Binding var selectionDate: [Date]
    @State var isShowSelector: Bool = false

    public init(_ selection: Binding<[UIImage]>, selectionDate: Binding<[Date]>) {
        _selection = selection
        _selectionDate = selectionDate
    }

    public var body: some View {
        field
            .animation(.default, value: selection)
            .sheet(isPresented: $isShowSelector) {
                GellaryPickerView(selection: $selection, selectionDate: $selectionDate)
            }
    }

    @ViewBuilder
    var field: some View {
        if selection.isEmpty {
            Button {
                isShowSelector.toggle()
            } label: {
                HStack {
                    Text("Add photo")

                    Spacer()

                    Icon(.camera)
                }
            }
            .buttonStyle(.field)
        } else {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: .xSmall) {
                    addPhotoSurface

                    ForEach(selection, id: \.self) { photo in
                        Image(uiImage: photo)
                            .resizable()
                            .scaledToFill()

                            .frame(width: 128, height: 128)
                            .overlay(alignment: .topTrailing) {
                                Button {
                                    if let index = selection.firstIndex(of: photo) {
                                        selection.remove(at: index)
                                        selectionDate.remove(at: index)
                                    }

                                } label: {
                                    Icon(.xMini)
                                        .iconColor(.white)
                                        .padding(.xxxSmall)
                                        .background {
                                            Circle()
                                                .fill(.thinMaterial)
                                        }
                                        .padding(.xxSmall)
                                }
                                .buttonStyle(.scale)
                            }
                            .cornerRadius(.medium)
                    }
                }
            }
        }
    }

    var addPhotoSurface: some View {
        Surface {
            isShowSelector.toggle()
        } label: {
            VStack(spacing: .xSmall) {
                Circle()
                    .fill(Color.surfacePrimary)
                    .frame(width: 48, height: 48)
                    .shadowElevaton(.z1)
                    .overlay {
                        Icon(.plus, color: .onSurfaceHighEmphasis)
                            .shadowElevaton(.z1)
                    }
                Text(L10n.Button.add)
                    .headline(.semibold)
                    .onSurfaceHighEmphasisForegroundColor()
            }
            .frame(width: 104)
        }
        .surfaceBackgroundColor(.surfacePrimary)
        .surfaceBorderColor(.surfaceSecondary)
        .surfaceBorderWidth(2)
        .surfaceContentInsets(EdgeSpaceInsets(top: .medium, leading: .xxSmall, bottom: .medium, trailing: .xxSmall))
    }
}

struct PhotoFieldView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoFieldView(.constant([]), selectionDate: .constant([]))
            .previewComponent()
    }
}
