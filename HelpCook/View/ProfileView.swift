//
//  ProfileView.swift
//  HelpCook
//
//  Created by sueun kim on 10/25/23.
//

import SwiftUI
import Foundation

struct Profile{
    let name: String
    var userImage: Image
    var nickname: String
}

struct ProfileView: View {
    @State private var showingImagePicker = false
    @State var pickedImage: Image
    @ObservedObject var imageViewModel: ImageViewModel
    @State private var profile = Profile(name: "sueunkim", userImage: Image(systemName: "person"), nickname: "수하")

    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack{
                photoSelectView()
                Text(profile.nickname)
                    .font(.title)
                ForEach(1..<5) { a in
                    profileListView()
                }
                Spacer()
                Button{
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
                Spacer()
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
            }label: {
                Circle()
                    .stroke( Gradient(colors: [.red,.blue,.green]) )
                    .background(
                        profile.userImage
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(.circle)
                    )
                    .frame(maxWidth: 200)
                    .padding()
            }.sheet(isPresented: $showingImagePicker) {
                ImagePicker(sourceType: .photoLibrary) { (image) in
                    profile.userImage = Image(uiImage: image)
                }
            }
        }
    }
}

#Preview {
    ProfileView(pickedImage: Image(systemName: "person.fill"), imageViewModel: ImageViewModel.init())
}
