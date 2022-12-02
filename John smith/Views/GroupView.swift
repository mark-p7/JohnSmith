//
//  GroupView.swift
//  John smith
//
//  Created by Hyeon Kim on 2022-11-18.
//

import SwiftUI
import Firebase
//import FirebaseFirestore
//import FirebaseFirestoreSwift


struct GroupView: View {
    
    let groupName: String
    let currentUser: String

    @State private var joinedUsers: Array<String> = []
    @State private var students: [User] = [User]()

    @State private var userNames: Array<String> = []
    @State private var names: String = ""
    @State private var b = false

    @State private var studentDictionary: [String: String] = [:]
    @State private var userDescription: String = ""
    @State private var hasJoined: Bool = false

    
    var body: some View {
        VStack {
            Text(groupName)
            Text(userDescription)
            if (hasJoined == false) {
                Button("Join", action: joinGroup)

            } else {
                Button("Leave group", action: leaveGroup)

            }
            
//            Button("Join", action: joinGroup)
            if (b == false) {
                Button("See the joined users", action: {
                    if b == false {
                        b = true
                    }
                })
            }
            
//            Button("See the joined users", action: {
////                if b == false {
////                    getname()
////                    for each in joinedUsers {
////                        gettings(id: each)
////                    }
////                    b = true
////                }
//                if b == false {
//                    b = true
//                }
//            })

//            List(userNames, id: \.self) { eachUser in
//                    Text("User Name: \(eachUser)")
//                }
            
            if (b == true) {
                List(Array(studentDictionary.keys), id: \.self) {each in
                    NavigationLink(studentDictionary[each]!, destination: UserDescriptionView(userId: each, user: studentDictionary[each]!) )
                }
            }

        }
        .onAppear{
            readFirestore()
            print("joined the groups view")
//            testMulti()
            
        }
        
    }
    
    func leaveGroup() {
        let db = Firestore.firestore()
        db.collection("Groups").document(groupName).updateData(["users" : FieldValue.arrayRemove([currentUser])
        ])
        hasJoined = false
    }
    
    func testMulti() {
        print("using multiple functions")
        for each in self.joinedUsers {
            print("user: \(each)")
            self.studentDictionary["\(each)"] = nil
        }
        print("The dictionary input is complete")
        print(self.studentDictionary)
        
    }
    
    func getname() {
        let db = Firestore.firestore()
        db.collection("Users").document(currentUser).addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("error")
                return
            }
            
            let namess = snapshot.data()?["name"] as? String
            print("finished")
            self.names = namess!
        }
    }
    
    func gettings(id: String) {
//        print("in the readFirestore")
        print("inside the gettings")
        let db = Firestore.firestore()
//        let part1 = [String]()
        db.collection("Users").document(id).addSnapshotListener { querySnapshot, error in
            guard let documentData = querySnapshot else {
                print("error")
                return
            }
            let name = documentData.data()?["name"] as? String
            print(name!)
            self.userNames.append(name!)
            studentDictionary[id] = name!
            
        }
    }
    

    
    func readFirestore() {
        let db = Firestore.firestore()
        db.collection("Groups").document(groupName).getDocument { (document, error) in
            if error == nil {
                if document != nil && document!.exists {
                    guard let documentData = document!.data() else {return}
                    let element = documentData["users"] as! [String]
                    let description = documentData["Description"] as! String
                    userDescription = description
//                    print(element)
//                    print(type(of: element))
                    joinedUsers = element
                    print("current user is")
                    if joinedUsers.contains(currentUser) {
                        joinedUsers = joinedUsers.filter { $0 != currentUser}
                        hasJoined = true
                    }
                    for each in joinedUsers {
                        print("user: \(each)")
                        studentDictionary[each] = ""
                    }
                    for each in joinedUsers {
                        gettings(id: each)
                    }
                    print(studentDictionary)
                    print("finished inside read")
                    
                }
            }
        }
    }
    
    func joinGroup() {
        let db = Firestore.firestore()
        db.collection("Groups").document(groupName).updateData(["users" : FieldValue.arrayUnion([currentUser])
        ])
        hasJoined = true
    }
    
}

struct GroupView_Previews: PreviewProvider {
    static var previews: some View {
        GroupView(groupName: "BCIT CST", currentUser: "Paul" )
    }
}
