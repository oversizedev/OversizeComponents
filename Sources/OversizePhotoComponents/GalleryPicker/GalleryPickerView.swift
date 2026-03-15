//
// Copyright © 2022 Alexander Romanov
// GalleryPickerView.swift
//

import OversizeComponents
import OversizeLocalizable
import OversizeUI
import PhotosUI
import SwiftUI

#if os(iOS)
@available(*, deprecated, renamed: "GalleryPickerView")
public typealias GellaryPickerView = GalleryPickerView

public struct GalleryPickerView: View {
    @Environment(\.dismiss) var dismiss

    @State private var selectedImages: [PHAsset] = .init([])
    @State var galleryImages: [PHAsset] = .init([])
    @State private var cameraImage: UIImage = .init()

    @State var isShowCamera: Bool = .init(false)

    @Binding var selection: [UIImage]
    @Binding var selectionDate: [Date]

    @State var isImportingPhotos: Bool = false

    @State var importProgress = 0.0
    @State var importImagesCount = 0.0
    
    
    private var isCameraHidden: Bool = false

    private let threeColumnGrid = [
        GridItem(.flexible(minimum: 40), spacing: 2),
        GridItem(.flexible(minimum: 40), spacing: 2),
        GridItem(.flexible(minimum: 40), spacing: 2),
    ]

    public init(selection: Binding<[UIImage]>, selectionDate: Binding<[Date]>, preselected: [PHAsset] = []) {
        _selection = selection
        _selectionDate = selectionDate
        _selectedImages = State(initialValue: preselected)
    }

    public var body: some View {
            ScrollView {
                content
                    .disabled(isImportingPhotos)
                    .opacity(isImportingPhotos ? 0.6 : 1)
                    .onAppear {
                        getImages()
                    }
            }
            .navigationTitle("Gallery")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close", systemImage: "xmark", role: .cancel) { dismiss() }
                        .labelStyle(.toolbar)
                        .buttonStyle(.toolbarSecondary)
                }
                ToolbarItem(placement: .primaryAction) {
                    if !selectedImages.isEmpty, !isImportingPhotos {
                        Button(L10n.Button.add, systemImage: "checkmark") {
                            Task {
                                let result = await importPhotos()
                                selection += result.0
                                selectionDate += result.1
                                dismiss()
                            }
                        }
                        .labelStyle(.toolbar)
                        .buttonStyle(.toolbarPrimary)
                    }
                    if isImportingPhotos {
                        ProgressView()
                    }
                }
            }
        
        .fullScreenCover(isPresented: $isShowCamera, onDismiss: {
            selection.append(cameraImage)
            selectionDate.append(Date())
            dismiss()
        }) {
            ImagePicker(sourceType: .camera, selectedImage: $cameraImage)
                .ignoresSafeArea(.all)
        }
    }


    private var content: some View {
        LazyVGrid(columns: threeColumnGrid, alignment: .center, spacing: 2) {
            if !isCameraHidden {
                Button {
                    isShowCamera.toggle()
                } label: {
                    ZStack {
                        CameraPreviewVideo()
                        Circle()
                            .fill(.black.opacity(0.2))
                            .frame(width: 48, height: 48)

                        Image.Base.camera
                            .renderingMode(.template)
                            .foregroundColor(.white)
                    }
                    .frame(minHeight: galleryImages.count > 0 ? nil : 200)
                }
                .buttonStyle(.scale)
            }

            ForEach(galleryImages, id: \.self) { image in
                let isSelected = selectedImages.contains(image)
                Color.clear
                    .background(
                        Image(uiImage: getThumbnailFromAsset(asset: image))
                            .resizable()
                            .scaledToFill(),
                    )
                    .aspectRatio(1, contentMode: .fill)
                    .clipped()
                    .contentShape(Rectangle())
                    .overlay(alignment: .topTrailing) {
                        ZStack {
                            RoundedRectangle(cornerRadius: .xxSmall, style: .continuous)
                                .stroke(Color.white, lineWidth: 2)
                                .frame(width: 24, height: 24)
                                .shadow(radius: 4)
                                .opacity(isSelected ? 0 : 1)

                            RoundedRectangle(cornerRadius: .xxSmall, style: .continuous).fill(Color.accent)
                                .frame(width: 24, height: 24)
                                .opacity(isSelected ? 1 : 0)

                            Image(systemName: "checkmark")
                                .font(.caption.weight(.black))
                                .foregroundColor(.onPrimary)
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

    func importPhotos() async -> ([UIImage], [Date]) {
        isImportingPhotos = true
        let selectedUiImages: [UIImage] = selectedImages.compactMap { getFullImageFromAsset(asset: $0) }
        let selectedImagesDates: [Date] = selectedImages.compactMap { $0.creationDate }
        return (selectedUiImages, selectedImagesDates)
    }

    func incrementImportCounter() {
        importImagesCount = Double(selectedImages.count)
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
        Task {
            let status = await PHPhotoLibrary.requestAuthorization(for: .readWrite)
            guard status == .authorized || status == .limited else { return }
            let fetchOptions = PHFetchOptions()
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            fetchOptions.fetchLimit = 25000
            let assets = PHAsset.fetchAssets(with: .image, options: fetchOptions)
            var images: [PHAsset] = []
            assets.enumerateObjects { object, _, _ in
                images.append(object)
            }
            await MainActor.run {
                galleryImages = images
            }
        }
    }

    // MARK: - Deprecated method wrappers

    @available(*, deprecated, renamed: "incrementImportCounter")
    func upImportCounter() {
        incrementImportCounter()
    }

    @available(*, deprecated, renamed: "getThumbnailFromAsset")
    func getAssetThumbnail(asset: PHAsset) -> UIImage {
        getThumbnailFromAsset(asset: asset)
    }

    @available(*, deprecated, renamed: "getFullImageFromAsset")
    func getImageFromAsset(asset: PHAsset) -> UIImage {
        getFullImageFromAsset(asset: asset)
    }
}

@available(iOS 16.0, *)
#Preview {
    NavigationStack {
        GalleryPickerView(selection: .constant([]), selectionDate: .constant([]))
    }
}

// MARK: - Modifiers

public extension GalleryPickerView {
    func hideCamera(_ hidden: Bool = true) -> Self {
        var view = self
        view.isCameraHidden = hidden
        return view
    }
}
#endif
