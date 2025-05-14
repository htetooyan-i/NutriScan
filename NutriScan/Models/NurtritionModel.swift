//
//  NurtritionModel.swift
//  NutriScan
//
//  Created by Htet Oo Yan on 29/4/25.
//

import Foundation


class NutritionModel: ObservableObject {
    
    @Published var nutrientInfo: [String : [String : Any]] = [:]
    @Published var isLoading = false
    private var completedRequests = 0
    private var totalRequests = 0

    func fetchNutritionInfo(for foodNames: [String]) {
        /**
         * *IDEA:* This function will be caled to fetch data from nutrition api
         * - Parameter foodName: Array of String that include top 6 food names
         */
        DispatchQueue.main.async {
            self.isLoading = true
            self.nutrientInfo = [:]
            self.completedRequests = 0
            self.totalRequests = foodNames.count
        }

        for foodName in foodNames {
            fetchSingleNutritionInfo(for: foodName)
        }
    }
    
    private func markRequestComplete() { // IDEA: use to toggle isLoading that change the display in SheetView
        completedRequests += 1
        if completedRequests == totalRequests {
            isLoading = false
            print("✅ All nutrition + image requests completed.")
        }
    }

    private func fetchSingleNutritionInfo(for foodName: String) {
        let url = URL(string: "https://trackapi.nutritionix.com/v2/natural/nutrients")! // base url for nutrition api
        var request = URLRequest(url: url) //make the request variable to make configuration
        request.httpMethod = "POST" // set the request method as post
        request.setValue("98793c7e", forHTTPHeaderField: "x-app-id") // set app id
        request.setValue("155e001d04b22b3d2a4c0ce163420448", forHTTPHeaderField: "x-app-key") // set api key
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // set content type
        
        let body = ["query": foodName]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body) // set query (In this case that will be food name)

        URLSession.shared.dataTask(with: request) { data, response, error in // make the request to api
            DispatchQueue.main.async {
                guard error == nil, let data = data else { // check recieved data is error or success data
                    print("Request error: \(error?.localizedDescription ?? "Unknown error")")
                    self.markRequestComplete()
                    return
                }

                do {
                    let result = try JSONDecoder().decode(NutritionResponse.self, from: data) // decode json to swift readable format
                    
                    self.nutrientInfo[foodName] = [ // set nutrientInfo for food according to the data that have recieved from api
                        "food_name": result.foods.first!.food_name,
                        "serving_qty": result.foods.first!.serving_qty,
                        "serving_unit": result.foods.first!.serving_unit,
                        "nf_calories": result.foods.first!.nf_calories,
                        "nf_protein": result.foods.first!.nf_protein,
                        "nf_dietary_fiber": result.foods.first!.nf_dietary_fiber,
                        "nf_total_fat": result.foods.first!.nf_total_fat,
                        "serving_weight_grams": result.foods.first!.serving_weight_grams
                    ]
                    
                    DatabaseModel.getFoodThumbnail(foodName: foodName) { image in // get food's thumbnail from database to display
                        DispatchQueue.main.async {
                            self.nutrientInfo[foodName]?["thumbnail"] = image
                            self.markRequestComplete()
                        }
                    }

                } catch {
                    print("Validation error for \(foodName)")
                    /**
                     * *IDEA:* if recieved data can't be decode to swift's readable format (In this case requested food is not available in api). In that case set nutrientInfo as empty array but thumbnail image need to be added for UI.
                     */
                    self.nutrientInfo[foodName] = [:]
                    DatabaseModel.getFoodThumbnail(foodName: foodName) { image in // get food's thumbnail from database to display
                        DispatchQueue.main.async {
                            self.nutrientInfo[foodName]?["thumbnail"] = image
                            self.markRequestComplete()
                        }
                    }

                }
            }
        }.resume()
    }
}

/**
 * *IDEA* Create [Codable] structs to decode json format to swift's readable format
 */
struct NutritionResponse: Codable {
    let foods: [Food]
}

struct Food: Codable {
    let food_name: String
    let serving_qty: Int
    let serving_unit: String
    let nf_calories: Double
    let nf_protein: Double
    let nf_dietary_fiber: Double
    let nf_total_fat: Double
    let photo: Photo
    let serving_weight_grams: Int
}

struct Photo: Codable {
    let thumb: String
}

