//
//  InfoModel.swift
//  HelpCook
//
//  Created by sueun kim on 12/2/23.
//

import Foundation
import SwiftUI


struct Models: Decodable{
    let error : Bool
    let message: String
    var data : [UserModel]
}

struct UserModel: Decodable{
    var name : String
    var image: String
    var job: String
    
    static let dummy = UserModel(name: "sueunkim", image: "", job: "iOS Developer")
}
