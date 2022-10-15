//
//  John_smithApp.swift
//  John smith
//
//  Created by Mark De Guzman on 2022-09-23.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct John_smithApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var viewModel = AuthViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
            }.environmentObject(viewModel)
        }
    }
}
