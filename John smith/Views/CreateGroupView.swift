//
//  CreateGroupView.swift
//  John smith
//
//  Created by Hyeon Kim on 2022-11-18.
//

import SwiftUI
import Firebase

struct CreateGroupView: View {
    
    @State private var groupName = ""
    @State private var description = ""
    
    var body: some View {
        VStack {
            TextField("Group Name", text: $groupName)
            TextField("Description", text: $description)
            Button("Create", action: addGroup)
        }.multilineTextAlignment(.center)
    }
    func addGroup() {
        let db = Firestore.firestore()
        db.collection("Groups").document(groupName).setData(["Description": description])
    }
}

struct CreateGroupView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGroupView()
    }
}
