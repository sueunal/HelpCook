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
    @ObservedObject var imageViewModel = ImageViewModel()
    
    var body: some View {
        VStack{
            PhotosPicker(
                selection: $selectedItem,
                matching: .images
            ){
                if imageViewModel.isDownload{
                   loadedView()
                }else{
                    photoSelectView()
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
        }.onAppear{
            imageViewModel.imageDonwload()
        }
    }
    @ViewBuilder
    func loadedView()-> some View{
        imageViewModel.profileImage
            .resizable()
            .frame(width: 150, height: 150)
            .clipShape(Circle())
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .background {
                Circle().fill(
                    LinearGradient(
                        colors: [.yellow, .orange],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
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
                    Circle().fill(
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
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .foregroundStyle(.black)
                .background {
                    Circle().fill(
                        LinearGradient(
                            colors: [.yellow, .orange],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                }
        }
    }
}
                   

#Preview {
    ProfileView()
}
