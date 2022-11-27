//
// Copyright © 2022 Alexander Romanov
// CameraPreviewView.swift
//

import AVFoundation
import SwiftUI
import UIKit

class CameraPreviewUIView: UIView {
    private var captureSession: AVCaptureSession?

    init() {
        super.init(frame: .zero)

        var allowedAccess = false
        let blocker: DispatchGroup = .init()
        blocker.enter()
        AVCaptureDevice.requestAccess(for: .video) { flag in
            allowedAccess = flag
            blocker.leave()
        }
        blocker.wait()

        if !allowedAccess {
            print("!!! NO ACCESS TO CAMERA")
            return
        }

        // setup session
        let session: AVCaptureSession = .init()
        session.beginConfiguration()

        let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                  for: .video, position: .unspecified) // alternate AVCaptureDevice.default(for: .video)
        guard videoDevice != nil, let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice!), session.canAddInput(videoDeviceInput) else {
            print("!!! NO CAMERA DETECTED")
            return
        }
        session.addInput(videoDeviceInput)
        session.commitConfiguration()
        captureSession = session
    }

    override class var layerClass: AnyClass {
        AVCaptureVideoPreviewLayer.self
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        layer as! AVCaptureVideoPreviewLayer
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        if superview != nil {
            videoPreviewLayer.session = captureSession
            videoPreviewLayer.videoGravity = .resizeAspectFill
            captureSession?.startRunning()
        } else {
            captureSession?.stopRunning()
        }
    }
}

struct CmeraPreviewVideo: UIViewRepresentable {
    public init() {}

    func makeUIView(context _: UIViewRepresentableContext<CmeraPreviewVideo>) -> CameraPreviewUIView {
        CameraPreviewUIView()
    }

    func updateUIView(_: CameraPreviewUIView, context _: UIViewRepresentableContext<CmeraPreviewVideo>) {}

    typealias UIViewType = CameraPreviewUIView
}

struct DemoVideoStreaming: View {
    var body: some View {
        VStack {
            CmeraPreviewVideo()
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
    }
}
