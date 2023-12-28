//
//  SetInfo.swift
//  HelpCook
//
//  Created by sueun kim on 12/23/23.
//

import SwiftUI
import PhotosUI
struct temp{
    var name: String
    var job: String
}
struct SetUserInformation: View {
    @State var user = temp(name: "", job: "")
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State private var next: Bool = false
    @ObservedObject var authViewModel = AuthViewModel()
    @ObservedObject var imageViewModel = ImageViewModel()
    
    var body: some View {
        NavigationStack{
            VStack{
                SetImage()
                InputView(text: $user.name, placeholder: "이름을 입력해주세요", title: "이름")
                NextButton()
                Spacer()
                    .frame(height: 200)
            }
            .navigationDestination(isPresented: $next) {
//                MainTabView(user: $user)
//                    .navigationBarBackButtonHidden(true)
            }
        }
    }
    @ViewBuilder
    func NextButton()-> some View{
        Button{
          next = true
        }label: {
            Text("다음")
                .foregroundStyle(.white)
                .fontWeight(.heavy)
        }
        .disabled(user.name.isEmpty)
        .background(user.name.isEmpty ? .gray : .blue)
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
