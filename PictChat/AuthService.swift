//
//  AuthService.swift
//  PictChat
//
//  Created by Francisco on 7/21/17.
//
//

import Foundation
import FirebaseAuth

typealias Completion = (_ errMsg: String?, _ data: Any?) -> Void

class AuthService {
    fileprivate static let _instance = AuthService()
    
    static var instance: AuthService {
        return _instance
    }
    
    func login(email: String, password: String, onComplete: @escaping Completion) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if error != nil {
                if let errorCode = AuthErrorCode(rawValue: (error?._code)!) {
                    if errorCode == .userNotFound {
                       Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            self.handleAuthError(error: error! as NSError, onComplete: onComplete)
                        } else {
                            if user?.uid != nil {
                                // Sign in
                                Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                                    if error != nil {
                                        self.handleAuthError(error: error! as NSError, onComplete: onComplete)
                                    } else {
                                        onComplete(nil, user)
                                    }
                                })
                            }
                        }
                       })
                    }
                } else {
                    self.handleAuthError(error: error! as NSError, onComplete: onComplete)
                }
            } else {
                onComplete(nil, user)
            }
        }
    }
    
    func handleAuthError(error: NSError, onComplete: Completion?) {
        print(error.debugDescription)
        if let errorCode = AuthErrorCode(rawValue: error.code) {
            switch errorCode {
            case .invalidEmail:
                onComplete?("Invaild email address", nil)
            case .wrongPassword:
                onComplete?("Invaild Password", nil)
            case .emailAlreadyInUse, .accountExistsWithDifferentCredential:
                onComplete?("Could not create account. Email is already in use.", nil)
            default:
                onComplete?("There was a problem authenticating. Try again", nil)
            }
        }
    }
}
