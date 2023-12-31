//
//  InfoModel.swift
//  HelpCook
//
//  Created by sueun kim on 12/2/23.
//

import Foundation
import SwiftUI


//struct Models: Decodable{
//    var data : [UserModel]
//}

struct UserModel: Decodable, Hashable{
    var name : String
    var job: String
    var image: String
    
    static let dummy = UserModel(name: "Example Name", job: "Example job", image: "Example Image")
}
