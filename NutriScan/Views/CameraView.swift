//
//  CameraView.swift
//  NutriScan
//
//  Created by Htet Oo Yan on 25/4/25.
//

import SwiftUI
import AVFoundation

struct CameraView: View {
    @StateObject var camera = CameraModel()
    @StateObject var model = ClassificationModel()
    @StateObject var nutritionData = NutritionModel()
    @State var showBottomSheet = false
    @State var currentDataId: String? = nil
    @State var flashIsOn = false
    @State var showLibrary = false
    
    var body: some View {
        ZStack {
            CameraPreview(camera: camera) // display the camera live feed
                .ignoresSafeArea(.all, edges: .all)
                .onAppear{
                    camera.model = model
                    model.nutritionData = nutritionData
                    camera.check()
                    camera.startSession()
                }
                .onDisappear{
                    camera.stopSession()
                }
            VStack {
                HStack {
                    Text("NutriScan") // Display App Title
                        .font(Font.custom("ComicRelief-Regular", size: 32))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(Color("PriColor"))
                        .padding(.horizontal, 20)
                    
                    if camera.isTaken { // ensure that image has been taken and show the retake button to display back the cera live feed
                        Spacer()
                        Button {
                            camera.retake()
                        } label: {
                            Image(systemName: "arrow.triangle.2.circlepath.camera")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color("PriColor"))
                                .clipShape(Circle())
                        }
                        .padding(.trailing, 10)
                    }
                    
                }
                
                Spacer()
                
                HStack{
                    VStack{ // Display library button to use image from library to predict food
                        Button {
                            showLibrary = true
                        } label: {
                            ZStack {
                                Circle()
                                    .fill(Color("PriColor"))
                                    .frame(width: 50, height: 50)
                                
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding()
                    Spacer()
                    
                    VStack{ // Display take Pic button to take new picture to predict food
                        Button {
                            showBottomSheet.toggle()
                            camera.takePic()
                            let generator = UIImpactFeedbackGenerator(style: .heavy)
                            generator.prepare()
                            generator.impactOccurred()
                        } label: {
                            ZStack {
                                Circle()
                                    .fill(Color("PriColor"))
                                    .frame(width: 65, height: 65)
                                Circle()
                                    .stroke(Color("PriColor"), lineWidth: 2)
                                    .frame(width: 75, height: 75)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    VStack{ // Display flash light button to toggle flash light
                        Button {
                            withAnimation {
                                camera.toggleFlashLight(flashIsOn)
                                flashIsOn.toggle()
                            }
                        } label: {
                            ZStack {
                                Circle()
                                    .fill(Color("PriColor"))
                                    .frame(width: 50, height: 50)
                                
                                Image(systemName: flashIsOn ? "bolt.slash.fill": "bolt.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding()
                }
            }
            .padding(.all)
            .sheet(isPresented: $showBottomSheet, onDismiss: { // prediction sheet view will be shown when show button sheet is true
                camera.retake()
                currentDataId = nil
            }) {
                SheetView(results: model, nutritionData: nutritionData, cameraData: camera , currentDataId: $currentDataId)
                    .presentationDetents([.fraction(0.4), .large])
                    .background(Color("ForColor"))
                    .onAppear {
                        if !camera.isTaken {
                            withAnimation {
                                camera.isTaken = true
                            }
                            
                        }
                    }
            }
            .sheet(isPresented: $showLibrary, onDismiss: { // library sheeet will be shown when showLibrary is true
                withAnimation {
                    camera.isTaken = false
                }
            }) {
                ImagePicker(showPrediction: $showBottomSheet, showLibrary: $showLibrary, classificationModel: model)
            }
        }
    }
    
}

