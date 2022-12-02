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
            VStack(alignment: .leading) {
                Text("PROFILE")
                    .font(.system(size: 60))
                    .bold()
                    .foregroundColor(Color("Primary"))
                    .padding(EdgeInsets(
                        top: 140,
                        leading: 0,
                        bottom: 0,
                        trailing: 0))
                    .shadow(color: Color("Secondary"), radius: 5)
                Text("Did you change your name or something?")
                    .font(.system(size: 15))
                    .foregroundColor(Color("Primary"))
                    .padding(EdgeInsets(
                        top: 0,
                        leading: 0,
                        bottom: 25,
                        trailing: 0))
                    .shadow(color: Color("Secondary"), radius: 5)
            }
            
            Text("Email: \(profileViewModel.getEmail())").padding(.bottom)
                .font(.title2)
                .foregroundColor(Color("Tenary"))
            Text("Name: \(profileViewModel.getName())")
                .font(.title2)
                .foregroundColor(Color("Tenary"))
            TextField("New Name: ", text: $editName) .padding(.top, -10.0)
            
            Text("Gender: \(profileViewModel.getGender())")
                .font(.title2)
                .foregroundColor(Color("Tenary"))
            TextField("New Gender: ", text: $editGender).padding(.top, -10.0)
            
            Text("About: \(profileViewModel.getAbout())").padding(.bottom, -5.0)
                .font(.title2)
                .foregroundColor(Color("Tenary"))
            TextField("Tell us about yourself: ", text: $editAbout).padding(.bottom, 20.0)
            
            HStack {
                Spacer()
                Button {
                    showingAlert = true
                } label: {
                    Text("Update")
                        .frame(width: 150,height: 30)
                        .foregroundColor(Color("Tenary"))
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
        .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
    }
}


