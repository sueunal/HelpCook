//
//  UserViewModel.swift
//  HelpCook
//
//  Created by sueun kim on 12/27/23.
//

import SwiftUI

class UserViewModel: ObservableObject{
    @Published var items : UserModel = .dummy
    @Published var myImage: Image? = nil
    let prefixURL = "http://localhost"
    init(){
        fetchPost()
    }
    func convertData(){
        let uiImage = UIImage(systemName: "person.fill")
        
        // 이미지를 Data로 변환합니다.
        guard let imageData = uiImage?.jpegData(compressionQuality: 1.0) else {
            print("Failed to convert image to Data")
            return
        }
        guard let url  = URL(string: "\(prefixURL)/image") else{
           return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // 이미지 데이터를 Base64로 인코딩하여 JSON에 담습니다.
        let base64String = imageData.base64EncodedString()
        let json: [String: Any] = ["imageBase64": base64String]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
            request.httpBody = jsonData
        } catch {
            print("Error creating JSON data: \(error)")
            return
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            if let data = data{
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Response data: \(jsonString)")
                }
            }
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
            }
        }
        task.resume()
        return 
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
