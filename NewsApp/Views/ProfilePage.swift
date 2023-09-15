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
    @IBOutlet weak var backgroundView: UIView!
    
    let darkModeEnabled = UserDefaults.standard.bool(forKey: "darkModeEnabled")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        preparePage()
        
    }
    
    private func preparePage() {
        imageBackgroundView.layer.cornerRadius = 70
        profileImage.layer.cornerRadius = 70
        logoutButton.layer.cornerRadius = 16
        backgroundView.layer.cornerRadius = 24
        
        if FirebaseAuth.Auth.auth().currentUser == nil {
            logoutButton.isHidden = true
            emailLabel.text = ""
        } else {
            logoutButton.isHidden = false
            emailLabel.text = FirebaseAuth.Auth.auth().currentUser?.email
        }
        modeSwitchButton.isOn = darkModeEnabled
        
    }
    
    @IBAction func modeSwitchButtonAct(_ sender: UISwitch) {
        let defaults = UserDefaults.standard
        
        if #available(iOS 13.0, *) {
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let appDelegate = windowScene?.windows.first
            if sender.isOn {
                appDelegate?.overrideUserInterfaceStyle = .dark
                defaults.set(true, forKey: "darkModeEnabled")
                return
            }
            appDelegate?.overrideUserInterfaceStyle = .light
            defaults.set(false, forKey: "darkModeEnabled")
        }
        
    }
    
    @IBAction func logoutAct(_ sender: Any) {
        try! FirebaseAuth.Auth.auth().signOut()
        let storyboard = UIStoryboard(name: "LoginPage", bundle: nil)
        let vc = (storyboard.instantiateViewController(withIdentifier: "LoginPage") as? LoginPage)!
        vc.modalPresentationStyle = .fullScreen
//        vc.modalTransitionStyle = .flipHorizontal
        self.present(vc, animated: true)
        
    }
}
