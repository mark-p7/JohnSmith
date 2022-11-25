//
//  ProfileView.swift
//  John smith
//
//  Created by Michael on 2022-11-24.
//

import SwiftUI
import Firebase
import FirebaseFirestore



struct ProfileView: View {
    @ObservedObject var profileViewModel = ProfileViewModel()
    @State private var showingAlert: Bool = false
    
    @State private var testmsg: String = ""
    
    var body: some View {
        profileInterfaceView
    }
    
    init() {
        profileViewModel.getUserData()
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

extension ProfileView {
    
    var profileInterfaceView: some View {
        VStack {
            //Text("UID: \(profileViewModel.getUserID())")
            Text("Email: \(profileViewModel.getEmail())")
            Text("Name: \(profileViewModel.getName())")
            Text("Gender: \(profileViewModel.getGender())")
            Text("About: \(profileViewModel.getAbout())")
            TextField("Enter test: ", text: $testmsg)
            Button("Edit") {
                showingAlert = true
            }.alert("Confirm changes?", isPresented: $showingAlert, actions: {
                Button("Ok", role: .destructive, action: {
                    profileViewModel.testWrite(change: testmsg)
                    profileViewModel.getUserData()
                })
             }, message: {
                Text("Yes")
             })
        }
    }
}


