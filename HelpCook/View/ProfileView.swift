//
//  ProfileView.swift
//  HelpCook
//
//  Created by sueun kim on 10/25/23.
//

import SwiftUI
import Foundation

struct Profile{
    var name: String
    var userImage: UIImage?
    var message: String
    var nickname: String
}

struct ProfileView: View {
    @State private var showingImagePicker = false
    @State var pickedImage: Image
    @ObservedObject var imageViewModel: ImageViewModel
    @State private var profile = Profile(name: "김수은", userImage: UIImage(systemName: "person"), message:"", nickname: "수하")
    @State var ProfileImage: Image = Image(systemName: "person")
    @State var isSaved: Bool = false
    var body: some View {
        ZStack{
            VStack{
                photoSelectView()
                Text(profile.nickname)
                    .font(.title)
                List {
                    TextField("input", text: $profile.message)
                }.listStyle(.inset)
                Spacer()
                Button{
                    if let image = imageViewModel.pickedImage{
                        profile.userImage = image
                        isSaved.toggle()
                    }
                }label: {
                    Text("Save")
                        .padding()
                        .foregroundStyle(.white)
                        .bold()
                        .frame(maxWidth: 250)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.pink)
                        )
                }
                .alert(isPresented: $isSaved, content: {
                    Alert(title: Text("저장되었습니다."))
                })
                Spacer()
            }
            .onAppear{
                if let image = imageViewModel.pickedImage{
                    ProfileImage = Image(uiImage: image)
                }
            }
        }
        
    }
    @ViewBuilder
    func profileListView()-> some View{
                HStack(alignment:.center){
                    Label("Your Favorite", systemImage: "heart.fill")
                        .padding()
                        .frame(maxWidth:.infinity)
                        .background(
                            Rectangle()
                            .stroke()
                            .shadow(radius: 5)
                            .foregroundStyle(
                                LinearGradient(colors: [.red,.blue,.green], startPoint: .leading, endPoint: .trailing)
                            )
                        )
                        .padding()
                }
    }
    @ViewBuilder
    func photoSelectView()-> some View{
        VStack{
            Button{
                self.showingImagePicker.toggle()
                guard let myImage = profile.userImage else{
                    return
                }
                ProfileImage = Image(uiImage: myImage)
            }label: {
                Circle()
                    .stroke( Gradient(colors: [.red,.blue,.green]) )
                    .background(
                        ProfileImage
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: 200, maxHeight: 200)
                            .cornerRadius(100)
                    )
                    .frame(maxWidth: 200, maxHeight: 200)
                    .padding()
            }.sheet(isPresented: $showingImagePicker) {
                ImagePicker(sourceType: .photoLibrary) { (image) in
                    ProfileImage = Image(uiImage: image)
                    imageViewModel.pickedImage = image
                }
            }
        }
    }
}

#Preview {
    ProfileView(pickedImage: Image(systemName: "person.fill"), imageViewModel: ImageViewModel.init())
}
