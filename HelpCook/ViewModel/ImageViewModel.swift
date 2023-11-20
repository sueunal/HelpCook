//
//  ImageViewModel.swift
//  HelpCook
//
//  Created by sueun kim on 10/27/23.
//

import Foundation
import SwiftUI

class ImageViewModel: ObservableObject {
    @Published var pickedImage: UIImage? {
        didSet {
            if let imageData = pickedImage?.pngData() {
                UserDefaults.standard.set(imageData, forKey: "pickedImage")
            }
        }
    }

    init() {
        if let imageData = UserDefaults.standard.data(forKey: "pickedImage") {
            pickedImage = UIImage(data: imageData)
        }
    }
}
