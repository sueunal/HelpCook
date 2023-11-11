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
    @State var levelType: String
    
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
                            Text("aaaa")
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
    func getCookData(_ urlLink: String, complation: @escaping ([cookItem])->Void){
        var recipes: [cookItem] = []
        let url = URL(string:urlLink)
        guard let url = url else {
            print("error")
            complation([])
            return
        }
        let task = URLSession.shared.dataTask(with: url){ data,  response, error in
            if let _ = error{
                print("Internet erorr")
                complation([])
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                print("Invaild response")
                complation([])
                return
            }
            guard let data = data else {
                print("The data recived is Wrong!")
                complation([])
                return
            }
            do {
                let html = try String(contentsOf: url, encoding: .utf8)
                let doc: Document = try SwiftSoup.parse(html)
                let titleElements = try doc.select(".caption_tit")
                let imgElements = try doc.select(".thumbnail").select("a").select("img")
                for i in 0..<min(titleElements.count, imgElements.count) {
                    let titleText = try titleElements[i].text()
                    let imgSrc = try imgElements[i].attr("src") // img 태그의 src 속성 가져오기
                    let recipe = cookItem(cookName: titleText, cookImage: imgSrc, cookDescription: "")
                    recipes.append(recipe)
                }
                complation(recipes)
            }catch{
                print("error")
            }
        }
        task.resume()
    }
    
    @ViewBuilder
    func cookListView(pageNumber: Int )-> some View{
        let urlString: String =  "https://www.10000recipe.com/issue/view.html?cid=10kconveni&page=\(pageNumber)"
        Button{
            getCookData(urlString) { cooks in
                print(cooks)
            }
        }label: {
            Text("coocococo")
        }
        
            //        let cooks = getCookData(urlString)
            //        ForEach(cooks, id: \.self){ item in
            //            LazyVStack(alignment: .center){
            //                AsyncImage(url: URL(string: item.cookImage)){ myimage in
            //                    myimage.resizable()
            //                        .frame(width: 180,height: 200)
            //                        .aspectRatio(contentMode: .fit)
            //                        .cornerRadius(10)
            //                    Text(item.cookName)
            //                        .font(.system(size: 18))
            //                        .fontWeight(.thin)
            //                        .frame(width: 180,height: 100)
            //                }placeholder: {
            //                    Text("잠시만 기다려주세요..")
            //                }
            //            }.background(
            //                RoundedRectangle(cornerRadius: 10)
            //                    .stroke()
            //                    .frame(width: 180)
            //            )
            //        }
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
    CookView(cookLevel: "", levelType: CookLevel.CookLevelType.lowLevel.level, cookData: [])
}
