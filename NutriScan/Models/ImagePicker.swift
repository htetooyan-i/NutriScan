//
//  ImagePicker.swift
//  NutriScan
//
//  Created by Htet Oo Yan on 7/5/25.
//

import Foundation
import UIKit
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var showPrediction: Bool
    @Binding var showLibrary: Bool
    var classificationModel: ClassificationModel
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}


class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var parent: ImagePicker
    
    init(_ parent: ImagePicker) {
        self.parent = parent
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.parent.showLibrary.toggle()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            DispatchQueue.main.async {
                self.parent.showLibrary.toggle()
                self.parent.showPrediction.toggle()
                self.parent.classificationModel.image = image
                self.parent.classificationModel.predict()
                
            }
        }
    }
}
