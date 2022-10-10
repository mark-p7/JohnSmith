//
//  RegisterViewModel.swift
//  John smith
//
//  Created by Mark De Guzman on 2022-10-10.
//

import Foundation
import Firebase

class RegisterViewModel: ObservableObject {
    
    func register(paramEmail: String, paramPassword: String) {
        Auth.auth().createUser(withEmail: paramEmail, password: paramPassword) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
            
        }
    }

}

