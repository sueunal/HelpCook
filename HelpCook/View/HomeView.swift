//
//  Home.swift
//  HelpCook
//
//  Created by sueun kim on 10/25/23.
//

import SwiftUI

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

struct HomeView: View {
    @State var cookLevel = CookLevel(cookLevelName: .difficult, cookLevel: .lowLevel, cookDescription: "누구나 쉽게 요리할 수 있어요")
    var path = Path()
    var body: some View {
        NavigationStack {
            ZStack{
                Color("BackgroundColor")
                VStack{
                    ScrollView{
                        NavigationLink{
                            CookView(cookLevel: cookLevel.cookLevelName.CookRankName, levelType: cookLevel.cookLevel.level, cookData: [])
                        }label: {
                            cookStepView(cookLevel: cookLevel, cookLevelName: cookLevel.cookLevelName.CookRankName)
                        }
                    }
                }
            }
        }
    }
    @ViewBuilder
    func cookStepView(cookLevel: CookLevel, cookLevelName: String)-> some View{
                VStack(alignment: .leading){
                    HStack{
                        Text(cookLevel.cookLevel.level)
                            .foregroundStyle(.green)
                            .fontWeight(.heavy)
                            .padding(7)
                            .overlay {
                                Circle()
                                    .stroke()
                                    .foregroundStyle(.green)
                            }
                            .padding(.leading,10)
                    }
                    HStack{
                        Spacer()
                        Text(cookLevelName)
                            .foregroundStyle(.green)
                            .font(.system(size: 30))
                            .fontWeight(.heavy)
                            .bold()
                            .padding(.trailing,10)
                    }.padding(10)
                    HStack{
                        Text(cookLevel.cookDescription)
                            .foregroundStyle(.black)
                            .fontWeight(.thin)
                            .padding()
                    }
                }.background(
                     RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.white)
                        .frame(maxWidth:.infinity, maxHeight: 150)
                ).padding()
    }
}

#Preview {
    HomeView()
}
