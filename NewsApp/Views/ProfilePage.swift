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
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var modeSwitchButton: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        preparePage()
        
    }
    
    private func preparePage() {
        imageBackgroundView.layer.cornerRadius = 70
        profileImage.layer.cornerRadius = 70
        logoutButton.layer.cornerRadius = 16
        
        if FirebaseAuth.Auth.auth().currentUser == nil {
            logoutButton.isHidden = true
            emailLabel.text = ""
        } else {
            logoutButton.isHidden = false
            emailLabel.text = FirebaseAuth.Auth.auth().currentUser?.email
        }
        modeSwitchButton.isOn = false
        
    }
    
    
    @IBAction func modeSwitchButtonAct(_ sender: UISwitch) {
        if #available(iOS 13.0, *) {
            let appDelegate = UIApplication.shared.windows.first
            if sender.isOn {
                appDelegate?.overrideUserInterfaceStyle = .dark
                return
            }
            appDelegate?.overrideUserInterfaceStyle = .light
        } else {
            
        }
        
    }
    
    @IBAction func logoutAct(_ sender: Any) {
        try! FirebaseAuth.Auth.auth().signOut()
        performSegue(withIdentifier: "profileToLoginPage", sender: nil)
        
    }
}
