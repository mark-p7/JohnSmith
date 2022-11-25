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
                    Text("Welcome \(profileViewModel.getName())")
                    NavigationLink(destination: ProfileView().navigationTitle("Profile")) {
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
        }
    }
}
