//
//  ProfileView.swift
//  HelpCook
//
//  Created by sueun kim on 10/25/23.
//

import SwiftUI

struct Profile{
    let name: String
    var userImage: Image
    var nickname: String
}

struct ProfileView: View {
    @State private var showingImagePicker = false
    @State var pickedImage: Image
    @State private var profile = Profile(name: "sueunkim", userImage: Image(""), nickname: "수하")
    var body: some View {
        ZStack{
            Color.red.ignoresSafeArea()
            VStack{
                photoSelectView()
                Text(profile.nickname)
                    .font(.title)
                Spacer()
            }
        }
    }
    @ViewBuilder
    func photoSelectView()-> some View{
        VStack{
            Button(action: {
                           self.showingImagePicker.toggle()
                profile.userImage = pickedImage
            }, label: {
                Circle()
                    .stroke(
                        Gradient(colors: [.red,.blue,.green])
                    )
                    .background(
                        profile.userImage
                            .resizable()
                            .frame(maxWidth: 200)
                            .cornerRadius(100)
                    )
                    .frame(maxWidth: 200)
                    .padding()
            }).sheet(isPresented: $showingImagePicker) {
                ImagePicker(sourceType: .photoLibrary) { (image) in
                    self.pickedImage = Image(uiImage: image)
                    print(image)
                }
            }
        }
    }
}

#Preview {
    ProfileView(pickedImage: Image(""))
}
