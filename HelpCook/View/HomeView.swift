//
//  Home.swift
//  HelpCook
//
//  Created by sueun kim on 10/25/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var cookmodel = CookViewModel()
    @State var cookLevel = CookLevel(cookLevelName: .difficult, cookLevel: .lowLevel, cookDescription: "누구나 쉽게 요리할 수 있어요")
    var path = Path()
    var body: some View {
        NavigationStack {
            ZStack{
                Color("BackgroundColor").ignoresSafeArea()
                VStack{
                    ScrollView{
                        NavigationLink{
                            CookView(cookLevel: cookLevel.cookLevelName.CookRankName, levelType: cookLevel.cookLevel.level)
                        }label: {
                            cookStepView(cookLevel: cookLevel, cookLevelName: cookLevel.cookLevelName.CookRankName)
                        }
                        .onTapGesture {
                            cookmodel.getRequestData()
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
