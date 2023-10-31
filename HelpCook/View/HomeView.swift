//
//  Home.swift
//  HelpCook
//
//  Created by sueun kim on 10/25/23.
//

import SwiftUI

struct CookLevel{
//    enum CookLevel{
//        case highLevel, middleLevel, lowLevel
//        
//        var level: String{
//            switch self{
//            case .highLevel:
//                return "3"
//            case .middleLevel:
//                return "2"
//            case .lowLevel:
//                return "1"
//            }
//        }
//    }
    var cookLevelName: String
    var cookLevel: String
    var cookDescription: String
}
struct HomeView: View {
        @State var cookLevel = CookLevel(cookLevelName:  "간단한 요리", cookLevel: "1", cookDescription: "누구나 쉽게 요리할 수 있어요")
    var path = Path()
    var body: some View {
        NavigationStack {
            ForEach(0..<4) { item in
                VStack{
                    NavigationLink{
                        CookView(cookLevel: cookLevel.cookLevelName)
                    }label: {
                        cookLevelView(cookLevel: cookLevel)
                    }
                }
            }
        }
    }
    @ViewBuilder
    func cookLevelView(cookLevel: CookLevel)-> some View{
        GeometryReader{ _ in
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity,maxHeight: 150)
                    .shadow(radius: 5)
                    .padding()
                VStack(alignment: .leading){
                    HStack{
                        Text(cookLevel.cookLevel)
                            .foregroundStyle(.green)
                            .fontWeight(.heavy)
                            .bold()
                            .padding(7)
                            .overlay {
                                Circle()
                                    .stroke()
                                    .foregroundStyle(.green)
                            }
                            .padding(.leading,30)
                    }
                    HStack{
                        Spacer()
                        Text(cookLevel.cookLevelName)
                            .foregroundStyle(.green)
                            .font(.system(size: 30))
                            .fontWeight(.heavy)
                            .bold()
                            .padding(.trailing,20)
                    }.padding(10)
                    HStack{
                        Text(cookLevel.cookDescription)
                            .foregroundStyle(.black)
                            .fontWeight(.thin)
                            .padding(.leading,30)
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
