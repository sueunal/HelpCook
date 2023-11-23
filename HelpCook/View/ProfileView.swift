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
    @ObservedObject var imageViewModel = ImageViewModel()
    @State private var profile = Profile(name: "김수은", userImage: UIImage(systemName: "person"), message:"", nickname: "수하")
    @State var isSaved: Bool = false
    @State var isClick: Bool = false
    @State var deleteImage: Bool = false
    var body: some View {
        ZStack{
            VStack{
                photoSelectView()
                Text(profile.nickname)
                    .font(.title)
                resetPhotoButton()
                profileListView()
                profileListView()
                Spacer()
                saveButton()
                Spacer()
            }
        }
        .onAppear{
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
    func resetPhotoButton()-> some View{
        Button{
            isClick.toggle()
        }label: {
            Image(systemName: "trash")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 30)
                .foregroundStyle(.black)
        }.alert(isPresented: $isClick, content: {
            Alert(
                title: Text("정말로 지우시겠습니까?"),
                primaryButton: .default(
                    Text("취소"),
                    action: .some({
                    })
                ),
                secondaryButton: .destructive(
                    Text("지우기"),
                    action: imageViewModel.removePickedImage
                )
            )
        })
    }
    @ViewBuilder
    func photoSelectView()-> some View{
        VStack{
            Button{
                showingImagePicker.toggle()
//                ProfileImage = imageViewModel.popPickedImage()
            }label: {
                Circle()
                    .stroke(Gradient(colors: [.red,.blue,.green]))
                    .background(
                        imageViewModel.pickedImage
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: 200, maxHeight: 200)
                            .frame(minWidth: 100,minHeight: 100)
                            .cornerRadius(100)
                    )
                    .frame(maxWidth: 200, maxHeight: 200)
                    .frame(minWidth: 100,minHeight: 100)
                    .padding()
            }.sheet(isPresented: $showingImagePicker) {
                ImagePicker(sourceType: .photoLibrary) { image in
                    imageViewModel.pushPickedImage(pushImage: image, savedName: "pickedImage")
                    imageViewModel.savePickedImage()
                }
            }
        }
    }
    @ViewBuilder
    func saveButton()-> some View{
        Button{
            isSaved.toggle()
            if isSaved{
                imageViewModel.savePickedImage()
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
    }
}

#Preview {
    ProfileView(pickedImage: Image(systemName: "person.fill"), imageViewModel: ImageViewModel.init())
}
