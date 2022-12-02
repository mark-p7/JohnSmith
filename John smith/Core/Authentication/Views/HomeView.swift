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
    @State private var navigationAction: Int? = 0
    
    var body: some View {
        // If User is nil then display Home Screen else Display Dashboard Screen
        
        // Preview purposes
        // homeInterfaceView
        
        // Development
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
        NavigationView {
            VStack{
                // App Name
                Text("John Smith")
                    .font(.system(size: 60))
                    .bold()
                    .foregroundColor(Color("Primary"))
                    .shadow(color: Color("Secondary"), radius: 5)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                
                // Slogan
                Text("Just humans interacting with other humans")
                    .frame(alignment: .center)
                    .font(.system(size: 15))
                    .foregroundColor(Color("Primary"))
                    .shadow(color: Color("Secondary"), radius: 5)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 50, trailing: 20))
                
                // Register Button
                NavigationLink(destination: RegisterView(), tag: 1, selection: $navigationAction){}
                    Button {
                        self.navigationAction = 1
                    }
                    label: {
                        Text("Register")
                            .padding()
                            .frame(width: 150,height: 35)
                            .foregroundColor(Color("Tenary"))
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color("Secondary"))
                    .buttonBorderShape(.capsule)
                    .padding()
                
                // Login Button
                NavigationLink(destination: LoginView(), tag: 2, selection: $navigationAction){}
                    Button {
                        self.navigationAction = 2
                    }
                    label: {
                        Text("Login")
                            .frame(width: 150,height: 35)
                            .foregroundColor(Color("Tenary"))
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color("Secondary"))
                    .buttonBorderShape(.capsule)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
                
            }
        }
    }
    
}
