//
//  InfoModel.swift
//  HelpCook
//
//  Created by sueun kim on 12/2/23.
//

import Foundation
import SwiftUI


struct Models: Decodable{
    let error : String
    let message: String
    let data : [UserModel]
}

struct UserModel: Decodable{
    var name : String = ""
    var image: Data? = nil
    var job: String = ""
    
    static let dummy = UserModel(name: "sueunkim", job: "iOS Developer")
}
