//
//  Network.swift
//  HelpCook
//
//  Created by sueun kim on 10/31/23.
//
import Foundation
import SwiftSoup


final class NetworkManager{
    static let share = NetworkManager()
    var CookData: [cookItem] = []
    private init(){ }
    
    func getCookData(_ urlString: String, complation: @escaping (cookItem) -> Void){
        guard let url = URL(string:urlString) else {
            print("error")
            return
        }
        let task = URLSession.shared.dataTask(with: url){ data,  response, error in
            if let error = error{
                print("Internet erorr")
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                print("Invaild response")
                return
            }
            guard let data = data else {
                print("The data recived is Wrong!")
                return
            }
            do {
                let html = try String(contentsOf: url, encoding: .utf8)
                let doc: Document = try SwiftSoup.parse(html)
                let titleElements = try doc.select(".caption_tit")
                let imgElements = try doc.select(".thumbnail").select("a").select("img")
                for i in 0..<min(titleElements.count, imgElements.count) {
                    let titleText = try titleElements[i].text()
                    let imgSrc = try imgElements[i].attr("src") // img 태그의 src 속성 가져오기
                    let recipe = cookItem(cookName: titleText, cookImage: imgSrc, cookDescription: "")
                    complation(recipe)
                }
            }catch{
                print("error")
            }
        }.resume()
    }
}
