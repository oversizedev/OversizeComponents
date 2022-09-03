//
// Copyright © 2022 Alexander Romanov
// CameraViewController.swift
//

import SwiftUI
import UIKit

final class CameraViewController: UIViewController {
    let cameraController = CameraController()
    var previewView: UIView!

    override func viewDidLoad() {
        previewView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        previewView.contentMode = UIView.ContentMode.scaleAspectFit
        view.addSubview(previewView)

        cameraController.prepare { error in
            if let error = error {
                print(error)
            }

            try? self.cameraController.displayPreview(on: self.previewView)
        }
    }
}

extension CameraViewController: UIViewControllerRepresentable {
    public typealias UIViewControllerType = CameraViewController

    public func makeUIViewController(context _: UIViewControllerRepresentableContext<CameraViewController>) -> CameraViewController {
        CameraViewController()
    }

    public func updateUIViewController(_: CameraViewController, context _: UIViewControllerRepresentableContext<CameraViewController>) {}
}
