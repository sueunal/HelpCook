//
//  CookView.swift
//  HelpCook
//
//  Created by sueun kim on 10/29/23.
//

import SwiftUI
import SwiftSoup

typealias cookModel = [cookItem]

struct cookItem: Hashable, Identifiable{
    let id = UUID()
    var cookName: String
    var cookImage: String
    var cookDescription: String
}

struct CookView: View {
    @State var cookLevel: String
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var cookData: [cookItem]
    let rows = [GridItem(),GridItem()]
    var n: Int = 1
    var body: some View {
        ZStack{
            Color("BackgroundColor")
            NavigationStack{
                VStack{
                    ScrollView{
                        LazyVGrid(columns: rows){
                            cookListView(pageNumber: 1)
                        }
                    }
                }
            }
            .navigationTitle(cookLevel)
            .navigationBarBackButtonHidden()
            .navigationBarItems(leading: backButton())
        }
    }
    func getCookData(_ urlLink: String)->[cookItem]{
        let url = URL(string:urlLink)
        guard let myURL = url else {   return  []  }
        var recipes: [cookItem] = []
        do {
            let html = try String(contentsOf: myURL, encoding: .utf8)
            let doc: Document = try SwiftSoup.parse(html)
            let titleElements = try doc.select(".caption_tit")
            let imgElements = try doc.select(".thumbnail").select("a").select("img")
            for i in 0..<min(titleElements.count, imgElements.count) {
                let titleText = try titleElements[i].text()
                let imgSrc = try imgElements[i].attr("src") // img 태그의 src 속성 가져오기
                let recipe = cookItem(cookName: titleText, cookImage: imgSrc, cookDescription: "")
                recipes.append(recipe)
            }
        }catch{
            print("error")
        }
        return recipes
    }
    
    @ViewBuilder
    func cookListView(pageNumber: Int)-> some View{
        let urlString: String =  "https://www.10000recipe.com/issue/view.html?cid=10kconveni&page=\(pageNumber)"
        let cooks = getCookData(urlString)
        ForEach(cooks, id: \.self){ item in
            LazyVStack(alignment: .center){
                AsyncImage(url: URL(string: item.cookImage)){ myimage in
                    myimage.resizable()
                        .frame(width: 180,height: 200)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                    Text(item.cookName)
                        .font(.system(size: 18))
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
    func cookItemData( itemImage: URL, itemText: String)->some View{
    }
    @ViewBuilder
    func backButton()-> some View{
        Button{
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            HStack {
                Image(systemName: "arrow.left")
                    .foregroundStyle(.green)
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
}

#Preview {
    CookView(cookLevel: "", cookData: [])
}
