//
//  UserViewModel.swift
//  HelpCook
//
//  Created by sueun kim on 12/27/23.
//

import SwiftUI

class UserViewModel: ObservableObject{
    @Published var items = [UserModel]()
    let prefixURL = "http://localhost"
    init(){
        fetchPost()
    }
    func fetchPost(){
        guard let url = URL(string: "\(prefixURL)/index.php") else{
            print("Not found URL")
            return
        }
        URLSession.shared.dataTask(with: url){ data, res, error in
            if let error = error {
                print("error : \(error.localizedDescription)")
            }
            do{
                if let data = data{
                    let result  = try JSONDecoder().decode(Models.self, from: data)
                    DispatchQueue.main.async {
                        self.items = result.data
                    }
                }else{
                    print("No data..")
                }
                
            }catch let JsonError{
                print("fetch json error:", JsonError.localizedDescription)
            }
        }.resume()
    }
}
