//
//  RegisterView.swift
//  John smith
//
//  Created by Mark De Guzman on 2022-10-10.
//

import SwiftUI

struct RegisterView: View {
    
    // UserObject
    @EnvironmentObject var authViewModel: AuthViewModel
    
    // Connect to RegisterViewModel
    // @ObservedObject var model = RegisterViewModel()
    
    // State variables for user data
    @State private var email = ""
    @State private var password = ""
    @State private var fullName = ""
    @State private var gender = ""
    
    // State variables for error messages
    @State private var alert = false
    @State private var alertMessage = ""
    
    var body: some View {
        registerInterfaceView
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
            // Title
            Text("JOIN NOW")
                .font(.system(size: 60))
                .bold()
                .foregroundColor(Color("Primary"))
                .padding(EdgeInsets(
                    top: 50,
                    leading: 0,
                    bottom: 0,
                    trailing: 0))
                .shadow(color: Color("Secondary"), radius: 5)
            Text("(It's free)")
                .font(.system(size: 15))
                .foregroundColor(Color("Primary"))
                .padding(EdgeInsets(
                    top: 0,
                    leading: 0,
                    bottom: 25,
                    trailing: 0))
                .shadow(color: Color("Secondary"), radius: 5)
            VStack{
                // Email and Password Textfields
                TextField("Name", text: $fullName)
                    .foregroundColor(.black)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
                TextField("Gender", text: $gender)
                    .foregroundColor(.black)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding()
                    .autocapitalization(.none)
                TextField("Email", text: $email)
                    .foregroundColor(.black)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .textInputAutocapitalization(.never)
                    .padding()
                    .autocapitalization(.none)
                SecureField("Password", text: $password)
                    .foregroundColor(.black)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .textInputAutocapitalization(.never)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 35, trailing: 10))
                    .autocapitalization(.none)
                // Register Button
                Button {
                    // Checks if email is valid
                    if (!isValidEmail(self.email)) {
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
                    if (self.fullName == "") {
                        self.alertMessage = "Name is not valid"
                        self.alert = true
                        return;
                    }
                    if (self.gender == "") {
                        self.alertMessage = "Gender is not valid"
                        self.alert = true
                        return;
                    }
                    authViewModel.register(withEmail: self.email, password: self.password, fullName: self.fullName, gender: self.gender)
                }
            label: {
                Text("Register")
                    .frame(width: 150,height: 30)
                    .foregroundColor(Color("Tenary"))
            }
            .buttonStyle(.borderedProminent)
            .tint(Color("Secondary"))
            .buttonBorderShape(.capsule)
            }.padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
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
