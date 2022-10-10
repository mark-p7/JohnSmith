//
//  RegisterView.swift
//  John smith
//
//  Created by Mark De Guzman on 2022-10-10.
//

import SwiftUI

struct RegisterView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack{
            Text("JOIN NOW")
                .font(.title)
                .bold()
                .padding(EdgeInsets(
                    top: 50,
                    leading: 10,
                    bottom: 10,
                    trailing: 10))
            VStack{
                TextField("Email", text: $email)
                    .foregroundColor(.black)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                SecureField("Password", text: $password)
                    .foregroundColor(.black)
                    .font(.title2)
                    .multilineTextAlignment(.center)
            }
            Spacer()
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
