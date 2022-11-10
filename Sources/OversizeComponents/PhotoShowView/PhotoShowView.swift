//
// Copyright © 2022 Alexander Romanov
// PhotoShowView.swift
//

import OversizeCore
import OversizeLocalizable
import OversizeResources
import OversizeUI
import SwiftUI

public struct PhotoShowView: ViewModifier {
    @Environment(\.screenSize) var screenSize
    @Environment(\.theme) var theme

    @State var currentScale: CGFloat = 1.0
    @State var previousScale: CGFloat = 1.0

    @State var currentOffset = CGSize.zero
    @State var previousOffset = CGSize.zero

    @State var isShowOptions: Bool = true

    @Binding var selectionIndex: Int
    let photos: [Image]

    @Binding var isShowPhotoDetal: Bool

    let action: () -> Void

    public init(isPresent: Binding<Bool>, selection: Binding<Int>, photos: [Image], action: @escaping () -> Void) {
        _selectionIndex = selection
        self.photos = photos
        _isShowPhotoDetal = isPresent
        self.action = action
    }

    public func body(content: Content) -> some View {
        content
            .overlay {
                ZStack {
                    TabView(selection: $selectionIndex) {
                        ForEach(0 ..< photos.count, id: \.self) { index in
                            photoWithOptions(image: photos[index])
                                .tag(index)
                                .id(index)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .indexViewStyle(.page(backgroundDisplayMode: .never))

                    VStack {
                        ModalNavigationBar(title: "\(selectionIndex + 1) of \(photos.count)",
                                           bigTitle: false,
                                           offset: .constant(CGPoint(x: 0, y: 0)),
                                           modalityPresent: true,
                                           alwaysSlideSmallTile: false,
                                           leadingBar: { BarButton(type: .backAction(action: {
                                               withAnimation {
                                                   isShowPhotoDetal = false
                                               }

                                           })) },
                                           trailingBar: { BarButton(type: .icon(.moreHorizontal, action: action)) })
                            .opacity(isShowOptions ? 1 : 0)
                            .background(.black.opacity(isShowOptions ? 0.1 : 0))
                        Spacer()
                    }
                    .opacity(optionsOpacity)
                }
                .ignoresSafeArea(.all)
                .navigationBarHidden(true)
                .background(.black.opacity(backgroundOpacity))
                .opacity(isShowPhotoDetal ? 1 : 0)
                .statusBar(hidden: isShowPhotoDetal)
                .colorScheme(.dark)
            }
    }

    @ViewBuilder
    func photoWithOptions(image: Image) -> some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .offset(x: currentOffset.width, y: currentOffset.height)
            .scaleEffect(max(currentScale, 0.01)) // the second question
            .gesture(tapGestue.sequenced(before: doubleTapGestue))
            .simultaneousGesture(dragGestue)
            .gesture(magnificationGesture)
        // .vCenter()
    }

    var magnificationGesture: some Gesture {
        MagnificationGesture()
            .onChanged { value in
                let delta = value / self.previousScale
                self.previousScale = value
                self.currentScale = self.currentScale * delta
            }
            .onEnded { value in
                if value < 0.2 {
                    currentScale = 1.0
                    hide()
                } else if value < 1 {
                    withAnimation {
                        currentScale = 1.0
                        currentOffset = CGSize.zero
                    }
                }
                self.previousScale = 1.0
            }
    }

    var doubleTapGestue: some Gesture {
        TapGesture(count: 2)
            .onEnded {
                withAnimation {
                    currentScale = 1.0
                    previousScale = 1.0
                    currentOffset = CGSize.zero
                    previousOffset = CGSize.zero
                }
            }
    }

    var tapGestue: some Gesture {
        TapGesture()
            .onEnded {
                isShowOptions.toggle()
            }
    }

    var dragGestue: some Gesture {
        DragGesture(minimumDistance: currentScale > 1.2 ? 0 : 20, coordinateSpace: .local)
            .onChanged { value in

                let deltaX = value.translation.width - self.previousOffset.width
                let deltaY = value.translation.height - self.previousOffset.height
                self.previousOffset.width = value.translation.width
                self.previousOffset.height = value.translation.height

                let newOffsetWidth = self.currentOffset.width + deltaX / self.currentScale
                // question 1: how to add horizontal constraint (but you need to think about scale)
                if newOffsetWidth <= screenSize.width - 150.0, newOffsetWidth > -150.0, currentScale > 1 {
                    self.currentOffset.width = self.currentOffset.width + deltaX / self.currentScale
                }

                self.currentOffset.height = self.currentOffset.height + deltaY / self.currentScale
            }
            .onEnded { _ in
                self.previousOffset = CGSize.zero
                if currentOffset.height > screenSize.height / 5 ||
                    currentOffset.height < -(screenSize.height / 5)
                {
                    hide()
                } else {
                    if currentScale < 1.2 {
                        withAnimation {
                            currentOffset.height = 0
                        }
                    }
                }
            }
    }

    func hide() {
        withAnimation {
            currentScale = 1.0
            previousScale = 1.0
            currentOffset = CGSize.zero
            previousOffset = CGSize.zero
            isShowPhotoDetal = false
        }
    }

    var backgroundOpacity: CGFloat {
        if isShowPhotoDetal {
            if currentOffset.height == 0 {
                return 1
            } else if currentOffset.height > 0 {
                return 1 / (currentOffset.height * 0.01)
            } else {
                return 1 / (-currentOffset.height * 0.01)
            }
        } else {
            return 0
        }
    }

    var optionsOpacity: CGFloat {
        if isShowPhotoDetal {
            if currentScale > 1.2 {
                return 1
            }

            if currentOffset.height == 0 {
                return 1
            } else if currentOffset.height > 0 {
                return 1 / (currentOffset.height * 0.3)
            } else {
                return 1 / (-currentOffset.height * 0.3)
            }
        } else {
            return 0
        }
    }
}

public extension View {
    func photoOverlay(isPresent: Binding<Bool>, selection: Binding<Int>, photos: [Image], action: @escaping () -> Void) -> some View {
        modifier(PhotoShowView(isPresent: isPresent, selection: selection, photos: photos, action: action))
    }
}

// struct PhotoDetalView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoDetalView()
//    }
// }
