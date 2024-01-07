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
    @State private var isClick: Bool = false
    @State private var onSheet: Bool = false
    @State private var isLogged: Bool = true
    @StateObject var imageViewModel = ImageViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    
    let profileImages : Image = Image(systemName: "person.circle.fill")
    
    var body: some View {
        ZStack{
            NavigationStack{
                if isLogged{
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
                                    Image(systemName: "person.circle.fill")
                                        .resizable()
                                        .frame(width: 150, height: 150)
                                        .clipShape(Circle())
                                        .foregroundStyle(
                                            LinearGradient(colors: [Color.black,Color.gray], startPoint: .topLeading, endPoint: .bottomTrailing)
                                        )
                                        .aspectRatio(contentMode: .fill)
                                }
                            }
                            .padding()
                            InfoView()
                                .task{
                                    imageViewModel.downloadImage()
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
                                SettingsView()
                            })
                        }
                    }
                    .blur(radius: 10)
                    Spacer()
                        .frame(height: 150)
                    goLoginButton()
                        .fullScreenCover(isPresented: $isClick, content: {
                            RegisterView(isClick: $isClick)
                        })
                    Spacer()
                }
                else{
                }
            }
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
                .clipShape(RoundedRectangle(cornerRadius: 5))
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
    @ViewBuilder
    func goLoginButton()-> some View{
        Button{
            isClick.toggle()
        }label: {
            Text("회원가입 또는 로그인하기")
                .padding()
                .foregroundStyle(.black)
                .fontWeight(.heavy)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke()
                        .foregroundStyle(.black)
                )
        }
    }
}
                   

#Preview {
    ProfileView()
}
