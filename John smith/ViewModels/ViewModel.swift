//
//  ViewModel.swift
//  John smith
//
//  Created by Mark De Guzman on 2022-10-07.
//

import Foundation
import Firebase

class ViewModel: ObservableObject {
    @Published var userList = [User]()
    @Published var groupList = [Group]()
    
    
    func getGroupsData() {
        
        // Get db ref
        let db = Firestore.firestore()
        
        // Read documents
        db.collection("Groups").getDocuments { snapshot, error in
            
            // Check for err
            if error == nil {
                
                // No err
                if let snapshot = snapshot{
                    
                    // Update the userList property in main thread
                    DispatchQueue.main.async {
                        
                        // Get Documents
                        self.groupList = snapshot.documents.map { groupDocument in
                            
                            // Create User Object with each document returned
                            return Group(id: groupDocument.documentID,
                                        users: groupDocument["users"] as? [String] ?? [""]
                            )
                        }
                    }
                }
            }
        }
    }
    
    func getUsersData() {
        
        // Get db ref
        let db = Firestore.firestore()
        
        // Read documents
        db.collection("Users").getDocuments { snapshot, error in
            
            // Check for err
            if error == nil {
                
                // No err
                if let snapshot = snapshot{
                    
                    // Update the userList property in main thread
                    DispatchQueue.main.async {
                        
                        // Get Documents
                        self.userList = snapshot.documents.map { userDocument in
                            
                            // Create User Object with each document returned
                            return User(id: userDocument.documentID,
                                        name: userDocument["name"] as? String ?? "",
                                        gender: userDocument["gender"] as? String ?? "",
                                        desctiption: userDocument["about"] as? String ?? "",
                                        matches: userDocument["matches"] as? [String] ?? [""],
                                        pushedLikes: userDocument["pushedLikes"] as? [String] ?? [""],
                                        pulledLikes: userDocument["pulledLikes"] as? [String] ?? [""]
                            )
                        }
                    }
                }
            }
        }
    }
}
