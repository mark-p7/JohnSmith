//
//  RegisterViewModel.swift
//  John smith
//
//  Created by Mark De Guzman on 2022-10-10.
//

import Foundation
import Firebase
import FirebaseFirestore

class AuthViewModel: ObservableObject {
    
    // If User is logged in, store user here
    @Published var userSession: FirebaseAuth.User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        print("DEBUG: USER UID is      \(self.userSession?.uid)")
        print("DEBUG: User session is  \(self.userSession)")
    }
    
    func login(withEmail email: String, password: String) {
        
        // Login a User
        Auth.auth().signIn(withEmail: email, password: password) { result, err in
            
            // If err, prints err and returns
            if let err = err {
                print("DEBUG: Failed to login with error \(err.localizedDescription)")
                return
            }
            
            // Login User client side
            guard let user = result?.user else { return }
            self.userSession = user
            
            // Print Login success
            print("DEBUG: Did log user in...")
        }
    }
    
    // Register User account
    func register(withEmail email: String, password: String, fullName: String, gender: String) {
        
        // Creates a User
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            // If err, prints err and returns
            if let error = error {
                print("DEBUG: Failed to register with error \(error.localizedDescription)")
                return
            }
            
            // Login User client side
            guard let user = result?.user else { return }
            self.userSession = user
            
            // Notifies User change
            print("DEBUG: Registered user successfully")
            print("DEBUG: User is \(self.userSession)")
            
            // Creates User data
            let data: [String: Any] = [
                "email": email,
                "name": fullName,
                "id": user.uid,
                "about": "",
                "gender": gender,
                "pulledLikes": [""],
                "pushedLikes": [""],
                "matches": [""]
                ]
            
            // Create User document
            Firestore.firestore().collection("Users")
                .document(user.uid)
                .setData(data) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
        }
    }
    
    func signOut() {
        
        // Signs out current User client side
        userSession = nil
        
        // Signs out current user server side
        try? Auth.auth().signOut()
    }
}

