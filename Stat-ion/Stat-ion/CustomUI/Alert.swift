//
//  Alert.swift
//  Stat-ion
//
//  Created by furkan vural on 8.04.2023.
//

import Foundation
import UIKit

struct Alert {
    
    private static func showBasicAlert(on vc: UIViewController, with title: String, message: String ){
        let alert  = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let button = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(button)
        DispatchQueue.main.async {
            vc.present(alert, animated: true)
        }
    }
    
    static func showFirebaseLoginError(on vc: UIViewController, with title: String, message: String){
        showBasicAlert(on: vc, with: title, message: message)
    }
    
    static func showFirebaseGetDataError(on vc: UIViewController, with title: String, message: String){
        showBasicAlert(on: vc, with: title, message: message)
    }
    
    static func showAlert(on vc: UIViewController, with title: String, message: String){
        showBasicAlert(on: vc, with: title, message: message)
    }
}
