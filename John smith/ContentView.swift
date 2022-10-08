//
//  ContentView.swift
//  John smith
//
//  Created by Mark De Guzman on 2022-09-23.
//

import SwiftUI
import FirebaseDatabase

struct ContentView: View {
    let db = Database.database().reference()
    var body: some View {
        HStack {
            Text("Hello, world!")
            Text("Hello round 2")
            Button("Save details") {
                     
                     let dateFormatter = DateFormatter()
                     dateFormatter.dateStyle = .short
                     dateFormatter.timeStyle = .long
                     
                     let newRef = db.child("HTGame").childByAutoId()
                     
                     db.child("something").child(newRef.key!).setValue([
                        "college": newRef.key,
                        "date-time": dateFormatter.string(from: Date())
                     ])
                  }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
