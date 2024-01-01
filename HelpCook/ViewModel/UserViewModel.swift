//
//  UserViewModel.swift
//  HelpCook
//
//  Created by sueun kim on 12/27/23.
//

import SwiftUI

class UserViewModel: ObservableObject{
    @Published var items : UserModel = .dummy
    let prefixURL = "http://localhost"
    init(){
        fetchPost()
    }
    func insertData(parameter: [String: Any]) {
        guard let url = URL(string: "\(prefixURL)/create") else{
            print("Invaild URL!!")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameter, options: [])
            request.httpBody = jsonData
        } catch {
            print("JSON serialization failed: \(error.localizedDescription)")
            return
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
            }
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Response data: \(jsonString)")
            }
        }
        task.resume()
    }
    func fetchPost(){
        guard let url = URL(string: "\(prefixURL)/posts") else{
            print("Not found URL")
            return
        }
        URLSession.shared.dataTask(with: url){ data, response, error in
            if let error = error{
                print(error.localizedDescription)
            }
            guard let response = response else{
                return
            }
            do{
                if let data = data{
                    let result = try JSONDecoder().decode(UserModel.self, from: data)
                    DispatchQueue.main.async {
                        self.items = result
                    }
                }else{
                    print("No Data..")
                }
            }catch let JsonError{
                print("fetch json error:", JsonError.localizedDescription)
            }
        }.resume()
    }
}