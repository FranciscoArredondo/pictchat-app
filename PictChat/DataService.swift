//
//  DataService.swift
//  PictChat
//
//  Created by Francisco on 7/21/17.
//
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

class DataService {
    fileprivate static let _instance = DataService()
    
    static var instance: DataService {
        return _instance
    }
    
    var mainReference: DatabaseReference {
        return Database.database().reference()
    }
    
    var usersReference: DatabaseReference {
        return mainReference.child("users")
    }
    
    var mainStorageReference: StorageReference {
        return Storage.storage().reference()
    }
    
    var imagesStorageReference: StorageReference {
        return mainStorageReference.child("images")
    }
    
    var videoStorageReference: StorageReference {
        return mainStorageReference.child("videos")
    }
    
    func saveUser(uid: String) {
        let profile: Dictionary<String, Any> = ["firstname": "", "lastname": ""]
        mainReference.child("users").child(uid).child("profile").setValue(profile)
    }
}
