//
//  ProfileView.swift
//  HelpCook
//
//  Created by sueun kim on 10/25/23.
//

import SwiftUI
import PhotosUI
import FirebaseStorage
struct ProfileView: View {
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State private var profileImage = Image(systemName: "person.fill")
    
    var body: some View {
        VStack{
            profileImage
                .resizable()
                .onAppear{
                    imageDonwload()
                }
            PhotosPicker(
                selection: $selectedItem,
                matching: .images
            ){
                photoSelectView()
            }
            .onChange(of: selectedItem) { newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        selectedImageData = data
                        StorageManger(data: data)
                    }
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
    func imageDonwload(){
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let pathReference = storage.reference(withPath: "UserProfile/Images/rivers.jpg")
        let gsReference = storage.reference(forURL: "gs://cooktook-6b52d.appspot.com/UserProfile/Images/rivers.jpg")
        // Create a reference to the file you want to download
        let islandRef = storageRef.child("UserProfile/Images/rivers.jpg")
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        islandRef.getData(maxSize: 1 * 3068 * 3068 ) { data, error in
            if let error = error {
                print(error)
            } else {
                // Data for "images/island.jpg" is returned
                if let donwloadImage = UIImage(data: data!){
                   profileImage = Image(uiImage: donwloadImage)
                }
            }
        }
    }
}
                   

#Preview {
    ProfileView()
}
