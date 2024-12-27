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
            16
        } else {
            24
        }
    }

    var folderRadius: CGFloat {
        switch controlSize {
        case .mini:
            4
        case .small:
            6
        case .regular:
            12
        case .large:
            18
        default:
            18
        }
    }

    var folderTopLeftRadius: CGFloat {
        switch controlSize {
        case .mini:
            3
        case .small:
            4
        case .regular:
            8
        case .large:
            14
        default:
            18
        }
    }

    var folderWidth: CGFloat {
        switch controlSize {
        case .mini:
            32
        case .small:
            48
        case .regular:
            86
        case .large:
            164
        default:
            18
        }
    }

    var folderBottomHeight: CGFloat {
        switch controlSize {
        case .mini:
            28
        case .small:
            40
        case .regular:
            72
        case .large:
            138
        default:
            18
        }
    }

    var folderTopHeight: CGFloat {
        switch controlSize {
        case .mini:
            25
        case .small:
            36
        case .regular:
            64
        case .large:
            124
        default:
            18
        }
    }

    var previewImageWidth: CGFloat {
        switch controlSize {
        case .mini:
            28
        case .small:
            42
        case .regular:
            78
        case .large:
            148
        default:
            18
        }
    }

    var previewImageHeight: CGFloat {
        switch controlSize {
        case .mini:
            21
        case .small:
            30
        case .regular:
            56
        case .large:
            108
        default:
            18
        }
    }

    var previewImagePadding: CGFloat {
        switch controlSize {
        case .mini:
            2
        case .small:
            3
        case .regular:
            4
        case .large:
            8
        default:
            18
        }
    }

    var previewRadius: CGFloat {
        switch controlSize {
        case .mini:
            2
        case .small:
            3
        case .regular:
            8
        case .large:
            11
        default:
            18
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
