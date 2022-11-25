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
    @EnvironmentObject var authViewModel: AuthViewModel
    
    let uid = Auth.auth().currentUser?.uid
    
    var body: some View {
        dashboardInterfaceView
    }
    
    init() {
        model.getUsersData()
        model.getGroupsData()
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
            // Text(uid!)
            Text("Groups").font(.title).bold()
            List(model.groupList) { group in
                NavigationLink("\(group.id)",destination: GroupView (groupName: group.id, currentUser: uid!))
        //                Text(group.id).font(.title3).bold()
            }.font(.title3)
            Text("Users").font(.title).bold()
            List(model.userList) { user in
                NavigationLink("\(user.name)", destination: UserView (userName: user.name, desctiption: user.desctiption, gender: user.gender))
        //                Text(user.name).font(.title3).bold()
            }
            // my change
            HStack{
                
                Button {
                    authViewModel.signOut()
                } label: {
                    Text("SignOut")
                }
                NavigationLink("Create Group", destination: CreateGroupView())
                
            }
        }
    }
    
}
