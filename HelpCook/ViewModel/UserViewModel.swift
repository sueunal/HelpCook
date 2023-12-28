//
//  UserViewModel.swift
//  HelpCook
//
//  Created by sueun kim on 12/27/23.
//

import SwiftUI

class UserViewModel: ObservableObject{
    @Published var items : [UserModel] = []
    let prefixURL = "http://localhost"
    init(){
        fetchPost()
    }
    func fetchPost(){
        guard let url = URL(string: "\(prefixURL)/posts") else{
            print("Not found URL")
            return
        }
        URLSession.shared.dataTask(with: url){ data, response, error in
            do{
                if let data = data{
                    let result = try JSONDecoder().decode(Models.self, from: data)
                    DispatchQueue.main.async {
                        self.items.append(contentsOf: result.data)
                    }
                }else{
                    print(data)
                    print("No Data..")
                }
            }catch let JsonError{
                if let data = data{
                    print(data)
                    print("fetch json error:", JsonError.localizedDescription)
                }
            }
        }.resume()
    }
}
