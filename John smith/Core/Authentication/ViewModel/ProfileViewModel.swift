//
//  ProfileViewModel.swift
//  John smith
//
//  Created by Michael on 2022-11-24.
//

import Foundation
import Firebase
import FirebaseFirestore

class ProfileViewModel: ObservableObject {
    
    @Published var userEmail = ""
    @Published var userName = ""
    @Published var userGender = ""
    @Published var userAbout = ""

    func getUserID() -> String {
        let userID : String = (Auth.auth().currentUser?.uid)!
        print("Current user ID is" + userID)
        
        return userID
    }
    
    
    func getUserData() -> Void {
        let db = Firestore.firestore()
        let docRef = db.collection("Users").document(getUserID())
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                    let dataDescription = document.data()
                    self.userEmail = dataDescription?["email"] as! String
                    self.userName = dataDescription?["name"] as! String
                    self.userGender = dataDescription?["gender"] as! String
                    self.userAbout = dataDescription?["about"] as! String
                    print(self.userEmail)
                } else {
                    print("Document does not exist")
                }
        }
    }
    
    
    func getEmail() -> String {
        //getUserData()
        return userEmail
    }
    
    func getName() -> String {
        //getUserData()
        return userName
    }
    
    func getGender() -> String {
        //getUserData()
        return userGender
    }
    
    func getAbout() -> String {
        //getUserData()
        return userAbout
    }
    
    func testWrite(change: String) {
        print(change)
        let db = Firestore.firestore()
        db.collection("Users").document(getUserID()).updateData([
            "about" : change
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
}
