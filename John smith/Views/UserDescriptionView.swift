//
//  UserDescriptionView.swift
//  John smith
//
//  Created by Hyeon Kim on 2022-11-24.
//

import SwiftUI
import Firebase

struct UserDescriptionView: View {
    var userId: String
    let user: String
    
    let uid = Auth.auth().currentUser?.uid
    
    @State private var about: String = ""
    @State private var gender: String = ""
    @State private var like: Bool = false
    
    var body: some View {
        VStack {
            Text("Current user ID is: \(userId)")
            Text("Current user name: \(user)")
            Text("About \(user): \(about)")
            Text("\(user)'s Gender: \(gender)")
            if (like == false) {
                Button("Like", action: likeUser)
            } else {
                Button("Unlike", action: unlikeUser)
                
            }
        }.onAppear(perform: readFirestore)
        
    }
    
    func likeUser() {
        let db = Firestore.firestore()
        db.collection("Users").document(userId).updateData(["pulledLikes" : FieldValue.arrayUnion([uid!])
        ])
        print("your uid is \(uid!)")
        like = true
    }
    
    func unlikeUser() {
        let db = Firestore.firestore()
        db.collection("Users").document(userId).updateData(["pulledLikes" : FieldValue.arrayRemove([uid!])
        ])
        like = false
    }
    
    func readFirestore() {
        let db = Firestore.firestore()
        db.collection("Users").document(userId).getDocument { (document, error) in
            if error == nil {
                if document != nil && document!.exists {
                    guard let documentData = document!.data() else {return}
                    let userAbout = documentData["about"] as! String
                    let userGender = documentData["gender"] as! String
                    about = userAbout
                    gender = userGender
                    if (documentData["pulledLikes"] as? [String] == nil) {
                        print("There is nothing here")
                    } else {
                        let userLikes = documentData["pulledLikes"] as! [String]
                        print(userLikes)
                        if userLikes.contains(uid!) {
                            print("exists")
                            like = true
                        } else {
                            print("not exists")
                            like = false
                        }
                    }
                    
//                    let userLikes = documentData["pulledLikes"] as! [String]
//                    if userLikes.contains(userId) {
//                        like = true
//                    } else {
//                        like = false
//                    }
                    
                    
                }
            }
        }
    }
}

struct UserDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        UserDescriptionView(userId: "111", user: "111")
    }
}
