//
//  ProfileViewModel.swift
//  NewsApp
//
//  Created by Öznur Ölçek on 18.09.2023.
//

import UIKit
import FirebaseAuth

final class ProfileViewModel {
    var currentUser = FirebaseAuth.Auth.auth().currentUser
    let appDelegate = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first
    
    func darkMode() {
        if #available(iOS 13.0, *) {
            defaults.set(true, forKey: "darkModeEnabled")
            appDelegate?.overrideUserInterfaceStyle = .dark
        }
    }
    
    func lightMode() {
        if #available(iOS 13.0, *) {
            defaults.set(false, forKey: "darkModeEnabled")
            appDelegate?.overrideUserInterfaceStyle = .light
        }
    }
    
    func logOut() {
        try! FirebaseAuth.Auth.auth().signOut()
    }
}
