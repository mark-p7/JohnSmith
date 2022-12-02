//
//  DashboardView.swift
//  John smith
//
//  Created by Mark De Guzman on 2022-10-14.
//

import SwiftUI
import Firebase

struct DashboardView: View {
    
    @ObservedObject var model = DashboardViewModel()
    @ObservedObject var profileViewModel = ProfileViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    
    let uid = Auth.auth().currentUser?.uid
    
    var body: some View {
        dashboardInterfaceView
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
        VStack{
            HStack{
                Button {
                    authViewModel.signOut()
                } label: {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .imageScale(.large)
                }.padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 10))
                    .foregroundColor(Color("Tenary"))
                Spacer()
                HStack {
                    Text("Hi, \(profileViewModel.getName())!").foregroundColor(Color("Primary"))
                        .font(.title2)
                        .bold()
                        .padding()
                    NavigationLink(destination: ProfileView()
                        .navigationTitle("My Profile")
                        .navigationBarTitleDisplayMode(.inline)
                    ) {
                        Image(systemName: "person.crop.circle")
                            .imageScale(.large)
                    }.padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 30))
                        .foregroundColor(Color("Tenary"))
                }
            }
            HStack {
                Text("Groups").font(.title).bold().foregroundColor(Color("Primary"))
                NavigationLink(destination: CreateGroupView()
                    .navigationBarTitleDisplayMode(.inline)
                ) {
                    Image(systemName: "plus.square")
                }.padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                    .foregroundColor(Color("Tenary"))
            }
            List(model.groupList) { group in
                NavigationLink("\(group.id)",destination: GroupView (groupName: group.id, currentUser: uid!))
                    .foregroundColor(Color("Tenary"))
            }.font(.title3).listRowBackground(Color("Secondary"))
            Text("Matched Users").font(.title).bold().foregroundColor(Color("Primary"))
            List(model.matchedUsersList) { user in
                Text(user.name).font(.title3).bold()
                    .foregroundColor(Color("Tenary"))
            }.listRowBackground(Color("Secondary"))
        }.onAppear {
            profileViewModel.getUserData()
        }
        
    }
}

