//
//  GPTModel.swift
//  NutriScan
//
//  Created by Htet Oo Yan i on 26/5/25.
//

import Foundation

class GPTModel: ObservableObject {
    static let shared = GPTModel()
    
    @Published var isLoading: Bool = false
    
    func callGPT(prompt: String, completion: @escaping (String) -> Void) {
        self.isLoading = true
        let url = URL(string: "https://openrouter.ai/api/v1/chat/completions")!
        var request = URLRequest(url: url)
        request.timeoutInterval = 60
        request.httpMethod = "POST"
        if let apiKey = HelperFunctions.getSecretKey(named: "GPT_API_KEY") {
            request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "model": "deepseek/deepseek-r1:free",
            "messages": [
                ["role": "user", "content": prompt]
            ]
        ]


        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Request error:", error)
                completion("Error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("No data received")
                completion("Error: No data received")
                return
            }

            // Print raw response string for debugging
            if let rawResponse = String(data: data, encoding: .utf8) {
                print("Raw response:", rawResponse)
            }

            // Now try to parse JSON
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let choices = json["choices"] as? [[String: Any]],
                   let message = choices.first?["message"] as? [String: Any],
                   let content = message["content"] as? String {
                    self.isLoading = false
                    completion(content)
                } else if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                          let errorInfo = json["error"] as? [String: Any],
                          let message = errorInfo["message"] as? String {
                    self.isLoading = false
                    completion("API Error: \(message)")
                } else {
                    self.isLoading = false
                    completion("Error: Unexpected response format.")
                }
            } catch {
                self.isLoading = false
                print("JSON parse error:", error)
                completion("Error: Could not parse JSON.")
            }
        }
        task.resume()

    }
}

