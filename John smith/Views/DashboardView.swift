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
                Spacer()
                HStack {
                    Text("Hi, \(profileViewModel.getName())!")
                        .font(.title2)
                        .bold()
                        .padding()
                    NavigationLink(destination: ProfileView()
                        .navigationBarTitleDisplayMode(.inline)
                    ) {
                        Image(systemName: "person.crop.circle")
                            .imageScale(.large)
                    }.padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 30))
                }
            }
            Text("Groups").font(.title).bold()
            List(model.groupList) { group in
                Text(group.id).font(.title3).bold()
            }
            Text("Matched Users").font(.title).bold()
            List(model.matchedUsersList) { user in
                Text(user.name).font(.title3).bold()
            }
        }.onAppear {
            profileViewModel.getUserData()
        }
        
    }
    
}

