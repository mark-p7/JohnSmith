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
        model.getMatchedUsersList()
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
<<<<<<< HEAD
        }.navigationBarTitle("")
            .navigationBarHidden(true)
=======
            Text("Matched Users").font(.title).bold()
            List(model.matchedUsersList) { user in
                Text(user.name).font(.title3).bold()
            }
            HStack {
                Button {
                    authViewModel.signOut()
                } label: {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .imageScale(.large)
                }.padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 10))
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "person.crop.circle")
                        .imageScale(.large)
                }.padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 30))
            }
        }
>>>>>>> MatchedUsersView
    }
}
