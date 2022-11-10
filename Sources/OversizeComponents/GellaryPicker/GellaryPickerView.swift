//
// Copyright © 2022 Alexander Romanov
// GellaryPickerView.swift
//

import OversizeCore
import OversizeLocalizable
import OversizeResources
import OversizeUI
import PhotosUI
import SwiftUI

public struct GellaryPickerView: View {
    @Environment(\.dismiss) var dismiss

    @State private var selectedImages: [PHAsset] = .init([])
    @State var gellaryImages: [PHAsset] = .init([])
    @State private var cameraImage: UIImage = .init()

    @State var isShowCamera: Bool = .init(false)

    @Binding var selection: [UIImage]

    @State var isImportingPhotos: Bool = false

    @State var importProgress = 0.0
    @State var importImagesCount = 0.0

    private let threeColumnGrid = [
        GridItem(.flexible(minimum: 40), spacing: 2),
        GridItem(.flexible(minimum: 40), spacing: 2),
        GridItem(.flexible(minimum: 40), spacing: 2),
    ]

    public init(selection: Binding<[UIImage]>) {
        _selection = selection
    }

    public var body: some View {
        PageView("Gallery") {
            content()
                .disabled(isImportingPhotos)
                .opacity(isImportingPhotos ? 0.6 : 1)
                .onAppear {
                    getImages()
                }
        }
        .leadingBar {
            BarButton(type: .close)
        }
        .trailingBar {
            if !selectedImages.isEmpty, !isImportingPhotos {
                BarButton(type: .accent(L10n.Button.add, action: {
                    importPhotos()
                }))
            }
            if isImportingPhotos {
                ProgressView("", value: importProgress, total: importImagesCount)
                    .progressViewStyle(.circular)
            }
        }
        .fullScreenCover(isPresented: $isShowCamera, onDismiss: {
            selection.append(cameraImage)
            dismiss()
        }) {
            ImagePicker(sourceType: .camera, selectedImage: self.$cameraImage)
                .ignoresSafeArea(.all)
        }
    }

    @ViewBuilder
    private func content() -> some View {
        LazyVGrid(columns: threeColumnGrid, alignment: .center, spacing: 2) {
            Button {
                isShowCamera.toggle()
            } label: {
                ZStack {
                    CmeraPreviewVideo()
                    Circle()
                        .fill(.black.opacity(0.2))
                        .frame(width: 48, height: 48)

                    Icon.Solid.DevicesandElectronics.camera
                        .renderingMode(.template)
                        .foregroundColor(.white)
                }
            }
            .buttonStyle(.scale)

            ForEach(gellaryImages, id: \.self) { image in
                let isSelected = selectedImages.contains(image)
                Color.clear
                    .background(
                        Image(uiImage: getAssetThumbnail(asset: image))
                            .resizable()
                            .scaledToFill()
                    )
                    .aspectRatio(1, contentMode: .fill)
                    .clipped()
                    .contentShape(Rectangle())
                    .overlay(alignment: .topTrailing) {
                        ZStack {
                            RoundedRectangle(cornerRadius: Radius.small, style: .continuous)
                                .stroke(Color.white, lineWidth: 2)
                                .frame(width: 24, height: 24)
                                .shadow(radius: 4)
                                .opacity(isSelected ? 0 : 1)

                            RoundedRectangle(cornerRadius: Radius.small, style: .continuous).fill(Color.accent)
                                .frame(width: 24, height: 24)
                                .opacity(isSelected ? 1 : 0)

                            Image(systemName: "checkmark")
                                .font(.caption.weight(.black))
                                .foregroundColor(.onPrimaryHighEmphasis)
                                .opacity(isSelected ? 1 : 0)
                        }
                        .padding(.all, .xxSmall)
                    }
                    .onTapGesture {
                        let isSelected = selectedImages.contains(image)
                        if isSelected {
                            selectedImages.remove(image)
                        } else {
                            selectedImages.append(image)
                        }
                    }
            }
        }
    }

    func importPhotos() {
        isImportingPhotos = true
        let selectedImages: [UIImage] = selectedImages.compactMap { getImageFromAsset(asset: $0) }
        selection += selectedImages
        dismiss()
    }

    func upImportCounter() {
        DispatchQueue.main.async {
            importImagesCount = Double(selectedImages.count)
            importProgress += 1
        }
    }

    func getAssetThumbnail(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFit, options: option, resultHandler: { result, _ in
            thumbnail = result!
        })
        return thumbnail
    }

    func getImageFromAsset(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        option.isNetworkAccessAllowed = true
        option.resizeMode = .none
        manager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .default, options: option, resultHandler: { result, _ in
            thumbnail = result!
        })
        upImportCounter()
        return thumbnail
    }

    func getImages() {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        fetchOptions.fetchLimit = 25000
        let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: fetchOptions)
        assets.enumerateObjects { object, _, _ in
            self.gellaryImages.append(object)
        }
    }
}

struct UnexpectedNilError: Error {}

extension PHImageManager {
    func requestImage(
        for asset: PHAsset,
        targetSize: CGSize,
        contentMode: PHImageContentMode,
        options: PHImageRequestOptions?
    ) async throws -> UIImage {
        options?.isSynchronous = false

        var requestID: PHImageRequestID?

        return try await withTaskCancellationHandler(
            handler: { [requestID] in
                guard let requestID else {
                    return
                }

                cancelImageRequest(requestID)
            }
        ) {
            try await withCheckedThrowingContinuation { continuation in
                requestID = requestImage(
                    for: asset,
                    targetSize: targetSize,
                    contentMode: contentMode,
                    options: options
                ) { image, info in
                    if let error = info?[PHImageErrorKey] as? Error {
                        continuation.resume(throwing: error)
                        return
                    }

                    guard !(info?[PHImageCancelledKey] as? Bool ?? false) else {
                        continuation.resume(throwing: CancellationError())
                        return
                    }

                    // When degraded image is provided, the completion handler will be called again.
                    guard !(info?[PHImageResultIsDegradedKey] as? Bool ?? false) else {
                        return
                    }

                    guard let image else {
                        // This should in theory not happen.
                        continuation.resume(throwing: UnexpectedNilError())
                        return
                    }

                    // According to the docs, the image is guaranteed at this point.
                    continuation.resume(returning: image)
                }
            }
        }
    }
}

struct NewPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        GellaryPickerView(selection: .constant([]))
    }
}
