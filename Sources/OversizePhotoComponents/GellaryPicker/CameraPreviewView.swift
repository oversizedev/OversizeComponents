//
// Copyright © 2022 Alexander Romanov
// CameraPreviewView.swift
//

import AVFoundation
import SwiftUI
#if canImport(UIKit)
    import UIKit
#endif

#if os(iOS)
    public class CameraPreviewUIView: UIView {
        private var captureSession: AVCaptureSession?

        public init() {
            super.init(frame: .zero)
            Task {
                guard await requestCameraAccess() else {
                    return
                }
                await configureCaptureSession()
            }
        }

        override public class var layerClass: AnyClass {
            AVCaptureVideoPreviewLayer.self
        }

        @available(*, unavailable)
        required init?(coder _: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        var videoPreviewLayer: AVCaptureVideoPreviewLayer {
            layer as! AVCaptureVideoPreviewLayer
        }

        override public func didMoveToSuperview() {
            super.didMoveToSuperview()

            if superview != nil {
                videoPreviewLayer.session = captureSession
                videoPreviewLayer.videoGravity = .resizeAspectFill
                Task {
                    await startSession()
                }
            } else {
                Task {
                    await stopSession()
                }
            }
        }

        private func requestCameraAccess() async -> Bool {
            await withCheckedContinuation { continuation in
                AVCaptureDevice.requestAccess(for: .video) { allowedAccess in
                    continuation.resume(returning: allowedAccess)
                }
            }
        }

        private func configureCaptureSession() async {
            let session = AVCaptureSession()
            session.beginConfiguration()

            guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .unspecified),
                  let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice),
                  session.canAddInput(videoDeviceInput)
            else {
                return
            }

            session.addInput(videoDeviceInput)
            session.commitConfiguration()
            captureSession = session
        }

        private func startSession() async {
            await MainActor.run {
                captureSession?.startRunning()
            }
        }

        private func stopSession() async {
            await MainActor.run {
                captureSession?.stopRunning()
            }
        }
    }

    public struct CameraPreviewVideo: UIViewRepresentable {
        public init() {}

        public func makeUIView(context _: Context) -> CameraPreviewUIView {
            CameraPreviewUIView()
        }

        public func updateUIView(_: CameraPreviewUIView, context _: Context) {}

        public typealias UIViewType = CameraPreviewUIView
    }

#endif
