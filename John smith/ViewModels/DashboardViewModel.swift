//
//  DashboardViewModel.swift
//  John smith
//
//  Created by Mark De Guzman on 2022-10-14.
//

import Foundation
import Foundation
import Firebase
import FirebaseAuth

class DashboardViewModel: ObservableObject {
    @Published var userList = [User]()
    @Published var groupList = [Group]()
    @Published var matchedUsersList = [User]()
    
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
    
    
    func getMatchedUsersList() {
        
        // Get current user
        let currentUser = Auth.auth().currentUser
        
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
                        self.matchedUsersList = snapshot.documents.compactMap { userDocument in
                            
                            var userDocumentMatches = userDocument["matches"] as? [String] ?? [""]
                            // Iterating through user IDs in every user's match list
                            for userId in userDocumentMatches {
                                // Check if current user is matched
                                if (currentUser?.uid == userId) {
                                    // Create User Object with each document returned
                                    return User(id: userDocument.documentID,
                                                name: userDocument["name"] as? String ?? "",
                                                gender: userDocument["gender"] as? String ?? "",
                                                desctiption: userDocument["about"] as? String ?? "",
                                                matches: userDocument["matches"] as? [String] ?? [""],
                                                pushedLikes: userDocument["pushedLikes"] as? [String] ?? [""],
                                                pulledLikes: userDocument["pulledLikes"] as? [String] ?? [""]
                                                
                                    )}
                            }
                            return nil;
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




