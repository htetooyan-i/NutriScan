//
//  DatabaseModel.swift
//  NutriScan
//
//  Created by Htet Oo Yan on 3/5/25.
//

import FirebaseFirestore
import FirebaseStorage
import UIKit

public struct DatabaseModel: Codable {
    /*, completion: @escaping (Bool, String) -> Void*/
    
    static func createFoodDataForUser(user: String, collectionName: String, foodDataArray: [String : Any], takenPicData: Data, completion: @escaping (Bool, String?) -> Void) {
        
        let db = Firestore.firestore()
        let foodId = UUID().uuidString
        let docRef = db.collection("users")
            .document(user)
            .collection(collectionName)
            .document(foodId)
        
        let storageRef = Storage.storage().reference()
        let fileRef = storageRef.child("user_food_images/\(foodId).jpg")
        
        // Upload image to Firebase Storage
        fileRef.putData(takenPicData, metadata: nil) { metadata, error in
            if let error = error {
                print("Failed to upload image: \(error)")
                completion(false, nil)
                return
            }
            // Get the download URL
            fileRef.downloadURL { url, error in
                if let error = error {
                    print("Failed to get download URL: \(error)")
                    completion(false, nil)
                    return
                }
                
                guard let imageURL = url?.absoluteString else {
                    print("Image URL is nil")
                    completion(false, nil)
                    return
                }
                
                var foodData = foodDataArray
                foodData["foodId"] = foodId
                foodData["imageURL"] = imageURL // Add image URL to Firestore data
                
                // Save metadata to Firestore
                docRef.setData(foodData) { error in
                    if let error = error {
                        print("Failed to save data: \(error)")
                        completion(false, foodId)
                    } else {
                        print("Data saved successfully with ID: \(foodId)")
                        completion(true, foodId)
                    }
                }
            }
        }
    }
    
    static func getFoodDataForUser(
        user: String,
        collectionName: String,
        queryField: String? = nil,
        queryValue: Any? = nil,
        completion: @escaping ([[String: Any]]) -> Void
    ) {
        let db = Firestore.firestore()
        var foodData: [[String: Any]] = []
        
        var collectionRef: Query = db
            .collection("users")
            .document(user)
            .collection(collectionName)
        
        // Apply filter only if both queryField and queryValue are provided
        if let field = queryField, let value = queryValue {
            collectionRef = collectionRef
                .whereField(field, isGreaterThanOrEqualTo: Timestamp(date: value as! Date))
        }

        collectionRef.getDocuments { snapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in snapshot!.documents {
                    foodData.append(document.data())
                }
            }
            completion(foodData)
        }
    }

    static func updateFoodDataForUser(user: String, collectionName: String, updateId: String, updateArray: [String: Any], completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        print("Update Id: \(updateId)")
        db.collection("users")
            .document(user)
            .collection(collectionName)
            .document(updateId)
            .updateData(updateArray) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                    completion(false)
                } else {
                    completion(true)
                    print("Document successfully updated")
                }
            }
        
    }
    
    static func deleteFoodDataForUser(user: String, collectionName: String, deleteId: String, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(user)
            .collection(collectionName)
            .document(deleteId)
            .delete { error in
                if let error = error {
                    print("Error deleting document: \(error)")
                    completion(false)
                } else {
                    print("Document successfully deleted.")
                    completion(true)
                }
            }
        
    }
    
    static func getFoodThumbnail(foodName: String, completion: @escaping (UIImage?) -> Void) {
        let db = Firestore.firestore()
        
        db.collection("food_thumbnails")
            .document(foodName)
            .getDocument(source: .default) { snapshot, error in
                if let error = error {
                    print("Error during geting data from database: \(error.localizedDescription)")
                }
                
                if let data = snapshot?.data(),
                   let imageUrl = data["url"] as? String,
                   let url = URL(string: imageUrl) {
                    URLSession.shared.dataTask(with: url) { data, response, error in
                        if let data = data, let image = UIImage(data: data) {
                            DispatchQueue.main.async{
                                completion(image)
                            }
                        }else {
                            print("Error downloading image: \(error?.localizedDescription ?? "Unknown error")")
                            DispatchQueue.main.async {
                                completion(nil)
                            }
                        }
                    }.resume()
                } else {
                    print("Error downloading image: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
    }
}
