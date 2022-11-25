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
    //View model for profile
    @ObservedObject var profileViewModel = ProfileViewModel()
    //boolean for edit profile alert
    @State private var showingAlert: Bool = false
    //Variables that are changed using edit
    @State private var editAbout: String = ""
    @State private var editGender: String = ""
    @State private var editName: String = ""
    
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
        VStack(alignment: .leading) {
            Text("Email: \(profileViewModel.getEmail())")
            
            Text("Name: \(profileViewModel.getName())")
            TextField("Your Name: ", text: $editName)
            
            Text("Gender: \(profileViewModel.getGender())")
            TextField("Your Gender: ", text: $editGender)
            
            Text("About: \(profileViewModel.getAbout())")
            TextField("Tell us about yourself: ", text: $editAbout)
            
            Button("Edit") {
                showingAlert = true
            }.alert("Are you sure?", isPresented: $showingAlert, actions: {
                Button("Ok", role: .destructive, action: {
                    profileViewModel.editAbout(
                        changeAbout: editAbout,
                        changeGender: editGender,
                        changeName: editName
                    )
                    //Clear text fields afterwards
                    editName = ""
                    editGender = ""
                    editAbout = ""
                    //Reload data on profile page
                    profileViewModel.getUserData()
                })
             }, message: {
                Text("")
             })
            Spacer()
        }
        .padding(.horizontal, 20.0)
        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        
    }
}


