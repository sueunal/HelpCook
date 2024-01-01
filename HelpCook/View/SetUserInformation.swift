//
//  SetInfo.swift
//  HelpCook
//
//  Created by sueun kim on 12/23/23.
//

import SwiftUI
import PhotosUI

struct SetUserInformation: View {
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State private var next: Bool = false
    @State var name: String = ""
    @ObservedObject var userViewModel = UserViewModel()
    @ObservedObject var authViewModel = AuthViewModel()
    @ObservedObject var imageViewModel = ImageViewModel()
    
    var body: some View {
        NavigationStack{
            VStack{
                SetImage()
                InputView(text: $name, placeholder: "이름을 입력해주세요", title: "이름")
                NextButton()
                Spacer()
                    .frame(height: 200)
            }
<<<<<<< HEAD
            //            .navigationDestination(isPresented: $next) {
            //                MainTabView()
            //                    .navigationBarBackButtonHidden(true)
            //                    .environmentObject(userViewModel)
            //
=======
//            .navigationDestination(isPresented: $next) {
//                MainTabView()
//                    .navigationBarBackButtonHidden(true)
//                    .environmentObject(userViewModel)
//            }
>>>>>>> 6e1c2d99a5b632994b1f42859194f03bae613fba
        }
    }
    @ViewBuilder
    func NextButton()-> some View{
        Button{
<<<<<<< HEAD
            userViewModel.insertData(parameter: ["name": name, "job":"developer", "image": "name"])
=======
            userViewModel.insertData(parameter: ["name": "sueun","job":"developer", "image": "asdfasdfasdfasdfasdfasdfa"])
>>>>>>> 6e1c2d99a5b632994b1f42859194f03bae613fba
        }label: {
            Text("다음")
                .foregroundStyle(.white)
                .fontWeight(.heavy)
        }
        .disabled(name.isEmpty)
        .background(name.isEmpty ? .gray : .blue)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .buttonStyle(.borderedProminent)
    }
    @ViewBuilder
    func SetImage() -> some View{
        VStack{
            PhotosPicker(
                selection: $selectedItem,
                matching: .images
            ){
                if let myImage = imageViewModel.profileImage {
                    myImage
                        .resizable()
                        .frame(width: 150, height: 150)
                        .foregroundStyle(.black)
                        .clipShape(Circle())
                        .aspectRatio(contentMode: .fill)
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                        .foregroundStyle(
                            LinearGradient(colors: [Color.black,Color.gray], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .aspectRatio(contentMode: .fill)
                }
            }
            .onChange(of: selectedItem) { newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        selectedImageData = data
                        imageViewModel.StorageManger(data: data)
                    }
                }
            }
        }
    }
}

#Preview {
    SetUserInformation()
}
