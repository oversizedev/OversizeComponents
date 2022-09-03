//
// Copyright © 2022 Alexander Romanov
// CameraController.swift
//

import AVFoundation
import UIKit

class CameraController: NSObject {
    var captureSession: AVCaptureSession?
    var frontCamera: AVCaptureDevice?
    var frontCameraInput: AVCaptureDeviceInput?
    var previewLayer: AVCaptureVideoPreviewLayer?

    func prepare(completionHandler: @escaping (Error?) -> Void) {
        func createCaptureSession() {
            captureSession = AVCaptureSession()
        }
        func configureCaptureDevices() throws {
            let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .front)

            frontCamera = camera

            try camera?.lockForConfiguration()
            camera?.unlockForConfiguration()
        }
        func configureDeviceInputs() throws {
            guard let captureSession = captureSession else { throw CameraControllerError.captureSessionIsMissing }

            if let frontCamera = frontCamera {
                frontCameraInput = try AVCaptureDeviceInput(device: frontCamera)

                if captureSession.canAddInput(frontCameraInput!) { captureSession.addInput(frontCameraInput!) }
                else { throw CameraControllerError.inputsAreInvalid }
            } else { throw CameraControllerError.noCamerasAvailable }

            captureSession.startRunning()
        }

        DispatchQueue(label: "prepare").async {
            do {
                createCaptureSession()
                try configureCaptureDevices()
                try configureDeviceInputs()
            } catch {
                DispatchQueue.main.async {
                    completionHandler(error)
                }

                return
            }

            DispatchQueue.main.async {
                completionHandler(nil)
            }
        }
    }

    func displayPreview(on view: UIView) throws {
        guard let captureSession = captureSession, captureSession.isRunning else { throw CameraControllerError.captureSessionIsMissing }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer?.connection?.videoOrientation = .portrait

        view.layer.insertSublayer(previewLayer!, at: 0)
        previewLayer?.frame = view.frame
    }
}

enum CameraControllerError: Swift.Error {
    case captureSessionAlreadyRunning
    case captureSessionIsMissing
    case inputsAreInvalid
    case invalidOperation
    case noCamerasAvailable
    case unknown
}
