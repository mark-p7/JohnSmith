//
//  LoginView.swift
//  John smith
//
//  Created by Mark De Guzman on 2022-10-10.
//

import SwiftUI

struct LoginView: View {
    
    // UserObject
    @EnvironmentObject var authViewModel: AuthViewModel
    
    // State variables for user data
    @State private var email = ""
    @State private var password = ""
    
    // State variables for error messages
    @State private var alert = false
    @State private var alertMessage = ""
    
    var body: some View {
        loginInterfaceView
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

extension LoginView {
    
    var loginInterfaceView: some View {
        VStack {
            Text("LOGIN")
                .font(.system(size: 60))
                .bold()
                .foregroundColor(Color("Primary"))
                .padding(EdgeInsets(
                    top: 180,
                    leading: 0,
                    bottom: 0,
                    trailing: 0))
                .shadow(color: Color("Secondary"), radius: 5)
            Text("Hi! (with rizz)")
                .font(.system(size: 15))
                .foregroundColor(Color("Primary"))
                .padding(EdgeInsets(
                    top: 0,
                    leading: 0,
                    bottom: 25,
                    trailing: 0))
                .shadow(color: Color("Secondary"), radius: 5)
            TextField("Email", text: $email)
                .foregroundColor(.black)
                .font(.title2)
                .multilineTextAlignment(.center)
                .autocapitalization(.none)
                .padding()
            SecureField("Password", text: $password)
                .foregroundColor(.black)
                .font(.title2)
                .multilineTextAlignment(.center)
                .autocapitalization(.none)
                .padding()
            Button {
                // Checks if email is valid
                if (self.email == "") {
                    // Displays alert if email is not valid
                    self.alertMessage = "Email is not valid"
                    self.alert = true
                    return;
                }
                if (self.password == "") {
                    self.alertMessage = "Password is not valid"
                    self.alert = true
                    return;
                }
                authViewModel.login(withEmail: self.email, password: self.password)
            } label: {
                Text("Login")
                    .frame(width: 150,height: 30)
                    .foregroundColor(Color("Tenary"))
            }
            .buttonStyle(.borderedProminent)
            .tint(Color("Secondary"))
            .buttonBorderShape(.capsule)
            .padding(EdgeInsets(top: 25, leading: 0, bottom: 0, trailing: 0))
            Spacer()
        }.alert(self.alertMessage, isPresented: $alert) {
            Button("OK", role: .cancel) {
                self.alert = false
                self.alertMessage = ""
            }
        }
    }
    
}
