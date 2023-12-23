//
//  ProfileView.swift
//  HelpCook
//
//  Created by sueun kim on 10/25/23.
//
import SwiftUI
import PhotosUI

struct ProfileView: View {
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State var user = UserModel(username: "수은", job: "iOS Developer", favorite: "iOS")
    @State var onSheet: Bool = false
    @ObservedObject var imageViewModel = ImageViewModel()
    
    let profileImages : Image = Image(systemName: "person.circle.fill")
    
    var body: some View {
        NavigationStack{
            VStack{
                HStack(spacing: 20){
                    PhotosPicker(
                        selection: $selectedItem,
                        matching: .images
                    ){
                        if let profileImage = imageViewModel.profileImage{
                            profileImage
                                .resizable()
                                .frame(width: 150, height: 150)
                                .clipShape(Circle())
                                .aspectRatio(contentMode: .fill)
                        } else {
                            ProgressView()
                        }
                    }
                    .padding()
                    InfoView(user: $user)
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
            .navigationTitle("프로필")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem {
                    Button{
                        onSheet = true
                    }label: {
                        Image(systemName: "gear")
                    }
                    .sheet(isPresented: $onSheet, content: {
                        SettingsView(user: $user, confirm: $onSheet)
                    })
                }
            }
            Spacer()
        }
    }
    @ViewBuilder
    func photoSelectView()-> some View{
        if let selectedImageData, let image = UIImage(data: selectedImageData){
            Image(uiImage: image)
                .resizable()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .background {
                    Circle()
                        .fill(
                        LinearGradient(
                            colors: [.yellow, .orange],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                }
        }else{
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundStyle(.black)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .foregroundStyle(.black)
                .background {
                    Circle().fill(
                        LinearGradient(
                            colors: [.cyan, .white],
                            startPoint: .center,
                            endPoint: .zero
                        )
                    )
                }
        }
    }
}
                   

#Preview {
    ProfileView()
}
