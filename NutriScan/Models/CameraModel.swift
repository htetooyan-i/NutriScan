//
//  CameraModel.swift
//  NutriScan
//
//  Created by Htet Oo Yan on 25/4/25.
//

import Foundation
import AVFoundation
import SwiftUI

class CameraModel: NSObject,ObservableObject, AVCapturePhotoCaptureDelegate {
    @Published var isTaken: Bool = false
    @Published var session = AVCaptureSession()
    @Published var alert: Bool = false
    @Published var output = AVCapturePhotoOutput()
    @Published var preview = AVCaptureVideoPreviewLayer()
    @Published var picData = Data(count: 0)
    @Published var isCapturing = false
    @ObservedObject var model = ClassificationModel()
    
    @AppStorage("photoSaving") var photoSaving: Bool?
    
    // MARK: - Check & Setup Camera View
    
    func check() { // IDEA: Check device camera is available and have permission to take video
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setup()
            return
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    self.setup()
                }
            }
        case .denied:
            self.alert.toggle()
            return
        default:
            return
        }
    }
    
    func setup() {
        self.session.beginConfiguration()
        
        var input: AVCaptureDeviceInput? = nil

        // Try to get the dual camera device first
        if let device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back) {
            do {
                input = try AVCaptureDeviceInput(device: device)
                print("Dual Camera")
            } catch {
                print("Error creating device input from dual camera: \(error)")
            }
        } else if let fallbackDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
            // Fallback to wide angle camera
            do {
                input = try AVCaptureDeviceInput(device: fallbackDevice)
                print("builtInWideAngleCamera")
            } catch {
                print("Error creating device input from wide angle camera: \(error)")
            }
        } else {
            print("No suitable camera found.")
        }
        
        // Add input if available and session allows
        if let input = input, self.session.canAddInput(input) {
            self.session.addInput(input)
        } else {
            print("Cannot add input to session.")
        }
        
        // Add output if possible
        if self.session.canAddOutput(self.output) {
            self.session.addOutput(self.output)
        } else {
            print("Cannot add output to session.")
        }
        
        self.session.commitConfiguration()
    }

    
    // MARK: - Save Output Image
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        /**
         * *IDEA:* When use capture the photo this function will run and check there is error while processing. If there is no error it call the [SavePic] func to save to library and asset to picData to store in database and save in library.
         */
        if let error = error {
            print("Error: \(error.localizedDescription)")
            return
        }
        
        guard let imageData = photo.fileDataRepresentation() else {
            print("No image data representation.")
            return
        }
        
        self.picData = imageData
        
        if let photoSaving = photoSaving, photoSaving {
            self.savePic()
        }else{
            print("Not Saved")
        }
        
        if self.picData.count > 0, let image = UIImage(data: self.picData) {
            self.model.image = image
            self.model.predict()
        }
        
    }
    
    func savePic() {
        /**
         * *IDEA:* When photoOutput has run, it will call this function to save taken picture to library using picData. Then it will pass saved image to to prediction model and also call the prediction function to predict food
         */
        print("picData size: \(self.picData.count) bytes")
        
        if self.picData.count > 0, let image = UIImage(data: self.picData) {
            DispatchQueue.main.async {
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            }
            print("Saved to Photos")
        } else {
            print("Failed to create image from picData. Data is empty or invalid.")
        }
        
        
    }
    
    // MARK: - Take Picture
    
    func takePic() {
        /**
         * *IDEA:* When user click the take picture button this function will run and capture photot and set isTaken to true which means sheetView will pop up and show the preidction.
         */
        if isCapturing{
            return
        }
        
        isCapturing = true
        DispatchQueue.global(qos: .background).async {
            print("Taking picture...")
            if self.output.connection(with: .video) != nil{
                self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
            }

            DispatchQueue.main.async {
                withAnimation {
                    self.isTaken = true
                }
            }
        }
        
        isCapturing = false
    }
    
    // MARK: - Retake Picture
    
    func retake() {
        /**
         * *IDEA:* This Function will run when user click the retake button or swipe down the sheetView. It will toggle the isTaken variable to false and turn back to camera rolling
         */
        DispatchQueue.global(qos: .background).async {
            self.session.startRunning()
            
            DispatchQueue.main.async {
                self.isTaken = false
            }
        }
    }
    
    func toggleFlashLight(_ isOn: Bool) {
        /**
         * - Parameter isOn: This recieve the current stage of the flash light
         * *IDEA:* This Function will run when user click the flash light button and ensure that device has flash light. Then toogle the flash light stage.
         */
        guard let device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back),
              device.hasTorch else {
            print("Torch not available")
            return
        }
        
        do {
            try device.lockForConfiguration()
            
            if !isOn {
                try device.setTorchModeOn(level: 1.0)
            } else {
                device.torchMode = .off
            }
            device.unlockForConfiguration()
        } catch {
            print("Flashlight error: \(error.localizedDescription)")
        }
    }
    
    
    func startSession() { // use to start displaying live feed
        if !self.session.isRunning {
            DispatchQueue.global(qos: .background).async{
                self.session.startRunning()
            }
        }
    }
    
    func stopSession() {
        if self.session.isRunning { // use to stop displaying live feed
            DispatchQueue.global(qos: .background).async {
                self.session.stopRunning()
            }
        }
    }
    
    
    
    
    
}
