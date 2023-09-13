//
//  ProfilePage.swift
//  NewsApp
//
//  Created by Öznur Ölçek on 6.09.2023.
//

import UIKit
import FirebaseAuth

final class ProfilePage: UIViewController {

    @IBOutlet weak var imageBackgroundView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        preparePage()
    }
    
    private func preparePage() {
        imageBackgroundView.layer.cornerRadius = 70
        profileImage.layer.cornerRadius = 70
        logoutButton.layer.cornerRadius = 16
        if FirebaseAuth.Auth.auth().currentUser == nil {
            logoutButton.isHidden = false
        } else {
            logoutButton.isHidden = false
        }
    }
    
    @IBAction func logoutAct(_ sender: Any) {
        try! FirebaseAuth.Auth.auth().signOut()
        performSegue(withIdentifier: "profileToLoginPage", sender: nil)
        
    }
}
