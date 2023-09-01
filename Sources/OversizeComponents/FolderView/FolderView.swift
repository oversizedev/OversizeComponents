//
// Copyright © 2022 Alexander Romanov
// FolderView.swift
//

import OversizeUI
import SwiftUI

#if os(iOS)
    @available(iOS 15.0, *)
    @available(macOS, unavailable)
    @available(watchOS, unavailable)
    @available(tvOS, unavailable)
    public enum FolderViewContentType {
        case photos([Image])
        case icon(Image)
    }

    @available(iOS 15.0, *)
    @available(macOS, unavailable)
    @available(watchOS, unavailable)
    @available(tvOS, unavailable)
    public struct FolderView: View {
        @Environment(\.controlSize) var controlSize
        let color: Color
        var isLocked: Bool = .init(false)
        var contentType: FolderViewContentType?

        public init(color: Color = .accent) {
            self.color = color
        }

        public var body: some View {
            ZStack(alignment: .bottom) {
                FolderShape(folderTopInset: folderBottomHeight - folderTopHeight, radius: folderRadius)
                    .fill(color)
                    .overlay {
                        FolderShape(folderTopInset: folderBottomHeight - folderTopHeight, radius: folderRadius)
                            .fill(Color.black.opacity(0.1))
                    }
                    .frame(width: folderWidth, height: folderBottomHeight)
                    .cornerRadius(folderRadius, corners: .bottomRight)
                    .cornerRadius(folderRadius, corners: .bottomLeft)
                    .cornerRadius(folderTopLeftRadius, corners: .topLeft)

                Rectangle()
                    .fill(color)
                    .cornerRadius(folderRadius, corners: .topRight)
                    .cornerRadius(folderRadius, corners: .bottomRight)
                    .cornerRadius(folderRadius, corners: .bottomLeft)
                    .frame(width: folderWidth, height: folderTopHeight)

                folderContent
            }
        }

        private var folderContent: some View {
            Group {
                if isLocked {
                    ZStack {
                        if controlSize == .large {
                            Circle()
                                .fill(Color.black.opacity(0.2))
                                .frame(width: 54, height: 54)
                        }
                        Image.Base.lock
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: iconSize, height: iconSize)
                            .foregroundColor(Color.white)
                    }
                    .frame(width: previewImageWidth, height: previewImageHeight)
                    .padding(.bottom, previewImagePadding)
                } else {
                    switch contentType {
                    case let .photos(images):
                        if let image = images.first {
                            image
                                .frame(width: previewImageWidth, height: previewImageHeight)
                                .padding(.bottom, previewImagePadding)
                        }
                    case let .icon(icon):
                        VStack {
                            icon
                                .renderingMode(.template)
                                .foregroundColor(.black.opacity(0.5))
                        }
                        .frame(width: previewImageWidth, height: previewImageHeight)
                        .padding(.bottom, previewImagePadding)
                    default:
                        EmptyView()
                    }
                }
            }
        }
    }

    // MARK: - Folder midificators

    @available(iOS 15.0, *)
    @available(macOS, unavailable)
    @available(watchOS, unavailable)
    @available(tvOS, unavailable)
    public extension FolderView {
        func lock(_ lock: Bool = true) -> FolderView {
            var control = self
            control.isLocked = lock
            return control
        }

        func folderContent(_ type: FolderViewContentType) -> FolderView {
            var control = self
            control.contentType = type
            return control
        }
    }

    // MARK: - Folder sizes

    @available(iOS 15.0, *)
    @available(macOS, unavailable)
    @available(watchOS, unavailable)
    @available(tvOS, unavailable)
    extension FolderView {
        var iconSize: CGFloat {
            if controlSize == .mini {
                return 16
            } else {
                return 24
            }
        }

        var folderRadius: CGFloat {
            switch controlSize {
            case .mini:
                return 4
            case .small:
                return 6
            case .regular:
                return 12
            case .large:
                return 18
            default:
                return 18
            }
        }

        var folderTopLeftRadius: CGFloat {
            switch controlSize {
            case .mini:
                return 3
            case .small:
                return 4
            case .regular:
                return 8
            case .large:
                return 14
            default:
                return 18
            }
        }

        var folderWidth: CGFloat {
            switch controlSize {
            case .mini:
                return 32
            case .small:
                return 48
            case .regular:
                return 86
            case .large:
                return 164
            default:
                return 18
            }
        }

        var folderBottomHeight: CGFloat {
            switch controlSize {
            case .mini:
                return 28
            case .small:
                return 40
            case .regular:
                return 72
            case .large:
                return 138
            default:
                return 18
            }
        }

        var folderTopHeight: CGFloat {
            switch controlSize {
            case .mini:
                return 25
            case .small:
                return 36
            case .regular:
                return 64
            case .large:
                return 124
            default:
                return 18
            }
        }

        var previewImageWidth: CGFloat {
            switch controlSize {
            case .mini:
                return 28
            case .small:
                return 42
            case .regular:
                return 78
            case .large:
                return 148
            default:
                return 18
            }
        }

        var previewImageHeight: CGFloat {
            switch controlSize {
            case .mini:
                return 21
            case .small:
                return 30
            case .regular:
                return 56
            case .large:
                return 108
            default:
                return 18
            }
        }

        var previewImagePadding: CGFloat {
            switch controlSize {
            case .mini:
                return 2
            case .small:
                return 3
            case .regular:
                return 4
            case .large:
                return 8
            default:
                return 18
            }
        }

        var previewRadius: CGFloat {
            switch controlSize {
            case .mini:
                return 2
            case .small:
                return 3
            case .regular:
                return 8
            case .large:
                return 11
            default:
                return 18
            }
        }
    }

    @available(iOS 15.0, *)
    @available(macOS, unavailable)
    @available(watchOS, unavailable)
    @available(tvOS, unavailable)
    struct FolderView_Previews: PreviewProvider {
        static var previews: some View {
            Group {
                VStack(spacing: .large) {
                    FolderView()
                        .controlSize(.large)

                    FolderView()
                        .controlSize(.regular)

                    FolderView()
                        .controlSize(.small)

                    FolderView()
                        .controlSize(.mini)
                }

                VStack(spacing: .large) {
                    FolderView()
                        .lock()
                        .controlSize(.large)

                    FolderView()
                        .lock()
                        .controlSize(.regular)

                    FolderView()
                        .lock()
                        .controlSize(.small)

                    FolderView()
                        .lock()
                        .controlSize(.mini)
                }
            }
            .padding(.large)
            .previewLayout(.sizeThatFits)
        }
    }
#endif
