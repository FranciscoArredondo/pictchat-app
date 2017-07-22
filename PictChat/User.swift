//
//  User.swift
//  PictChat
//
//  Created by Francisco on 7/21/17.
//
//

import Foundation

struct User {
    fileprivate var _firstName: String
    fileprivate var _uid: String
    
    var uid: String {
        return _uid
    }
    
    var firstName: String {
        return _firstName
    }
    
    init(uid: String, firstName: String) {
        _uid = uid
        _firstName = firstName
    }
}
