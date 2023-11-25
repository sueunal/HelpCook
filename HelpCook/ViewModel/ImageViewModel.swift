//
//  ImageViewModel.swift
//  HelpCook
//
//  Created by sueun kim on 10/27/23.
//

import Foundation
import FirebaseStorage

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
        let size = metadata.size
        print(metadata.name)
        riversRef.downloadURL { (url, error) in
            guard let downloadURL = url else {
                return
            }
        }
    }
}
        
