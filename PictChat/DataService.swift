//
//  DataService.swift
//  PictChat
//
//  Created by Francisco on 7/21/17.
//
//

import Foundation
import FirebaseDatabase

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
    
    func saveUser(uid: String) {
        let profile: Dictionary<String, Any> = ["firstname": "", "lastname": ""]
        mainReference.child("users").child(uid).child("profile").setValue(profile)
    }
}
