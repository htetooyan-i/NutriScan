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
    
    static func createUserInfo(user: String, collectionName: String, docName: String, data: [String: Any], completion: @escaping (Bool)->Void) {
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(user)
            .collection(collectionName)
            .document(docName)
            .setData(data) { err in
                if let err = err {
                    print("Error setting document: \(err)")
                    completion(false)
                } else {
                    print("Document set successfully!")
                    completion(true)
                }
            }
    }
    
    static func deleteUser(user:String, completion: @escaping (Bool) -> Void) {
        
        let userId = user
        let db = Firestore.firestore()
        let userDocRef = db.collection("users").document(userId)
        
        // 1. Delete subcollections first (example for 'foods' and 'userInfo')
        // Note: You must delete every subcollection you have
        
        deleteCollection(collectionRef: userDocRef.collection("foods")) { successFoods in
            guard successFoods else {
                completion(false)
                return
            }
            
            deleteCollection(collectionRef: userDocRef.collection("userInfo")) { successUserInfo in
                guard successUserInfo else {
                    completion(false)
                    return
                }
                
                // 2. Delete the user document itself
                userDocRef.delete { err in
                    if let err = err {
                        print("Error deleting user document: \(err.localizedDescription)")
                        completion(false)
                        return
                    }
                    
                    print("User document deleted successfully")
                }
            }
        }
    }
    
    // Helper function to delete all documents in a collection
    static func deleteCollection(collectionRef: CollectionReference, completion: @escaping (Bool) -> Void) {
        collectionRef.getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting documents for deletion: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion(true) // no docs to delete
                return
            }
            
            let batch = collectionRef.firestore.batch()
            
            for doc in documents {
                batch.deleteDocument(doc.reference)
            }
            
            batch.commit { batchError in
                if let batchError = batchError {
                    print("Batch delete error: \(batchError.localizedDescription)")
                    completion(false)
                } else {
                    completion(true)
                }
            }
        }
    }
    
    static func getUserInfo(user: String, docName: String, completion: @escaping (PersonalInfo?)-> Void) {
        let db = Firestore.firestore()
        db.collection("users")
            .document(user)
            .collection("userInfo")
            .document(docName)
            .getDocument { (document, error) in
                
                if let error = error {
                    print("Error during getting user info: \(error.localizedDescription)")
                    return
                }
                
                guard let document = document,
                      let data = document.data() else{
                    print("Error during getting user info: Document does not exist")
                    completion(nil)
                    return
                }
                
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data)
                    let info = try JSONDecoder().decode(PersonalInfo.self, from: jsonData)
                    completion(info)
                } catch {
                    print("Decoding error: \(error)")
                    completion(nil)
                }
                
                
            }
    }
    
    static func getUserAccInfo(user: String, docName: String, completion: @escaping (AccountInfo?)-> Void) {
        let db = Firestore.firestore()
        db.collection("users")
            .document(user)
            .collection("userInfo")
            .document(docName)
            .getDocument { (document, error) in
                
                if let error = error {
                    print("Error during getting user info: \(error.localizedDescription)")
                    return
                }
                
                guard let document = document,
                      let data = document.data() else{
                    print("Error during getting acc info: Document does not exist")
                    completion(nil)
                    return
                }
                
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data)
                    let info = try JSONDecoder().decode(AccountInfo.self, from: jsonData)
                    completion(info)
                } catch {
                    print("Decoding error: \(error)")
                    completion(nil)
                }
                
            }
    }
    
}
