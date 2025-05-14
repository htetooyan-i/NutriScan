//
//  ClassificationModel.swift
//  NutriScan
//
//  Created by Htet Oo Yan on 29/4/25.
//

import Foundation
import SwiftUI
import CoreML
import Vision

class ClassificationModel: ObservableObject {
    @Published var image: UIImage?
    @Published var predictions: [VNClassificationObservation] = []
    @ObservedObject var nutritionData = NutritionModel()
    
    init(image: UIImage? = nil) {
        self.image = image
    }
    
    func predict(){
        guard let image = image else { // check image is available or not
            print("Error while loading image")
            return
        }
        self.predictions = []
        self.nutritionData.nutrientInfo = [:]
        
        guard let ciImage = CIImage(image: image) else { // convert image to ciimage format since most of the models want ciimage as the input
            fatalError("couldn't convert uiimage to CIImage")
        }
        detect(ciImage: ciImage)
    }
    
    func detect(ciImage: CIImage) {
        guard let mlModel = try? FoodClassificationV4(configuration: MLModelConfiguration()), let model = try? VNCoreMLModel(for: mlModel.model)  else { // Check model is available with correct format
            print(#function, "failed to load model")
            return
        }
        
        let request = VNCoreMLRequest(model: model) { request, error in
            if error != nil { // make the request to the model
                print("Error while requesting: \(String(describing: error?.localizedDescription))")
                return
            }
            
            if let results = request.results as? [VNClassificationObservation] {
                DispatchQueue.main.async {
                    
                    self.predictions = Array(results.prefix(6))
                    
                    let identifiers = self.predictions.map { $0.identifier }
                    self.nutritionData.fetchNutritionInfo(for: identifiers)

                }
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: ciImage, orientation: .up) // send image to Vision then model can get image and make prediction
        
        DispatchQueue.global(qos: .userInitiated).async { // make sure request has been prioritized
            do {
                try handler.perform([request])
            } catch {
                print("Error during request: \(error.localizedDescription)")
            }
        }
    }
}
