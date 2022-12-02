//
//  DashboardView.swift
//  John smith
//
//  Created by Mark De Guzman on 2022-10-14.
//

import SwiftUI

struct DashboardView: View {
    
    @ObservedObject var model = DashboardViewModel()
    @ObservedObject var profileViewModel = ProfileViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        dashboardInterfaceView
            .padding(/*@START_MENU_TOKEN@*/.top, -50.0/*@END_MENU_TOKEN@*/)
    }
    
    init() {
        model.getUsersData()
        model.getGroupsData()
        profileViewModel.getUserData()
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}

extension DashboardView {
    var dashboardInterfaceView: some View {
        NavigationView {
            VStack{
                VStack {
                    Text("\(profileViewModel.getName())")
                        .font(.title)
                    Text("\(profileViewModel.getGender())")
                        .font(.title2)
                    Text("\(profileViewModel.getAbout())")
                        .font(.title2)
                    NavigationLink(destination: ProfileView().navigationTitle("Profile")
                        .navigationBarTitleDisplayMode(.inline)
                    ) {
                        Text("Edit Profile")
                    }
                    
                }.font(.title)
                
                Text("Groups").font(.title).bold()
                List(model.groupList) { group in
                    Text(group.id).font(.title3).bold()
                }
                Text("Users").font(.title).bold()
                List(model.userList) { user in
                    Text(user.name).font(.title3).bold()
                }
                Button {
                    authViewModel.signOut()
                } label: {
                    Text("SignOut")
                }
            }
            .padding(.top, -50.0)
            .background(Color.blue)
        }.navigationBarTitle("")
            .navigationBarHidden(true)
    }
}
