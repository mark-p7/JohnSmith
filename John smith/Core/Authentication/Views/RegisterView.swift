//
//  RegisterView.swift
//  John smith
//
//  Created by Mark De Guzman on 2022-10-10.
//

import SwiftUI

struct RegisterView: View {
    
    // UserObject
    @EnvironmentObject var viewModel: AuthViewModel
    
    // Connect to RegisterViewModel
    // @ObservedObject var model = RegisterViewModel()

    // State variables for email and password
    @State private var email = ""
    @State private var password = ""
    
    // State variables for error messages
    @State private var alert = false
    @State private var alertMessage = ""

    var body: some View {
            if viewModel.userSession == nil {
                
                registerInterfaceView
            } else {
                DashboardView()
            }
    }
    
    // Checks if Email is Valid
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
}

extension RegisterView {
    
    var registerInterfaceView: some View {
        VStack{
            Text("Email: \(self.email)")
            Text("Password: \(self.password)")
            Text("JOIN NOW")
                .font(.title)
                .bold()
                .padding(EdgeInsets(
                    top: 50,
                    leading: 10,
                    bottom: 10,
                    trailing: 10))
            VStack{
                // Email and Password Textfields
                TextField("Email", text: $email)
                    .foregroundColor(.black)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                SecureField("Password", text: $password)
                    .foregroundColor(.black)
                    .font(.title2)
                    .multilineTextAlignment(.center)
            }
            // Register Button
            Button("Register", action: {
                // Checks if email is valid
                if (!isValidEmail(self.email)) {
                    // Displays alert if email is not valid
                    self.alertMessage = "Email is not valid"
                    self.alert = true
                    return;
                }
//                model.register(paramEmail: self.email, paramPassword: self.password)
            })
            Spacer()
        }.alert(self.alertMessage, isPresented: $alert) {
            Button("OK", role: .cancel) {
                self.alert = false
                self.alertMessage = ""
            }
        }
    }
    
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
