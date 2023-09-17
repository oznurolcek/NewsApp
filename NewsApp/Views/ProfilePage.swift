//
//  ProfilePage.swift
//  NewsApp
//
//  Created by Öznur Ölçek on 6.09.2023.
//

import UIKit
import FirebaseAuth

let defaults = UserDefaults.standard

final class ProfilePage: UIViewController {

    @IBOutlet weak var imageBackgroundView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var modeSwitchButton: UISwitch!
    @IBOutlet weak var backgroundView: UIView!
    
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
        modeSwitchButton.isOn = defaults.bool(forKey: "darkModeEnabled")
        
    }
    
    @IBAction func modeSwitchButtonAct(_ sender: UISwitch) {
        
        if #available(iOS 13.0, *) {
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let appDelegate = windowScene?.windows.first
            if sender.isOn {
                defaults.set(true, forKey: "darkModeEnabled")
                DispatchQueue.main.asyncAfter(deadline: .now()){
                    appDelegate?.overrideUserInterfaceStyle = .dark
                }
            } else {
                defaults.set(false, forKey: "darkModeEnabled")
                DispatchQueue.main.asyncAfter(deadline: .now()){
                    appDelegate?.overrideUserInterfaceStyle = .light
                }
                
            }
            
        }
    }
    
    @IBAction func logoutAct(_ sender: Any) {
        try! FirebaseAuth.Auth.auth().signOut()
        let storyboard = UIStoryboard(name: "LoginPage", bundle: nil)
        let vc = (storyboard.instantiateViewController(withIdentifier: "LoginPage") as? LoginPage)!
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
    }
}
