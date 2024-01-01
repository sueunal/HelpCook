//
//  ImageViewModel.swift
//  HelpCook
//
//  Created by sueun kim on 10/27/23.
//

import Foundation
import FirebaseStorage
import SwiftUI


class ImageViewModel: ObservableObject {
    @Published var profileImage: Image?
    
    init() {
        downloadImage()
    }
    func StorageManger(data: Data){
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let storageMeta = StorageMetadata()
        storageMeta.contentType = "image/jpeg"
        
        let riversRef = storageRef.child("UserProfile/Images/rivers.jpg")
        riversRef.putData(data,metadata: storageMeta)
        
        let uploadTask = riversRef.putData(data, metadata: storageMeta) { (metadata, error) in
            guard let metadata = metadata else {
                print(metadata?.md5Hash)
                return
            }
            guard let error = error else{
                print(error?.localizedDescription)
                return
            }
            riversRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    return
                }
            }
        }
    }
    func downloadImage() {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let islandRef = storageRef.child("UserProfile/Images/rivers.jpg")
        
        islandRef.getData(maxSize: 4048 * 4048) { data, error in
            if let error = error {
                print("문제가 발생했습니다. \(error.localizedDescription)")
            } else {
                if let data = data, let downloadedImage = UIImage(data: data) {
                    self.profileImage = Image(uiImage: downloadedImage)
                    print("Success!")
                }
            }
        }
    }
}
