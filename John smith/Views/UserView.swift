//
//  UserView.swift
//  John smith
//
//  Created by Hyeon Kim on 2022-11-18.
//

import SwiftUI

struct UserView: View {
    let userName: String
    let desctiption: String
    let gender: String
    var body: some View {
        VStack {
            Text("Name: \(userName)")
            Text("Gender: \(gender)")
            Text("About: \(desctiption)")
            
        }
    }
    
    
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(userName: "Jon Doe", desctiption: "likes girls", gender: "Male")
    }
}
