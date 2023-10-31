//
//  CookView.swift
//  HelpCook
//
//  Created by sueun kim on 10/29/23.
//

import SwiftUI
import SwiftSoup

struct cookItem: Hashable, Identifiable{
    let id = UUID()
    var cookName: String
    var cookImage: String
    var cookDescription: String
}

struct CookView: View {
    @State var cookLevel: String
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let rows = [GridItem(),GridItem()]
    
    var body: some View {
        NavigationStack{
            VStack{
                ScrollView{
                    cookListView()
                }
            }
        }
        .navigationTitle(cookLevel)
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: backButton())
    }
    func getCookData()->[cookItem]{
        var pageNumber: Int = 2
        let url = URL(string:"https://www.10000recipe.com/issue/view.html?cid=10kconveni&page=\(pageNumber)")
        guard let myURL = url else {   return  []  }
        var recipes: [cookItem] = []
        do {
            let html = try String(contentsOf: myURL, encoding: .utf8)
            let doc: Document = try SwiftSoup.parse(html)
            let titleElements = try doc.select(".caption_tit")
            let imgElements = try doc.select(".thumbnail").select("a").select("img")
            let imgDescription = try doc.select(".common_sp_caption_rv_name").select("a")
            // 값 출력 및 구조체에 저장
            for i in 0..<min(titleElements.count, imgElements.count) {
                let titleText = try titleElements[i].text()
                let imgSrc = try imgElements[i].attr("src") // img 태그의 src 속성 가져오기
//                let imgDes = try imgDescription[i].text()
                let recipe = cookItem(cookName: titleText, cookImage: imgSrc, cookDescription: "")
                recipes.append(recipe)
            }
        }catch{
            print("error")
        }
        return recipes
    }
    
    @ViewBuilder
    func cookListView()-> some View{
        let cooks = getCookData()
        
        ForEach(cooks,id:\.self){ item in
            LazyVGrid(columns: rows){
                    AsyncImage(url: URL(string:item.cookImage)) { cookImage in
                        cookImage
                            .resizable()
                            .frame(width: 160,height: 200)
                            .aspectRatio(contentMode: .fit)
                            .background()
                    } placeholder: {
                        ProgressView()
                    }
                VStack(alignment: .leading){
                        Text(item.cookName)
                        .padding(.bottom,10)
                }
            }.background(RoundedRectangle( cornerRadius: 10)
                .stroke()
                .bold()
                .foregroundStyle(.green)
                .shadow(radius: 5)
            )
            .padding()
        }
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
    CookView(cookLevel: "")
}
