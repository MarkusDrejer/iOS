//
//  FirebaseManager.swift
//  FirebaseLoginSpring
//
//  Created by admin on 03/04/2020.
//  Copyright © 2020 Markus. All rights reserved.
//

import Foundation
import FirebaseAuth

class Authentication {
    
    static var auth = Auth.auth()
    let parentVC:LoginController
    
    init(parentVC: LoginController) {
        self.parentVC = parentVC
        Authentication.auth.addIDTokenDidChangeListener { (auth, user) in
            if user != nil {
                print("Status: user is logged in: \(user.debugDescription)")
                parentVC.presentMapView()
            } else {
                print("Status: user is logged out")
                parentVC.moveToLogin()
            }
        }
    }
    
    static func signUp(email: String, pwd: String) {
        auth.createUser(withEmail: email, password: pwd) { (result, error) in
            if error == nil { // success
                print("successfully signed up to Firebase \(result.debugDescription)")
            } else {
                print("Failed to log in \(error.debugDescription)")
            }
        }
    }
    
    static func signIn(email: String, pwd: String) {
        auth.signIn(withEmail: email, password: pwd) { (result, error) in
            if error == nil {
                print("Successfully logged in")
            } else {
                print("Failed to log in")
            }
        }
    }
    
    static func signOut() {
        do {
            try auth.signOut()
        } catch let error {
            print("Error signing out \(error.localizedDescription)")
        }
    }
}
