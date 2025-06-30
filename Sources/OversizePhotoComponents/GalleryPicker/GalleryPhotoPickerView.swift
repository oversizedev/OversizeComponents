//
// Copyright © 2023 Alexander Romanov
// GalleryPhotoPickerView.swift
//

import OversizeComponents
import OversizeCore
import OversizeLocalizable
import OversizeUI
import PhotosUI
import SwiftUI

#if os(iOS)
public struct GalleryPhotoPickerView: View {
    @Environment(\.dismiss) var dismiss

    @State var galleryImages: [PHAsset] = .init([])
    @State private var cameraImage: UIImage = .init()

    @State var isShowCamera: Bool = .init(false)

    @Binding var selection: UIImage?
    @Binding var selectionDate: Date?

    @State var isImportingPhotos: Bool = false

    @State var importProgress = 0.0

    private let threeColumnGrid = [
        GridItem(.flexible(minimum: 40), spacing: 2),
        GridItem(.flexible(minimum: 40), spacing: 2),
        GridItem(.flexible(minimum: 40), spacing: 2),
    ]

    public init(selection: Binding<UIImage?>, date: Binding<Date?> = .constant(nil)) {
        _selection = selection
        _selectionDate = date
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
            BarButton(.close)
        }
        .fullScreenCover(isPresented: $isShowCamera, onDismiss: {
            selection = cameraImage
            dismiss()
        }) {
            ImagePicker(sourceType: .camera, selectedImage: $cameraImage)
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
                    CameraPreviewVideo()
                    Circle()
                        .fill(.black.opacity(0.2))
                        .frame(width: 48, height: 48)

                    Image.Base.Camera.fill
                        .renderingMode(.template)
                        .foregroundColor(.white)
                }
                .frame(minHeight: galleryImages.count > 0 ? nil : 200)
            }
            .buttonStyle(.scale)

            ForEach(galleryImages, id: \.self) { image in
                Color.clear
                    .background(
                        Image(uiImage: getThumbnailFromAsset(asset: image))
                            .resizable()
                            .scaledToFill(),
                    )
                    .aspectRatio(1, contentMode: .fill)
                    .clipped()
                    .contentShape(Rectangle())
                    .overlay {
                        if isImportingPhotos {
                            ProgressView()
                        }
                    }
                    .onTapGesture {
                        Task {
                            await importPhoto(image)
                        }
                    }
            }
        }
    }

    @MainActor
    func importPhoto(_ asset: PHAsset) async {
        isImportingPhotos = true
        let selectedUiImage: UIImage = getFullImageFromAsset(asset: asset)
        let selectedImagesDate: Date = asset.creationDate ?? Date()
        selection = selectedUiImage
        selectionDate = selectedImagesDate
        dismiss()
    }

    func incrementImportCounter() {
        importProgress += 1
    }

    func getThumbnailFromAsset(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option: PHImageRequestOptions = .init()
        var thumbnail = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFit, options: option, resultHandler: { result, _ in
            thumbnail = result!
        })
        return thumbnail
    }

    func getFullImageFromAsset(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option: PHImageRequestOptions = .init()
        var thumbnail = UIImage()
        option.isSynchronous = true
        option.isNetworkAccessAllowed = true
        option.resizeMode = .none
        manager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .default, options: option, resultHandler: { result, _ in
            thumbnail = result!
        })
        incrementImportCounter()
        return thumbnail
    }

    func getImages() {
        let fetchOptions: PHFetchOptions = .init()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        fetchOptions.fetchLimit = 25000
        let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: fetchOptions)
        assets.enumerateObjects { object, _, _ in
            galleryImages.append(object)
        }
    }
}

// struct NewPhotoView_Previews: PreviewProvider {
//    static var previews: some View {
//        GalleryPickerView(selection: .constant([]))
//    }
// }
#endif
