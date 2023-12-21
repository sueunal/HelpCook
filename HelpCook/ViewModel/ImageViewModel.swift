//
//  ImageViewModel.swift
//  HelpCook
//
//  Created by sueun kim on 10/27/23.
//

import Foundation
import FirebaseStorage
import SwiftUI


class ImageViewModel: ObservableObject{
    @Published var profileImage: Image = Image(systemName: "person.circle.fill")
    @Published var isDownload: Bool = false
    
    func StorageManger(data: Data){
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let storageMeta = StorageMetadata()
        storageMeta.contentType = "image/jpeg"
        
        let riversRef = storageRef.child("UserProfile/Images/rivers.jpg")
        riversRef.putData(data,metadata: storageMeta)
        
        let uploadTask = riversRef.putData(data, metadata: storageMeta) { (metadata, error) in
            guard let metadata = metadata else {
                print(metadata)
                return
            }
            riversRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    return
                }
            }
        }
    }
    func imageDonwload(){
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let islandRef = storageRef.child("UserProfile/Images/rivers.jpg")
        
        if self.profileImage != Image(systemName: "person.circle.fill"){
            print("not Empty")
        }
        else{
            islandRef.getData(maxSize: 4048 * 4048 ){data, error in
                if let error = error {
                    self.isDownload = false
                    print(error)
                } else {
                    if let donwloadImage = UIImage(data: data!){
                        self.profileImage = Image(uiImage: donwloadImage)
                        self.isDownload = true
                        print("Success!")
                    }
                }
            }
        }
    }
}
