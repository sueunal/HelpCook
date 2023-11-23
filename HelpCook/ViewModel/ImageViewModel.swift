//
//  ImageViewModel.swift
//  HelpCook
//
//  Created by sueun kim on 10/27/23.
//

import Foundation
import SwiftUI

class ImageViewModel: ObservableObject {
    @Published var pickedImage: Image = Image(systemName: "person")
    init() {
        if let imageData = UserDefaults.standard.data(forKey: "pickedImage"){
            if let image = UIImage(data: imageData){
                self.pickedImage = Image(uiImage: image)
            }
        }
    }
    func pushPickedImage(pushImage: UIImage?, savedName: String){
        if let imageDate = pushImage?.pngData(){
            UserDefaults.standard.set(imageDate, forKey: savedName)
            print("Saved!")
        }
    }
    func savePickedImage(){
        let imageData = UserDefaults.standard.data(forKey: "pickedImage")
        if let imageData = imageData{
            guard let savedImage = UIImage(data: imageData) else { return  }
            self.pickedImage = Image(uiImage: savedImage)
        }
    }
    func removePickedImage(){
        UserDefaults.standard.removeObject(forKey: "pickedImage")
        self.pickedImage = Image(systemName: "person")
    }
    func showPickedImage(){
        for (key, value) in UserDefaults.standard.dictionaryRepresentation(){
            print("\(key): \(value)")
        }
    }
}
