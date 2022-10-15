//
//  DashboardView.swift
//  John smith
//
//  Created by Mark De Guzman on 2022-10-14.
//

import SwiftUI

struct DashboardView: View {
    
    @ObservedObject var model = DashboardViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack{
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
