//
//  ProfilePage.swift
//  NewsApp
//
//  Created by Öznur Ölçek on 6.09.2023.
//

import UIKit

let defaults = UserDefaults.standard

final class ProfilePage: UIViewController {

    @IBOutlet weak var imageBackgroundView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var modeSwitchButton: UISwitch!
    @IBOutlet weak var backgroundView: UIView!
    
    private lazy var viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        preparePage()
    }
    
    private func preparePage() {
        imageBackgroundView.layer.cornerRadius = 70
        profileImage.layer.cornerRadius = 70
        logoutButton.layer.cornerRadius = 16
        backgroundView.layer.cornerRadius = 24
        
        if viewModel.currentUser == nil {
            logoutButton.isHidden = true
            emailLabel.text = ""
        } else {
            logoutButton.isHidden = false
            emailLabel.text = viewModel.currentUser?.email
        }
        modeSwitchButton.isOn = defaults.bool(forKey: "darkModeEnabled")
    }
    
    @IBAction func modeSwitchButtonAct(_ sender: UISwitch) {
        if sender.isOn {
            viewModel.darkMode()
        } else {
            viewModel.lightMode()
        }
    }
    
    @IBAction func logoutAct(_ sender: Any) {
        viewModel.logOut()
        let storyboard = UIStoryboard(name: "LoginPage", bundle: nil)
        let vc = (storyboard.instantiateViewController(withIdentifier: "LoginPage") as? LoginPage)!
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
    }
}
