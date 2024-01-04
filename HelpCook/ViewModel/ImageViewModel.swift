//
//  ImageViewModel.swift
//  HelpCook
//
//  Created by sueun kim on 10/27/23.
//

import Foundation
import FirebaseStorage
import FirebaseAuth
import SwiftUI


class ImageViewModel: ObservableObject {
    @Published var profileImage: Image?
    
    init() {
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
    func uploadImage(image: UIImage, completion: @escaping(URL) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.1) else { return }
        
        guard let fileName = Auth.auth().currentUser?.uid else {
            debugPrint("[ERROR] : ImageUploader에서 유저 세션 nil")
            return
        }
        let storageReference = Storage.storage().reference(withPath: "/profile_images/\(fileName)")
        storageReference.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print("[ERROR] : 프로필 이미지 업로드 실패 : \(error.localizedDescription)")
            }
            
            storageReference.downloadURL { imageURL, error in
                if let error = error {
                    print("[ERROR] : URL 다운로드 실패 : \(error.localizedDescription)")
                }
                
                guard let imageURL = imageURL else { return }
                completion(imageURL)
            }
        }
    }
    func downloadImage() {
        guard let fileName = Auth.auth().currentUser?.uid else {
            debugPrint("[ERROR] : ImageUploader에서 유저 세션 nil")
            return
        }
        let storageReference = Storage.storage().reference(withPath: "/profile_images/\(fileName)")
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let islandRef = storageRef.child("/profile_images/\(fileName)")
        
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
