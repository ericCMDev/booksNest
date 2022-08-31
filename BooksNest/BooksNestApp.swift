//
//  BooksNestApp.swift
//  BooksNest
//
//  Created by Eric Cabestany Mena on 9/4/22.
//

import SwiftUI
import Firebase
import FacebookLogin

class AppDelegate: NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ApplicationDelegate.shared.application(application,
                                               didFinishLaunchingWithOptions: launchOptions)
        FirebaseApp.configure()

        return true
      }
}

@main
struct BooksNestApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authenticationViewModel = AuthenticationViewModel()
    
    var body: some Scene {
        WindowGroup {
            
            if let _ = authenticationViewModel.user {
                
                HomeView(authenticationViewModel: authenticationViewModel)
               
            
            } else {
            
                AuthenticationView(authenticationViewModel: authenticationViewModel)
            }
        }
    }
}
