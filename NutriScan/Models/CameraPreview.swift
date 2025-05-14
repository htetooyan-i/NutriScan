//
//  CameraPreview.swift
//  NutriScan
//
//  Created by Htet Oo Yan on 25/4/25.
//

import SwiftUI
import AVFoundation

struct CameraPreview: UIViewRepresentable {
    
    @ObservedObject var camera : CameraModel
    
    func makeUIView(context: Context) -> UIView { // make the camera live feed as a SwiftUI View
        let view = UIView(frame: UIScreen.main.bounds)
        
        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
        camera.preview.frame = view.frame
        camera.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(camera.preview)
        
        DispatchQueue.global(qos: .background).async {
            camera.session.startRunning()
        }
        
        return view
    }
        
    func updateUIView(_ uiView: UIView, context: Context) {
    }
}
