//
//  InfoModel.swift
//  HelpCook
//
//  Created by sueun kim on 12/2/23.
//

import Foundation
import SwiftUI


struct UserModel{
    var username: String = ""
    var image: Image? = nil
    var job: String = ""
    var favorite: String = ""
    
    static let dummy = UserModel(username: "sueunkim", job: "iOS Developer", favorite: "iOS")
}
