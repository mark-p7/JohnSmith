//
//  HomeView.swift
//  John smith
//
//  Created by Mark De Guzman on 2022-10-10.
//

import SwiftUI
import Firebase

struct HomeView: View {
    
    @ObservedObject var model = HomeViewModel()
    
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
        }
    }
    
    init() {
        model.getUsersData()
        model.getGroupsData()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
