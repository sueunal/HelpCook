//
//  CookView.swift
//  HelpCook
//
//  Created by sueun kim on 10/29/23.
//

import SwiftUI
import SwiftSoup


struct CookView: View {
    @State var cookLevel: String
    @State var levelType: String
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var cookModel = CookViewModel()
    
    let rows = [GridItem(),GridItem()]
    var body: some View {
        ZStack{
            Color("BackgroundColor")
            NavigationStack{
                VStack{
                    ScrollView{
                        LazyVGrid(columns: rows){
                            cookListView()
                        }
                    }
                }
            }
            .navigationTitle(cookLevel)
            .navigationBarBackButtonHidden()
            .navigationBarItems(leading: backButton())
        }
    }
    @ViewBuilder
    func cookListView()-> some View{
        ForEach(cookModel.cookData, id: \.self){ item in
            LazyVStack(alignment: .center){
                AsyncImage(url: URL(string: item.cookImage)){ myimage in
                    myimage.resizable()
                        .frame(width: 180,height: 200)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                    Text(item.cookName)
                        .font(.system(size: 18))
                        .fontWeight(.thin)
                        .frame(width: 180,height: 100)
                }placeholder: {
                    Text("잠시만 기다려주세요..")
                }
            }.background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke()
                    .frame(width: 180)
            )
        }
    }
    @ViewBuilder
    func backButton()-> some View{
        Button{
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            HStack {
                Image(systemName: "arrow.left")
                    .foregroundStyle(.black)
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
}

#Preview {
    CookView(cookLevel: "", levelType: CookLevel.CookLevelType.lowLevel.level)
}
