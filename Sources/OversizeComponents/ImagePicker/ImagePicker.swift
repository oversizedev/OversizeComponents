//
// Copyright © 2022 Alexander Romanov
// ImagePicker.swift
//

import SwiftUI
#if canImport(UIKit)
    import UIKit
#endif

#if os(iOS)
    public struct ImagePicker: UIViewControllerRepresentable {
        var sourceType: UIImagePickerController.SourceType = .photoLibrary

        @Binding var selectedImage: UIImage
        @Environment(\.presentationMode) private var presentationMode

        public init(sourceType: UIImagePickerController.SourceType = .camera, selectedImage: Binding<UIImage>) {
            self.sourceType = sourceType
            _selectedImage = selectedImage
        }

        public func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
            let imagePicker: UIImagePickerController = .init()
            imagePicker.allowsEditing = false
            imagePicker.sourceType = sourceType
            imagePicker.delegate = context.coordinator

            return imagePicker
        }

        public func updateUIViewController(_: UIImagePickerController, context _: UIViewControllerRepresentableContext<ImagePicker>) {}

        public func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }

        public final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
            var parent: ImagePicker

            public init(_ parent: ImagePicker) {
                self.parent = parent
            }

            public func imagePickerController(_: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
                if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                    parent.selectedImage = image
                }

                parent.presentationMode.wrappedValue.dismiss()
            }
        }
    }
#endif
