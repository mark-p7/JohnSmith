//
//  UserContactView.swift
//  John smith
//
//  Created by Hyeon Kim on 2022-12-02.
//

import SwiftUI
import Firebase


struct UserContactView: View {
    let userId: String
    
    @State private var about: String = ""
    @State private var gender: String = ""
    @State private var email: String = ""
    @State private var name: String = ""

    
    var body: some View {
        VStack {
            Text("PROFILE")
                .font(.system(size: 60))
                .bold()
                .foregroundColor(Color("Primary"))
                .padding(EdgeInsets(
                    top: 0,
                    leading: 0,
                    bottom: 15,
                    trailing: 0))
                .shadow(color: Color("Secondary"), radius: 5)
            Text("Name: \(name)")
                .font(.title3)
                .foregroundColor(Color("Tenary"))
                .padding(.vertical, 15)
            Text("Gender: \(gender)")
                .font(.title2)
                .foregroundColor(Color("Tenary"))
                .padding(.vertical, 15)
            Text("About: \(about)")
                .font(.title2)
                .foregroundColor(Color("Tenary"))
                .padding(.vertical, 15)
            Text("Email: \(email)")
                .font(.title2)
                .foregroundColor(Color("Tenary"))
                .padding(.vertical, 15)
        }
        .onAppear{readFirestore()}
        
    }
    
    func readFirestore() {
        let db = Firestore.firestore()
        db.collection("Users").document(userId).getDocument { (document, error) in
            if error == nil {
                if document != nil && document!.exists {
                    guard let documentData = document!.data() else {return}
                    let userAbout = documentData["about"] as! String
                    let userGender = documentData["gender"] as! String
                    let userName = documentData["name"] as! String
                    let userEmail = documentData["email"] as! String
                    about = userAbout
                    gender = userGender
                    email = userEmail
                    name = userName
                }
            }
        }
    }
}

struct UserContactView_Previews: PreviewProvider {
    static var previews: some View {
        UserContactView(userId: "111")
    }
}
