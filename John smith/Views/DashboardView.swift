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
        dashboardInterfaceView
    }
    
    init() {
        model.getUsersData()
        model.getGroupsData()
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
            Text("Groups").font(.title).bold()
            List(model.groupList) { group in
                Text(group.id).font(.title3).bold()
            }
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
    }
}
