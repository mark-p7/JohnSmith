//
//  HomeView.swift
//  John smith
//
//  Created by Mark De Guzman on 2022-10-10.
//

import SwiftUI
import Firebase

struct HomeView: View {
    
//    @ObservedObject var model = HomeViewModel()
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        // If User is nil then display Home Screen else Display Dashboard Screen
        if viewModel.userSession?.uid == nil {
            homeInterfaceView
        } else {
            DashboardView()
        }
    }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension HomeView {
    
    var homeInterfaceView: some View {
        VStack{
            Text("LandingPage").font(.title).bold()
            NavigationLink(destination: RegisterView()){
                Text("Register")
            }
        }
    }
    
}
