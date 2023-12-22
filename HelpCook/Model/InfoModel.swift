//
//  InfoModel.swift
//  HelpCook
//
//  Created by sueun kim on 12/2/23.
//

import Foundation
import SwiftUI


struct UserModel{
    var name: String
    var image: Image?
    var job: String
    var favorite: String
    
    static let dummy = UserModel(name: "sueunkim", job: "iOS Developer", favorite: "iOS")
}
