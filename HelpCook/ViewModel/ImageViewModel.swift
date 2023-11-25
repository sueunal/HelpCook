//
//  ImageViewModel.swift
//  HelpCook
//
//  Created by sueun kim on 10/27/23.
//

import Foundation
import FirebaseStorage
import SwiftUI

func imageDonwload(){
    let storage = Storage.storage()
    let storageRef = storage.reference()
    let storageMeta = StorageMetadata()
    let pathReference = storage.reference(withPath: "UserProfile/Images/rivers.jpg")
    let gsReference = storage.reference(forURL: "gs://cooktook-6b52d.appspot.com/UserProfile/Images/rivers.jpg")
    let httpsReference = storage.reference(forURL: "https://firebasestorage.googleapis.com/b/bucket/o/images%20stars.jpg")
    // Create a reference to the file you want to download
    let islandRef = storageRef.child("UserProfile/Images/rivers.jpg")

    // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
    islandRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
      if let error = error {
        // Uh-oh, an error occurred!
      } else {
        // Data for "images/island.jpg" is returned
        let image = UIImage(data: data!)
      }
    }
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
            return
        }
        riversRef.downloadURL { (url, error) in
            guard let downloadURL = url else {
                return
            }
        }
    }
}
        
