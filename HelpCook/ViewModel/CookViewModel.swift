//
//  CookViewModel.swift
//  HelpCook
//
//  Created by sueun kim on 11/16/23.
//

import Foundation

class CookViewModel: ObservableObject{
    @Published var cookData: [cookItem] = []
    init(){
        getRequestData()
    }
    private func getRequestData(){
         let urlString: String =  "https://www.10000recipe.com/issue/view.html?cid=10kconveni&page=1"
        NetworkManager.share.getCookData(urlString) { cookTemp in
            self.cookData.append(cookTemp)
        }
    }
    
}
