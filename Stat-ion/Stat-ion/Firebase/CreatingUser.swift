//
//  CreatingUser.swift
//  Stat-ion
//
//  Created by furkan vural on 8.04.2023.
//

import Foundation
import FirebaseAuth

struct FirebaseUserCreateFunction{
    
    func createUser(on vc: UIViewController){
        let currentUser = Auth.auth().currentUser
        if currentUser == nil {
            Auth.auth().signInAnonymously { data, error in
                if error != nil{
                    Alert.showFirebaseLoginError(on: vc, with: Text.errorTitle, message: Text.errorMessageLogIn)
                }
            }
        }
    }
}


