//
//  OtherUserView.swift
//  John smith
//
//  Created by Hyeon Kim on 2022-11-24.
//

import SwiftUI
import Firebase

struct OtherUserView: View {
    var userId: String
    let user: String
    
    let uid = Auth.auth().currentUser?.uid
    
    @State private var about: String = ""
    @State private var gender: String = ""
    @State private var like: Bool = false
    
    var body: some View {
        VStack {
//            Text("Current user ID is: \(userId)")
//            Text("Current user name: \(user)")
            Text(user).font(.title).bold()
            Text("About : \(about)").font(.title2)
            Text("\(user)'s Gender: \(gender)").font(.title2)
            if (like == false) {
                Button("Like", action: likeUser)
                    .buttonStyle(.borderedProminent)
                    .tint(Color("Primary"))
                    .buttonBorderShape(.capsule)
            } else {
                Button("Unlike", action: unlikeUser)
                    .buttonStyle(.borderedProminent)
                    .tint(Color.red)
                    .buttonBorderShape(.capsule)
                
            }
        }.onAppear(perform: readFirestore)
        
    }
    
    func likeUser() {
        let db = Firestore.firestore()
        var temp: Array<String> = []
        db.collection("Users").document(userId).updateData(["pulledLikes" : FieldValue.arrayUnion([uid!])
        ])
        db.collection("Users").document(uid!).updateData(["pushedLikes" : FieldValue.arrayUnion([userId])
        ])
        print("your uid is \(uid!)")
        db.collection("Users").document(userId).getDocument { (document, error) in
            if error == nil {
                if document != nil && document!.exists {
                    guard let documentData = document!.data() else {return}
                    let pushedLikes = documentData["pushedLikes"] as! [String]
                    temp = pushedLikes
                    print("in like user")
                    print(temp)
                    if temp.contains(uid!) {
                        db.collection("Users").document(userId).updateData(["matches" : FieldValue.arrayUnion([uid!])
                        ])
                        db.collection("Users").document(uid!).updateData(["matches" : FieldValue.arrayUnion([userId])
                        ])
                    }

                }
            }
        }
        like = true
    }
    
    func unlikeUser() {
        let db = Firestore.firestore()
        var temp: Array<String> = []

        db.collection("Users").document(userId).updateData(["pulledLikes" : FieldValue.arrayRemove([uid!])
        ])
        db.collection("Users").document(uid!).updateData(["pushedLikes" : FieldValue.arrayRemove([userId])
        ])
        db.collection("Users").document(userId).getDocument { (document, error) in
            if error == nil {
                if document != nil && document!.exists {
                    guard let documentData = document!.data() else {return}
                    let matches = documentData["matches"] as! [String]
                    temp = matches
                    print("in unlike user")
                    print(temp)
                    if temp.contains(uid!) {
                        db.collection("Users").document(userId).updateData(["matches" : FieldValue.arrayRemove([uid!])
                        ])
                        db.collection("Users").document(uid!).updateData(["matches" : FieldValue.arrayRemove([userId])
                        ])
                    }

                }
            }
        }
        
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
        OtherUserView(userId: "111", user: "111")
    }
}
