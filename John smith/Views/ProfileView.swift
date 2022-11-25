//
//  ProfileView.swift
//  John smith
//
//  Created by Hyeon Kim on 2022-11-18.
//

import SwiftUI
import Firebase

struct ProfileView: View {
    let currentUser: String
//    let name: String
//    let gender: String
//    let email: String
//    let about: String
    
    
    var body: some View {
        Text("\(currentUser)")
//        Text("\(name)")
//        Text("\(gender)")
//        Text("\(email)")
//        Text("\(about)")
    }
    
    func addGroup() {
        let db = Firestore.firestore()
        db.collection("Users").document(currentUser)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(currentUser: "111")
    }
}
