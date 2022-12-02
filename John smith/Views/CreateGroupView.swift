//
//  CreateGroupView.swift
//  John smith
//
//  Created by Hyeon Kim on 2022-11-18.
//

import SwiftUI
import Firebase

struct CreateGroupView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var groupName = ""
    @State private var description = ""
    let uid = Auth.auth().currentUser?.uid
    
    var body: some View {
        VStack {
            Text("CREATE GROUP")
                .font(.system(size: 40))
                .bold()
                .foregroundColor(Color("Primary"))
                .padding(EdgeInsets(
                    top: 0,
                    leading: 0,
                    bottom: 15,
                    trailing: 0))
                .shadow(color: Color("Secondary"), radius: 5)
            TextField("Group Name", text: $groupName).padding(.vertical, 15)
            TextField("Description", text: $description).padding(.vertical, 15)
            Button {
                addGroup()
                joinGroup()
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Create")
                    .padding()
                    .frame(width: 150,height: 35)
                    .foregroundColor(Color("Tenary"))
            }
            .buttonStyle(.borderedProminent)
            .tint(Color("Secondary"))
            .buttonBorderShape(.capsule)
            .padding(.vertical, 15)
        }.multilineTextAlignment(.center)
    }
    func addGroup() {
        let db = Firestore.firestore()
        db.collection("Groups").document(groupName).setData(["Description": description])
    }
    func joinGroup() {
        let db = Firestore.firestore()
        db.collection("Groups").document(groupName).updateData(["users" : FieldValue.arrayUnion([uid!])
        ])
    }
}

struct CreateGroupView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGroupView()
    }
}
