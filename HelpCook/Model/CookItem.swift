//
//  CookItem.swift
//  HelpCook
//
//  Created by sueun kim on 11/16/23.
//

import Foundation

struct cookItem: Hashable, Identifiable{
    let id = UUID()
    var cookName: String
    var cookImage: String
    var cookDescription: String
}

struct CookLevel{
    enum CookLevelType{
        case highLevel, middleLevel, lowLevel
        var level: String{
            switch self{
            case .highLevel:
                return "3"
            case .middleLevel:
                return "2"
            case .lowLevel:
                return "1"
            }
        }
    }
    enum CookRank{
        case easy, soso, difficult
        var CookRankName: String{
            switch self{
            case .easy:
                return "간단한 요리"
            case .soso:
                return "적당한 요리"
            case .difficult:
                return "어려운 요리"
            }
        }
    }
    var cookLevelName: CookRank
    var cookLevel: CookLevelType
    var cookDescription: String
}
