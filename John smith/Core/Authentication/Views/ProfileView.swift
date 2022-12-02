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
            Text("Email: \(profileViewModel.getEmail())").padding(.bottom)
            
            Text("Name: \(profileViewModel.getName())")
            TextField("New Name: ", text: $editName) .padding(.top, -10.0)
            
            Text("Gender: \(profileViewModel.getGender())")
            TextField("New Gender: ", text: $editGender).padding(.top, -10.0)
            
            Text("About: \(profileViewModel.getAbout())").padding(.bottom, -5.0)
            TextField("Tell us about yourself: ", text: $editAbout).padding(.bottom, 20.0)
            
            HStack {
                Spacer()
                Button("Update") {
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
             }).buttonStyle(.borderedProminent)
                    .tint(Color("Secondary"))
                    .buttonBorderShape(.capsule)
            Spacer()
            }
            .padding(.vertical, 20.0)
            Spacer()
        }
        .padding(.horizontal, 30.0)
        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        
    }
}


