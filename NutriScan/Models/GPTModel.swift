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

    func callGPT(prompt: String, completion: @escaping (String?) -> Void) {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        guard let apiKey = HelperFunctions.getSecretKey(named: "GPT_API_KEY") else {
            DispatchQueue.main.async {
                self.isLoading = false
            }
            completion("Auth Error")
            return
        }
        
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let messages: [[String: String]] = [
            ["role": "system", "content": "You are a helpful nutrition assistant. Provide short, friendly feedback based on food and user health data."],
            ["role": "user", "content": prompt]
        ]

        let body: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": messages,
            "temperature": 0.7
        ]


        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                completion("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let choices = json["choices"] as? [[String: Any]],
                   let message = choices.first?["message"] as? [String: Any],
                   let content = message["content"] as? String {
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                    completion(content)
                } else {
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                    completion("Error: Unexpected response format.")
                }
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                completion("Error parsing JSON: \(error.localizedDescription)")
            }
        }

        task.resume()
    }

}

