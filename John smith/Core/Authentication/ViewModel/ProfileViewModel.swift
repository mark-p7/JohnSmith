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
    //Variables as is for dumping from firestore
    @Published var userEmail = ""
    @Published var userName = ""
    @Published var userGender = ""
    @Published var userAbout = ""
    
    //pulls user id from signed in user to query documents, does not check if user is logged in because user must be logged in
    func getUserID() -> String? {
        let userID : String? = (Auth.auth().currentUser?.uid)
        if userID != nil {
            print("Current user ID is" + userID!)
            return userID
        }
        return ""
    }
    
    //Pulls firestore db document as dictionary and dumps data into local variables
    func getUserData() -> Void {
        let db = Firestore.firestore()
        var docID = getUserID()
        if (docID == "") {
            return;
        }
        let docRef = db.collection("Users").document(docID!)
        
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
    
    //Getters for each variable for clarity
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
    
    //Edits the about category under user
    func editAbout(changeAbout: String, changeGender: String, changeName: String) {
        print(changeAbout)
        var about = changeAbout
        var gender = changeGender
        var name = changeName
        
        //Checks if input fields are empty
        if(changeAbout.isEmpty) {
          about = getAbout()
        }
        
        if(changeGender.isEmpty) {
            gender = getGender()
        }
        
        if(changeName.isEmpty) {
            name = getName()
        }
        
        let db = Firestore.firestore()
        var docID = getUserID()
        if (docID == "") {
            print("Error updating document")
            return;
        }
        db.collection("Users").document(docID!).updateData([
            "about" : about,
            "gender" : gender,
            "name" : name
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
}
